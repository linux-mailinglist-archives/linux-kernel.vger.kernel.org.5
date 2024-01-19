Return-Path: <linux-kernel+bounces-30848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F6F832514
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B15B21C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD87D51C;
	Fri, 19 Jan 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBZ9EZbi"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D95D518;
	Fri, 19 Jan 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649777; cv=none; b=B3MBxfOxdtQ9tTnbTSiTz1XBAfWBRnpHLMzCjQavfiNUc1hoeGJRYcB8Njfg4QJP+Won1jfr29uPFwjPJswSERe0KTVbkXAuoMHIVF42P1O7eJhg0FDKTklqvPMfwfPX3L5/JoqGIql+U2SPo1cC4OTHJtVSqwciqrIKu05pKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649777; c=relaxed/simple;
	bh=ATa/wWcVOMvBrwAk92bprGIR7xSGsMx0ZJqndSRwXtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1Nr33uXHH+r21PWitlQGr3jp/jXeOcwb0whmVgBSBNFwIj/LRMGdwRKvqkirmskD9ucnpy2nix2Xopzz8kbdWftV4OekL0GCf9siBXzeEWLa6pva+Oaeb/jv1rtGyxwUxpPPI96u+6OvqveQ9AM7swmEUalNIr/W8CTF6NBgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBZ9EZbi; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705649775; x=1737185775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ATa/wWcVOMvBrwAk92bprGIR7xSGsMx0ZJqndSRwXtg=;
  b=DBZ9EZbizy5H8+xomKHwXzShbTVgizzwqNRXDC+OAW1WflW4L/NLQ+t9
   HzcSAwV/IqxZEN+/0lzVvqy0yErhneN5GmDl8j2T6awPyqZsd+/yfznz5
   oZJViptdgUripAnh1cOxpdKMCmipS3KTzS21e5dxCeP9Qt3zY8GdS58ob
   NoT2PfnFMKfcsJllXAxHAu6cbrcyAQioCH1ZNk7Fz+BRVuYOMb9h8qThn
   GeWP6yMFOYsEYEqo2p8pt8Uc5mxuaAEsVV0pCNwWdz79i2dHN8zQ6Xzqe
   4O/V2bu/etMXFQqHt4RrYoVdpPvitw/urzcV+2c3njGqES3Zdm7m79cdd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="431854838"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="431854838"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="785009656"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="785009656"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.208])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 23:36:11 -0800
Message-ID: <66cdc5f9-a09a-4841-8fca-252b7c78114b@intel.com>
Date: Fri, 19 Jan 2024 09:36:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix small negative period being ignored
Content-Language: en-US
To: Luo Gengkun <luogengkun2@huawei.com>
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org
References: <20240116083915.2859302-1-luogengkun2@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240116083915.2859302-1-luogengkun2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/24 10:39, Luo Gengkun wrote:
> In perf_adjust_period, we will first calculate period, and then use
> this period to calculate delta. However, when delta is less than 0,
> there will be a deviation compared to when delta is greater than or
> equal to 0. For example, when delta is in the range of [-14,-1], the
> range of delta = delta + 7 is between [-7,6], so the final value of
> delta/8 is 0. Therefore, the impact of -1 and -2 will be ignored.
> This is unacceptable when the target period is very short, because
> we will lose a lot of samples.
> 
> Here are some tests and analyzes:
> before:
>   # perf record -e cs -F 1000  ./a.out
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.022 MB perf.data (518 samples) ]
> 
>   # perf script
>   ...
>   a.out     396   257.956048:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.957891:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.959730:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.961545:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.963355:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.965163:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.966973:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.968785:         23 cs:  ffffffff81f4eeec schedul>
>   a.out     396   257.970593:         23 cs:  ffffffff81f4eeec schedul>
>   ...
> 
> after:
>   # perf record -e cs -F 1000  ./a.out
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.058 MB perf.data (1466 samples) ]
> 
>   # perf script
>   ...
>   a.out     395    59.338813:         11 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.339707:         12 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.340682:         13 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.341751:         13 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.342799:         12 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.343765:         11 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.344651:         11 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.345539:         12 cs:  ffffffff81f4eeec schedul>
>   a.out     395    59.346502:         13 cs:  ffffffff81f4eeec schedul>
>   ...
> 
> test.c
> 
> int main() {
>         for (int i = 0; i < 20000; i++)
>                 usleep(10);
> 
>         return 0;
> }
> 
>   # time ./a.out
>   real    0m1.583s
>   user    0m0.040s
>   sys     0m0.298s
> 
> The above results were tested on x86-64 qemu with KVM enabled using
> test.c as test program. Ideally, we should have around 1500 samples,
> but the previous algorithm had only about 500, whereas the modified
> algorithm now has about 1400. Further more, the new version shows 1
> sample per 0.001s, while the previous one is 1 sample per 0.002s.This
> indicates that the new algorithm is more sensitive to small negative
> values compared to old algorithm.
> 
> Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>

It seems better, and the maths makes sense, so:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


But the test case still seems to give unexpected results. Usually:

  # time taskset --cpu 1 ./test
  real    0m 1.25s
  user    0m 0.03s
  sys     0m 0.00
  # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.051 MB perf.data (1290 samples) ]

But occasionally:

  # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
  # perf script
  ...
  test   865   265.377846:         16 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.378900:         15 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.379845:         14 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.380770:         14 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.381647:         15 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.382638:         16 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.383647:         16 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.384704:         15 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.385649:         14 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.386578:        152 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.396383:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.406183:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.415839:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.425445:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.435052:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.444708:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.454314:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.463970:        154 cs:  ffffffff832e927b schedule+0x2b
  test   865   265.473577:        154 cs:  ffffffff832e927b schedule+0x2b
  ...



> ---
>  kernel/events/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 683dc086ef10..cad50d3439f1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4078,7 +4078,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>  	period = perf_calculate_period(event, nsec, count);
>  
>  	delta = (s64)(period - hwc->sample_period);
> -	delta = (delta + 7) / 8; /* low pass filter */
> +	if (delta >= 0)
> +		delta += 7;
> +	else
> +		delta -= 7;
> +	delta /= 8; /* low pass filter */
>  
>  	sample_period = hwc->sample_period + delta;
>  


