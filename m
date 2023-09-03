Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0217E790D3B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbjICRWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjICRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:22:31 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984FCDD;
        Sun,  3 Sep 2023 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=sCdnjBI3k+22FfyYfXDpxGdCt/Np2mtFytRDIWk5a8w=; b=11aZom3PL9OR2u8QcLytZPUFcV
        aYULIjfqpcb/bCg/DS+DcXCobP2maQVbut6lOumuOgSLizL4Hqbd3tUBDb1exU1mJqE9zIVK8maFj
        D4EC4Kz5r+0jBW3KfgRpfUjVGO5rFVMv7ANAuYv5af1xg3fLQQOSPbv9AUuDgQbMHDvs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qcqnh-005gxi-Km; Sun, 03 Sep 2023 19:22:17 +0200
Date:   Sun, 3 Sep 2023 19:22:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: dsa: hsr: Provide generic HSR
 ksz_hsr_{join|leave} functions
Message-ID: <08dd3467-7720-46e1-8c72-1d46d951f90d@lunn.ch>
References: <20230831111827.548118-1-lukma@denx.de>
 <20230831111827.548118-5-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111827.548118-5-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
> +{
> +	struct dsa_port *partner = NULL, *dp;
> +	struct ksz_device *dev = ds->priv;
> +	enum hsr_version ver;
> +	int ret;
> +
> +	ret = hsr_get_version(hsr, &ver);
> +	if (ret)
> +		return ret;
> +
> +	switch (dev->chip_id) {
> +	case KSZ9477_CHIP_ID:
> +		if (ver == PRP_V1)
> +			return -EOPNOTSUPP;

This should probably check for versions which are support, and not
assume PRP_V42 is not added some time in the future, which would be
accepted here.

	 Andrew
