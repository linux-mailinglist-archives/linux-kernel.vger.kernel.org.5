Return-Path: <linux-kernel+bounces-155857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87BD8AF817
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADC71C21F52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E497142E85;
	Tue, 23 Apr 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJLvS7FG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9662C13FD8E;
	Tue, 23 Apr 2024 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904662; cv=none; b=nn8Gjy5AKL4R2e/QgO8/tMwlGDnbR9+0x90vXSr5mUC0ZFCDHS2Lnd30WWton9w8bRUcjWLo1zAmR0Aj8hN3LhWvuzn5IkCtp9wyBUw/GW0ZLhOY7gBqk8DWg1/DqACXllXN5S0vlXjVAWo1Juro/p5VCyWMo7XOBn6NE3SOTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904662; c=relaxed/simple;
	bh=P89WNhg/a/bLXsZUqJDGwcAwiliOwCUCLVi06pVezO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq7oxuTsX751KbIwmvXPia0SVcAA5cDrfRTr45WI2t8etJv0CySXE4BLWpsI/YGwkQM6jG7RiZH1cp00eHa1rvi/gGxpQPvyb6AemUVdeYMoUF22CPoMMKK2xHd5ytfCCSVI1evNJGnwaGVHen8MoClENHqGCDG1YxnG/j4k8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJLvS7FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD58C116B1;
	Tue, 23 Apr 2024 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713904662;
	bh=P89WNhg/a/bLXsZUqJDGwcAwiliOwCUCLVi06pVezO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJLvS7FGZ1yr2xI+2uIMgptkBUPqNN2Fnp83Y8OATDCBh+6P2GkvXdurf4hR7nM5f
	 JuYIfAj1zY9GEi9v8pVtBIjVvtorRzo2Zx8Yi6enX3keO2KJZyxFW6UiHcEC0+RcxL
	 U3H2swi+fNFX5zu/Bw0JWikbGYu3jeqGSLIFvpX7t5N5fkd2DU85sExCD/eW5DLk5q
	 iJw3mqU5lEsc3UEN6EAxWYwc5ylQPZgKmp2l+eexoZrWR4RoMimjbINqGjr0yoCWgt
	 nG3IY9uTwg95ptKq2yphfwS4yFwA8VUfQHWkoXi+rX24uJTRGVEU7B2SXoeH9glzdT
	 XjRv71efZzAEA==
Date: Tue, 23 Apr 2024 17:37:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf trace beauty: Always show param if show_zero
 is set
Message-ID: <ZigcEg1inS1JoSr5@x1>
References: <20240423015330.2206892-1-changbin.du@huawei.com>
 <20240423015330.2206892-2-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423015330.2206892-2-changbin.du@huawei.com>

On Tue, Apr 23, 2024 at 09:53:29AM +0800, Changbin Du wrote:
> For some parameters, it is best to also display them when they are 0,
> e.g. flags.

Please provide examples of what you're changing, to understand your
change one has to know what are strarrays and what they handle in 'perf
trace', i.e. if the value is zero but the argument has a string array
associated, it probably will translate zero into some string.

So I did:

root@x1:~# perf trace -e syscalls:sys_enter_mmap --filter prot==0
     0.000 gnome-shell/2293 syscalls:sys_enter_mmap(addr: 0x10afec7e1000, len: 65536, flags: PRIVATE|FIXED|ANONYMOUS)
^Croot@x1:~#

And this is _before_ this patch, after this patch we get:


root@x1:~# perf trace -e syscalls:sys_enter_mmap --filter prot==0
     0.000 Isolated Web C/25530 syscalls:sys_enter_mmap(addr: 0x7f27df529000, len: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
    40.267 DOM Worker/1105511 syscalls:sys_enter_mmap(addr: 0x1c9faec48000, len: 65536, flags: PRIVATE|FIXED|ANONYMOUS)
   270.145 firefox/3447 syscalls:sys_enter_mmap(addr: 0x7fa0ed343000, len: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
  2194.686 firefox/3447 syscalls:sys_enter_mmap(addr: 0x7fa0ed39f000, len: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
  2461.709 Isolated Web C/21794 syscalls:sys_enter_mmap(addr: 0x7fdc3e100000, len: 1048576, flags: PRIVATE|FIXED|ANONYMOUS)
  4476.053 firefox/3447 syscalls:sys_enter_mmap(addr: 0x7fa0ed3a1000, len: 4096, flags: PRIVATE|FIXED|ANONYMOUS)
^Croot@x1:~#

Because 'mmap's 'prot' is not set directly as an strarray, see:

        { .name     = "mmap",       .hexret = true,
/* The standard mmap maps to old_mmap on s390x */
#if defined(__s390x__)
        .alias = "old_mmap",
#endif
          .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,  /* prot */ },
                   [3] = { .scnprintf = SCA_MMAP_FLAGS, /* flags */
                           .strtoul   = STUL_STRARRAY_FLAGS,
                           .parm      = &strarray__mmap_flags, },
                   [5] = { .scnprintf = SCA_HEX,        /* offset */ }, }, },

static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size, struct syscall_arg *arg)
{
        unsigned long prot = arg->val;

        if (prot == 0)
                return scnprintf(bf, size, "%sNONE", arg->show_string_prefix ? strarray__mmap_prot.prefix : "");

        return mmap__scnprintf_prot(prot, bf, size, arg->show_string_prefix);
}

#define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot

So can you please provide an example that shows before/after your patch?

- Arnaldo
 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/builtin-trace.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e5fef39c34bf..a8407eee58a3 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2099,9 +2099,9 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  			    !trace->show_zeros &&
>  			    !(sc->arg_fmt &&
>  			      (sc->arg_fmt[arg.idx].show_zero ||
> -			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
> -			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
> -			      sc->arg_fmt[arg.idx].parm))
> +			        ((sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
> +			          sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
> +			         sc->arg_fmt[arg.idx].parm))))
>  				continue;
>  
>  			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
> @@ -2803,8 +2803,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  		 */
>  		if (val == 0 &&
>  		    !trace->show_zeros &&
> -		    !((arg->show_zero ||
> -		       arg->scnprintf == SCA_STRARRAY ||
> +		    !arg->show_zero &&
> +		    !((arg->scnprintf == SCA_STRARRAY ||
>  		       arg->scnprintf == SCA_STRARRAYS) &&
>  		      arg->parm))
>  			continue;
> -- 
> 2.34.1

