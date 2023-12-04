Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5398803BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjLDRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjLDRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:10:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E795CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:10:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44926C433C9;
        Mon,  4 Dec 2023 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701709858;
        bh=eYlfVLjV3hhcYavJ60dgUIHZwtpyUj6mNwY7SPULvfM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B83T4568LPa9narG26Op803qArGPHwWv2OwSIGkYCDpoVlBa2OHjqmUZLe3rcco3n
         yIYQEhAzJVk5ZdGsV3PX5JlhkWEuS3RUFzeZ5d0U7R5mFvaqNKcpXq5E+KgGwkTAvm
         ad48ikdKZpQGMC9vu3msxUWiZnFTNMICvgfaneoW4v0mHl4c+B7klcqYbS6jPH7vYB
         qyjcv+dN+X8aShmr9ai7RiHYfn6Pi1/uz7Kmb2PjlsZF3Wi8FpNr0bJfn1MHqeYUIG
         7Pi6loKtLCdjqUUfQyNL5zZIOA8WQHIX7svm3dtOKHb9XQVy/+iVHxr/69QRVLFHk0
         MuCE2tj1haSSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD3F8CE0CC3; Mon,  4 Dec 2023 09:10:57 -0800 (PST)
Date:   Mon, 4 Dec 2023 09:10:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     sfr@canb.auug.org.au, peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [BUG] RCU CPU stall warning (bisected)
Message-ID: <995d8fb2-6901-489a-9191-360ad074dad3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fc50b62c-813b-45e6-ad7b-227cbd0415ba@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc50b62c-813b-45e6-ad7b-227cbd0415ba@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:43:52AM -0800, Paul E. McKenney wrote:
> Hello!
> 
> Just FYI for the moment.
> 
> I hit the following three times out of 15 ten-hour TREE03 rcutorture
> runs on next-20231121, which suggests an MTBF of about 50 hours.  This is
> new over the past week or so.
> 
> The symptom is that the RCU grace-period kthread is marked as running
> ("R"), but remains stuck in schedule() for the remainder of the run.
> 
> My next steps will be to retry on today's -next, and if that reproduces
> the bug, attempt to bisect.
> 
> But I figured that I should send this out on the off-chance that it is
> a known problem.

And the bisection fingered this commit, maybe even rightfully so:

5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")

Next step is to revert this on top of v6.7-rc3 and retest.  I will let
you know what happened when the test completes.  And the error rate did
drop off during the bisection, so it is possible that there are multiple
causes of this bug.  :-/

In the meantime, is this a known problem?  ("Did I just waste a week
bisecting something that has already been fixed?")

							Thanx, Paul
