Return-Path: <linux-kernel+bounces-44726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9AF842690
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC391C23A96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5256D1D7;
	Tue, 30 Jan 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPKGr9mN"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CF60ED3;
	Tue, 30 Jan 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623341; cv=none; b=FCa3Lzi90G0qa9hszG3C2A6ABr0dk+pOJAaujq6uXeF4szJtVzv+Gu/ECcWg4MVCTnjJDs7uF//vki0InjVHmGiU4TpNqxCwiO6anl+CS3DTM9QwE8RAr/G8T2mR9CSz/0RsEgV/WekSYHbSmhZs6cmxf+Klj2ah4mPgBoN9a+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623341; c=relaxed/simple;
	bh=E4O+rDogaPUll+wLBT5x1wpMvV0U7UCoGRlSeC3bRbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSlpnkSXtRGHRUM9/OpyC6lDZ52ssu9KmutR3FOPC1Mcs6rUnMKvmg9UPdNREkDGqi+YhrsYbjH951SDgOCc64sJ1G14ZmeldDU6AOnTjW3fd1/c8SyIPlR3s0mKFkBkj5n9WfBT5Xx55EIYH2gOulDd4Z0qAewAhhsblnnOHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPKGr9mN; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706623339; x=1738159339;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E4O+rDogaPUll+wLBT5x1wpMvV0U7UCoGRlSeC3bRbs=;
  b=PPKGr9mNjSNEfdoFj6J0qDS4whj+0LGGJ7yHgTkVriwai63ZB2Yemcp0
   c9YijYlWVOoKKw5dHoyoxozDXvz3uPvwTH/eyA06HRw5nq+J1/E0PaFkC
   BJyrF9sgUorXF2mtEo6/JZYl+ZHRyq2I2qJkrLAvuZmFhasKeBe353EyF
   1wiLn4hjsZCv3tPYNLZFdBJGyfoeASr8hgclcbv2KwkUWtPNjCEnZDsH6
   lOOSrvELR7xqPPkaeJGNwMZmXdx/L+Ncb6s1rqezJK7T2BUC3xbK7mjRL
   F6ERHaSp+AdyGR6b0ry7xRCKnu51TLja4xtM4n+AzZNuYICOTbpReirIY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="400423989"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="400423989"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:02:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="22439003"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:02:18 -0800
Received: from [10.213.169.162] (kliang2-mobl1.ccr.corp.intel.com [10.213.169.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 75637580DA4;
	Tue, 30 Jan 2024 06:02:17 -0800 (PST)
Message-ID: <fe3a8fea-00ba-48ca-8dba-4b48901042f3@linux.intel.com>
Date: Tue, 30 Jan 2024 09:02:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf test hybrid failing on 14700K
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
 <CAP-5=fWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjRw476VKA@mail.gmail.com>
 <Zbj_8KkXWnCJB-8M@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zbj_8KkXWnCJB-8M@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-01-30 8:56 a.m., Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 19, 2024 at 10:09:10PM -0800, Ian Rogers escreveu:
>> On Sat, Dec 23, 2023 at 5:55 AM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>>>
>>> Hi Kan,
>>>
>>> I noticed the following problem, are you able to reproduce it?
>>>
>>> Happy solstice!
>>>
>>> - Arnaldo
>>
>> Hi Arnaldo,
>>
>> I'm seeing a test failure on Alderlake in perf-tools-next and wondered
>> if it was on your radar:
>> ```
>>  32: Session topology                                                :
>> --- start ---
>> test child forked, pid 539222
>> templ file: /tmp/perf-test-HMet21
>> Using CPUID GenuineIntel-6-97-2
>> ------------------------------------------------------------
>> perf_event_attr:
>>  type                             0 (PERF_TYPE_HARDWARE)
>>  config                           0x800000000
>>  disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 4
>> ------------------------------------------------------------
>> perf_event_attr:
>>  type                             0 (PERF_TYPE_HARDWARE)
>>  config                           0x400000000
>>  disabled                         1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
>> non matching sample_type
>> FAILED tests/topology.c:73 can't get session
>> test child finished with -1
>> ---- end ----
>> Session topology: FAILED!
>> ```
>>
>> The code is hitting this line in evlist__valid_sample_type as
>> core.nr_entries is 2 on hybrid not 1:
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evlist.c?h=perf-tools-next#n1215
>> this causes perf_session__open to fail:
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/session.c?h=perf-tools-next#n129
> 
> Yes, I see this as well, haven't yet analysed it

This should has been fixed by James.
https://lore.kernel.org/lkml/20240124094358.489372-1-james.clark@arm.com/

Thanks,
Kan
> 
> root@number:~# perf test -v topology
>  38: Session topology                                                :
> --- start ---
> test child forked, pid 260120
> templ file: /tmp/perf-test-WMa4M5
> Using CPUID GenuineIntel-6-B7-1
> non matching sample_type
> FAILED tests/topology.c:73 can't get session
> test child finished with -1
> ---- end ----
> Session topology: FAILED!
> root@number:~#
> 

