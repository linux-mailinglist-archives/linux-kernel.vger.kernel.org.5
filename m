Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C257E72A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjKIUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344411AbjKIUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:09:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDEA44B6;
        Thu,  9 Nov 2023 12:09:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FABC433CD;
        Thu,  9 Nov 2023 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699560553;
        bh=riorARNTuUvrlXkh0YCvRYbJWzEYMnZ3VVViKJzwNnY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KEhwNhP3Qwutf1hNZ2Ywp22kez+8buGFI8rtM6kkCclFXCJANChpvmRuNRDNJgahr
         DDU6tqL96GigHkw8SFqXO2PzGhHWUyASQSKdWRO6WhFH4Ks4K0+GbS+BEdF4vDbROy
         2jVCP10aw4PfAjOcfaFj4xui6T5XI+380WPboVOp1OjKchozAQYnKmNF9Ciaq5lyax
         wWlkR/BLzm0W8XOZ2MgcMY85Naq5yE4oC+UGyMTEmzyJdpsOYmfS9m9B5T3iRCPLib
         4LO16SYkLCYo60+s28+2YASXHOa/8p8T14dpLkLAjXC6S7V2kc7aAb/wMqVySazzf0
         wOF7Lf8Xf4gyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BFD75CE0B77; Thu,  9 Nov 2023 12:09:11 -0800 (PST)
Date:   Thu, 9 Nov 2023 12:09:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>, j.alglave@ucl.ac.uk,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, davidtgoldblatt@gmail.com
Subject: Re: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Message-ID: <de5b0428-6624-4143-be28-5ba34106d765@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
 <20231105230859.GH8262@noisy.programming.kicks-ass.net>
 <d18e0ce6-db9e-4590-a7ab-15e27b2c33f4@paulmck-laptop>
 <20231107095745.GD19790@gate.crashing.org>
 <bf18e3f7-f8be-4b11-b348-b784420bda16@paulmck-laptop>
 <ece7680c-630e-956d-ad9f-10614afa84a4@huaweicloud.com>
 <ZU0j1z26ki1dsPpB@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU0j1z26ki1dsPpB@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:24:23AM -0800, Boqun Feng wrote:
> On Thu, Nov 09, 2023 at 05:25:05PM +0100, Jonas Oberhauser wrote:
> [...]
> > > 4.	Semantics of volatile.	Perhaps the current state is the best
> > > 	that can be hoped for, but given that the current state is a
> > > 	few vague words in the standard in combination with the fact
> > > 	that C-language device drivers must be able to use volatile
> > > 	to reliably and concurrently access memory shared with device
> > > 	firmware, one would hope for better.
> > 
> > 
> > Is it really so bad? I think the definition in the manual is quite precise,
> > if confusing. (volatiles are visible side effects and must therefore have
> > the same program order in the abstract machine and in the implementation,
> > and that's pretty much it).
> 
> But I don't think there is any mention on whether current volatile
> accesses can be excluded from data race, or whether a volatile access
> on a machine-word size natually aligned object can be teared or not.

Here is my understanding:  It must be possible to write C-language
device drivers for devices that...

1.	read and write to normal memory.  If this device has C-langugae
	firmware, volatile reads and writes involving aligned
	machine-word-sized locations must not invoke undefined behavior.

2.	allow concurrent reads and writes to MMIO registers (or to
	normal memory).  Even ignoring the device firmware, volatile
	reads and writes involving aligned machine-word-sized locations
	must not invoke undefined behavior.

Not necessarily a popular view, but then again, in my experience,
objective reality never has been trying to win a popularity contest.

							Thanx, Paul

> Regards,
> Boqun
> 
> > There should just be a large explanatory note about what it implies and what
> > it doesn't imply.
> > 
> > 
