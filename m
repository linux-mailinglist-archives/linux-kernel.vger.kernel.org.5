Return-Path: <linux-kernel+bounces-33894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB7D837005
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1779728F1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36F95D738;
	Mon, 22 Jan 2024 18:05:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B055355C07
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946739; cv=none; b=iOhUIjeDPKfLVN/yC54VvPZ9eZqYrNG7KdI4c5vdZTgh34n5IpzBeMHsAxTdkvdPaK+oyCBhkDt1isFPAOmqdnH2l9kpKtilydc/Gwj8H4PU+sDN1GVqay3LWyzpvN7cIY5bWQsuo1C/J6qRRJJcDCUdJHcvf/iDYRp1Qi87ypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946739; c=relaxed/simple;
	bh=mkOh437bqgzsjSVRgyWnmYukaqIxTYJlIqBagsASh50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiezU88oBhOiOsSNEGMDspVJVlX3u6edaWJXy4dpTF2gWsdH1URorUzYSu/oExbqVmzVez06j/eK8p84dFvDQoDAvC+Jn5Ilq8DFGI0R/bCJSPbwBy8rvCZxUmE7eOGBgbkWIfZjaRfTvXJfhGQV2qQTPG//A5PlZVX7qnO6cgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BC99106F;
	Mon, 22 Jan 2024 10:06:23 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8DA13F5A1;
	Mon, 22 Jan 2024 10:05:34 -0800 (PST)
Message-ID: <0463b814-f304-6317-f3c1-226688f33f8b@arm.com>
Date: Mon, 22 Jan 2024 18:05:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 06/24] x86/resctrl: Access per-rmid structures by index
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
 <20231215174343.13872-7-james.morse@arm.com>
 <0072e1fe-7c4e-4bd2-a1d9-24c2161d14d6@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <0072e1fe-7c4e-4bd2-a1d9-24c2161d14d6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 16/12/2023 04:58, Reinette Chatre wrote:
> On 12/15/2023 9:43 AM, James Morse wrote:
>> x86 systems identify traffic using the CLOSID and RMID. The CLOSID is
>> used to lookup the control policy, the RMID is used for monitoring. For
>> x86 these are independent numbers.
>> Arm's MPAM has equivalent features PARTID and PMG, where the PARTID is
>> used to lookup the control policy. The PMG in contrast is a small number
>> of bits that are used to subdivide PARTID when monitoring. The
>> cache-occupancy monitors require the PARTID to be specified when
>> monitoring.
>>
>> This means MPAM's PMG field is not unique. There are multiple PMG-0, one
>> per allocated CLOSID/PARTID. If PMG is treated as equivalent to RMID, it
>> cannot be allocated as an independent number. Bitmaps like rmid_busy_llc
>> need to be sized by the number of unique entries for this resource.
>>
>> Treat the combined CLOSID and RMID as an index, and provide architecture
>> helpers to pack and unpack an index. This makes the MPAM values unique.
>> The domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as
>> are domain mbm_local[] and mbm_total[].
>>
>> x86 can ignore the CLOSID field when packing and unpacking an index, and
>> report as many indexes as RMID.

> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks!

James



