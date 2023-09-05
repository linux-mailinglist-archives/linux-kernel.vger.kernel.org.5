Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66333792AE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbjIEQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354748AbjIEOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:04:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC4198;
        Tue,  5 Sep 2023 07:04:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so3541393a12.3;
        Tue, 05 Sep 2023 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693922667; x=1694527467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9psAb430jC90VCdqe63QauPmlT/EpRgnVSmF0m3boE=;
        b=VH5HTP5wmcyWJl/2LQM5GmBBP9jl9m3EAhcre0cuhma5VOw4vBgxRrkdw8x3O72fao
         CpiCFbgFAz5iqJDXG3LR7Z2bHAuJ31zvqvtHSRYFH9u0JEWdTSac17/Z1BL903qXSVRo
         Yfuw7Ezujc0YWIeDF/lBF4PjQB1PIvo5cvzhZ/d7a1jO0qRvDumbKiZyDujWEgUoPYOa
         1G5WXfO9pyrOYVQc20/xtidsOUj46c/5zVW+mK8Ud4fGUHRO6xU66dudqxcSoa0GLibp
         aVLYP0D5ncKP3AQRewD2T39zMvFZ+kPg7vcxJRhnyk7MIY7XefN/VBMg2OO5EFZkNqsl
         xHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693922667; x=1694527467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9psAb430jC90VCdqe63QauPmlT/EpRgnVSmF0m3boE=;
        b=I/YX/cg5ee4uw6EOWCixhGwNglR+ejp2XhVf324GCc9rRZYlqpdH1/BJVTxGwT5I3L
         y0W6u2pH1i5vCagG/FZn85g/uWP+oAxfcd6/jUDp/vu8Um7tllOEM6IcSedRzd/1s8Ls
         mRBhyZNCPq/y789oaWMfmzDrDZltvu7DBQQLl9likR6UlfVq8iOki2bWL1BC6BM+2cTk
         sO++tSqMdH4luy/xCS0pGRvX8qFogmS2vQuHUlr6LOXTRD1Ulg9z556WFG5azqIgBbfj
         eHehq2IUbtDNMHuRmmEBRevlRzYKrd19zGnZQdtfcLX1Ldm29AKygBerC4VdLN0LrYRK
         mHrA==
X-Gm-Message-State: AOJu0YwhUdng2clnEz4y29Olu0+hwxF/okyA6pU6KUzPbIUmhcDTUjPz
        t3e0UQ/GeG+mFZcSQU4/mdk=
X-Google-Smtp-Source: AGHT+IE21Z/EFgzhQDzJSm0Hu31eOBpIi92vifw4CNSyPJg4tSrU3ibqgWuetSCsKEXTAorFGPQjjg==
X-Received: by 2002:aa7:c3d4:0:b0:523:4bfa:b450 with SMTP id l20-20020aa7c3d4000000b005234bfab450mr9349362edr.27.1693922666576;
        Tue, 05 Sep 2023 07:04:26 -0700 (PDT)
Received: from skbuf ([188.26.57.165])
        by smtp.gmail.com with ESMTPSA id c24-20020a056402121800b005256d4d58a6sm7129550edw.18.2023.09.05.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 07:04:26 -0700 (PDT)
Date:   Tue, 5 Sep 2023 17:04:23 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RFC 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <20230905140423.weisoaygc2tjvezb@skbuf>
References: <20230904120209.741207-1-lukma@denx.de>
 <20230904120209.741207-5-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904120209.741207-5-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 02:02:09PM +0200, Lukasz Majewski wrote:
> +static int ksz_hsr_leave(struct dsa_switch *ds, int port,
> +			 struct net_device *hsr)
> +{
> +	struct dsa_port *partner = NULL, *dp;
> +	struct ksz_device *dev = ds->priv;
> +
> +	dsa_hsr_foreach_port(dp, ds, hsr) {
> +		if (dp->index != port) {
> +			partner = dp;
> +			break;
> +		}
> +	}
> +
> +	if (!partner)
> +		return 0;
> +
> +	switch (dev->chip_id) {
> +	case KSZ9477_CHIP_ID:
> +		return ksz9477_hsr_leave(ds, port, hsr, partner);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

It's hard for me to put this in the proper perspective in this email,
since ksz9477_hsr_leave() is implemented in a different patch, so I'm
just going to reproduce it here:

int ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr,
		      struct dsa_port *partner)
{
	struct ksz_device *dev = ds->priv;

	/* Clear ports HSR support */
	ksz_write32(dev, REG_HSR_PORT_MAP__4, 0);

	/* Disable forwarding frames between HSR ports */
	ksz_prmw32(dev, port, REG_PORT_VLAN_MEMBERSHIP__4, dev->hsr_ports, 0);
	ksz_prmw32(dev, partner->index, REG_PORT_VLAN_MEMBERSHIP__4,
		   dev->hsr_ports, 0);

	/* Disable per port self-address filtering */
	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
	ksz_port_cfg(dev, partner->index, REG_PORT_LUE_CTRL,
		     PORT_SRC_ADDR_FILTER, false);

	return 0;
}

The code pattern from ksz_hsr_leave() is to disable HSR offload in both
member ports, after *both* member ports have left the HSR device, correct?

So it means that after this set of commands:

ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
ip link set dev lan1 up
ip link set dev lan2 up
ip link set lan1 nomaster

lan1 will still have HSR offload enabled, and forwarding enabled towards
lan2, correct? That's not good, because lan1 is now a standalone port
and should operate as such.
