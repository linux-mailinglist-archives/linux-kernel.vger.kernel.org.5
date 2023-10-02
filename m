Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DA7B5C83
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjJBViX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJBViV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:38:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A06AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IOnyXCPE/X01FPFeE/AD8XCGbNcYV5U6wQzXkM72WrE=; b=MlyNf6KkNPAmEp9Xe+n4yUvYwY
        plegmkH98M4oOaoMU+Sw2IinQ9JZC6GPMcF8aSzobFgSDnPjwzZWeGxg1GGwoiZlKgDDBae/ZTxHP
        M5k7BGSpSRWpsc1lJxJEJE0IBo5WBxu42EiSRb41qwWiuBohSzci0MXOBNz6tM2aA4pXnep8A/vQt
        frlviKS5bU9yYNmjGlVZQTebFDtXV8V6TDrdWnxP7py6n2g8VPVhpD/RojGgkGJSDnZ10+AuKa2Xv
        9bjSTlaiXJBncshvIDxnSzz4wg4jY3NNNGHI8x9E6yXYP+SmawSLqDtzsQkNVJQhA039yhLcn123E
        3oPzBHzA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnQbv-009JiK-1F;
        Mon, 02 Oct 2023 21:37:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3585F300454; Mon,  2 Oct 2023 23:37:52 +0200 (CEST)
Date:   Mon, 2 Oct 2023 23:37:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Message-ID: <20231002213752.GB1539@noisy.programming.kicks-ass.net>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
 <20231002154535.GB35785@noisy.programming.kicks-ass.net>
 <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:19:04PM -0400, Liang, Kan wrote:

> >> Also, add a new branch sample type, PERF_SAMPLE_BRANCH_EVT_CNTRS, to
> >> indicate whether include occurrences of events in branch info. The
> >> information will be stored in the extra space.
> > 
> > This... why do we need two flags?
> 
> Users may only collect the occurrences of some events in a group. The
> EVT_CNTRS flag is used to indicate those events. E.g.,
> perf record -e "{cpu/branch-instructions,branch_type=call/,
> cpu/branch-misses,branch_type=event/}"
> 
> Only the occurrences of the branch-misses event is collected in LBR and
> finally dumped into the extra buffer.
> 
> While the first flag, PERF_SAMPLE_BRANCH_EXTRA, only tells that the
> extra space is required.

Or have it implicit, I reallt don't see the point of having two bits
here.

> > Also, I can't find this in the SDM, how wide are these counter deltas?
> > ISTR they're saturating, but not how wide they are.
> 
> Now, it's documented in the Intel® Architecture Instruction Set
> Extensions and Future Features, Chapter 8, 8.6 LBR ENHANCEMENTS. It
> should be moved to SDM later.
> https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Only 2 bits for each counter. Saturating at a value of 3.

Urgh, this ISE document is shite, that thing don't say how many
IA32_LBR_INFO.PMCx_CNT fields there are, I think your later patch says
4, right? And is this for arch LBR or the other thing?

(Also, what is IA32_LER_x_INFO ?)

This is then a grant total of 8 bits.

And we still have 31 spare bits in perf_branch_entry.

Why again do we need the extra u64 ?!?

More specifically, this interface is pretty crap -- suppose the next
generation of things feels that 2 bits aint' enough and goes and gives
us 4. Then what do we do?

Did I already say that the ISE document raises more questions than it
provides answers?
