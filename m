Return-Path: <linux-kernel+bounces-33899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1FC837016
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F60290B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E15EE85;
	Mon, 22 Jan 2024 18:06:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925185EE7A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946779; cv=none; b=lJBsy19MMXvQcOst5ftBR9tk7jRQZBaYolE8EMGuV1DH26D7xDMGJSkJ6YABTv8IUE3NvKS5tERyX3gkGZJOp0WpK3B8IA4MiNhWndXBkot8QUtd3gw0V4/dsX5ZFX01dDMKWQdmB26MFVXHcMrCfXGh/tsqxIRMsk9Qmwemb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946779; c=relaxed/simple;
	bh=nvsspuUHuwR73EGCDJzUphXpHELKnqbnPKtYpb4y1uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JS3kGzjefL7cKwI6khp3CS7XmJLD6R5hblpBInrxwC2pf4AMsxtfY0h2GxaxcMQlAPtz+r61X8e4X8SemfDfAswoW9pu886THFUz0c4scEFhRtxqkgr4/n8jlFRZlU5/6dseaTj0jDiPnX59h1B7mwaC54MpKEKcprKnYwNVAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22D9A1424;
	Mon, 22 Jan 2024 10:07:02 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D01A3F5A1;
	Mon, 22 Jan 2024 10:06:13 -0800 (PST)
Message-ID: <9d30c56a-a772-c121-ca02-f3f237f0a892@arm.com>
Date: Mon, 22 Jan 2024 18:06:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-11-james.morse@arm.com>
 <25e75e7a-7cda-4099-8331-8fb1050a9dd5@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <25e75e7a-7cda-4099-8331-8fb1050a9dd5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 16/12/2023 05:01, Reinette Chatre wrote:
> On 12/15/2023 9:43 AM, James Morse wrote:
>> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>> used for different control groups.
>>
>> This means once a CLOSID is allocated, all its monitoring ids may still be
>> dirty, and held in limbo.
>>
>> Instead of allocating the first free CLOSID, on architectures where
>> CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
>> closid_num_dirty_rmid[] to find the cleanest CLOSID.
>>
>> The CLOSID found is returned to closid_alloc() for the free list
>> to be updated.


> (This is an example of me not relying on you dropping my reviewed-by tag
> to take a look at new changes.)

Significant changes. This is only the expected behaviour when significant changes are made
to a patch. This is a comment - and the text of the comment isn't changed.


> This change is unexpected and does not have anything to do with this patch.
> Instead it just seems to undo a change that sneaked into patch #8
> of this series.

Thanks - I was misled by closid_num_dirty_rmid existing before the patch with its name in
the subject. I'll fix this.


Thanks,

James

