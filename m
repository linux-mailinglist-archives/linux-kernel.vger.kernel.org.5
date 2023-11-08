Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188BA7E5605
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjKHMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHMQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:16:12 -0500
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D658B1BE8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:16:09 -0800 (PST)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id D10539DAF;
        Wed,  8 Nov 2023 14:16:06 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id ADE729DAE;
        Wed,  8 Nov 2023 14:16:06 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 88EDA3C0435;
        Wed,  8 Nov 2023 14:15:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1699445752; bh=5kNA2HkWJxRHfepizP/TtO0jMzvdoMXBRNQU3AzLFWQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=j6kgrfQx3GupUvw4PE6I5VuJ2Bluj/hWn4oJ2DFeMNVykVWlJ7EAtZDz35EF215Yv
         F+inDYsAp7u+xSV79P6MDGBAVFBf1k880pzyR00upfIzZn716JcqvNfE+Nz/HynRdT
         xkopQWlfLjo2QR6iiKrbIZ7v7/dqlvy8uOY81Vcc=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 3A8CFZqh016691;
        Wed, 8 Nov 2023 14:15:36 +0200
Date:   Wed, 8 Nov 2023 14:15:35 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     Ankur Arora <ankur.a.arora@oracle.com>
cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
In-Reply-To: <20231107215742.363031-48-ankur.a.arora@oracle.com>
Message-ID: <ed7c9c16-1f66-4c96-e532-ae74e52c270b@ssi.bg>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com> <20231107215742.363031-48-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Tue, 7 Nov 2023, Ankur Arora wrote:

> With PREEMPTION being always-on, some configurations might prefer
> the stronger forward-progress guarantees provided by PREEMPT_RCU=n
> as compared to PREEMPT_RCU=y.
> 
> So, select PREEMPT_RCU=n for PREEMPT_VOLUNTARY and PREEMPT_NONE and
> enabling PREEMPT_RCU=y for PREEMPT or PREEMPT_RT.
> 
> Note that the preemption model can be changed at runtime (modulo
> configurations with ARCH_NO_PREEMPT), but the RCU configuration
> is statically compiled.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Julian Anastasov <ja@ssi.bg>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> 
> ---
> CC-note: Paul had flagged some code that might be impacted
> with the proposed RCU changes:
> 
> 1. My guess is that the IPVS_EST_TICK_CHAINS heuristic remains
>    unchanged, but I must defer to the include/net/ip_vs.h people.

	Yes, IPVS_EST_TICK_CHAINS depends on the rcu_read_unlock()
and rcu_read_lock() calls in cond_resched_rcu(), so just removing
the cond_resched() call there is ok for us. Same for the other
cond_resched() calls in ipvs/

Regards

--
Julian Anastasov <ja@ssi.bg>

