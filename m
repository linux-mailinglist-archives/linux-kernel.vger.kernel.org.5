Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5376DA10
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjHBV6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjHBV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:58:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3E2698
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wFp82q9UK/1na1xyjRlFWk1ge9rCaVb4+zHZ4ttGQMw=; b=epLuKMagspVNjQw4lJgawfCxsE
        NGdRHk4k13kjHXWTQkl0byPEA9aN/ab7EAWzjrYSmwwJmdiQ3vbisGCE6B07Bie9OzGBXKZiOPIFK
        YjEe2Zlq/JisWU8eg/+Ar1b2DErBhEs5/ugpFHIU7VKq6pO2YC/tNSBcuACGW6eiBbynv1P1ZbbEr
        ON6MaIWrLxLP2Y5qAgB5mA5jmHZQdVEQV8Sw6tSr/BK5TGE7mXrg2Hc2R/ObPCf/X20smp56Vyw4U
        srzJ/CQKDe9tOx5RyzPPnG4HJGtcCl/MniTxunRXENHS5oESNYdgVAowTM3ccdIfZ2LCqxVyN9BTK
        edFIno9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRJrD-00GGBw-0h;
        Wed, 02 Aug 2023 21:58:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87D9530007E;
        Wed,  2 Aug 2023 23:58:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7340721094074; Wed,  2 Aug 2023 23:58:14 +0200 (CEST)
Date:   Wed, 2 Aug 2023 23:58:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/6] perf: Add branch stack extension
Message-ID: <20230802215814.GH231007@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522113040.2329924-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522113040.2329924-2-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:30:36AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Currently, the extra information of a branch entry is stored in a u64
> space. With more and more information added, the space is running out.
> For example, the information of occurrences of events will be added for
> each branch.
> 
> Add an extension space to record the new information for each branch
> entry. The space is appended after the struct perf_branch_stack.
> 
> Add a bit in struct perf_branch_entry to indicate whether the extra
> information is included.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Sandipan Das <sandipan.das@amd.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> 
> New patch
> - Introduce a generic extension space which can be used to
>   store the LBR event information for Intel. It can also be used by
>   other ARCHs for the other purpose.
> - Add a new bit in struct perf_branch_entry to indicate whether the
>   extra information is included.

Bah.. I don't like this, also the actual format isn't clear to me.

The uapi part is severely lacking, it just adds the ext:1 thing, but
doesn't describe what if anything happens when it's set.

The internal perf_branch_stack_ext thing is just that, internal.
Additionally it contains a nr member, which seems to suggest it can be
different from the number of entries in the branch-stack itself -- which
would be odd indeed.

So we have an 'ext' bit per branch entry to indicate the existance of
this extra data, this again suggests no 1:1 correspondence, but at most
one extra entry per set bit.

Parsing this will be pretty horrible, no?

So what we have now is:

	{ u64			nr;
	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
	  { u64 from, to, flags; } lbr[nr];
	} && PERF_SAMPLE_BRANCH_STACK

and AFAICT you're doing:

	{ u64			nr;
	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
	  { u64 from, to, flags; } lbr[nr];
+	  { u64	nr2;
+	    { u64 extra; } extra[nr2];
+         } && OR_i{lbr[i].flags.ext}
	} && PERF_SAMPLE_BRANCH_STACK

Which is pretty horrific, no? The straight forward:

	{ u64			nr;
	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
	  { u64 from, to, flags; } lbr[nr];
+	  { u64 extra; } ext[nr] && SOMETHING
	} && PERF_SAMPLE_BRANCH_STACK

Or perhaps even:

	{ u64			nr;
	  { u64 hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
	  { u64 from, to, flags; 
+	    u64 extra; && SOMETHING
	  } lbr[nr];
	} && PERF_SAMPLE_BRANCH_STACK

With the obvious question what 'SOMETHING' should be. I suppose
PERF_SAMPLE_BRANCH_EXTRA was considered and discarded?

Implementing the last suggestion wouldn't even be too bad, since having
PERF_SAMPLE_BRANCH_EXTRA set, we know to allocate and cast the existing
perf_sample_data::br_stack to a convenient new type, something like:

struct perf_branch_entry_ext {
	__u64	from;
	__u64	to;
	__u64	mispred:1,  /* target mispredicted */
		predicted:1,/* target predicted */
		in_tx:1,    /* in transaction */
		abort:1,    /* transaction abort */
		cycles:16,  /* cycle count to last branch */
		type:4,     /* branch type */
		spec:2,     /* branch speculation info */
		new_type:4, /* additional branch type */
		priv:3,     /* privilege level */
		reserved:31;
	__u64	extra;
};

Except at that point I think I would suggest doing s/EXTRA/COUNTERS/g
and making it something like:

	union {
		__u64	counters;
		__u8 	c[8];
	};

Or something daft like that.

Wouldn't all that make *MUCH* more sense?
