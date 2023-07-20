Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1775AA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjGTI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGTIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:50:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5EFD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d1GRTV8DaIBcVh8Suf9pIdOVp8Q4aHQl6vOAxTSkBmk=; b=T3cyL9iUEMIIa7s5Cyt/WoTFfy
        X3+vIPSbdFmlzf+sV33p4Rv6/lJKf3n53c2ul61VVsqVXiwK+U7pcc/gHVh7TrcwSFCCtbt0Ks8O6
        CNmZAnFLulEuXbCM3XmNfYlouhGS70c4QaRj+jWnKmjA8scPRW0Ff4ZZKBILyjEWncsjczLJxUpf+
        2UQ3+jxb/CRspgCldHMF/yFX4HDiIKooi4BbySGmvhGBftA1xSbeO/2yyBwOfAZV8Z9/tmEfUyC3a
        6uom1mUZ3kOAvM/6XKsj6IOsWGv58u3wVMMGZAcIPBIATKRTqGGorQXOio3BSqrPqRVYFfrP8mqiX
        L2VLVHjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMPMn-00FRJz-2r;
        Thu, 20 Jul 2023 08:50:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60C5D300095;
        Thu, 20 Jul 2023 10:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FBED2B32666E; Thu, 20 Jul 2023 10:50:32 +0200 (CEST)
Date:   Thu, 20 Jul 2023 10:50:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, luoben@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU
 topology.
Message-ID: <20230720085032.GB3569127@hirez.programming.kicks-ass.net>
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:34:11PM +0800, Kenan.Liu wrote:
> From: "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
> 
> Multithreading workloads in VM with Qemu may encounter an unexpected
> phenomenon: one hyperthread of a physical core is busy while its sibling
> is idle. Such as:

Is this with vCPU pinning? Without that, guest topology makes no sense
what so ever.

> The main reason is that hyperthread index is consecutive in qemu native x86 CPU
> model which is different from the physical topology. 

I'm sorry, what? That doesn't make sense. SMT enumeration is all over
the place for Intel, but some actually do have (n,n+1) SMT. On AMD it's
always (n,n+1) IIRC.

> As the current kernel scheduler
> implementation, hyperthread with an even ID number will be picked up in a much
> higher probability during load-balancing and load-deploying.

How so?

> This RFC targets to solve the problem by adjusting CFS loabalance policy:
> 1. Explore CPU topology and adjust CFS loadbalance policy when we found machine
> with qemu native CPU topology.
> 2. Export a procfs to control the traverse length when select idle cpu.
> 
> Kenan.Liu (2):
>   sched/fair: Adjust CFS loadbalance for machine with qemu native CPU
>     topology.
>   sched/fair: Export a param to control the traverse len when select
>     idle cpu.

NAK, qemu can either provide a fake topology to the guest using normal
x86 means (MADT/CPUID) or do some paravirt topology setup, but this is
quite insane.
