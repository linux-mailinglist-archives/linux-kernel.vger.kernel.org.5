Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C77F153E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKTOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjKTOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:04:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B621170B;
        Mon, 20 Nov 2023 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uc0JwOzjLilE+8LV/PtshmiVin5WqZkelAmOVULsXo8=; b=bMOpwJOKHP6MJ+6u4ayDpeHEvk
        Nicuud2iLkCBvPRrIyD2ZakyHmEVOmc48ewko+sLmU12OUElmhF/jd19NP5jsWqb/P4YhLiBP6SsD
        oKBdIg5oZjdWkAeLk6Z+fJOb0QRzBLiUL/7RD4yPU5vMELaV3I3eozlPGI6hKjcvQeS8YZFDH1peu
        nFzyShk+ZibBIJ5xCX2tzekTvbdzlkvwPe7axYOsdty9b6KRlz6v2V2E5W36y1Kk1NfO9NBxam4Vw
        9qG4rfr3Zi14+UGbZBnI32cfUQXNvGDX1cHvGrh5ejSQ7oDXEoeRKoTSini6sdT0Rmbl/nkoCINkX
        f2q5I8vw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r54sA-00AzmG-1J;
        Mon, 20 Nov 2023 14:03:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12E36300419; Mon, 20 Nov 2023 15:03:34 +0100 (CET)
Date:   Mon, 20 Nov 2023 15:03:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20231120140334.GW8262@noisy.programming.kicks-ass.net>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <ZVTuK5VRQfY1JOEY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTuK5VRQfY1JOEY@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:13:31AM -0800, Namhyung Kim wrote:

> ---8<---
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 39c6a250dd1b..a3765ff59798 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -456,7 +456,8 @@ struct perf_event_attr {
>  				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
>  				remove_on_exec :  1, /* event is removed from task on exec */
>  				sigtrap        :  1, /* send synchronous SIGTRAP on event */
> -				__reserved_1   : 26;
> +				defer_callchain:  1, /* generate DEFERRED_CALLCHAINS records for userspace */
> +				__reserved_1   : 25;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> @@ -1207,6 +1208,20 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
>  
> +	/*
> +	 * Deferred user stack callchains (for SFrame).  Previous samples would

Possibly also useful for ShadowStack based unwinders. And by virtue of
it possibly saving work when multiple consecutive samples hit
the same kernel section, for everything.

> +	 * have kernel callchains only and they need to be stitched with this
> +	 * to make full callchains.
> +	 *
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				nr;
> +	 *	u64				ips[nr];
> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_DEFERRED_CALLCHAINS		= 22,
> +
>  	PERF_RECORD_MAX,			/* non-ABI */
>  };
>  

Anyway, yeah, that should do I suppose.
