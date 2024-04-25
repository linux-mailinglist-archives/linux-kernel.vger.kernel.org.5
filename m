Return-Path: <linux-kernel+bounces-158648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335048B236B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43D628A936
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4E149E05;
	Thu, 25 Apr 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGsqkNso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1A149C67;
	Thu, 25 Apr 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053732; cv=none; b=qGeu4grdno7bpFTNcJvoXzmv+3d2udmJFsT1YWAVsNV2Lfgxi9VbZ0vQPNEgvHH8iG8mSNEGjbyvzvrLXGowoNbVvIfUdVqSGcu0B60T8n6HbHHkGLaMaMPs9hLP9sMXEo8FY1P64kUVzXTOOdwgssNxvx6yFnL1b7kEwezVa1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053732; c=relaxed/simple;
	bh=DqKDPDUySoPXORwAqXe1B4HQ1YXnLVQ0qpjZYrw3o/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiITfrH2uThuc0HjOKnrsMmjIna5HGiJew2W3TGo+joCmPMO14UhHhkCg453ukAAq57Ar6oMjP9XydFtuVW+YyTPXM1Y3WcD8/qWe44qc/oFtM/DaaclrL4K6TMhW1QPxsp0mC+ctd2BGNYGVTszejStsQxKzQ++g3qukczT8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGsqkNso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3504C113CC;
	Thu, 25 Apr 2024 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053731;
	bh=DqKDPDUySoPXORwAqXe1B4HQ1YXnLVQ0qpjZYrw3o/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGsqkNsokOe2xC6Fyqe0dMBHKMyWAXt6nvmoVnUSUIAcbn0o0scNqoVJXGQvp9+kl
	 /IyN+IMZ52aCbpjmYubh915efG8Gigbx0F1xJx+nnEWBLUvUgLOxLyGMUUmUWoZOxY
	 LTSko+R85DzFxx91a4WVKuuILPxZqG6wXXyHIEPYpYVW6c6ai+f6F7GSG1petyjnyu
	 bOlGMaVqirH9NYB7qRu3364NRAhkv5pnoemq1KWQqYLP5gHzOH8IdG7CefKsxcJtN4
	 +FsBeU/uyZNgc4Fs7mz4P9ryJ61h/ODCTMvZsSaXUIo+IEECydN36FygplyihMqhoS
	 y8kaj9XaFhUAA==
Date: Thu, 25 Apr 2024 11:02:06 -0300
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
Message-ID: <ZipiXhB21fgPM_xl@x1>
References: <20240425005157.1104789-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425005157.1104789-1-namhyung@kernel.org>

On Wed, Apr 24, 2024 at 05:51:56PM -0700, Namhyung Kim wrote:
> I found some cases that capstone failed to disassemble.  Probably my
> capstone is an old version but anyway there's a chance it can fail.  And
> then it silently stopped in the middle.  In my case, it didn't
> understand "RDPKRU" instruction.
> 
> Let's check if the capstone disassemble reached to the end of the
> function.  And fallback to objdump if not.

Thanks, applied to perf-tools-next,

- Arnaldo
 
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

