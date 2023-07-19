Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54827758F08
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGSH31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGSH3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:29:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DA9E60;
        Wed, 19 Jul 2023 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xl78/WYSoHzrvKBvWbbCGhTvulPHGsSDdgV7YlEU7EQ=; b=jFzZO9jLXOoirrBttyynwHUG+7
        VQ+0fP4e53cpMXtvjHu1FdOVFM54+zSu4+sEiF73YnRpx+0reoOIC10Agfc4LaPHYWgnrbf2zjBwb
        CqdKy5DffN7r5y5vz8b80bj3MEs2mfmiIFfT1SE9V/14EoNQQptlSUER4R7I+qdI1x1ySoU6qGkVX
        pWOdBPIiOXFI3oTtbjbyKPf5hK+RN0P5+Vrd8xN8+yGUd/OR+H2FRaZABTBPeVmgOaFafV+2tH8mY
        Vb9ZVS9AC8x8PXkmGgNlaTsaJUc3dLWJWcFDVl8RaCyQnYAg6usrnCthFwqW07o1dWdq1/WXK+8Ue
        XSJj8r8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qM1cC-00DSb0-1a;
        Wed, 19 Jul 2023 07:28:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95B953001E7;
        Wed, 19 Jul 2023 09:28:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E0E3266880AC; Wed, 19 Jul 2023 09:28:50 +0200 (CEST)
Date:   Wed, 19 Jul 2023 09:28:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 3/6] x86/cpuid: Add smp helper
Message-ID: <20230719072850.GA3529734@hirez.programming.kicks-ass.net>
References: <cover.1689748843.git.sandipan.das@amd.com>
 <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:25:38PM +0530, Sandipan Das wrote:
> Depending on which CPU the CPUID instruction is executed, some leaves
> can report different values. There are cases where it may be required
> to know all possible values.
> 
> E.g. for AMD Zen 4 processors, the ActiveUmcMask field from leaf
> 0x80000022 ECX, which provides a way to determine the active memory
> controllers, can have different masks on CPUs belonging to different
> sockets as each socket can follow a different DIMM population scheme.
> Each memory channel is assigned a memory controller (UMC) and if no
> DIMMs are attached to a channel, the corresponding memory controller
> is inactive. There are performance monitoring counters exclusive to
> each memory controller which need to be represented under separate
> PMUs. So, it will be necessary to know the active memory controllers
> on each socket during the initialization of the UMC PMUs irrespective
> of where the uncore driver's module init runs.
> 
> Add a new helper that executes CPUID on a particular CPU and returns
> the EAX, EBX, ECX and EDX values.
> 

So I hate all this for multiple reasons:

 - the wohle foo_on_cpu() model generally leads to atrocious code that
   does multiple IPIs, I've seen rdmsr_on_cpu() followed by
   wrmsr_on_cpu() and worse things, just don't do this.

 - The whole CPUID thing is insane; we should read CPUID -- all of it --
   *ONCE* at bringup and thereafter never touch the instruction ever
   again. It could be people are already working on patches to this
   effect.

 - Different CPUID values for different CPUs is a pain :/
