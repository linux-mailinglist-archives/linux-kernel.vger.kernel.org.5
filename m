Return-Path: <linux-kernel+bounces-162770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3E8B604E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10461C22155
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F901272AE;
	Mon, 29 Apr 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nrTcxYfc"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44578627D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412507; cv=none; b=Su21X0OlBYkPg4Z2Q0wL26tzZ36yxpET+ENOHjUTYqAfXDVfOjXAnJRZFwSg0aG9XKfAgpkL8ha9HTFvE74ZmxJ93qEr7jynjuZjcJmdPVY/rv5cBCTmejuvsFWHcIvqgOKQfKamyTwi1fQzrJs3LqP0kRHl8xT9/y0/beV3TPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412507; c=relaxed/simple;
	bh=L3srICNZ8JI+jJ5xdpdatcPeFVLD+JRjtynT6KPWQwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqYlQoud150YSFiXeVXS2JSgBqtmUrJomWbwbKU2pqzB4+pIdwnQCf/Fx03kqsZLq1HvEUcI6bENJnMhYkwCx8ETeG3qBHiq4UCdM7LvXBM039SPNIlvIdVy6YJAC+U02IhKlslDrNg7ndULKQl1o625Srjq387/AOYzajHgdvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nrTcxYfc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f7fc45fe1bso3803601a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714412504; x=1715017304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrFu2prq6bdsJ9xfjkBw/azXyVVdY+Tuvcz8oe4FnI=;
        b=nrTcxYfcR0t3aSRYhopkRqaKTLUxxt+ppXbvlRFqyuAksPWV7s6JQvULK70p6SeAEm
         59gHWkcJO159xgA2vUV8ntrn18FYE2xgehmKn42ys/vEvAbj9s4caL2RivPbAo6rRPgf
         a8lxzusI5PJAOoZaPsEJC/VxC8WgjHeLG8Yzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714412504; x=1715017304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtrFu2prq6bdsJ9xfjkBw/azXyVVdY+Tuvcz8oe4FnI=;
        b=hu01T3lgBgmUcqXqgg6XmuRzrBZ3MLfTwcCjTzOq1dKs4G2aRbjtLPs5bq2x+Wzuyo
         Z4SlcWL5t5U6TiO6N4Hvh/6q5yJj4QxDEbbXzcEH2g+nXzvc/joJXjvP+nUedH65p/IH
         0MMJDotln0+yY22bUSE8DBPtyKPyq6v1sVyR+BR7aZHvjigMW8EyqcvpVEjlKomWqaXr
         eHqgLnTIVZ/PK6jewAIIgZyHx+jj6XCozfq4i9smOWG00GiUrCB7W0EVgehkB0GAd2mm
         UFm3UJZaKM1HuDHtFFH89Ai5h6QpgMgONJRtrbjUFiVOBJBmnYpgb5TR0jSCxY4hJLf4
         qLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpNxNGyPSNO07U7eXG0rlEWqqIEOecjP5yE7IrcrV03K5aA8cprPh/tHe4C65YUfsRCJajaMuTrkprDfCF6tN3HXjdc+WIlyQbmijq
X-Gm-Message-State: AOJu0YziZPSsmpzAVaNshbopqM5MnrgnIsCcpM9OSvQWvul5wWfRG/oN
	rmlya2SlXkOCuHA3q4LW2KifxSKFk78u8DKz/ubSk6WOKYPrA2ffwQgj96TyvA==
X-Google-Smtp-Source: AGHT+IFATNf22dm2Wr01Vm5CDgIO7XF7i/x9IJ3rUpHw3Y+PYyfZIOmgFROcKdptZa50eHmABN+8kg==
X-Received: by 2002:a17:90b:3d86:b0:2ac:40c8:1ed3 with SMTP id pq6-20020a17090b3d8600b002ac40c81ed3mr10595967pjb.5.1714412504165;
        Mon, 29 Apr 2024 10:41:44 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090ad60300b002b233a9f1d2sm895829pju.42.2024.04.29.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 10:41:43 -0700 (PDT)
Date: Mon, 29 Apr 2024 10:41:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] perf/x86/amd/uncore: Use kcalloc*() instead of
 kzalloc*()
Message-ID: <202404291039.E21F02B98@keescook>
References: <PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com>

On Sat, Apr 27, 2024 at 06:45:23PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe. However, using kcalloc*()
> is more appropriate [2] and improves readability. This patch has no
> effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Changes in v3:
> - Update the commit message to better explain the changes.
> - Rebase against linux-next.
> 
> Changes in v2:
> - Add the "Reviewed-by:" tag.
> - Rebase against linux-next.
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/20240116125813.3754-1-erick.archer@gmx.com
> v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com
> 
> Hi,
> 
> This is a new try. In the v2 version Ingo explained that this change
> is nonsense since kzalloc() is a perfectly usable interface and there
> is no real overflow here.
> 
> Anyway, if we have the 2-factor form of the allocator, I think it is
> a good practice to use it.
> 
> In this version I have updated the commit message to explain that
> the code is obviusly safe in contrast with the last version where the
> impression was given that there was a real overlow bug.
> 
> I hope this patch can be applied this time.
> 
> Regards,
> Erick
> ---
>  arch/x86/events/amd/uncore.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 4ccb8fa483e6..61c0a2114183 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -479,8 +479,8 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>  				goto fail;
>  
>  			curr->cpu = cpu;
> -			curr->events = kzalloc_node(sizeof(*curr->events) *
> -						    pmu->num_counters,
> +			curr->events = kcalloc_node(pmu->num_counters,
> +						    sizeof(*curr->events),
>  						    GFP_KERNEL, node);

As a general aside to the original code authors, looking at struct
amd_uncore_pmu, I see stuff that should likely be u32 instead of
"int". How is a negtaive num_counters ever sane?

struct amd_uncore_pmu {
	...
        int num_counters;
        int rdpmc_base;
        u32 msr_base;
        int group;
	...
};

-- 
Kees Cook

