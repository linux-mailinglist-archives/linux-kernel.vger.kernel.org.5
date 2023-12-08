Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE880A426
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573780AbjLHNIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjLHNIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:08:46 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196C171F;
        Fri,  8 Dec 2023 05:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2uqrxoJfKu97qTEB3nwXnMLgOA8AJ2MT8uVklnbJidk=; b=6I+obFWleDOwa+2LqL7HXGXT+J
        8l1Kz4XRqO89xKXU7AEyM6dT4XM3X5AJovokahzxzKNyVjlP+sQcZ/4UH/D29bd8AJNhGhj5is9JG
        SfeYoxKdIKzhDsqz0MydIAL5PsOvNM7JL1xWbjj1hhz+MWzqqA+KhdoUrv5O4n0OR/9E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rBaap-002Ptv-Ge; Fri, 08 Dec 2023 14:08:35 +0100
Date:   Fri, 8 Dec 2023 14:08:35 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Daniel Golle <daniel@makrotopia.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-ID: <b052c43c-5f4c-4cfa-8779-3dc66a451c4e@lunn.ch>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
 <20231207172923.62ce530e@dellmb>
 <cdcab57e-ef73-436d-8dac-f92219e4cbf9@lunn.ch>
 <20231208075804.4f8559e6@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208075804.4f8559e6@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What if the netdev does not have a PHY? The MAC also has speed
> information.

The ethtool API provides a list of link modes the MAC supports:

/usr/sbin/ethtool enp2s0
Settings for enp2s0:
	Supported ports: [ TP	 MII ]
	Supported link modes:   10baseT/Half 10baseT/Full
	                        100baseT/Half 100baseT/Full
	                        1000baseT/Full

The MAC driver can provide this information by calling into phylib or
phylink, or it can do it some other way. In fact, none of the LED code
goes direct to the PHY when determining when to blink in software, its
all via the struct net_device.

We should use the ethtool API to determine which speed sysfs files
should exist.

       Andrew
