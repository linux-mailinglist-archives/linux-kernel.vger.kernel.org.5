Return-Path: <linux-kernel+bounces-33896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBD837006
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A871F26641
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326A5D8F8;
	Mon, 22 Jan 2024 18:05:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DEC5D74F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946751; cv=none; b=UbKFVYHkavIejqW5D8o37GWJdTkJswOpmVWrOocEzXNs74GSJYhgcDh2Rz2Yk/hjUU8UnN6DMP6kVif/CLU6G15f6bN0UUN3NaM246gfZVVOifhneFN/1iQvmx5xHg/94YF8qPGpRyWtS5vtSba8hERoxQhcH6cYozdAA5lQeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946751; c=relaxed/simple;
	bh=vjkQbsJF7oly2TIEgMq2DhwGPrjb127EyE57puGIqe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNSnzPnlH2L5NRrVUp4augGj4m95m9nsyOAcOP1zL2d53kELjcZRFWjGezkOBYVv60qyNqBJRTvOevxQZv9ZBIZFQ2pNnxfoS8xN1oWZD9nkvT+h9OHs2pZKpzDRNl2zST0viI7d7MacrVTcOi9Wes2nE6g+8T3ZwqbutX/38qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B180313D5;
	Mon, 22 Jan 2024 10:06:35 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 884B73F5A1;
	Mon, 22 Jan 2024 10:05:46 -0800 (PST)
Message-ID: <22cc6861-3f3a-a38b-307b-809e29d034c1@arm.com>
Date: Mon, 22 Jan 2024 18:05:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 08/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-GB
To: babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-9-james.morse@arm.com>
 <286216a9-d586-42dc-9f1a-8909364bd7bd@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <286216a9-d586-42dc-9f1a-8909364bd7bd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 03/01/2024 19:43, Moger, Babu wrote:
> On 12/15/23 11:43, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Keep track of the number of RMID held in limbo each CLOSID has. This will
>> allow a future helper to find the 'cleanest' CLOSID when allocating.
>>
>> The array is only needed when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is
>> defined. This will never be the case on x86.

> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks!

James


