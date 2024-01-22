Return-Path: <linux-kernel+bounces-33905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308E837017
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D281C295AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6AB5FBAC;
	Mon, 22 Jan 2024 18:06:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91C5FB96
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946798; cv=none; b=WhWiTQg4AjeXcooWOR0PYA4iEku5RNQ9O3g0RoWZjC8sT0gCV8mX+BVPrZqc/3PYZoJfjBwsstwnLbGEu//FJ3LWRtcCLVndotl3bDlxysoqvtFll46Dme9VEO62tCvJsM+3PBwvbJZKfyatCLgvjN3f//WXtpV3Y3KZC4CqCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946798; c=relaxed/simple;
	bh=HCgXEn0tm48cKGYKWxdvlNUL4kOd/LO0cgBonVcu7mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iiub0341q2xnb+Xe75ZIyLffQMijSo75HEVTq1/6PoR+lFF/V7cd4P9yFJyavArjIYzNwjurPA2N+p/0wneBm+3zJD/sIOTtQbNgGFOhT1ODCkpHd5Ij+Bp1GS90+CMeKoVwZ3iVcS0GkmlHbKHX5Cav8kVANQdfkux4L+rs9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E2E1477;
	Mon, 22 Jan 2024 10:07:22 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDD0A3F5A1;
	Mon, 22 Jan 2024 10:06:33 -0800 (PST)
Message-ID: <88a6c45b-eaf5-a391-7758-d04f1d0611d2@arm.com>
Date: Mon, 22 Jan 2024 18:06:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
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
 <20231215174343.13872-22-james.morse@arm.com>
 <1516e4ad-b0c6-4c03-922a-5b14522c8d0a@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <1516e4ad-b0c6-4c03-922a-5b14522c8d0a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 16/12/2023 05:02, Reinette Chatre wrote:
> On 12/15/2023 9:43 AM, James Morse wrote:
>> When a CPU is taken offline resctrl may need to move the overflow or
>> limbo handlers to run on a different CPU.
>>
>> Once the offline callbacks have been split, cqm_setup_limbo_handler()
>> will be called while the CPU that is going offline is still present
>> in the cpu_mask.
>>
>> Pass the CPU to exclude to cqm_setup_limbo_handler() and
>> mbm_setup_overflow_handler(). These functions can use a variant of
>> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
>> need excluding.

> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

