Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641627E5258
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjKHJEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjKHJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:04:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476710A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DwKMrZEJqJWyb1iBNiRoOym1/rT8hlneyKBBreukvKY=; b=eWtfMsEVUfu3st4uo/Ysp7hJuh
        /SLVqHjLFQGPjGeNt2JGCWk+5JrNdlgb4HdLTUDlL4+qRLYUllYFWVrzEYzN5tG3Nq5sZX5b6PtXB
        NuVFNWKWcdssAEA/Y07Jp+leufgCPmizUk/Ow2ZGRNKmHibvJceCi3e/3tt9zqLF6H50VTGzE0vAZ
        pGRqMPekzCxjrxrs9HYym6AWm06Ks6DOMMV5QfG+IBQlvQxsKB+Rl9NSspVENRkCT1EgBhc8+L7e/
        vRD+Hh4ok5twbF8V7rV8n1uJH9pZ9qgup7sAYSIaaOnbvEe3ox/FNJ9yd22nq/FQ2Zwbu+6IUi1ll
        2pqpVMTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0eTE-0005fY-P5; Wed, 08 Nov 2023 09:03:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2085330049D; Wed,  8 Nov 2023 10:03:33 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:03:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 38/86] sched: *_tsk_need_resched() now takes resched_t
Message-ID: <20231108090333.GI8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-39-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-39-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:24PM -0800, Ankur Arora wrote:
> *_tsk_need_resched() need to test for the specific need-resched
> flag.
> 
> The only users are RCU and the scheduler. For RCU we always want
> to schedule at the earliest opportunity and that is always
> RESCHED_eager.

Why ?

> 
> For the scheduler, keep everything as RESCHED_eager for now.

Why ?
