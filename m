Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0086F7B25AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjI1THF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1THD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:07:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C1194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:07:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88F5C433C7;
        Thu, 28 Sep 2023 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695928021;
        bh=h2mLoXWXVYbN/GQUNVZLyj+AYwIemw9Pknt/ZTBSAtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLGzXOq2aAtYKG/F6iMP7gKCBmkSnjG2JKjrrQ9ac0EPmzbdeR0vAmbZ0z9gLBxwg
         /y6cWE7fN7+U0ULhn+k4lVPa74I1608uALI4irvkXq1d6wpcaB8jpmlKHy5VxIM1yN
         AvLTC2cnoOGdbgCTAwDFFvpBIRUoH9fssv7nfzzgx6OOheMdmwoQwM0hoThdXRXbfv
         Nee1UCyFQtrsdxqrnxEuPtr7h6VZfPea2SOzXynmWppp2FIl+1nAdZWvwpvtWjtawl
         k/H5S/NDSrEEXannR7tjrevGChbO+tYsTiKDFB+L+ddc6BORcOqk679oLQIWDdSpKw
         JcWsWUR/30reQ==
Date:   Thu, 28 Sep 2023 21:06:54 +0200
From:   Simon Horman <horms@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [RFC PATCH v2 net-next 14/15] net: pcs: mtip_backplane: add
 driver for MoreThanIP backplane AN/LT core
Message-ID: <20230928190654.GP24230@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-15-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923134904.3627402-15-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 04:49:03PM +0300, Vladimir Oltean wrote:

...

> +static int mtip_rx_c72_coef_update(struct mtip_backplane *priv,
> +				   struct c72_coef_update *upd,
> +				   bool *rx_ready)
> +{
> +	char upd_buf[C72_COEF_UPDATE_BUFSIZ], stat_buf[C72_COEF_STATUS_BUFSIZ];
> +	struct device *dev = &priv->mdiodev->dev;
> +	struct c72_coef_status stat = {};
> +	int err, val;
> +
> +	err = read_poll_timeout(mtip_read_lt_lp_coef_if_not_ready,
> +				val, val < 0 || *rx_ready || LT_COEF_UPD_ANYTHING(val),
> +				MTIP_COEF_STAT_SLEEP_US, MTIP_COEF_STAT_TIMEOUT_US,
> +				false, priv, rx_ready);
> +	if (val < 0)
> +		return val;
> +	if (*rx_ready) {
> +		if (!priv->any_request_received)
> +			dev_warn(dev,
> +				 "LP says its RX is ready, but there was no coefficient request (LP_STAT = 0x%x, LD_STAT = 0x%x)\n",
> +				 mtip_read_lt(priv, LT_LP_STAT),
> +				 mtip_read_lt(priv, LT_LD_STAT));
> +		else
> +			dev_dbg(dev, "LP says its RX is ready\n");
> +		return 0;
> +	}
> +	if (err) {
> +		dev_err(dev,
> +			"LP did not request coefficient updates; LP_COEF = 0x%x\n",
> +			val);
> +		return err;
> +	}
> +
> +	upd->com1 = LT_COM1_X(val);
> +	upd->coz = LT_COZ_X(val);
> +	upd->cop1 = LT_COP1_X(val);
> +	upd->init = !!(val & LT_COEF_UPD_INIT);
> +	upd->preset = !!(val & LT_COEF_UPD_PRESET);
> +	

Hi Vladimir,

I'm unsure if this can actually happen.
But if the while loop runs zero times then err is used uninitialised here.

As flagged by Smatch.

> +		mtip_an_restart_from_lt(priv);
> +
> +	kfree(lt_work);
> +}
> +
> +/* Train the link partner TX, so that the local RX quality improves */
> +static void mtip_remote_tx_lt_work(struct kthread_work *work)
> +{
> +	struct mtip_lt_work *lt_work = container_of(work, struct mtip_lt_work,
> +						    work);
> +	struct mtip_backplane *priv = lt_work->priv;
> +	struct device *dev = &priv->mdiodev->dev;
> +	int err;
> +
> +	while (true) {
> +		struct c72_coef_status status = {};
> +		union phy_configure_opts opts = {
> +			.ethernet = {
> +				.type = C72_REMOTE_TX,
> +			},
> +		};
> +
> +		if (READ_ONCE(priv->lt_stop_request))
> +			goto out;

Likewise, I'm unsure if this can happen.
But if the condition above is met on the first iteration of
the loop then the out label will use err without it being initialised.

Also flagged by Smatch.

> +
> +		err = mtip_lt_in_progress(priv);
> +		if (err) {
> +			dev_err(dev, "Remote TX LT failed: %pe\n", ERR_PTR(err));
> +			goto out;
> +		}
> +
> +		err = phy_configure(priv->serdes, &opts);
> +		if (err) {
> +			dev_err(dev,
> +				"Failed to get remote TX training request from SerDes: %pe\n",
> +				ERR_PTR(err));
> +			goto out;
> +		}
> +
> +		if (opts.ethernet.remote_tx.rx_ready)
> +			break;
> +
> +		err = mtip_tx_c72_coef_update(priv, &opts.ethernet.remote_tx.update,
> +					      &status);
> +		if (opts.ethernet.remote_tx.cb)
> +			opts.ethernet.remote_tx.cb(opts.ethernet.remote_tx.cb_priv,
> +						   err, opts.ethernet.remote_tx.update,
> +						   status);
> +		if (err)
> +			goto out;
> +	}
> +
> +	/* Let the link partner know we're done */
> +	err = mtip_modify_lt(priv, LT_LD_STAT, LT_COEF_STAT_RX_READY,
> +			     LT_COEF_STAT_RX_READY);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to update LT_LD_STAT: %pe\n",
> +			ERR_PTR(err));
> +		goto out;
> +	}
> +
> +	err = mtip_remote_tx_lt_done(priv);
> +	if (err) {
> +		dev_err(dev, "Failed to finalize remote LT: %pe\n",
> +			ERR_PTR(err));
> +		goto out;
> +	}
> +
> +out:
> +	if (err && !READ_ONCE(priv->lt_stop_request))
> +		mtip_an_restart_from_lt(priv);
> +
> +	kfree(lt_work);
> +}

...
