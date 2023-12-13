Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE09811BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379341AbjLMSKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjLMSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:10:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D1AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:10:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F8FC433C8;
        Wed, 13 Dec 2023 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702491011;
        bh=Ibow/m3GEIZ8IbXREIXNaOr+KBGSFkWlItf/pSKXo4c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ssMW5lZJIZ5NkgTVS2CPSerSu2jRNbbVAQMzsq1elsgc+uvsg7FpqeseiFpjIgOzd
         xPYO9kMqRGH4nMcEa/Io2KeiyRXVRmhuZstS0RDleFb+oYGQkJKdvwU1GNLLZ3jC2L
         dl27/wYKQZbdsnsPx15szs2sxCYclPJA6663OmuN69hchuNg5wd1SwMw5m6i4CRJO7
         vdVwsZBN/V28TYQGDM30RT4DhIAC6h6Phd41QN0EY6/kxpgZBRIFw3DwfBJdo4q4RC
         skmIisgdZ0wGWDFyN+kYeAH2LBWKgJ1vnwQ4pbU60sLhhTOY4tlc4ZGP4Ir9cZ+tIz
         ahBjiOpKnm4dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3608ACE0C4D; Wed, 13 Dec 2023 10:10:11 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:10:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
Message-ID: <41db96d6-db3f-4e17-87a1-744441ae56c5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231211015717.1067822-1-joel@joelfernandes.org>
 <48B36383-8849-4F52-8882-3B98AD0B9AF7@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48B36383-8849-4F52-8882-3B98AD0B9AF7@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:11:30PM -0500, Joel Fernandes wrote:
> 
> 
> > On Dec 10, 2023, at 8:57 PM, Joel Fernandes (Google) <joel@joelfernandes.org> wrote:
> > 
> > ﻿The comments added in commit 1ef990c4b36b ("srcu: No need to
> > advance/accelerate if no callback enqueued") are a bit confusing to me.
> > The comments are describing a scenario for code that was moved and is
> > no longer the way it was (snapshot after advancing). Improve the code
> > comments to reflect this and also document by acceleration can never
> > fail.
> > 
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Do we want to quick review and put it in Neeraj PR?
> 
> Or next merge window ok with me. Just that then I have to keep track of it ;-)

Or it could get an ack and I could pull it into -rcu.  ;-)

							Thanx, Paul

> Thanks,
> 
> - Joel 
> 
> 
> 
> > ---
> > v1->v2: Fix typo in change log.
> > 
> > kernel/rcu/srcutree.c | 24 ++++++++++++++++++++----
> > 1 file changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 0351a4e83529..051e149490d1 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1234,11 +1234,20 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >    if (rhp)
> >        rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> >    /*
> > -     * The snapshot for acceleration must be taken _before_ the read of the
> > -     * current gp sequence used for advancing, otherwise advancing may fail
> > -     * and acceleration may then fail too.
> > +     * It's crucial to capture the snapshot 's' for acceleration before
> > +     * reading the current gp_seq that is used for advancing. This is
> > +     * essential because if the acceleration snapshot is taken after a
> > +     * failed advancement attempt, there's a risk that a grace period may
> > +     * conclude and a new one may start in the interim. If the snapshot is
> > +     * captured after this sequence of events, the acceleration snapshot 's'
> > +     * could be excessively advanced, leading to acceleration failure.
> > +     * In such a scenario, an 'acceleration leak' can occur, where new
> > +     * callbacks become indefinitely stuck in the RCU_NEXT_TAIL segment.
> > +     * Also note that encountering advancing failures is a normal
> > +     * occurrence when the grace period for RCU_WAIT_TAIL is in progress.
> >     *
> > -     * This could happen if:
> > +     * To see this, consider the following events which occur if
> > +     * rcu_seq_snap() were to be called after advance:
> >     *
> >     *  1) The RCU_WAIT_TAIL segment has callbacks (gp_num = X + 4) and the
> >     *     RCU_NEXT_READY_TAIL also has callbacks (gp_num = X + 8).
> > @@ -1264,6 +1273,13 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >    if (rhp) {
> >        rcu_segcblist_advance(&sdp->srcu_cblist,
> >                      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > +        /*
> > +         * Acceleration can never fail because the state of gp_seq used
> > +         * for advancing is <= the state of gp_seq used for
> > +         * acceleration. This means that RCU_NEXT_TAIL segment will
> > +         * always be able to be emptied by the acceleration into the
> > +         * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
> > +         */
> >        WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
> >    }
> >    if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> > -- 
> > 2.43.0.472.g3155946c3a-goog
> > 
