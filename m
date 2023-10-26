Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADC57D8487
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbjJZOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjJZOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:22:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC1128;
        Thu, 26 Oct 2023 07:22:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D8DC433C8;
        Thu, 26 Oct 2023 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698330140;
        bh=ReF9zaUXu0sZ+PuTc7MtN6FAGsaQwd2XyDGFYmv5jgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZQ/uhorQXgghmZwn2hDEQJgZ+0zTgPiYs0ZXWlBZrv9ZDsiPKSjZgcJEtLNojSOo
         EuWiQaLfdN1CHLsLgzFuTN6P2vzmuhvXYrJ9cInV8WXWOBop4ozO0eBUVRxfddVkND
         pNSnbQkEcvy3kL6eW1aZE/nP766/oy/omOfGH/8C+UySItzI7zzjKcITccD6pPZ7jR
         jyUbp5k/4ueqPtiDq4Qv+1QBWUkrshoVIVv9VGn1RrrVJs70EM2/fmU2vjvbJFJvf6
         cDQZxeQLoXQ9fRriebwubhiPbqCtqfvoVDF7MnILJEqPO9SEJfKHoabEuqGo5kCM1e
         mTP6iwhx3634g==
Date:   Thu, 26 Oct 2023 16:22:17 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZTp2Ge2ILOJ4VbYZ@lothringen>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTkwl0bzTTCy8g5N@localhost.localdomain>
 <ZTpi6diP4h84PtWE@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpi6diP4h84PtWE@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:00:25PM +0200, Uladzislau Rezki wrote:
> On Wed, Oct 25, 2023 at 05:13:27PM +0200, Frederic Weisbecker wrote:
> > > +	llist_for_each_safe(pos, head, head) {
> > 
> > Two times head intended here? There should be some
> > temporary storage in the middle.
> > 
> Yes. It is intentially done. The head is updated, i.e. shifted to a next,
> because we directly process users from a GP. The number is limited to 5
> all the rest is deferred.

Ah ok.

> > So you can have:
> > 
> > * Queue to sr.curr is atomic fully ordered
> > * Check and move from sr.curr to sr.wait is atomic fully ordered
> > * Check from sr.wait can have a quick unatomic unordered
> >   llist_empty() check. Then extract unatomic unordered as well.
> > * If too many, move atomic/ordered to sr.done.
> > 
> > Am I missing something?
> >
> If too many move to done and kick the helper. The sr.wait can not
> be touched until the rcu_sr_normal_gp_cleanup() is completed, i.e.:
> 
> <snip>
> GP-kthread(same and one task context):
>     rcu_sr_normal_gp_cleanup();
>     wait for a grace period;
>     rcu_sr_normal_gp_cleanup();
> <snip>
> 
> Am i missing your point?

Yeah got it. My point was just that any manipulation of sr.wait can be
done without atomic/ordered operations. Such as using __list_empty() and
__llist_del_all().

Ah there is also the line:

   llist_add_batch(head, tail, &sr.wait);

in rcu_sr_normal_gp_init() that can be turned into __llist_add_batch()

Thanks.
