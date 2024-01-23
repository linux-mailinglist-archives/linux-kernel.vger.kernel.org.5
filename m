Return-Path: <linux-kernel+bounces-34768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84D838749
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E7A28D6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3D5025E;
	Tue, 23 Jan 2024 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPvcVHky"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C750242;
	Tue, 23 Jan 2024 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990913; cv=none; b=nPn+kC5cTxSJEkBCCsJ5s9kOFy6no3hUl+fw5PCpuNo8gNe3Sah5Zq1jyRUqMYLiXogKOhvXWoHcV1eNXIdoPCzllJjIuPk5NHcvUYcERa2vFAf/dv05YsleYzHy0K3FV4qE+npYI6XSiJCCF93ACq8DHkRGtPy5HKpZp79GGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990913; c=relaxed/simple;
	bh=TNQNx0qYYSetcUCpOyMQNkCTJJsrGoFBI6YDppksKeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZniLwXq8qp5Kqn+6Rn2cuqITOCWdlur6REGfRpm1RbKxktvBp6QkaFvPadrHIkfhaA5e3nsmebWZLeph0CcSecxTKaCD/D1LG4YLj1YOkB/mkKB4Z+akLWvX+55StKs2iK7dIP/L8+NTiEG2NaSx3sD4sjZe1mo40ia4fhmRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPvcVHky; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705990912; x=1737526912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TNQNx0qYYSetcUCpOyMQNkCTJJsrGoFBI6YDppksKeE=;
  b=lPvcVHkynIh1oJozRNJxiKRYXnjYijalHNicYJ/M7z3IyGyR3XhrPM9D
   CbIsNWZz7AWm090gAzCSXgV58Pyomu1remG83akKOpR7T3iKvc2B8gKCz
   ytR7F5x/CfAgNGdZyhtMhXZHq33p5y7huO3Exiv4MizGv3SWMEXfzC5Xx
   Sop/POzrbFRbL0LiT9LuGvEzedm4ypS/ZO2TBnbbOltTZ6n12VrPIvYMx
   PaefJDWfW+hIXGlIRjiL9mr4a/c/fC1jeySrWD/dNsJrjbn2ov8gu5Rxe
   kyOe2UjoaqnTfOgSLkjtT8wC+623fyQwEjT++ZAJxgfcnyaUfgmeizFkB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8539916"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="8539916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1550933"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.4])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:21:46 -0800
Message-ID: <dc3a7101-964b-46c5-a78b-374b68cd54fb@intel.com>
Date: Tue, 23 Jan 2024 08:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 69/82] perf tools: Refactor intentional wrap-around test
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, John Garry <john.garry@huawei.com>,
 Fangrui Song <maskray@google.com>, linux-perf-users@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-69-keescook@chromium.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240123002814.1396804-69-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/24 02:27, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/perf/util/dso.c                    | 2 +-
>  tools/perf/util/unwind-libdw.c           | 2 +-
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 22fd5fa806ed..470a86f1cdfd 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1122,7 +1122,7 @@ static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
>  	if (offset > dso->data.file_size)
>  		return -1;
>  
> -	if (offset + size < offset)
> +	if (add_would_overflow(offset, size))

perf tools has separate includes to the kernel, so does not
seem to include add_would_overflow() in any of its include
files at this point.  Need to update
tools/include/linux/overflow.h first.


