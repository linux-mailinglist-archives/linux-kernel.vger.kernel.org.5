Return-Path: <linux-kernel+bounces-35199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F47D838D76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC1B223FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D705D75A;
	Tue, 23 Jan 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aA88Lxg9"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA143D7B;
	Tue, 23 Jan 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009553; cv=none; b=meR5CNHbefbDgyBE89cHXbwuD8QzG7et5A4Pw0pHC2EkQFqFEmNanB0XVnxKa6Z3WWaiuosffnB8rNrbmV8ADpwno3Y2yil67933ElhHqD8O0nMJokMFn6a+DXeST3RUpD/Y4ka9BV8rFpGbn3t3a0v4bT+FW9WiB9op9cjF1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009553; c=relaxed/simple;
	bh=zouesPAIO0cDhcbx3mfu1OwAwsS4EMUtfV+8BsSAPX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQeOgsfRFrYaRsr72TOhTuZrNP+hRy2Z1ffe2AoiHrt5sbiPhsmC2vMCb6dokNS+EjuQksVWmvIymXfSjoAmiaeD/v9tyxjkYvLWb47+VbPw3YzvnaJ7Fy2/znCkp5XQwkPl9Hv5yCz10N0s3aSgTMt/Hthu0LFNW72Vwh1vRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aA88Lxg9; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706009551; x=1737545551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zouesPAIO0cDhcbx3mfu1OwAwsS4EMUtfV+8BsSAPX0=;
  b=aA88Lxg9cfc65zl2DaBXmPZV1UDVOC84T2M51j69rV03jBu7J+itpMDL
   VMk/RMi8gcigVNgZhfMovqAwhp+597aKvONOH9TOalH6Rpfo4v8dLjOhS
   b/sEtsigpA13wZwudcxDYCmeaLsEqK3c0doGkcT+NDbbMZg4j+XVCsm8L
   FtuyaeTYdqb51c1i8Of73qbMdxbcabFebUyYR+dVke0jqSsMb9aW95uZi
   vyUpL8PyOAjowMyJniIQKg0dPkxHogxaKkh2o/HmkajOG/6WNaNt/Hfzo
   hLwXn/K/D+ogGuvUtMmmJeiopSWWP7V3zcb91SHwWGn24vLTx+NhOCHWp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="400347730"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="400347730"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 03:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1570277"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.4])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 03:32:26 -0800
Message-ID: <089e43c5-1e0e-4c6e-9b91-827b01012b23@intel.com>
Date: Tue, 23 Jan 2024 13:32:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] tools: perf: Expose sample ID / stream ID to python
 scripts
Content-Language: en-US
To: Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 namhyung@kernel.org, irogers@google.com, will@kernel.org
References: <20240123103137.1890779-1-ben.gainey@arm.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240123103137.1890779-1-ben.gainey@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/24 12:31, Ben Gainey wrote:
> This patch modifies the perf python scripting engine so that the ID and
> STREAM_ID are exposed as part of the sample so that they may be
> correlated to the corresponding throttle/unthrottle event (for example).
> 
> NB: For scripts where perf_db_export_mode = True, this may be a breaking
> change depending on how the script is constructed. Each field is passed
> to `sample_table` as an argument so any script that is written as:
> 
>     def sample_table(db_id, evsel_id, machine_id, ..., cyc_cnt, flags)
> 
> will now fail due to the changed number of arguments with:
> 
>     TypeError: sample_table() takes 25 positional arguments but 27 were given
> 
> Scripts that use:
> 
>     def sample_table(*args)
> 
> or some variation thereof will not be affected.

That is documented in tools/perf/Documentation/db-export.txt.  It was
anticipated that more arguments could be added, so that should be OK.

> 
> When `perf_db_export_mode = False`, the script should be unaffected as
> all the arguments are inserted into a dictionary.
> 
> The export-to-xxx.py scripts use the (..., *x) form so are not affected.
> 
> 
> Ben Gainey (1):
>   tools: perf: Expose sample ID / stream ID to python scripts
> 
>  tools/perf/Documentation/perf-script-python.txt        | 4 ++--
>  tools/perf/util/scripting-engines/trace-event-python.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 


