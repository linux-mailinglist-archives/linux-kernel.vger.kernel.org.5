Return-Path: <linux-kernel+bounces-54761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4384B34F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175DE1F2280A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCDC12E1FC;
	Tue,  6 Feb 2024 11:20:10 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDD612F386;
	Tue,  6 Feb 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218409; cv=none; b=arsOueyYDCJeNzM3w4SZaNx4uR1XtCc5Mtz62psW8TFiB7/QXBKytbAf/eA/4eBFk8Ytwnwj+Fwvcw11AtOrVra8bBBd6nuWoUt8g49EOOguRO1jUKXM4d2+PoIvNh7rH7CeDl5xaZnAdxOhckr348gyNC9Hxh38V5ffeEapopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218409; c=relaxed/simple;
	bh=jXDJ/7VsvP6dKXAq9+t5H8lnoCQ6UEDCOXgzG9RhFEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyxPAZZLVC0p/NLfSrsSje1Wk5LWhY7iXsDkvnw76P/5yq8AGgAl3oUiowyvI9xQzBAgaLB17IHGd4xaZxZmcP0PA1i2nkxweBltBjtcKLtNnwPLKmqhkHUYssnLeKJlzhNiRnb/5e+XDPKSpKKN0tgl0EA1MHH/zB7wVGqtEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TTgkW2YxCz1vt9M;
	Tue,  6 Feb 2024 19:19:31 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 108DB140499;
	Tue,  6 Feb 2024 19:19:59 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Tue, 6 Feb
 2024 19:19:57 +0800
Date: Tue, 6 Feb 2024 19:19:39 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, Andi
 Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
	<changbin.du@gmail.com>
Subject: Re: [PATCH v6 2/5] perf: util: use capstone disasm engine to show
 assembly instructions
Message-ID: <20240206111939.kmw4u4p47l6ed74k@M910t>
References: <20240206021438.768731-1-changbin.du@huawei.com>
 <20240206021438.768731-3-changbin.du@huawei.com>
 <631f8b5e-2bd2-4419-885f-34be07012b29@intel.com>
 <20240206111150.zqjyx33wqipqitzu@M910t>
 <51db7422-582e-4958-9704-e00719605b25@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51db7422-582e-4958-9704-e00719605b25@intel.com>
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Tue, Feb 06, 2024 at 01:17:05PM +0200, Adrian Hunter wrote:
> On 6/02/24 13:11, Changbin Du wrote:
> > On Tue, Feb 06, 2024 at 12:33:10PM +0200, Adrian Hunter wrote:
> >> On 6/02/24 04:14, Changbin Du wrote:
> >>> +size_t sample__fprintf_insn(struct perf_sample *sample, struct thread *thread __maybe_unused,
> >>> +			    struct machine *machine __maybe_unused, FILE *fp)
> >>> +{
> >>> +	pr_warning_once("perf needs to be built with libcapstone support to disassemble instructions\n");
> >>> +	return sample__fprintf_insn_raw(sample, fp);
> >>
> >> The validation stops this being called so could just leave
> >> out the 2 lines above, and add __maybe_unused as necessary.
> >>
> > I expect this being a generic api and could be invoked by other functions which
> > may not require the validation (raw code is acceptable).
> 
> kernel-style is not to add code if it isn't being used,
> but it seems likely another user of the API would probably
> need to check for libcapstone first, just like perf script,
> so the code would still not be used.
>
okay, so let me just return 0 since nothing printed.

-- 
Cheers,
Changbin Du

