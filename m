Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992527584DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGRScG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjGRScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1473F0;
        Tue, 18 Jul 2023 11:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A0D61653;
        Tue, 18 Jul 2023 18:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE9BC433C7;
        Tue, 18 Jul 2023 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689705121;
        bh=l8baMBxLHo8xo/gePwxWBpJyf65ETLy32ieqmnFWIWA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J83MPQUNKBD+OnvqW/hkocKgtvizr6JsNsiLnkizdxB0+jwAXkqM3ERcS7JlE3em+
         I2+f+hjqkN0ANtwk1e4MNsAV7vLEqMqKQ6hvZvs5A9fEETMoHisu4/yYAb18wBM3rD
         KKvl8SPSI6T0QKbXuq2cRC+cOQOVYQeGOcY8Q4bJ8x5s5MUFMmEaeheBKBxyPFZ+dc
         InUwbFSzOgrB2xy+RFMBRAbpOe3XwxvJFCNfOWT7UmFF0iy0sXsUKUGSogFLexTARW
         9UaaTlk7heJBf3Wbzkai3VNHJ9VlpF3u08YwiG4yng/PSSlqrBAdVdchadjLsQiGva
         7+1ckpQY9VMNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D0BCCE04CD; Tue, 18 Jul 2023 11:32:01 -0700 (PDT)
Date:   Tue, 18 Jul 2023 11:32:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 6/6] rcu: Use WRITE_ONCE() for assignments to ->next
 for rculist_nulls
Message-ID: <3f6b04b3-af22-49f0-8d3c-269640f9f762@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-6-paulmck@kernel.org>
 <9651c3b4-0791-5cd7-567f-f65d28bc8fae@joelfernandes.org>
 <BE64BF3F-69AD-4522-965E-0B7E4054D737@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BE64BF3F-69AD-4522-965E-0B7E4054D737@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:48:07PM +0800, Alan Huang wrote:
> 
> > 2023年7月18日 21:49，Joel Fernandes <joel@joelfernandes.org> 写道：
> > 
> > On 7/17/23 14:03, Paul E. McKenney wrote:
> >> From: Alan Huang <mmpgouride@gmail.com>
> >> When the objects managed by rculist_nulls are allocated with
> >> SLAB_TYPESAFE_BY_RCU, old readers may still hold references to an object
> >> even though it is just now being added, which means the modification of
> >> ->next is visible to readers.  This patch therefore uses WRITE_ONCE()
> >> for assignments to ->next.
> >> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> >> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Did we ever conclude that the READ_ONCE() counterparts were not needed? ;-)
> 
> Read-side is already protected by rcu_dereference_raw() in hlist_nulls_for_each_entry_{rcu, safe}.

It turns out that different traversal synchronization designs want
different pointers using WRITE_ONCE().

> > But incremental progress and all, so this LGTM:
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I will apply all four on my next rebase, thank you!

							Thanx, Paul

> > thanks,
> > 
> > - Joel
> > 
> > 
> >> ---
> >>  include/linux/rculist_nulls.h | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> >> index ba4c00dd8005..89186c499dd4 100644
> >> --- a/include/linux/rculist_nulls.h
> >> +++ b/include/linux/rculist_nulls.h
> >> @@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
> >>  {
> >>   struct hlist_nulls_node *first = h->first;
> >>  - n->next = first;
> >> + WRITE_ONCE(n->next, first);
> >>   WRITE_ONCE(n->pprev, &h->first);
> >>   rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
> >>   if (!is_a_nulls(first))
> >> @@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
> >>   last = i;
> >>     if (last) {
> >> - n->next = last->next;
> >> + WRITE_ONCE(n->next, last->next);
> >>   n->pprev = &last->next;
> >>   rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
> >>   } else {
> > 
> 
