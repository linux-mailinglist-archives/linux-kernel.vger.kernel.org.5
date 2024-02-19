Return-Path: <linux-kernel+bounces-71714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F385A95F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDC01C22906
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ED5446CC;
	Mon, 19 Feb 2024 16:53:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32464437E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361634; cv=none; b=AVurDfC8catdZ2sDzMKeBEbVssas+NtUgxdmv/dwCtJ+WOBoElhZGowGGNdRrrjZdfZ7hq35O0qZwctu2M+/8vTYCLyjgpADyaY7zrb/PX6vzGQPeS+WOSsWtUgUNRUyDfMMrBXSF/r3hAtfHemgHA45IbqP6heg5rlq8qvPFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361634; c=relaxed/simple;
	bh=jNG2UBlz0AARR7JcjYI2bdU4AslUQ5qXdKsNm7iVCJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmNNdRE3oAj0ZO2Qc7I0oQ64oh1AemYbm1xlJ/tBbtY6MssRaKNSlV2zxYdP466aSdHTL41U4j7sJyzV7aSxP/L4K9gdv+OFdz+br88+f755jNWxZKKjwPHlcESyZ7X7Hua9aTs6r20/yOb2suOoL/B6Q+4h3pNPulOoKggvctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D59B91042;
	Mon, 19 Feb 2024 08:54:31 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A6C3F762;
	Mon, 19 Feb 2024 08:53:47 -0800 (PST)
Message-ID: <d14dcee0-da13-442b-b73a-c51792e14f73@arm.com>
Date: Mon, 19 Feb 2024 16:53:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/24] x86/resctrl: kfree() rmid_ptrs from
 resctrl_exit()
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
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-3-james.morse@arm.com>
 <d587fdcb-776a-4464-a5e0-dc9491504ae9@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <d587fdcb-776a-4464-a5e0-dc9491504ae9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 13/02/2024 23:14, Reinette Chatre wrote:
> On 2/13/2024 10:44 AM, James Morse wrote:
>> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
>>
>> While the exit text ends up in the linker script's DISCARD section,
>> the direction of travel is for resctrl to be/have loadable modules.
>>
>> Add resctrl_put_mon_l3_config() to cleanup any memory allocated
>> by rdt_get_mon_l3_config().
>>
>> There is no reason to backport this to a stable kernel.

> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

