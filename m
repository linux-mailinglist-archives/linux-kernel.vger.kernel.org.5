Return-Path: <linux-kernel+bounces-99701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8A878BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5388EB20F73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161997E6;
	Tue, 12 Mar 2024 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dCvedYoi"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8D63A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710203755; cv=none; b=ceoh6vha6qiUOp4appBmW/75PLx8IqSZA6tmlIUONqEDKkyB/UWdrhQrTsmuSMdpDCl7yukijfMxFxtSnyc2HVdSIqKU3j7XJ3scwyj4v3B+gKbysWF4M4mKofkxWsC7wTv0g+/1xD6c5tlk8ijSfD0FV+L1OXUkIfjXqMr5Hsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710203755; c=relaxed/simple;
	bh=TpIS1vfLQJyDHgGigTC7f68IgnLxdrd1hjqFVH29Dyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ei6T1BWzzdJZtan6h1NWhWE+8CDEqOyxoeayAvS2lbfmDuK1Cd/PqaIgfDfNUx4qZPkEb6PwCRsn1fpVaTafdyQqhltdZsbqIYr+rhTSL743m/vXPY7XIy3TrmrQv1fWjdjUH7+IcNcfZ1nJKTsSnpGb1vytmK4dsdQbS7KB7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dCvedYoi; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42f2a4f77a6so18401561cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710203752; x=1710808552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JTBtDRaEpoCIigQxhZrQrfkOxHxP/G0rOetjigew6g=;
        b=dCvedYoif454sBMmgIqHjnytCQ8hSk7xMByOxuFMIzFVHwRliYU20r2sByyemC/ye7
         5b+E8BorU1thbbtgCIP3Vj3DP7XTOoyINAxnmW9tkDDz3DVIpoRL26WXgZlLh/H3YzNK
         3yuQ3CEwgo+zN8KAi+IE+nv7SXZGtY2hg2g2KbUwI92oeUvjFU8sLKOQP80BZs6usndI
         OCgP+gzdsoE6xykz88TX9AMHMdnagDNhxvUzTPvphZmiCxFW9L01XypSfG6frnj1Pta2
         OKwj/9xhDcK+XDoMHl9x9BScSqGO1oDCn6tzFvnnihMMXdC596bCHAWisU+DAEnm+U6j
         9dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710203752; x=1710808552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JTBtDRaEpoCIigQxhZrQrfkOxHxP/G0rOetjigew6g=;
        b=gHzHF6qZav8Ofh0y+zukeYLraCTgupDDxrffymTvqIF+t1Lkvm6w2s64Koq1f+HIKh
         IKuHQYRKdXeltPNUGxuTAP962TJcWRzRQbU+xkCO2H7cus3eRLzJXVSjRTecURht+SWA
         OKljYJJBi4I7Hktrc11OfrCZjNKGnq3EPzeiqtxz03ZdMnbBE+0B3CDfB3ZsN5FQEImx
         YJG8/pZq+JjFrZnGOs2j6sNZmQiFaj2ZFEG+L4m+/x8LKp8SJ8iNBcbKTdA+z8gvtV1D
         D0Fka9ruT9n0PPN8QNVwkOcNPiswVjq2oqTmoOc6zADcIYCSZk7jiZR8Vz3RPr4PhgeJ
         UVFw==
X-Forwarded-Encrypted: i=1; AJvYcCX32IYtxynMjCdbrXQBQ3obkVbxZcZG4GxsFH6o7OpdUxS/nLrz5hM4Kj4OJkl3Hi0i0N41xaVaipPvQ2SUwM0jXIvRjxp+n2cR8aAv
X-Gm-Message-State: AOJu0YyoidMUtYfJbj5RGBufo9E6BagyzhLTRABPrc5NvG+P4kLjqFf+
	SivND64/6x/gMs8xAEg5NnxvBfPJqiH/5+6SUw3OcapbvLdtjbp+pyhkaCjs73U=
X-Google-Smtp-Source: AGHT+IEf0OlYbf0aVPGX+KApg4PvxZ0cB3JvU5qic6wZx79zx+tbwWq5OvM38n+dAE1aOcxr4lfC8A==
X-Received: by 2002:a05:622a:3cd:b0:42e:fcf5:b0a0 with SMTP id k13-20020a05622a03cd00b0042efcf5b0a0mr589449qtx.66.1710203752404;
        Mon, 11 Mar 2024 17:35:52 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id o9-20020ac84289000000b0042c78553d1dsm3211862qtl.28.2024.03.11.17.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:35:51 -0700 (PDT)
