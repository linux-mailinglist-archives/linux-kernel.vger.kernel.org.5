Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0E7B7388
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjJCVwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjJCVwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:52:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11455A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nnmS8DXkjdVhg68qX7c14kBClGtQYzgjiQqqX6QhaL4=; b=HeB+7NoXrJ4t/oTZGb8b7OFEFi
        V3A3z9zevjwclhDluaVDBm0i3fGqXet/tTX/csic4k0xIgGo02PMH0W8BT9zAeG22T1P2+eQbjhGx
        0iEVSOJzfAXwv99OLmbX1hXuhw/4IgRdGqaApb1e7dwDumDjJpiDNRBn6HV14VCvDBdY0gc0pqv7Z
        KiQTRvCHJVWfz/M2Jw3s4jw+l0DpnjCGPAof3RUvoP84ag3Db04OdWLVquDRMjnjtKKAaFLwH9J7D
        C/UgnaS1zBMMR9sVhdzIpCNQLEKWnINUsRh7KN+m0Rw/uXH7TIBeVOiEc/NIDIEmLQv/m/0937SYL
        syiGWLkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnnJA-00HLnP-2L; Tue, 03 Oct 2023 21:52:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B88BB30036C; Tue,  3 Oct 2023 23:51:59 +0200 (CEST)
Date:   Tue, 3 Oct 2023 23:51:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
Message-ID: <20231003215159.GJ1539@noisy.programming.kicks-ass.net>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:25:08PM +0200, Julia Lawall wrote:
> Is it expected that the commit e8f331bcc270 should have an impact on the
> frequency of NUMA balancing?

Definitely not expected. The only effect of that commit was supposed to
be the runqueue order of tasks. I'll go stare at it in the morning --
definitely too late for critical thinking atm.

Thanks!

> The NAS benchmark ua.C.x (NPB3.4-OMP,
> https://github.com/mbdevpl/nas-parallel-benchmarks.git) on a 4-socket
> Intel Xeon 6130 suffers from some NUMA moves that leave some sockets with
> too few threads and other sockets with too many threads.  Prior to the
> commit e8f331bcc270, this was corrected by subsequent load balancing,
> leading to run times of 20-40 seconds (around 20 seconds can be achieved
> if one just turns NUMA balancing off).  After commit e8f331bcc270, the
> running time can go up to 150 seconds.  In the worst case, I have seen a
> core remain idle for 75 seconds.  It seems that the load balancer at the
> NUMA domain level is not able to do anything, because when a core on the
> overloaded socket has multiple threads, they are tasks that were NUMA
> balanced to the socket, and thus should not leave.  So the "busiest" core
> chosen by find_busiest_queue doesn't actually contain any stealable
> threads.  Maybe it could be worth stealing from a core that has only one
> task in this case, in hopes that the tasks that are tied to a socket will
> spread out better across it if more space is available?
> 
> An example run is attached.  The cores are renumbered according to the
> sockets, so there is an overload on socket 1 and an underload on sockets
> 2.
> 
> julia


