Return-Path: <linux-kernel+bounces-150315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C48A9D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7C11C20980
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4B16F29F;
	Thu, 18 Apr 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/gEZ6Da"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79D16E860;
	Thu, 18 Apr 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450665; cv=none; b=oAVtUftmUPoruHLYonTb8R2DlQZk6Ytd4K1Sm8YN4aa8i4NRe3E5F1pLre31v60fy+zvMD/t9QW+DlpMZ/WSwx954PUeY9DtlivyOWxQWqeBaIm9i83gSd4dz8o3ad+7fAp970n+gW8n3+4QZN2ORtUG+Xs+chEDSeKJZDOU+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450665; c=relaxed/simple;
	bh=JNWOYInEppemZQhyMubvU6G/hY2DOYhQpgoRO85vT90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnPXnQu2bCG1ughM2a3xmBGd8Fkh2c/gsPjEfmRRwMim+4FHiZG4Vh9c5CGS6/x5wTKP/iqaSXhk0bG13Nh25ixmk0Lg98vp/sqmEIFlrXvOvaFT6dg3KrZLZD4Je7ribk0pMb9bsdOinCzdabX5UaP51OAP+XW1L1Hat2D38Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/gEZ6Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1793FC113CC;
	Thu, 18 Apr 2024 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713450664;
	bh=JNWOYInEppemZQhyMubvU6G/hY2DOYhQpgoRO85vT90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/gEZ6DaX909LOqPE6dfWYYOZfN/XmXB1cqg+/hZoHbGJu5ftjO3zN2w3IRaIlRJg
	 GxYs7gDvzWaf/5QGMAdWXRatI+nncjiifGvTYVcoc62/Of0jxYZPlF37mseqoLHJQr
	 8plTVWBoe+t8HveKXBzNUoMT0Hcox4ACsm8Pv6ARJMfA+yFLXwaL3pkmx1m5gcm07B
	 qzCJWYoTInasE297lrtEvAQl3aUYWGhKQcFUxWlG8DvAQP9Qby1RkweRRPAPCBAv6g
	 6jX01K9kqf5dN0QKR+WPLvSqnBIxnTYAgazrl5IaIQeRMMaV06h3Bsqvc/3nV2AqXl
	 gv2k+8tvpP0Jw==
Date: Thu, 18 Apr 2024 11:31:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] perf trace beauty: Always show mprotect prot even
 though PROT_NONE
Message-ID: <ZiEupQ_PDlA_3Lo4@x1>
References: <20240418131304.3188385-1-changbin.du@huawei.com>
 <20240418131304.3188385-5-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418131304.3188385-5-changbin.du@huawei.com>

On Thu, Apr 18, 2024 at 09:13:04PM +0800, Changbin Du wrote:
> Do not omit the flags even though it is PROT_NONE.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 349550b02f79..7f936f1b5519 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1042,7 +1042,7 @@ static const struct syscall_fmt syscall_fmts[] = {
>  		   [4] = { .scnprintf = SCA_MOVE_MOUNT_FLAGS, /* flags */ }, }, },
>  	{ .name	    = "mprotect",
>  	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
> -		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
> +		   [2] = { .scnprintf = SCA_MMAP_PROT, .show_zero = true, /* prot */ }, }, },


So since syscall_arg__scnprintf_mmap_prot() special cases 0 to print
NONE for prot... Ok, I'll expand a bit the commit log message _and_ the
syscall_fmts entry for mprotect.

- Arnaldo

>  	{ .name	    = "mq_unlink",
>  	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
>  	{ .name	    = "mremap",	    .hexret = true,
> -- 
> 2.34.1

