Return-Path: <linux-kernel+bounces-81322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E324886741D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988351F2D963
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D875B680;
	Mon, 26 Feb 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvnoWVjK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE45A7BB;
	Mon, 26 Feb 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948789; cv=none; b=ppOjswkVkVtIIEBFvRu5JBXhdxDDD/qUiU4QS/Ea8v6PgDtrmVf765FX0zGz9amDXA7C/Ookaje2zG76UN+wQMnyG03Kc5kLanfPqkrHlv97ldWSzIi4fyS9y0/TN0Ef0xK65wWlBaHBexS0lZaEYqKn48pENv0NEyAGaiiam9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948789; c=relaxed/simple;
	bh=ggq0gLZC5vBuL4MnHfBB0kPJ74QpbJ7V8VcT0K/xY5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSnP06FM3XcM/VbQEpXnJwsb47UVPmHAMLf2D0436yiU8sIQUOBB7NeAawln8KKfF9GH6RGvcr+vhgM5FwbaJbl9/3dtgYOaKT1PoiRFudSgnk8GgSmhGDrNli4lmJerx+kB8pyjtgGhiHAAIa7DzRVcmVuFpt5Om1WtYJAkOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvnoWVjK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708948788; x=1740484788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ggq0gLZC5vBuL4MnHfBB0kPJ74QpbJ7V8VcT0K/xY5w=;
  b=PvnoWVjKW38wEeMkwT30lahec3oHjkSEI2kl5eiy4ol/H0/bX3qjW1Y9
   Li41/8acmFM+nx+08+l8+cw9hXCdaacgr1oYTMlbpfye0PnLsACk4v/Ie
   0qgYAs6CH8xN5Dm81Vm2Wrdk5ZmoHh5YIq1P8vU/LXinn0p6iluD96tm7
   HDKDG9KE6DfgpGAds52avVTOw+LTswZBYrwg55sZY3S6Bf6QYecEZtGxU
   51XyRaaZltt0piAZegSy2wrVEFspLenc5N3yjEIMXEv95pQd5DvyJWesV
   iSid/7kAKE/5lXaisHx58zauMVREBSIxVZC6CHPGnNZUyI6gj996ePsdv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14360062"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14360062"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="37426369"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.48.254])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:59:42 -0800
Message-ID: <5a1ad9a5-52d8-4d78-9c26-ee5b9eb00b40@intel.com>
Date: Mon, 26 Feb 2024 13:59:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] perf test: Fix spelling mistake "curent" ->
 "current"
To: Colin Ian King <colin.i.king@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226105326.3944887-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240226105326.3944887-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/24 12:53, Colin Ian King wrote:
> There is a spelling mistake in a pr_debug message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/symbols.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index 2fed6d67f50f..d208105919ed 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c
> @@ -85,7 +85,7 @@ static int create_map(struct test_info *ti, char *filename, struct map **map_p)
>  		*map_p = find_module_map(ti->machine, dso);
>  		dso__put(dso);
>  		if (!*map_p) {
> -			pr_debug("Failed to find map for curent kernel module %s",
> +			pr_debug("Failed to find map for current kernel module %s",
>  				 filename);
>  			return TEST_FAIL;
>  		}


