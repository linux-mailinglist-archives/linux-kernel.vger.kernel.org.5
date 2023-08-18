Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20149780B35
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376701AbjHRLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376683AbjHRLhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:37:36 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6632112;
        Fri, 18 Aug 2023 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=quMEXcsxvIp/ZE+e0LW7gaISdxOwwNn2IUA4hyZEeSI=; b=XvQB7+aWEzZitFLDwHI8hOs/+s
        IV9kZq7KcJA1MpKiiGwtk/x3+Vr/bvOVSsVsQkAyBY6SAy2F/QMGsnQjCcU/wsi8g5w3qZ/BHmuQh
        i1PUYYlBwrTpm0JlAgkK6Yhk3S3kY9zHmWtNZnzUCpM6QH+zmrjlsRmh7HvWCzUZy5Zpk+Tij1CKz
        zua6ZINgAoAcG3dj0blVRQ9bqSwtJL7EF4l3kN1MxUvsdQ3UqCIGQU9tjr2ikDy8ldrtFmEbdme7z
        gvbshXEZ0j7MIgZslvgcEOkX4Umf8zzKQsAvvGboFHuR8UodffF9aMjVMkAfbjveHcJcNDy/FBC5K
        l9ukIqrQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59946)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qWxnE-0005Xg-23;
        Fri, 18 Aug 2023 12:37:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qWxnD-0001b1-DS; Fri, 18 Aug 2023 12:37:27 +0100
Date:   Fri, 18 Aug 2023 12:37:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v3] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
Message-ID: <ZN9X97YntVZkw3PG@shell.armlinux.org.uk>
References: <20230818110556.10300-1-josua@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818110556.10300-1-josua@solid-run.com>
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

On Fri, Aug 18, 2023 at 01:05:56PM +0200, Josua Mayer wrote:
> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> for active optical cables supporting 25G and 100G speeds.
> 
> Since the specification makes no statement about transmitter range, and
> as the specific sfp module that had been tested features only 2m fiber -
> short-range (SR) modes are selected.
> 
> The 100G speed is irrelevant because it would require multiple fibers /
> multiple SFP28 modules combined under one netdev.
> sfp-bus.c only handles a single module per netdev, so only 25Gbps modes
> are selected.
> 
> sfp_parse_support already handles SFF8024_ECC_100GBASE_SR4_25GBASE_SR
> with compatible properties, however that entry is a contradiction in
> itself since with SFP(28) 100GBASE_SR4 is impossible - that would likely
> be a mode for qsfp modules only.
> 
> Add a case for SFF8024_ECC_100G_25GAUI_C2M_AOC selecting 25gbase-r
> interface mode and 25000baseSR link mode.
> Also enforce SFP28 bitrate limits on the values read from sfp eeprom as
> requested by Russell King.
> 
> Tested with fs.com S28-AO02 AOC SFP28 module.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
