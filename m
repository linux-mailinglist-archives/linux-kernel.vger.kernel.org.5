Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53B7DE49F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjKAQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:32:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65141183;
        Wed,  1 Nov 2023 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=b7ErS4udndynF6UaXLpgiQ7+PIYLOlNsuoCTupPOWmI=; b=R/gO4xfAVLAFORdwaOjVel2gQ1
        ldQeo1PiZoeo2VlEDgy7DjdnE8D5BLQW0SdGY+2IuHSyHkqMN3kAsK0IJ0JT23KY6+FPj7q5cC6zZ
        IbouZ6W1KsqlfLHw3Nn3gomjThRsjZNXpJUMjNLd6/bxCB1BA/t8v4R5g1Jsgrhwcgek=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyE8r-000hBV-OS; Wed, 01 Nov 2023 17:32:29 +0100
Date:   Wed, 1 Nov 2023 17:32:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
Message-ID: <34a0b76e-aa0e-4148-ba01-c3b4608f17f7@lunn.ch>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
 <65427400.5d0a0220.41c58.0ded@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65427400.5d0a0220.41c58.0ded@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +	for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
> > > +		u32 word = 0;
> > > +
> > > +		memcpy(&word, data + pos, min(sizeof(u32), len - pos));
> > 
> > Rather than do a memcpy, use the get_unaligned_ macros. They might map
> > to a memcpy(), but some architectures can do unaligned accesses
> > without problems.
> > 
> 
> I don't think this is doable for this loop, think we would end up in
> some funny situation where for the last run we have to copy less than
> u32. (get_unaligned would always take u32 of data and that would end up
> reading more than requested) Am I wrong?

Does it happen in practice that the last chunk is not 4 bytes?  Since
this is firmware, its probably produced by some sort of linker, and
they often round segments to words. Could you take a look at the
firmware images you have access to and see if this is true?

It could be we do need to keep with the memcpy, but it would be nice
if we could limit it to words, at least until somebody has a firmware
which is not word aligned.

      Andrew
