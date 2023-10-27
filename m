Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312A37DA229
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJ0VIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0VIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:08:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731B1B8;
        Fri, 27 Oct 2023 14:08:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED75BC433C8;
        Fri, 27 Oct 2023 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698440895;
        bh=JVg9o8t4kx7NkmThvEj5qCPKC7jZ1L/iglby5Zilnkg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ErnTMBy/oxMpX/l8GXxZU1fVuG6ioNxq91y3LTCvU+7/SnZlaFfBuT3moteliFEl9
         Ep6ezq69YDQoxqYQJ2FgAfj99Us/c7XJP+/aWjDNP7sJ42ZbcWlufebe2xSfskggJ0
         KC1WMd1G58gD5vXCu8VME+84xhUMpySMMPMRgamumvVtduEzaK3HHAdofV3Te8LvIy
         uorycD+VRHqeggKLTiA6NtvgY3mcUzypvZ8R0TPIEf6NfeqD089ua3BGFigErOp69C
         Wfc3M4tMg7GuDVMCcJjWuM8JA07x8gnk/g4Ud/jSERCY+hZxrZT8LshaK764GfAYN1
         r1wUxFp2UBv9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C5ECECE0F11; Fri, 27 Oct 2023 14:08:13 -0700 (PDT)
Date:   Fri, 27 Oct 2023 14:08:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     j.alglave@ucl.ac.uk, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        palmer@dabbelt.com, parri.andrea@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com,
        davidtgoldblatt@gmail.com
Subject: Fw: [isocpp-parallel] OOTA fix (via fake branch-after-load)
 discussion
Message-ID: <b1634b24-4541-49c5-867c-7f24292a27bb@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

FYI, unless someone complains, it is quite likely that C++ (and thus
likely C) compilers and standards will enforce Hans Boehm's proposal
for ordering relaxed loads before relaxed stores.  The document [1]
cites "Bounding data races in space and time" by Dolan et al. [2], and
notes an "average a 2.x% slow down" for ARMv8 and PowerPC.  In the past,
this has been considered unacceptable, among other things, due to the
fact that this issue is strictly theoretical.

This would not (repeat, not) affect the current Linux kernel, which
relies on volatile loads and stores rather than C/C++ atomics.

To be clear, the initial proposal is not to change the standards, but
rather to add a command-line argument to enforce the stronger ordering.
However, given the long list of ARM-related folks in the Acknowledgments
section, the future direction is clear.

So, do any ARMv8, PowerPC, or RISC-V people still care?  If so, I strongly
recommend speaking up.  ;-)

							Thanx, Paul

[1] https://lukegeeson.com/blog/2023-10-17-A-Proposal-For-Relaxed-Atomics/
[2] https://dl.acm.org/doi/10.1145/3192366.3192421

----- Forwarded message from David Goldblatt via Parallel <parallel@lists.isocpp.org> -----

Date: Fri, 27 Oct 2023 11:09:18 -0700
From: David Goldblatt via Parallel <parallel@lists.isocpp.org>
To: SG1 concurrency and parallelism <parallel@lists.isocpp.org>
Reply-To: parallel@lists.isocpp.org
Cc: David Goldblatt <davidtgoldblatt@gmail.com>
Subject: [isocpp-parallel] OOTA fix (via fake branch-after-load) discussion

Those who read this list but not the LLVM discourse might be interested in:
- This discussion, proposing `-mstrict-rlx-atomics`:
https://discourse.llvm.org/t/rfc-strengthen-relaxed-atomics-implementation-behind-mstrict-rlx-atomics-flag/74473
to enforce load-store ordering
- The associated blog post here:
https://lukegeeson.com/blog/2023-10-17-A-Proposal-For-Relaxed-Atomics/

- David

_______________________________________________
Parallel mailing list
Parallel@lists.isocpp.org
Subscription: https://lists.isocpp.org/mailman/listinfo.cgi/parallel
Link to this post: http://lists.isocpp.org/parallel/2023/10/4151.php


----- End forwarded message -----
