Return-Path: <linux-kernel+bounces-72801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37B85B8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B731282E79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC13612C2;
	Tue, 20 Feb 2024 10:16:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B75F470;
	Tue, 20 Feb 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424197; cv=none; b=D8ArFPlFvEqqmYKaGIUBg3WhvLXN20BfIjQ399RBI3v5Pu6nastIR9e5tie4JeHtJ/EybCRI3B9JpTcW/GY0O/yBclo6Kf4lYQcXxgmpH6oW9aBZvJnPEaAJ86ifnPe0NzRaZeqNY8tBRZR+o3jn92Z88meOmEuoG+V1JxrQBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424197; c=relaxed/simple;
	bh=Q2SEni8lYrReOYpeYRIQl/qQW9MUqNjd7JPwTm5wWCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9YZLi+N4+5YVTymcD+tZF5TUY1wFuk8tGbvzq7M8+Uuwi5gbgMFL6rEE/P12eS6ne7svfjwXT0LZGLr7Ngr4rnLmK4ZkQZJ68vpT4C+5rSlO+jfYPtj51VmsgjyzdcbJivh6eRx2CO+/NtcUDvmgufiYWjs0T0qkdLY5fgS8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39A611007;
	Tue, 20 Feb 2024 02:17:14 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B81013F762;
	Tue, 20 Feb 2024 02:16:31 -0800 (PST)
Message-ID: <7df55836-f782-3765-d8eb-67b6ae6a3bc4@arm.com>
Date: Tue, 20 Feb 2024 10:16:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] perf tools: Fix test "perf probe of function from
 different CU"
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
 linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Georg_M=c3=bcller?=
 <georgmueller@gmx.net>, Masami Hiramatsu <mhiramat@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
References: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/02/2024 04:29, Chaitanya S Prakash wrote:
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Defconfig doesn't provide all the necessary configs required for the
> test "perf probe of function from different CU" to run successfully on
> all platforms. Therefore the required configs have been added to
> config fragments to resolve this issue. On further investigation it was
> seen that the Perf treated all files beginning with "/tmp/perf-" as a
> map file despite them always ending in ".map", this caused the test to
> fail when Perf was built with NO_DWARF=1. As the file was parsed as a
> map file, the probe...--funcs command output garbage values instead of
> listing the functions in the binary. After fixing the issue an
> additional check to test the output of the probe...--funcs command has
> been added.
> 
> This patch series has been tested on 6.8-rc3 mainline kernerl, both on
> arm64 and x86 platforms.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Georg Müller <georgmueller@gmx.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Chaitanya S Prakash (3):
>   perf tools: Enable configs required for
>     test_uprobe_from_different_cu.sh
>   perf tools: Only treat files as map files when they have the extension
>     .map
>   perf test: Check output of the probe ... --funcs command
> 
>  tools/perf/builtin-script.c                    | 15 +--------------
>  tools/perf/tests/config-fragments/config       |  3 +++
>  .../shell/test_uprobe_from_different_cu.sh     |  2 +-
>  tools/perf/util/string.c                       | 18 ++++++++++++++++++
>  tools/perf/util/string2.h                      |  1 +
>  tools/perf/util/symbol.c                       |  5 ++++-
>  6 files changed, 28 insertions(+), 16 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

