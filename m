Return-Path: <linux-kernel+bounces-54388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44384AEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024C5285703
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEADC12880D;
	Tue,  6 Feb 2024 07:10:07 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB5128802;
	Tue,  6 Feb 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203407; cv=none; b=RFlsW4bcpTFjXfKPBjvESeKfn8ENoNvbvVI1H4elHUbqegHWGJ7LH6H7ox3R84+lp3HubVItxJyFu2L3bLdrdaleB6l2JcPUPZtkjHof4mYHaWeo0UG5IVO4ez4Hij4gU+laqcIu+UBSTQ+WOlgkku51l0X4ptmFEQOv8n/qLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203407; c=relaxed/simple;
	bh=sP0+3IoatM5rxJCdyOt8aV9I1XKx8tCRXkDH41UfBmI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W4LUJRcgxkj7qcfIaAl+dMXTbt/9BhURuxQRK+k978tbblLAA+IfzpO0cUCmtw0foeAe/uDqInVSYu/vmo5mTO4leT/qrwKFeDFUpyMpEVJ5EbbNparawta2leyk977ek8U6A54QoVfujzYfw7n2zQg/UD8JNThuK6lPg3RPc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TTZ8Q1MNjz1Q8l9;
	Tue,  6 Feb 2024 15:08:06 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C795140390;
	Tue,  6 Feb 2024 15:10:02 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 15:10:01 +0800
Subject: Re: [PATCH 5/5] perf thread_map: Free strlist on normal path in
 thread_map__new_by_tid_str()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240205104616.132417-1-yangjihong1@huawei.com>
 <20240205104616.132417-6-yangjihong1@huawei.com> <ZcEybM9bV6vP9n7K@x1>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <7081618d-eb64-3eda-dc1a-2719b6ac5194@huawei.com>
Date: Tue, 6 Feb 2024 15:10:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZcEybM9bV6vP9n7K@x1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Hello,

On 2024/2/6 3:09, Arnaldo Carvalho de Melo wrote:
> On Mon, Feb 05, 2024 at 10:46:16AM +0000, Yang Jihong wrote:
>> slist needs to be freed in both error path and normal path in
>> thread_map__new_by_tid_str().
> 
> Please add:
> 
> Fixes: b52956c961be3a04 ("perf tools: Allow multiple threads or processes in record, stat, top")
> 
OK, will add fixes tag in v2.

> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
Thanks for the reviewed-by tag

> - Arnaldo

Thanks,
Yang

