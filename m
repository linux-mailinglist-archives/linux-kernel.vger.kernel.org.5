Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826A9759F34
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGSUDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGSUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:03:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC1210E;
        Wed, 19 Jul 2023 13:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93EC61805;
        Wed, 19 Jul 2023 20:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBB8C433C7;
        Wed, 19 Jul 2023 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689796979;
        bh=scbk5YRYsVggHMvCaLAFxu3w656JVeYWrqypMrbUNs0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T8zE3XeWVAqzDIHZTQOGiRbKNetAkz0LqiLaOjD0p2A/T1BBR/S9neEsx4JahhOMn
         jSwUDMEVzRGEXDpS0A8z83xWGyYcYgcjaQwHZ7zeYgjWBfrjCJGHThw3s+tm9/0zdC
         zO3lGVA2KuPOP+0axdHyncagf598QQV5sPca1d5t5rgCywefd64zTVMYsTGOs9IjK9
         yNb1oA7ERkMymImQYWV9O3rGDEN6g4zbxnl9tZtpH1YToRfCd9f+mQftiCu9o6hqQy
         nllriGnmlQ9L9CSUEi5zaW6GvAMoULjpX8TsumAcwLoScgbpXtlO891B7RSflz/SJu
         mLETum6PfSa1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4F40CE0928; Wed, 19 Jul 2023 13:02:58 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:02:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next
 for rculist_nulls
Message-ID: <1c3260bc-9e22-4ea4-9790-50f9a78581ee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-6-paulmck@kernel.org>
 <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
 <BE64BF3F-69AD-4522-965E-0B7E4054D737@gmail.com>
 <3f6b04b3-af22-49f0-8d3c-269640f9f762@paulmck-laptop>
 <449d0d48-ac98-659b-4d03-e75c318605d4@joelfernandes.org>
 <50bc6e0d-7d9b-4634-999a-2ee8f503e86a@paulmck-laptop>
 <129BFB2B-1A19-437E-B04E-16B16AA4C838@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <129BFB2B-1A19-437E-B04E-16B16AA4C838@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:17:58AM +0800, Alan Huang wrote:
> 
> > 2023年7月20日 02:20，Paul E. McKenney <paulmck@kernel.org> 写道：
> > 
> > On Tue, Jul 18, 2023 at 09:48:59PM -0400, Joel Fernandes wrote:
> >> 
> >> 
> >> On 7/18/23 14:32, Paul E. McKenney wrote:
> >>> On Tue, Jul 18, 2023 at 10:48:07PM +0800, Alan Huang wrote:
> >>>> 
> >>>>> 2023年7月18日 21:49，Joel Fernandes <joel@joelfernandes.org> 写道：
> >>>>> 
> >>>>> On 7/17/23 14:03, Paul E. McKenney wrote:
> >>>>>> From: Alan Huang <mmpgouride@gmail.com>
> >>>>>> When the objects managed by rculist_nulls are allocated with
> >>>>>> SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an object
> >>>>>> even though it is just now being added, which means the modification of
> >>>>>> ->next is visible to readers.  This patch therefore uses WRITE_ONCE()
> >>>>>> for assignments to ->next.
> >>>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> >>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>>>> 
> >>>>> Did we ever conclude that the READ_ONCE() counterparts were not needed? ;-)
> >>>> 
> >>>> Read-side is already protected by rcu_dereference_raw() in hlist_nulls_for_each_entry_{rcu, safe}.
> >>> 
> >>> It turns out that different traversal synchronization designs want
> >>> different pointers using WRITE_ONCE().
> >> 
> >> Thank you Alan and Paul,
> >> 
> >> Btw, I don't see any users of hlist_nulls_unhashed_lockless(), maybe it can
> >> be removed?
> > 
> > Either that or the people who removed uses injected bugs...
> 
> It has never been used.
> 
> That said, the data race has been there almost for four years.
> 
> And the network people use sk_unhashed() for both hlist_node and hlist_nulls_node.
> So, I plan to use hlist_unhashed_lockless() in sk_unhashed(), that will be one of my future patches.
> 
> > 
> > But if this one really does go away, do we need ->pprev to be
> > protected by _ONCE()?
> 
> The ->pprev thing is what I’m currently working on. :)

Very good, looking forward to seeing what you come up with!

							Thanx, Paul
