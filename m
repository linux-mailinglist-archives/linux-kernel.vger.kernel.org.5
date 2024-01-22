Return-Path: <linux-kernel+bounces-33893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4D2837000
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232711F210A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3335C918;
	Mon, 22 Jan 2024 18:05:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA355C07
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946733; cv=none; b=sDfVKaZaXmRNnuImbmjmsUGZjLYIcP37GNFc/QbLTNx9z3rNmgtqqjyhnighCW1yByebXg2+heUXzaYIxjTglMJcSTkA/UdIL9sAly4nuXC+GIW/PiKfieBzzIBKCg1ppgvXTDrGLDG9JqC2VmkYHqDwc1xVzTpmTox00l3Dyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946733; c=relaxed/simple;
	bh=j6U/22XQiL0fB5WoQZtHBz16KttxKsPw+wy5+wRs478=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJeqho1TajVLuXnctjreeL6YuMDYYUQ3i7Q37prw+FhiPtHJPeyDsmI/PB1/MDHjXWPnSubVXtMZnIchPOsRrnhQ76b1U7yJR41miKgYTHeq9srPlH7UMM0sIsMm5uk14gEhd5KrsYOOQgPIzu8igpG59m03AH+zXO8y/M6Hdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73A37FEC;
	Mon, 22 Jan 2024 10:06:16 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8FA73F5A1;
	Mon, 22 Jan 2024 10:05:27 -0800 (PST)
Message-ID: <802e84b7-ff12-19df-cb72-6cf307c7d67a@arm.com>
Date: Mon, 22 Jan 2024 18:05:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 05/24] x86/resctrl: Track the closid with the rmid
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
 <20231215174343.13872-6-james.morse@arm.com>
 <e54dedf6-158f-4553-b309-e4c61d69587a@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <e54dedf6-158f-4553-b309-e4c61d69587a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 16/12/2023 04:58, Reinette Chatre wrote:
> On 12/15/2023 9:43 AM, James Morse wrote:
>> x86's RMID are independent of the CLOSID. An RMID can be allocated,
>> used and freed without considering the CLOSID.
>>
>> MPAM's equivalent feature is PMG, which is not an independent number,
>> it extends the CLOSID/PARTID space. For MPAM, only PMG-bits worth of
>> 'RMID' can be allocated for a single CLOSID.
>> i.e. if there is 1 bit of PMG space, then each CLOSID can have two
>> monitor groups.
>>
>> To allow resctrl to disambiguate RMID values for different CLOSID,
>> everything in resctrl that keeps an RMID value needs to know the CLOSID
>> too. This will always be ignored on x86.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James


