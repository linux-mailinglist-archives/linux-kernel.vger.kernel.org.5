Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864A79773B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbjIGQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbjIGQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:07 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487493CB;
        Thu,  7 Sep 2023 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F7vSpfCfYCvODMAyXRt6Ug4ZFfLol/1tefnPrblJooA=; b=fMOtER0Kc3s0dWOOXdWUtzuoWA
        dWl8L35t9P5Oddj5gWtY8xsnKWUvCkbc/D1Ac/S/bGTbqaQBUZeF225T2faMESNfQYx+alM5b26cp
        2Zd6OJJ660Y9ofKMEWwcBhxl29S77LF5hhkur4SX1RKv25PGVCNnh92l4JzJ+xVRAnd680jY5Ojwj
        x8pg96Xg6igE69LQ0fWlmaiomAI+vapPlLtSf3cgAUY4xvbC62dX13Cdl4Nyrgvagtc7KUxUDIPTV
        vzWxJTxfivuKIOOvk8UfxrknCPUVQz8sZmTH29NDO7EyhS7oU8WYc9CGZoEZfAqfDq0tCIAlpFmM/
        qMfs6kww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48762)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qeAWl-0001ci-0Q;
        Thu, 07 Sep 2023 09:38:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qeAWd-0005ft-Ce; Thu, 07 Sep 2023 09:38:07 +0100
Date:   Thu, 7 Sep 2023 09:38:07 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Bo Liu <liubo03@inspur.com>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mdio: Use helper function IS_ERR_OR_NULL()
Message-ID: <ZPmL72ShZz4gq2na@shell.armlinux.org.uk>
References: <20230907071705.3907-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907071705.3907-1-liubo03@inspur.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 03:17:05AM -0400, Bo Liu wrote:
> Use IS_ERR_OR_NULL() to detect an error pointer or a null pointer
> open-coding to simplify the code.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Please do a more thorough review of the code before proposing changes
to discover what the correct solution should be.

> diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
> index 1190a793555a..1518abfc3e22 100644
> --- a/drivers/net/mdio/mdio-xgene.c
> +++ b/drivers/net/mdio/mdio-xgene.c
> @@ -263,7 +263,7 @@ struct phy_device *xgene_enet_phy_register(struct mii_bus *bus, int phy_addr)
>  	struct phy_device *phy_dev;
>  
>  	phy_dev = get_phy_device(bus, phy_addr, false);
> -	if (!phy_dev || IS_ERR(phy_dev))
> +	if (IS_ERR_OR_NULL(phy_dev))

Looking at get_phy_device(), the returns from this function are either:

        if (r)
                return ERR_PTR(r);

which can't return NULL, or the return value from phy_device_create().

Looking at phy_device_create(), the returns from this function are:

        if (!dev)
                return ERR_PTR(-ENOMEM);

        if (ret) {
...
                dev = ERR_PTR(ret);
...
        return dev;

so I don't see any of this being able to return NULL either. Therefore,
the code that you are modifying should be:


-	if (!phy_dev || IS_ERR(phy_dev))
+	if (IS_ERR(phy_dev))

and the commit description needs to be updated to state that
get_phy_device() does not return NULL.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
