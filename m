Return-Path: <linux-kernel+bounces-48057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244CF8456BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D341C288E86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7915D5C2;
	Thu,  1 Feb 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WRELC0PS"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B515CD54
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788967; cv=none; b=OucXdQRig5OdO4r47IHC5IddWwxxwtY0QbujzSOs1N/qeNfqTYhqPKXA7KWAE66Au/nZPKlFVcXfQyVXieP+0Fiwr/aEIartx4a3P0V7BUKPMaWoQ4zdcxnzMUmeizwhCce7KdrxbkZrJdG9ot0zoCdAwK1BUi19uLcgyeeDvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788967; c=relaxed/simple;
	bh=U1QgTx/gonDu/uoDj6Yhkj7Mk5lTXdQzwCSaXC26Vq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYYA/lb7cSMDkp2BPGCqQDV2evigCigkKhY6JBKoi1FBYbPbMp2mrYM+1FC6VQsl/f77NED3X30D8y/vaJENWi2tI+WuknCNon5/OpSxMHgsy6DQAQUVaqD6IYmwB6XrgrkheY4n5CRFU3S+SrsZ+0DgY2vjlkMkXpvXT47c6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WRELC0PS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.212] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F789206FCD0;
	Thu,  1 Feb 2024 04:02:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F789206FCD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706788965;
	bh=qjw0e01e5zFmjwwo4oUZmNAjRO4lcWWRzjpiHATsHPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WRELC0PSaLUMEtlRV/S8ryd5KvNa58lt15AZNRro2BSnLpzOJFyou7LW6Nv9NfFoY
	 GfOyTslatpxy2VeYebidLaHHNzfydmCyJHoEFt05OPTOV7uPHkCYu3eKXWmFLFCLPf
	 B3mXpPQSaXrvqobr5rXV0qztr8Dn4f4Mc1IWSzhk=
Message-ID: <1d9d3372-825a-417a-8811-ffa501c83936@linux.microsoft.com>
Date: Thu, 1 Feb 2024 13:02:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
To: Vishal Annapurve <vannapurve@google.com>,
 Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com,
 rientjes@google.com, seanjc@google.com, erdemaktas@google.com,
 ackerleytng@google.com, jxgao@google.com, sagis@google.com,
 oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
 dmatlack@google.com, pgonda@google.com, michael.roth@amd.com,
 kirill@shutemov.name, thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
 linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com,
 isaku.yamahata@gmail.com, andrew.jones@linux.dev, corbet@lwn.net,
 hch@lst.de, m.szyprowski@samsung.com, rostedt@goodmis.org,
 iommu@lists.linux.dev
References: <20240112055251.36101-1-vannapurve@google.com>
 <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com>
 <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
Content-Language: en-US
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/02/2024 04:46, Vishal Annapurve wrote:
> On Wed, Jan 31, 2024 at 10:03 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>
>> On 1/11/24 21:52, Vishal Annapurve wrote:
>>> @@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>>>       int ret;
>>>
>>>       /* Should not be working on unaligned addresses */
>>> -     if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
>>> -             addr &= PAGE_MASK;
>>> +     if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n", addr)
>>> +             || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
>>> +                     "misaligned numpages: %#lx\n", numpages))
>>> +             return -EINVAL;
>>
>> This series is talking about swiotlb and DMA, then this applies a
>> restriction to what I *thought* was a much more generic function:
>> __set_memory_enc_pgtable().  What prevents this function from getting
>> used on 4k mappings?
>>
>>
> 
> The end goal here is to limit the conversion granularity to hugepage
> sizes. SWIOTLB allocations are the major source of unaligned
> allocations(and so the conversions) that need to be fixed before
> achieving this goal.
> 
> This change will ensure that conversion fails for unaligned ranges, as
> I don't foresee the need for 4K aligned conversions apart from DMA
> allocations.

Hi Vishal,

This assumption is wrong. set_memory_decrypted is called from various
parts of the kernel: kexec, sev-guest, kvmclock, hyperv code. These conversions
are for non-DMA allocations that need to be done at 4KB granularity
because the data structures in question are page sized.

Thanks,
Jeremi

