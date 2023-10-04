Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420177B7E95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbjJDMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJDMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:01:35 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F68A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cRAsb9oQxIrg5d7xP8u94JUhKrAckfPAD8OQOEx9FcQ=;
  b=Z01BSt53YHGGRMCRSSmmJO5TXcL+CM4t5BMXNRshVUYKm/tU0KY75iyK
   i35/2mx1YzZoB6T1oV1C2coI+Yvn8pi0UC6C7RHVtUrGZbtT+3WcS5f3X
   uBzdcdFVGkEBsKo6kBo9FrcfZ1Io25GuLy0owe1FuTMLmSi2rRX01/BMF
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,200,1694728800"; 
   d="scan'208";a="129423003"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 14:01:26 +0200
Date:   Wed, 4 Oct 2023 14:01:26 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <20231003215159.GJ1539@noisy.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2310041358420.3108@hadrien>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231003215159.GJ1539@noisy.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Oct 2023, Peter Zijlstra wrote:

> On Tue, Oct 03, 2023 at 10:25:08PM +0200, Julia Lawall wrote:
> > Is it expected that the commit e8f331bcc270 should have an impact on the
> > frequency of NUMA balancing?
>
> Definitely not expected. The only effect of that commit was supposed to
> be the runqueue order of tasks. I'll go stare at it in the morning --
> definitely too late for critical thinking atm.

Maybe it's just randomly making a bad situation worse rather than directly
introduing a problem.  There is a high standard deviatind in the
performance.  Here are some results with hyperfine.  The general trends
are reproducible.

julia

Parent of e8f331bcc270, and typical of earlier commits:

::::::::::::::
ua.C.x_yeti-4_g76cae9dbe185_performance.json
::::::::::::::
{
  "results": [
    {
      "command": "./ua.C.x",
      "mean": 30.404105904309993,
      "stddev": 6.453760260515126,
      "median": 29.533294615035,
      "user": 3858.47296929,
      "system": 11.516864580000004,
      "min": 21.987556851035002,
      "max": 50.464735263034996,
      "times": [
        34.413034851035,
        27.065085820035,
        26.838279920035,
        26.351314604035,
        32.374011336035,
        25.954025885035,
        23.035775634035,
        44.235798762034996,
        31.300110969035,
        23.880906093035,
        50.464735263034996,
        35.448494361034996,
        27.299214444035,
        27.225401613035,
        25.065921751035,
        25.729637724035,
        21.987556851035002,
        26.925861508035002,
        29.757618969035,
        33.824266792035,
        23.601111060035,
        27.949622236035,
        33.836797180035,
        31.107119088035,
        34.467454332035,
        25.538367186035,
        44.052246282035,
        36.811265399034994,
        25.450476009035,
        23.805947650035,
        32.977559361035,
        33.023708943035,
        30.331184650035002,
        31.707529155035,
        30.281404379035,
        43.624723016035,
        29.552102609035,
        29.514486621035,
        26.272782395035,
        23.081295470035002
      ]
    }
  ]
}
::::::::::::::
ua.C.x_yeti-4_ge8f331bcc270_performance.json
::::::::::::::
{
  "results": [
    {
      "command": "./ua.C.x",
      "mean": 39.475254171930004,
      "stddev": 23.25418332945763,
      "median": 32.146023067405,
      "user": 4990.425470314998,
      "system": 10.6357894,
      "min": 21.404253416405,
      "max": 142.348752034405,
      "times": [
        39.670084545405,
        22.450176801405,
        33.077489706405,
        65.853454333405,
        23.453408823405,
        24.179283189404998,
        59.538350766404996,
        27.435145718405,
        22.806777380405,
        44.347348933405,
        26.028480016405,
        24.918487113405,
        105.289569793405,
        32.857970958405,
        31.176198789405,
        39.639462769405,
        38.234222138405,
        41.646424303405,
        31.434075176405,
        25.651942354404998,
        42.029314429405,
        26.871583034405,
        62.334539310405,
        142.348752034405,
        23.912191729405,
        24.219083951405,
        22.243050782405,
        22.957280548405,
        35.763612381405,
        30.797416492405,
        50.024712290405,
        25.385043529405,
        27.676768642404998,
        49.878477271404996,
        30.451312037405,
        35.842247874405,
        49.171212633405,
        48.880110438405,
        47.130850438405,
        21.404253416405
      ]
    }
  ]
}




>
> Thanks!
>
> > The NAS benchmark ua.C.x (NPB3.4-OMP,
> > https://github.com/mbdevpl/nas-parallel-benchmarks.git) on a 4-socket
> > Intel Xeon 6130 suffers from some NUMA moves that leave some sockets with
> > too few threads and other sockets with too many threads.  Prior to the
> > commit e8f331bcc270, this was corrected by subsequent load balancing,
> > leading to run times of 20-40 seconds (around 20 seconds can be achieved
> > if one just turns NUMA balancing off).  After commit e8f331bcc270, the
> > running time can go up to 150 seconds.  In the worst case, I have seen a
> > core remain idle for 75 seconds.  It seems that the load balancer at the
> > NUMA domain level is not able to do anything, because when a core on the
> > overloaded socket has multiple threads, they are tasks that were NUMA
> > balanced to the socket, and thus should not leave.  So the "busiest" core
> > chosen by find_busiest_queue doesn't actually contain any stealable
> > threads.  Maybe it could be worth stealing from a core that has only one
> > task in this case, in hopes that the tasks that are tied to a socket will
> > spread out better across it if more space is available?
> >
> > An example run is attached.  The cores are renumbered according to the
> > sockets, so there is an overload on socket 1 and an underload on sockets
> > 2.
> >
> > julia
>
>
>
