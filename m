Return-Path: <linux-kernel+bounces-33639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42090836C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57761F26D09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F24C3A3;
	Mon, 22 Jan 2024 15:58:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE23E48C;
	Mon, 22 Jan 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939098; cv=none; b=Ihg8HMEDT2swnoF5f3ksqh8rV9fOQYRh1uSODr4wArmKmcw0osHvkOzIK1cwM0nnb9HbpO0I0uRxbpaL1PMRrmFFQ2nR2FcS+Q37P4ZJgXhZch/Lb6E9gzLrFkZNF9GIXrXIPWxOHH7Gq90ptWVQIDrhE+5ufI5Rb6SZntUI7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939098; c=relaxed/simple;
	bh=zoAq8vir56qyCEXCULxhD1kzhH4Cp1AG0AdQm5TVZG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tV0fXGmRe9EYd81QgUnOMMB6w+kX3AjFRSdOHPdfzgewnSilGiLafbOwFRuHCFrtqAWdQKUhQptQa1jxhl46Jhf0Gg2QOqJHvVVkEjNBd666qd3t5K3kiLht+7fc4x8xNHg8TZiGJT2IQ5I+47g7s+bZ0aymyagjS91I9KJFhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 665AF1FB;
	Mon, 22 Jan 2024 07:59:01 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 960AB3F5A1;
	Mon, 22 Jan 2024 07:58:13 -0800 (PST)
Message-ID: <c8568014-c9e5-4555-b086-e231647696f5@arm.com>
Date: Mon, 22 Jan 2024 15:58:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf test: Fix session topology test on heterogeneous
 systems
Content-Language: en-US
To: linux-perf-users@vger.kernel.org, mark.rutland@arm.com, irogers@google.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>,
 Changbin Du <changbin.du@huawei.com>, linux-kernel@vger.kernel.org
References: <20240122155436.185089-1-james.clark@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240122155436.185089-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/01/2024 15:54, James Clark wrote:
> The test currently fails with this message when evlist__new_default()
> opens more than one event:
> 
>   32: Session topology                                                :
>   --- start ---
>   templ file: /tmp/perf-test-vv5YzZ
>   Using CPUID 0x00000000410fd070
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xb00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 4
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xa00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 5
>   non matching sample_type
>   FAILED tests/topology.c:73 can't get session
>   ---- end ----
>   Session topology: FAILED!
> 
> This is because when re-opening the file and parsing the header, Perf
> expects that any file that has more than one event has the session ID

session ID -> sample ID