Message-ID: <100d5414-11fa-4c47-9c35-51f5fad2d6e6@sifive.com>
Date: Mon, 11 Mar 2024 19:35:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v5 08/13] riscv: Avoid TLB flush loops when
 affected by SiFive CIP-1200
Content-Language: en-US
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
 <20240229232211.161961-9-samuel.holland@sifive.com>
 <CAEEQ3w=8dVxO=qtW6_-SChLJ5No+7nGgf+1fXz0wSeBhb0Kk0A@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAEEQ3w=8dVxO=qtW6_-SChLJ5No+7nGgf+1fXz0wSeBhb0Kk0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yunhui,

On 2024-02-29 8:48 PM, yunhui cui wrote:
> Hi Samuel,
> 
> On Fri, Mar 1, 2024 at 7:22 AM Samuel Holland <samuel.holland@sifive.com> wrote:
>>
>> Since implementations affected by SiFive errata CIP-1200 always use the
>> global variant of the sfence.vma instruction, they only need to execute
>> the instruction once. The range-based loop only hurts performance.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v4)
>>
>> Changes in v4:
>>  - Only set tlb_flush_all_threshold when CONFIG_MMU=y.
>>
>> Changes in v3:
>>  - New patch for v3
>>
>>  arch/riscv/errata/sifive/errata.c | 5 +++++
>>  arch/riscv/include/asm/tlbflush.h | 2 ++
>>  arch/riscv/mm/tlbflush.c          | 2 +-
>>  3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
>> index 3d9a32d791f7..716cfedad3a2 100644
>> --- a/arch/riscv/errata/sifive/errata.c
>> +++ b/arch/riscv/errata/sifive/errata.c
>> @@ -42,6 +42,11 @@ static bool errata_cip_1200_check_func(unsigned long  arch_id, unsigned long imp
>>                 return false;
>>         if ((impid & 0xffffff) > 0x200630 || impid == 0x1200626)
>>                 return false;
>> +
>> +#ifdef CONFIG_MMU
>> +       tlb_flush_all_threshold = 0;
>> +#endif
>> +
>>         return true;
>>  }
>>
>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>> index 463b615d7728..8e329721375b 100644
>> --- a/arch/riscv/include/asm/tlbflush.h
>> +++ b/arch/riscv/include/asm/tlbflush.h
>> @@ -66,6 +66,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
>>                                unsigned long uaddr);
>>  void arch_flush_tlb_batched_pending(struct mm_struct *mm);
>>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>> +
>> +extern unsigned long tlb_flush_all_threshold;
>>  #else /* CONFIG_MMU */
>>  #define local_flush_tlb_all()                  do { } while (0)
>>  #endif /* CONFIG_MMU */
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 365e0a0e4725..22870f213188 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -11,7 +11,7 @@
>>   * Flush entire TLB if number of entries to be flushed is greater
>>   * than the threshold below.
>>   */
>> -static unsigned long tlb_flush_all_threshold __read_mostly = 64;
>> +unsigned long tlb_flush_all_threshold __read_mostly = 64;
>>
>>  static void local_flush_tlb_range_threshold_asid(unsigned long start,
>>                                                  unsigned long size,
>> --
>> 2.43.1
>>
> 
> If local_flush_tlb_all_asid() is used every time, more PTWs will be
> generated. Will such modifications definitely improve the overall
> performance?

This change in this commit specifically applies to older SiFive SoCs with a bug
making single-page sfence.vma instructions unsafe to use. In this case, a single
call to local_flush_tlb_all_asid() is optimal, yes.

> Hi Alex, Samuel,
> The relationship between flush_xx_range_asid() and nr_ptes is
> basically linear growth (y=kx +b), while flush_all_asid() has nothing
> to do with nr_ptes (y=c).
> Some TLBs may do some optimization. The operation of flush all itself
> requires very few cycles, but there is a certain delay between
> consecutive flush all.
> The intersection of the two straight lines is the optimal solution of
> tlb_flush_all_threshold. In actual situations, continuous
> flush_all_asid will not occur. One problem caused by flush_all_asid()
> is that multiple flush entries require PTW, which causes greater
> latency.
> Therefore, the value of tlb_flush_all_threshold needs to be considered
> or quantified. Maybe doing local_flush_tlb_page_asid() based on the
> actual nr_ptes_in_range would give better overall performance.
> What do you think?

Yes, this was something Alex brought up when adding this threshold, that it
should be tuned for various scenarios. That still needs to be done. This patch
just covers one specific case where we know the optimal answer due to an erratum.

Regards,
Samuel


