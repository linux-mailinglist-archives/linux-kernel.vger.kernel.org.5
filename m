Return-Path: <linux-kernel+bounces-162740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF218B5FED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED3F1C20CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39D86640;
	Mon, 29 Apr 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OsZGsOFi"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28158627A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411087; cv=none; b=f5w6KwTBQgB9QNdSroRqHAT7NkJarADxiEeTOjf4/U3ehWSS3T5aVd9blHL/l/rgeJS8uKTFm+Jcea7DxJTnv9KxUWhQ+QmndRvo5/UJXmCWnIodXZF7SdarmWoWRj2o78GdogAUvBhWLGfmyqZPAWZ9tewAXDXnF1Wt/Ig38kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411087; c=relaxed/simple;
	bh=qWnvkovjN0ozqbXF/oi4B7/RPRSQlKRASO5y4VDl8Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqyCom8wdNehdPyaJYFU1//zt+aBie4QGhNIzP3wriyR3+qkONlXo8q07FHb3lM2r595JR4iPXtC+XkvEyVJmMbjI3G0pzGERpEFmBSuxMWsl55nuhMQtuOKHISCGC5d3VKs+GKuN6o/1Keodn/MO5DVMplNI3fj6v8vK9ywCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OsZGsOFi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso4023797b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714411085; x=1715015885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hd/wdvdADW+smZoeTYyFDi1rtzHcyz1g8xNiBj96c8=;
        b=OsZGsOFiPCGntUzBHC54nROZSMu/FO2UlLJ2JnFI4YZKjLidJKCP9FlZIWN8fq+0qM
         QvTKCvHEhK/8xl/ofsigdGypjgWxIjIVWyqzc4CfpuP19bZJUs37WUmXlqPq+Dh8G+0g
         hSwqr7O/Oi7GhHmXLVPU14q/wDX9lOVLQkWio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714411085; x=1715015885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hd/wdvdADW+smZoeTYyFDi1rtzHcyz1g8xNiBj96c8=;
        b=DSyU2uHYvBdWQpSbx7uoMFnHyWuGhcEeCLzWqJsx4D7iHusoeQm5DEV8bzdt6/5nvF
         4MYAQ71NUbtiEsDILzqXzGbqgsVU9WXiN+CPHUsN7hxyGGOmI5skC/9OxhbDGju3FVha
         cBTUDVnf9sk77kYawe1Eci3nqtVufDyjJI5Ql0VoPqEQ5CA4Me2xm8dC7IE3h8uYZVaS
         4C0m+TbrdB2jSD+ENsRaj4+cDpMF+ZVhckYlkGx/1ehOaLvHupW97VTwK2lW8YIBSIps
         TBzeTLp2vVwNAxbHMwl005bk23MnEsM9c389OzsKNWAnNRcGLEXBFhv+HLpnIT4njj+t
         BEoA==
X-Forwarded-Encrypted: i=1; AJvYcCVQKL79nDFfPi8JQ6oEJNx79tNuTr4UdKXTOoEJHywNfuy53kHk4VDJ42R4s+8UNiUWiAbhTQsohr5Uw1hvHElXHVjyqwcAJG6yD7J9
X-Gm-Message-State: AOJu0YwQkC+5ew+N38AMERFLuE2sQEB6Dgd3/mIZZOTlBKoNZirgBL9X
	hxvWjvaaK/BgVZp0NZlNjLwcn6n/UfH+PdsTi3eLQ0OEuPuV0tH79Rd/u0sNvQ==
X-Google-Smtp-Source: AGHT+IE9C63YQJERIQ6wskzU4nO9p3NnPb2ovyYO3ig5u2YdgvqNsBYsWG/giRuAHKr64kV5bbKq/A==
X-Received: by 2002:a05:6a20:9187:b0:1a7:52fa:7d6b with SMTP id v7-20020a056a20918700b001a752fa7d6bmr13417202pzd.43.1714411085239;
        Mon, 29 Apr 2024 10:18:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78648000000b006eade394613sm19515196pfo.198.2024.04.29.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:18:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:18:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Prefer struct_size over open
 coded arithmetic
Message-ID: <202404291013.B21EADD4F@keescook>
References: <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, Mar 30, 2024 at 03:32:59PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "box" variable is a pointer to "struct intel_uncore_box" and
> this structure ends in a flexible array:
> 
> struct intel_uncore_box {
> 	[...]
> 	struct intel_uncore_extra_reg shared_regs[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc_node() function.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> The Coccinelle script used to detect this code pattern is the following:
> 
> virtual report
> 
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
> 
> i0 = sizeof(t1) + sizeof(t2) * i1;
> ...
> i2 = ALLOC@p1(..., i0, ...);
> 
> @script:python depends on report@
> p1 << rule1.p1;
> @@
> 
> msg = "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
> 
> Regards,
> Erick
> ---
>  arch/x86/events/intel/uncore.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 258e2cdf28fa..ce756d24c370 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -350,12 +350,11 @@ static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
>  static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
>  						 int node)
>  {
> -	int i, size, numshared = type->num_shared_regs ;
> +	int i, numshared = type->num_shared_regs;
>  	struct intel_uncore_box *box;
>  
> -	size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
> -
> -	box = kzalloc_node(size, GFP_KERNEL, node);
> +	box = kzalloc_node(struct_size(box, shared_regs, numshared), GFP_KERNEL,
> +			   node);
>  	if (!box)
>  		return NULL;

Thanks, yes, this looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

Peter and Ingo, you seem to traditionally take these changes (via -tip)?
Can you please pick this up?

-- 
Kees Cook

