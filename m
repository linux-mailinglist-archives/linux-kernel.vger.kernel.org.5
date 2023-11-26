Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEA7F9515
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjKZTjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:39:46 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A60FA;
        Sun, 26 Nov 2023 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Mk7SDcFSL7B3ppHTk9/onNe9s3kcpJLUTe7gaGAWUj8=; b=EEMCwfkMOXVsQNMyVQn+iEIRN4
        5wTzPkhM6eUSSy1fc+z45XYcN/Dar/fF79pPKQf2eV6oiLXy+WsDlhPOIjtGerLXZ7nN3RzC1QVg/
        stjhJlcOmQT/EgQa76Xl+avVKtgJwrJ8aeTPpsIM0eBsFIPYtC7F8CrlboyUlfycXz8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r7Kyh-001GiE-1M; Sun, 26 Nov 2023 20:39:39 +0100
Date:   Sun, 26 Nov 2023 20:39:39 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: extend PHY package API to support
 multiple global address
Message-ID: <4759bf58-0e9f-4d06-8b8a-d33df378c003@lunn.ch>
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <cc37984c-13b1-4116-99f8-1a65546c477a@lunn.ch>
 <65638967.5d0a0220.28475.43b3@mx.google.com>
 <240c0d9a-38d9-44fc-a56d-cdd88d9144a9@lunn.ch>
 <65638d0a.050a0220.5d4fd.3082@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65638d0a.050a0220.5d4fd.3082@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well yes I think we should assume those API to be called only in
> config_once context or in package context. But is it Panic ok? I would
> at least use something like BUG() to give descriptive warning instead of
> NULL pointer exception. What do you think?

BUG() is way too strong. It causes an immediate stop of everything,
and probably file system data loss and a reboot. WARN_ON() is
generally no better.

An Opps gives a stack trace, which is what you need to find the bug,
and kills the process. Generally, you can do a controlled shutdown,
without any losses.

	Andrew
