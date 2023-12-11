Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855D580DF70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjLKXXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLKXXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:23:03 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6067CF;
        Mon, 11 Dec 2023 15:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jrCVMJHthbqeGM1aFmtvmFcFPoeI3AQf6oEdNuwB7Ek=; b=F6dnW5mBJVog++to6z1R9NmBkI
        jGfXAd1fYlZ+0hwwuh88UATilbj9bYLTK/P3djKdlQ7dcrqn2gACCuRUQ0KKzhyEugJD7bpsk3cza
        I+9F1h35IGE1cqRJbjZSIq1idA+iSmf+8lYIqjXwt0asHxsVX6S/QEt67byLyouTT4OGt3poyaGIE
        fXC0EyIGAYrghsjnAFUrA53htVG9t9pQEc/fmwFasz7HZMNeQjvT8PSjmtyMII5tnXI4sDS4wywxy
        lcX8jw4rBt4LhLYa+Kkdgfv8HK1lnwL5v7420WBa52wmr6y8AbgyUZzV8K3bP2yr45Oew+CqbjWFc
        zlflsvHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58904)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rCpby-00067g-33;
        Mon, 11 Dec 2023 23:22:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rCpbz-0008FZ-Pr; Mon, 11 Dec 2023 23:22:55 +0000
Date:   Mon, 11 Dec 2023 23:22:55 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] net: mdio-gpio: replace deprecated strncpy with
 strscpy
Message-ID: <ZXeZz4JcJAIMJLTy@shell.armlinux.org.uk>
References: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211-strncpy-drivers-net-mdio-mdio-gpio-c-v3-1-76dea53a1a52@google.com>
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

On Mon, Dec 11, 2023 at 07:10:00PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> its prior assignment through snprintf:
> |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> 
> Due to this, a suitable replacement is `strscpy` [2] due to the fact
> that it guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> We can also use sizeof() instead of a length macro as this more closely
> ties the maximum buffer size to the destination buffer. Do this for two
> instances.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
