Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B04759D29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGSSUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGSSUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:20:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDDB6;
        Wed, 19 Jul 2023 11:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 533BC617DF;
        Wed, 19 Jul 2023 18:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9575C433C7;
        Wed, 19 Jul 2023 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689790836;
        bh=STDrO2XG5LQFsEtCL+3146/AIGbyOQu+kSYgcPpwbqE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YP6THxhJrcWyOm88VDT+pQ6UdtyGZyURfg960GO72IfdKvfr863gwxG9KH7h0szw4
         h8lc46JXX5FbCID14+MPczGiX98APiA+CQ4Pz/mrbHOXCaXhNhB47Nji6/g5rYMK7q
         mq/5fcYT4xrd+weSmhIdLFBmi2QBzHn+QDWtTMiLJQbgggj6x13kbbmqQyX84ZwjcY
         SZBCL9++rFHIckEUJZ1dqUACZ2rq3d2jS26/5Yz/FS/SungAO8Zy71OK0YqKCxRiZv
         JgaunElg6A2QjjfpkgkEDH9yzGHjC8lQOVayGiOHwUYWG6Yeh50A1oguN0Kmr7u8SM
         Jn5ivIXl/wXgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 56910CE092F; Wed, 19 Jul 2023 11:20:36 -0700 (PDT)
Date:   Wed, 19 Jul 2023 11:20:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Huang <mmpgouride@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next
 for rculist_nulls
Message-ID: <50bc6e0d-7d9b-4634-999a-2ee8f503e86a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-6-paulmck@kernel.org>
 <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
 <BE64BF3F-69AD-4522-965E-0B7E4054D737@gmail.com>
 <3f6b04b3-af22-49f0-8d3c-269640f9f762@paulmck-laptop>
 <449d0d48-ac98-659b-4d03-e75c318605d4@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <449d0d48-ac98-659b-4d03-e75c318605d4@joelfernandes.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:48:59PM -0400, Joel Fernandes wrote:
> 
> 
> On 7/18/23 14:32, Paul E. McKenney wrote:
> > On Tue, Jul 18, 2023 at 10:48:07PM +0800, Alan Huang wrote:
> > > 
> > > > 2023年7月18日 21:49，Joel Fernandes <joel@joelfernandes.org> 写道：
> > > > 
> > > > On 7/17/23 14:03, Paul E. McKenney wrote:
> > > > > From: Alan Huang <mmpgouride@gmail.com>
> > > > > When the objects managed by rculist_nulls are allocated with
> > > > > SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an object
> > > > > even though it is just now being added, which means the modification of
> > > > > ->next is visible to readers.  This patch therefore uses WRITE_ONCE()
> > > > > for assignments to ->next.
> > > > > Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > Did we ever conclude that the READ_ONCE() counterparts were not needed? ;-)
> > > 
> > > Read-side is already protected by rcu_dereference_raw() in hlist_nulls_for_each_entry_{rcu, safe}.
> > 
> > It turns out that different traversal synchronization designs want
> > different pointers using WRITE_ONCE().
> 
> Thank you Alan and Paul,
> 
> Btw, I don't see any users of hlist_nulls_unhashed_lockless(), maybe it can
> be removed?

Either that or the people who removed uses injected bugs...

But if this one really does go away, do we need ->pprev to be
protected by _ONCE()?

							Thanx, Paul
