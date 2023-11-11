Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA787E8C38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjKKSyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 13:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjKKSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 13:54:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87293860;
        Sat, 11 Nov 2023 10:54:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B88C433C8;
        Sat, 11 Nov 2023 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699728873;
        bh=oo5O6rf4BgBduIC/o4zIoXXInF+9i4ULrLw/tboxCQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKsvU79Lp0NZys+X2bUEhwEkXMdiKL7Vt+o5EO0rAy43V5W4F43MGt4yrAge1Ei+O
         TXd1+JtRNFFtaEsmcYcZkuYEYFexW/9LzNAK4kRR0V1F4AQ8fENfyHnCPV7sCQpsuC
         8lDsG8XvIJbv4Bn4NCclmdGVuF9hf1WtDU0KwuAvVcKe93qlLj7vLO8TEg5e2GbiWr
         eTqO0oJOnMT9G/grSyWF6GnETcLsCagMfPHbbnwj8JVxuLBb+qdA5YF6QDkDz6aE0B
         7XZl8a+4stCiLnfP6S/kFFdI3Qr4Q6LS109izujXtXWsNYrhJgPkfBQy0HQxOc4a8o
         95BwGR9qa/+rQ==
Date:   Sat, 11 Nov 2023 10:54:30 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20231111185430.7j5izoshctdmu5h5@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231111184908.ym4l6cwzwnkl7e6m@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 10:49:10AM -0800, Josh Poimboeuf wrote:
> On Fri, Nov 10, 2023 at 10:57:58PM -0800, Namhyung Kim wrote:
> > > +static void perf_pending_task_unwind(struct perf_event *event)
> > > +{
> > > +       struct pt_regs *regs = task_pt_regs(current);
> > > +       struct perf_output_handle handle;
> > > +       struct perf_event_header header;
> > > +       struct perf_sample_data data;
> > > +       struct perf_callchain_entry *callchain;
> > > +
> > > +       callchain = kmalloc(sizeof(struct perf_callchain_entry) +
> > > +                           (sizeof(__u64) * event->attr.sample_max_stack) +
> > > +                           (sizeof(__u64) * 1) /* one context */,
> > > +                           GFP_KERNEL);
> > 
> > Any chance it can reuse get_perf_callchain() instead of
> > allocating the callchains every time?
> 
> I don't think so, because if it gets preempted, the new task might also
> need to do an unwind.  But there's only one task-context callchain per
> CPU.

BTW it's not just preemption, this code can also block when the unwinder
tries to copy from user space.  So disabling preemption isn't an option.

-- 
Josh
