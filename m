Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37977B8762
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbjJDSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbjJDSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:04:40 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB6BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rdNUG6VypG8ZPGiyeASVVVgbZI92wpsXdMNeWjK5qZw=;
  b=Ac1tVy1WIeroFpp5CYJUNFz7inf39DkW/4WLGpswoREPS6latF9eNGJI
   zT+hXmVvbGhMGgYWw7LAHXG0Yzk3GTZBtJX0vHG00W+y1zq/6fqt6GFX2
   oTouoDiIsg+66gNqAT5fFuBKy7/8yUu9Y0jSFLQJXCRHXOInOH4Bqu2t6
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,201,1694728800"; 
   d="scan'208";a="67787618"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 20:04:35 +0200
Date:   Wed, 4 Oct 2023 20:04:34 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <20231004174801.GE19999@noisy.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2310041958380.3108@hadrien>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231003215159.GJ1539@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041358420.3108@hadrien> <20231004120544.GA6307@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <20231004174801.GE19999@noisy.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll go build the benchmark thing tomorrow, if I can figure out how that
> works, this NAS stuff looked 'special'. Nothing simple like ./configure;
> make -j$lots :/

Starting from git clone, I had to do:

cd NPB3.4-OMP
mkdir bin
cd config
cp make.def.template make.def
cd ..
make ua CLASS=C

You also need gfortran to be installed.


>
> > The commit e8f331bcc270 starts with
> >
> > -       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
> > +       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> >
> > This seemed like a big change - cfs_rq->nr_running > 1 should be rarely
> > true in ua, while cfs_rq->nr_running should always be true.  Adding back
> > the > 1 and simply replacing the test by 0 both had no effect, though.
>
> Yeah, this is because I flip the order of place_entity() and
> nr_running++ around later in the patch. Previously it would increment
> before place, now it does place before increment.

Ah, ok, not likely the source of the problem then.

Thanks,
julia
