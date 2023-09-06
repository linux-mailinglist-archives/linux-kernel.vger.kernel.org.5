Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FA793CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjIFMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjIFMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:31:23 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C5170D;
        Wed,  6 Sep 2023 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=l8w5U8Lo+Ib8rdRaUcxv84w69rTq14NU8ZSfpAgImrU=; b=KLQuWSv0mz09IR2wkr3eCTIWVL
        IYXnu+t86H2cLlxaTw9o+mnMOG7rWaRPL7MJo+0Fln0PYbzGi+HW9TQVc74baXCt1qnHlTgmeriEr
        6vQlYkNQB12trzCJGjM9H7WTN8xYSG5Z3vcdNpFw1OCijfK7RYNrHI8Z1bqgi5QKfcGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qdrgi-005tx3-Fm; Wed, 06 Sep 2023 14:31:16 +0200
Date:   Wed, 6 Sep 2023 14:31:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sergio Callegari <sergio.callegari@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Regression with AX88179A: can't manually set MAC address anymore
Message-ID: <d6777bc1-46ad-4ad9-a7e3-655dbe4f6317@lunn.ch>
References: <54cb50af-b8e7-397b-ff7e-f6933b01a4b9@gmail.com>
 <ZPcfsd_QcJwQq0dK@debian.me>
 <6315027e-d1ab-4dec-acf2-0a77bb948807@gmail.com>
 <ZPfZQsLKG9LKGR1G@debian.me>
 <075308b2-7768-40b2-9c00-a5a14df62678@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075308b2-7768-40b2-9c00-a5a14df62678@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So if the in-tree driver could be fixed to correctly support the manual
> configuration of the hardware (MAC) address as it used to be that would be
> the best. I hope that Andrew Lunn's hypothesis is correct, and that cdc_ncm
> can be extended to work with AX88179A even when a manual MAC addr is
> configured.

I think it can, but it looks like it needs a different
implementation. The CDC NCM standard is publicly available. It
documents an optional call to set the MAC address, and there appears
to be a capability bit to indicate if its implemented in a specific
device. Ideally if the bit is not set -EOPNOTSUPP should be returned
when trying to set the MAC address, otherwise make the call to let the
hardware know of the new MAC address.

Sorry, i don't have the time or the hardware to actually implement
this. But i can review patches and help with processes.

      Andrew

	
