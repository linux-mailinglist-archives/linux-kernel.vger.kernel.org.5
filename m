Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA277DDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbjHPJwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbjHPJw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:52:26 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B994272C;
        Wed, 16 Aug 2023 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vPIRm+r2j/XGNQXmGb4kJZdwIiaYA0yFVuKELbN9uLA=; b=oyNmb5IZWnRRDkvSc1JUzx4yvm
        LaVAUu4hmkg/TtletDcU/VC5E9VSgwp03B4OVBq03ZPk+9afMC+7tKkb6yg7DQ50tiV3Q32RBjlx5
        jeR3Rw5K6R0mjxEfyNijqOP5XGAf0NzOVA/uKpayTE89oWcTHQmQO+sakz4KsUffXIhCWrm2wrtxb
        Gc394NOj28WCq8AAriIPnTOBwT+AEAl+rKWv36+WFggWjr+nYZzxORA7KY1u4gLIuMHaL5MOoJldG
        pcmp7BwXNppsxj4wmtWUxDCkyAGJSFerBpDBHF/62zdR/GD5nIfag2cQ2POAyh9nvwN541AJ6p8TW
        Ff48bYqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45260)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qWDBn-0002b3-2d;
        Wed, 16 Aug 2023 10:51:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qWDBl-0007ug-W6; Wed, 16 Aug 2023 10:51:42 +0100
Date:   Wed, 16 Aug 2023 10:51:41 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Justin Stitt <justinstitt@google.com>,
        Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net: mdio: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <ZNycLZCK4GGfayWg@shell.armlinux.org.uk>
References: <20230815-void-drivers-net-mdio-mdio-xgene-v1-1-5304342e0659@google.com>
 <cf3a36ea-d8d2-4560-9032-04ecc2ad7495@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3a36ea-d8d2-4560-9032-04ecc2ad7495@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:41:39PM +0200, Andrew Lunn wrote:
> On Tue, Aug 15, 2023 at 08:35:59PM +0000, Justin Stitt wrote:
> > When building with clang 18 I see the following warning:
> > |       drivers/net/mdio/mdio-xgene.c:338:13: warning: cast to smaller integer
> > |               type 'enum xgene_mdio_id' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> > |         338 |                 mdio_id = (enum xgene_mdio_id)of_id->data;
> > 
> > This is due to the fact that `of_id->data` is a void* while `enum
> > xgene_mdio_id` has the size of an int. This leads to truncation and
> > possible data loss.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I wonder whether it would be better to use device_get_match_data()
here? The whole of_match_device()...acpi_match_device() dance could
become:

+	mdio_id = (uintptr_t)device_get_match_data(&pdev->dev);
	if (!mdio_id)
		return -ENODEV;

It's probably something for a follow-up patch though.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
