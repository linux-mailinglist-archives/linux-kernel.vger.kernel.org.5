Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AFE7996B3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245578AbjIIHPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbjIIHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 03:15:53 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9E1FCA;
        Sat,  9 Sep 2023 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=20JpG9Rw3CnWjoWUx3u3nHgi+Oc1MtoUJn70NC8pol8=; b=Zcyt5UeZcFuWEfFxP7ObVLhHwK
        BUTTB5SUPbGCUOsAi+bkNJbMQWbMzfX8bboZL0cVVovJ74Q3BqtUuTu3aV4QlZHFZBbf9BIPlsciD
        6RMwTi8G5hAVsyu5CsV6qysHAsLwj+ZL3mOCrplSz2pmrW4M3M/1nbGaaG3KyODLY72t4rPVRKvWj
        HXU0zYFDdLILAXybCiGVeMWvVoCCGr5QU+9BIKJw0wt7XBrSuvZiImK3SUXJp1P+D+3bsXAJVKvgt
        s/EPJ94dtwRKJYuIdVsKpTxsPqxst0OslA2IEE/+b11/hVrjZTeZrZ5G68sIa+IGZVRwDhGt3bNfS
        hW6ltgBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48000)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qesBv-0005pw-03;
        Sat, 09 Sep 2023 08:15:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qesBt-0007kv-Em; Sat, 09 Sep 2023 08:15:37 +0100
Date:   Sat, 9 Sep 2023 08:15:37 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        netdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] net: phy: dp83867: Add support for hardware blinking LEDs
Message-ID: <ZPwbmebLiUECCL+x@shell.armlinux.org.uk>
References: <20230907084731.2181381-1-s.hauer@pengutronix.de>
 <2239338.iZASKD2KPV@steina-w>
 <6c8f5cc5-0b8b-42e0-ac86-91ddcb35389f@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c8f5cc5-0b8b-42e0-ac86-91ddcb35389f@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 04:27:31AM +0200, Andrew Lunn wrote:
> > This works as intended so far. Unfortunately this driver and the PHY LED 
> > framework do not support active-low LEDs (yet).
> 
> Polarity is something which i've seen a few PHY devices have. It also
> seems like a core LED concept, not something specific to PHY LEDs. So
> i think this needs to be partially addressed in the LED core.

However, doesn't the LED layer deals with LED brightness, not by logic
state? It certainly looks that way, and it's left up to the drivers
themselves to deal with any polarity inversion - which makes sense if
the core is just concerned about brightness.

Introducing inversion in the core means drivers will be passed a
brightness of "100" for off and "0" for on which, do you not think,
starts to get rather silly?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
