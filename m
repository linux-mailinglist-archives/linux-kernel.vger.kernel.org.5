Return-Path: <linux-kernel+bounces-129945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FD89725D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE771281236
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EFF149C60;
	Wed,  3 Apr 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY5cHO5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6213149C47;
	Wed,  3 Apr 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154081; cv=none; b=dQ/ml7D3e+sIyYHd9SEyOXwe48sm2DXSbIPPOOqjvNlgduASFu/vRieh39CrZwniSMTxuaBUUS2bb+X6ADnDGTqhHmDLGm11M6wTImJWluSlM4Xv9JgLnSnyCNB48hwMpn/aCpj5SdjKbdYkbgFiwqm/gyv+S1QbBqhj0/1vAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154081; c=relaxed/simple;
	bh=/q4fBitqFxCOY548OFJKuQZURhoeAk7wbdCOBzEyi20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/isGkePzgwNcLt8RjnTuCSUjcHUMH7jxmjO4Dobus1sJ30kOtrG5ZxVvFIFB1KoWL8TOBqwhCwmKK1cYnvfqJT3hy+Zt15VePEeX9XRbfg+6tDnDCLOEMcqtL9q37HKl0KZY0p+J5zZJvdLpbiAHMKjE86irOpamq4EZpybUdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY5cHO5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F318BC43394;
	Wed,  3 Apr 2024 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712154081;
	bh=/q4fBitqFxCOY548OFJKuQZURhoeAk7wbdCOBzEyi20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oY5cHO5feTs4f6Fb6PKrEkmsybCEaYbf/K7HZ5fDN0BA/n21s26F3bSx1wGs8ArWB
	 QYnqlrz8adWS92ksvCV+z/BAqYBo636IvW4kNRWcA2oHEZSahdnCNjOowmFKr0g/10
	 vvtnaTePplLn9+DzS+rtfc8fkGgurTMtZP4RJSQFcfyGTE2yXrsZ6aui2MuVdL55yj
	 vkd1rKdWsRlM0ClAVAE8fi0ZnMfLTYw5UBFSuFcosmdNpeJMHijg2UfzwCw0cXZ7o/
	 Se/zl0BK5kHsYhx1137Ydt6jbXpfaVQt6zaAydYHRY2HEjcEEtrvuvXvZHRtlvqGEP
	 xaSSgsXEoP1Lg==
Date: Wed, 3 Apr 2024 11:21:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf beauty: Fix AT_EACCESS undeclared build error for
 system with kernel versions lower than v5.8
Message-ID: <Zg1l3RUMrzJaBYcP@x1>
References: <20240403122558.1438841-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403122558.1438841-1-yangjihong@bytedance.com>

On Wed, Apr 03, 2024 at 08:25:58PM +0800, Yang Jihong wrote:
> In the environment of ubuntu20.04 (the version of kernel headers is 5.4),
> there is an error in building perf:
> 
>     CC      trace/beauty/fs_at_flags.o
>   trace/beauty/fs_at_flags.c: In function ‘faccessat2__scnprintf_flags’:
>   trace/beauty/fs_at_flags.c:35:14: error: ‘AT_EACCESS’ undeclared (first use in this function); did you mean ‘DN_ACCESS’?
>      35 |  if (flags & AT_EACCESS) {
>         |              ^~~~~~~~~~
>         |              DN_ACCESS
>   trace/beauty/fs_at_flags.c:35:14: note: each undeclared identifier is reported only once for each function it appears in
> 
> commit 8a1ad4413519 ("tools headers: Remove now unused copies of
> uapi/{fcntl,openat2}.h and asm/fcntl.h") removes fcntl.h from tools
> headers directory, and fs_at_flags.c uses the 'AT_EACCESS' macro.
> This macro was introduced in the kernel version v5.8.
> For system with a kernel version older than this version,
> it will cause compilation to fail.

Thanks, I test on it, but since I didn't found libtraceevent-devel
available there, then I have to build with NO_LIBTRACEEVENT=1 and thus
this doesn't get built :-\

Thanks, applying.

- Arnaldo
 
> Fixes: 8a1ad4413519 ("tools headers: Remove now unused copies of uapi/{fcntl,openat2}.h and asm/fcntl.h")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/trace/beauty/fs_at_flags.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/beauty/fs_at_flags.c
> index c1365e8f0b96..c200669cb944 100644
> --- a/tools/perf/trace/beauty/fs_at_flags.c
> +++ b/tools/perf/trace/beauty/fs_at_flags.c
> @@ -10,6 +10,14 @@
>  #include <linux/fcntl.h>
>  #include <linux/log2.h>
>  
> +/*
> + * uapi/linux/fcntl.h does not keep a copy in tools headers directory,
> + * for system with kernel versions before v5.8, need to sync AT_EACCESS macro.
> + */
> +#ifndef AT_EACCESS
> +#define AT_EACCESS 0x200
> +#endif
> +
>  #include "trace/beauty/generated/fs_at_flags_array.c"
>  static DEFINE_STRARRAY(fs_at_flags, "AT_");
>  
> -- 
> 2.25.1
> 

