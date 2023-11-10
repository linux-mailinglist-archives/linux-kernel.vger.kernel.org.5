Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59CD7E806E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjKJSKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjKJSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:08:10 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5BF2BE36;
        Fri, 10 Nov 2023 01:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RCqQsSVyM3DoXJTLUpazgJs9NwUukmIgdnC+ahMaGSU=; b=02EITr0OdLqv0CrU0Iuf65HdLz
        ihjguQJZ+aOheh6x0VJm3tU0/AFj4I38usxj+5SaOy9N8HN7heoNCjgyMqGiHY1Re84aQXs8nphcd
        5TbtBdAs0pvmsojcyhTBr5aNOyXzLQnBxLvyYfU8IYx2BdP8R1LV/RprefPa/62N9JtCRtzYY4/YL
        v2XyvJAL9V9P9O72c751zb339ii1SWayLwtEzjihLEe8p+LBwplBoHOdRthPnfe64+JAVlEbVx/EH
        k2GprCYgShO0DpAWg4g9Tui/vZICK5po39lpOZyrKUw78uqmtkg6RSYheoRBBKE1t2QYac+8KZqJr
        iz5C2eLA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43810)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r1O3b-0003QY-0D;
        Fri, 10 Nov 2023 09:44:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r1O3c-0001SO-J6; Fri, 10 Nov 2023 09:44:08 +0000
Date:   Fri, 10 Nov 2023 09:44:08 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        wsa@kernel.org, codrin.ciubotariu@microchip.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "i2c: pxa: move to generic GPIO recovery"
Message-ID: <ZU37aJfDpcixU2OZ@shell.armlinux.org.uk>
References: <20231110093039.190076-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110093039.190076-1-robert.marko@sartura.hr>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 10:30:11AM +0100, Robert Marko wrote:
> This reverts commit 0b01392c18b9993a584f36ace1d61118772ad0ca.
> 
> Conversion of PXA to generic I2C recovery, makes the I2C bus completely
> lock up if recovery pinctrl is present in the DT and I2C recovery is
> enabled.
> 
> So, until the generic I2C recovery can also work with PXA lets revert
> to have working I2C and I2C recovery again.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: stable@vger.kernel.org # 5.11+

My feels were that this should not have been converted to the generic
recovery as pointed out at the time, so thanks for confirming that it
broke as a result of that conversion, it did indeed break.

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
