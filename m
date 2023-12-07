Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A5809604
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjLGW5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjLGW5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:57:08 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4812198C;
        Thu,  7 Dec 2023 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e9QlfSVQ0gZy3QbK9bpFVf9dp3zXzuooGWrQsidX1tw=; b=J/9J1Z9e94VygRiQ0xxPn9Vy+A
        mRXXH8imkqLsqqEWTQMcjJPYDnyKNctzuIQ1jKFyT3fLAEc/cZnfgIFnZ9UFtG9DXfDs2Ds+Whvct
        ggxqcS4rwbiS8T6IYLfeWVUyk3gQL++sRVRMfqFsbSXZ9f5xtVFg7bh2UnKAxwPAXCxddlxrMfkjK
        7bDv3CFy0quiiQZn2IEm5/QHUt3b1HcrD5hDnLWJKs5abwu40vhV8s3FYYTwT1D02wgk63Z6z7hhM
        B3D33sVdXuclRaHhnopgO1MXvj/xfl0akDmuJfVcp8zAKm3oLeTXg1gYw5Y73zK622TFyOV7OXYmr
        nmRQuJww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57030)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rBNIn-0001ka-1u;
        Thu, 07 Dec 2023 22:57:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rBNIo-00047T-K2; Thu, 07 Dec 2023 22:57:06 +0000
Date:   Thu, 7 Dec 2023 22:57:06 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: mdio-gpio: replace deprecated strncpy with
 strscpy
Message-ID: <ZXJNwrcSfgUFhaz6@shell.armlinux.org.uk>
References: <20231207-strncpy-drivers-net-mdio-mdio-gpio-c-v2-1-c28d52dd3dfe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-mdio-mdio-gpio-c-v2-1-c28d52dd3dfe@google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:54:31PM +0000, Justin Stitt wrote:
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> We can also use sizeof() instead of a length macro as this more closely
> ties the maximum buffer size to the destination buffer.

Honestly, this looks machine generated and unreviewed by the submitter,
because...

>  	if (bus_id != -1)
>  		snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
>  	else
> -		strncpy(new_bus->id, "gpio", MII_BUS_ID_SIZE);
> +		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));

If there is an argument for not using MII_BUS_ID_SIZE in one place,
then the very same argument applies to snprintf(). If one place
changes the other also needs to be changed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
