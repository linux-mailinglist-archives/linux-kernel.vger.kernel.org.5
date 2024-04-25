Return-Path: <linux-kernel+bounces-158650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7B88B236F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0ED285697
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7720714A092;
	Thu, 25 Apr 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUmKFK5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9492149E18;
	Thu, 25 Apr 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053781; cv=none; b=JeIwYjVFXA7TxUHKJIb6Vcc+W8/8nX/kHvwbKprSd4nq0+0mrywg1/8BgHNXRvM8emefpgHvp2PaRve5wwArWWbDfhxQ5FxXdS5wT/6NBGnQddnj3JMTYxt9s9i9FPCk3lJ9Bq/WarY/c496vjJ7yBzROILwuR3CRtzkFUJyaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053781; c=relaxed/simple;
	bh=ILvhGO1VsJHi02UTnDRo93FjUfCcr+5j1zrCi7PVrnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbj3uAOJzvIwGtNSx40hl8zsvwsOSNeFiMxCBEUNiKwqwBHK1VdFi/tDsRnEeWODeG+KoNlPYY1UeBUWVxS8opfVpxP6jAHytC1U+rhUwoMNCHONekJE5TLiK9V2r5n4rRlUJJLTzaVafgpS4zf0r5Tcu3ZW5fbZlcNXUVhuv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUmKFK5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CA5C3277B;
	Thu, 25 Apr 2024 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053781;
	bh=ILvhGO1VsJHi02UTnDRo93FjUfCcr+5j1zrCi7PVrnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUmKFK5+D30BpDLy4QRzJT0M9fOo5C3u+1sA80IKgp3O+MwEZMamX+35MloptqbZP
	 Musz3DGloPC7J1/oQ9yI/1mU9/gQtt45J2/tn6r6D8hknvP2Z938RKkqZhZg0w0QK6
	 YxOgzgNoHHlKUrQGs416+ddv3evyhIHmbr3QDHq2U/vUL2Z23J+X4C7pfmBdXAY1C2
	 uHjs+EpZT9sGHVxWSM0XoGiLf/U4+VpmMrnYgMO64X8n52MXotZyrXc7cmFpf7UAPe
	 9pbu4kYcn40VRL8Dmic4YsnpjfMsKPANiUwUPm96APeYtgK5HQOUhe5iy7NMwvgIhc
	 AUe4mkBnfLp8g==
Date: Thu, 25 Apr 2024 11:02:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf annotate: Fallback to objdump when capstone
 fails
Message-ID: <ZipikatJMzfP0xTN@x1>
References: <20240425005157.1104789-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240425005157.1104789-1-namhyung@kernel.org>

On Wed, Apr 24, 2024 at 05:51:56PM -0700, Namhyung Kim wrote:
> I found some cases that capstone failed to disassemble.  Probably my
> capstone is an old version but anyway there's a chance it can fail.  And
> then it silently stopped in the middle.  In my case, it didn't
> understand "RDPKRU" instruction.
> 
> Let's check if the capstone disassemble reached to the end of the
> function.  And fallback to objdump if not.

Humm:

⬢[acme@toolbox perf-tools-next]$        git am ./20240424_namhyung_perf_annotate_fallback_to_objdump_when_capstone_fails.mbx
Applying: perf annotate: Fallback to objdump when capstone fails
Applying: perf annotate: Update dso binary type when try build-id
error: patch failed: tools/perf/util/disasm.c:1156
error: tools/perf/util/disasm.c: patch does not apply
Patch failed at 0002 perf annotate: Update dso binary type when try build-id
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf-tools-next]$ git am --abort
⬢[acme@toolbox perf-tools-next]$

checking...

- Arnado
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/disasm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 92937809be85..412101f2cf2a 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1542,6 +1542,20 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
>  		offset += insn[i].size;
>  	}
>  
> +	/* It failed in the middle: probably due to unknown instructions */
> +	if (offset != len) {
> +		struct list_head *list = &notes->src->source;
> +
> +		/* Discard all lines and fallback to objdump */
> +		while (!list_empty(list)) {
> +			dl = list_first_entry(list, struct disasm_line, al.node);
> +
> +			list_del_init(&dl->al.node);
> +			disasm_line__free(dl);
> +		}
> +		count = -1;
> +	}
> +
>  out:
>  	if (needs_cs_close)
>  		cs_close(&handle);
> -- 
> 2.44.0.769.g3c40516874-goog

