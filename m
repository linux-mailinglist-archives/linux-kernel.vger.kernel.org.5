Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F8782F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjHURVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjHURVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:21:52 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8D100;
        Mon, 21 Aug 2023 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=21ttcASDit1/izQa88pggG+/P1z9FA9nVd9gaOmu3SE=; b=jt11wQeV+vzprrJafgV+HsB7wB
        dvWl1Taokhk77L27avBNIVApE7ZPwNq1J/a15/7PSa9VWYLGv+3avcevw82wN0H0HK3QqrKFz2B25
        lJUx6DiKWu9MlGffYR+02cC961K+j+obzv5FTADvLOk99PuZGXEwHKDmwHQmZ6TPxobM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qY8av-004hwA-W0; Mon, 21 Aug 2023 19:21:37 +0200
Date:   Mon, 21 Aug 2023 19:21:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <3e5b2f0a-3661-4147-bc4e-784eecf41364@lunn.ch>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
 <4951391892534eaeb2da96f052364e4c@realtek.com>
 <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
 <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
 <97f3744d-afbf-4562-9168-5b9e211fac1f@lunn.ch>
 <4db3248874d64418b63fdf5c5e8a0f79@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db3248874d64418b63fdf5c5e8a0f79@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But I2C, SPI, MDIO are connected to the SoC through this chip's
> external pins, not on the PCIe bus.

Thanks, that was the information i was trying to get at.

> Actually, there is the other function in the PCIe GMAC(Multiple
> function) to manage the registers of Switch Core.  Should they be
> integrated into the MFD driver?

Can you cleanly attach another PCI driver to those functions?

You need to use an MFD when there is a single top level addressable
block of hardware which has multiple functions. Thank of an I2C
device, which has a single address on the bus, but multiple functions.
Access to that one address needs to be shared via multiple
drivers. The MFD framework provides the glue to share access to the
hardware.

However, PCI identification and addressing is more flexible. So long
as they are separate PCI functions, you should be able to load two
drivers and not have problems. Then you don't need an MFD.

	Andrew
