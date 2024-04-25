Return-Path: <linux-kernel+bounces-159027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADD8B284A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B8A1F22116
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449614EC58;
	Thu, 25 Apr 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAMNXiVI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FCF12C559;
	Thu, 25 Apr 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070645; cv=none; b=GPiw8HWgaIIJQmmdDJyfd/ou1wveEOkQZdNdc3Kg8YLNnXXNlkLfjaVQn9fhah1ay/PRUImTKxVbhERy5gY1t/vFjcDtnjxslXFDOXAZh6KIqVKIeor2JWwvzj+S42ku4hKpYICbKWWhGLaUwR0d4EhWGxFMwOu2AcMtBDDgugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070645; c=relaxed/simple;
	bh=UMnP0mnL7grQXshDwkjNarPO6eRVbHtAkUexGt6fxx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6wVuAOBTTguX3Sl0n5g1nYCRUH0AuNSy6NVuv4bHg5UXvwejPshFJpykGsmcCmmGRsxuiLDRhxeXcyL/dcJhnbYYUTadau65EYPsnUpPtAddvjtcxxPCu43hBpEo58j5g2fbzeMsL1vklqhlrjxyKIf+V248+QDekTfUe86iF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAMNXiVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B67C4AF07;
	Thu, 25 Apr 2024 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070644;
	bh=UMnP0mnL7grQXshDwkjNarPO6eRVbHtAkUexGt6fxx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAMNXiVIvoFFAn/ntq5SR2ZwG723BMuth8qUQU8VVXh9o0P7K0ICwyp9JEnM5Lu5w
	 ha3gvTMYpaiKa293+Ubtwf4l5NnLlTWe+Exysid4SqjYHi/2n85Uph1StH6vaGV6kY
	 ob6YluVmgVazLCtjQIbVtKN7yjGAOIaHztMepJ8LZRE4LpmEFE6m1r9fh0JWovg1gz
	 lAfKa9NGKZrv+woiLQzbKdsMjmyAYFg2KFZiTUMZzoRXNImryHnlkC36nY4tFM2Nx4
	 UBW6mYJziTVaqlJSCvgUwBvoJmlXVAr+4UudPU6xUt3MOq4y5h2WhJYJWHbhv8QIql
	 lcR3eWefwgG/Q==
Date: Thu, 25 Apr 2024 15:43:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix unassigned instruction op
Message-ID: <Ziqkb9lF30W0XX5d@x1>
References: <20240320162619.1272015-1-irogers@google.com>
 <20240326083223.10883-1-adrian.hunter@intel.com>
 <CAP-5=fVbR8xvFvG_cnzq6==QbZ1wX9mPT-RWHEMgaTp6ic0jNA@mail.gmail.com>
 <d7b31967-0820-4eef-8746-db0299af154f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7b31967-0820-4eef-8746-db0299af154f@intel.com>

On Tue, Mar 26, 2024 at 06:52:12PM +0200, Adrian Hunter wrote:
> On 26/03/24 18:13, Ian Rogers wrote:
> > On Tue, Mar 26, 2024 at 1:32 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> MemorySanitizer discovered instances where the instruction op value was
> >> not assigned.:
> >>
> >>   WARNING: MemorySanitizer: use-of-uninitialized-value
> >>     #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c:1527:17
> >>   Uninitialized value was stored to memory at
> >>     #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1256:25
> >>
> >> The op value is used to set branch flags for branch instructions
> >> encountered when walking the code, so fix by setting op to
> >> INTEL_PT_OP_OTHER in other cases.
> >>
> >> Reported-by: Ian Rogers <irogers@google.com>
> >> Closes: https://lore.kernel.org/linux-perf-users/20240320162619.1272015-1-irogers@google.com/
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > 
> > Great, thanks! Should it have a Fixes tag like:
> > 
> > Fixes: 4c761d805bb2 ("perf intel-pt: Fix intel_pt_fup_event()
> > assumptions about setting state type")
> 
> Yes, I should have put a fixes tag, cc stable.  I think the issue
> has always been there, so:
> 
> Fixes: 90e457f7be087 ("perf tools: Add Intel PT support")
> Cc: stable@vger.kernel.org

Thanks, applied, had fell thru the cracks :-\

- Arnaldo
 
> > 
> > Tested-by: Ian Rogers <irogers@google.com>
> > 
> > Ian
> > 
> >> ---
> >>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
> >>  tools/perf/util/intel-pt.c                          | 2 ++
> >>  2 files changed, 4 insertions(+)
> >>
> >> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> >> index b450178e3420..e733f6b1f7ac 100644
> >> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> >> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> >> @@ -1319,6 +1319,8 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder, bool no_tip)
> >>         bool ret = false;
> >>
> >>         decoder->state.type &= ~INTEL_PT_BRANCH;
> >> +       decoder->state.insn_op = INTEL_PT_OP_OTHER;
> >> +       decoder->state.insn_len = 0;
> >>
> >>         if (decoder->set_fup_cfe_ip || decoder->set_fup_cfe) {
> >>                 bool ip = decoder->set_fup_cfe_ip;
> >> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> >> index f38893e0b036..4db9a098f592 100644
> >> --- a/tools/perf/util/intel-pt.c
> >> +++ b/tools/perf/util/intel-pt.c
> >> @@ -764,6 +764,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
> >>
> >>         addr_location__init(&al);
> >>         intel_pt_insn->length = 0;
> >> +       intel_pt_insn->op = INTEL_PT_OP_OTHER;
> >>
> >>         if (to_ip && *ip == to_ip)
> >>                 goto out_no_cache;
> >> @@ -898,6 +899,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
> >>
> >>                         if (to_ip && *ip == to_ip) {
> >>                                 intel_pt_insn->length = 0;
> >> +                               intel_pt_insn->op = INTEL_PT_OP_OTHER;
> >>                                 goto out_no_cache;
> >>                         }
> >>
> >> --
> >> 2.34.1
> >>
> 

