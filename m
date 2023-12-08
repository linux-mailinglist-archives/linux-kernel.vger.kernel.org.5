Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB380A2A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573654AbjLHLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjLHLwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:52:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE11171F;
        Fri,  8 Dec 2023 03:52:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702036369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Bzhtr8Z/zHR1SS9qrv2WMjasbEmV2BoWGNIe8Z1tRg=;
        b=pmjuKESv4alxlWy9xXV/apAlv4xR7VxTUs7pAvw6l4veAR6iQbL83UpOdjpY/obRJdLcfo
        34PRGPNv5BVBMAhFccxAlq9bBigrkpWfoOBs9VEes7vF1akDLgK/JGE4Mxq0ZzCJVISx5l
        I/dDrPJqVDTtIbL53jyZ+zfZsY4ml/z0eQuZhLdJmsXO5togc6bPvyGnUQgHVXY/inOziR
        MDetaqoIKi0ESx77qQNtGyhDYIQsv7+Io2/KhThR5FzP3k8xcZxBFkr13T4U9GR6xW1NOY
        gf+6L4rqZwU7QHAmqMpzi0g3buykKehh/LFn88D+42VGaMV3BXqV805cQ4YHEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702036369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Bzhtr8Z/zHR1SS9qrv2WMjasbEmV2BoWGNIe8Z1tRg=;
        b=pS7ZGZq8uhbuePRlfYDITaiZxhff8pz3xaspEarOeSXWmtVmjO0shwgy4CuY4Dk5GJcri4
        h5Utb4ZE5vc+OqDQ==
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        seanjc@google.com, Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification handler
In-Reply-To: <20231207204607.2d2a3b72@jacob-builder>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
 <20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
 <20231115125624.GF3818@noisy.programming.kicks-ass.net>
 <87cyvjun3z.ffs@tglx> <20231207204607.2d2a3b72@jacob-builder>
Date:   Fri, 08 Dec 2023 12:52:49 +0100
Message-ID: <87zfyksyge.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07 2023 at 20:46, Jacob Pan wrote:
> On Wed, 06 Dec 2023 20:50:24 +0100, Thomas Gleixner <tglx@linutronix.de>
> wrote:
>> I don't understand what the whole copy business is about. It's
>> absolutely not required.
>
> My thinking is the following:
> The PIR cache line is contended by between CPU and IOMMU, where CPU can
> access PIR much faster. Nevertheless, when IOMMU does atomic swap of the
> PID (PIR included), L1 cache gets evicted. Subsequent CPU read or xchg will
> deal with invalid cold cache.
>
> By making a copy of PIR as quickly as possible and clearing PIR with xchg,
> we minimized the chance that IOMMU does atomic swap in the middle.
> Therefore, having less L1D misses.
>
> In the code above, it does read, xchg, and call_irq_handler() in a loop
> to handle the 4 64bit PIR bits at a time. IOMMU has a greater chance to do
> atomic xchg on the PIR cache line while doing call_irq_handler(). Therefore,
> it causes more L1D misses.

That makes sense and if we go there it wants to be documented.

> Without PIR copy:
>
> DMA memfill bandwidth: 4.944 Gbps
> Performance counter stats for './run_intr.sh 512 30':                                                             
>                                                                                                                    
>     77,313,298,506      L1-dcache-loads                                               (79.98%)                     
>          8,279,458      L1-dcache-load-misses     #    0.01% of all L1-dcache accesses  (80.03%)                   
>     41,654,221,245      L1-dcache-stores                                              (80.01%)                     
>             10,476      LLC-load-misses           #    0.31% of all LL-cache accesses  (79.99%)                    
>          3,332,748      LLC-loads                                                     (80.00%)                     
>                                                                                                                    
>       30.212055434 seconds time elapsed                                                                            
>                                                                                                                    
>        0.002149000 seconds user                                                                                    
>       30.183292000 seconds sys
>                         
>
> With PIR copy:
> DMA memfill bandwidth: 5.029 Gbps
> Performance counter stats for './run_intr.sh 512 30':
>
>     78,327,247,423      L1-dcache-loads                                               (80.01%)
>          7,762,311      L1-dcache-load-misses     #    0.01% of all L1-dcache accesses  (80.01%)
>     42,203,221,466      L1-dcache-stores                                              (79.99%)
>             23,691      LLC-load-misses           #    0.67% of all LL-cache accesses  (80.01%)
>          3,561,890      LLC-loads                                                     (80.00%)
>
>       30.201065706 seconds time elapsed
>
>        0.005950000 seconds user
>       30.167885000 seconds sys

Interesting, though I'm not really convinced that this DMA memfill
microbenchmark resembles real work loads.

Did you test with something realistic, e.g. storage or networking, too?

Thanks,

        tglx
