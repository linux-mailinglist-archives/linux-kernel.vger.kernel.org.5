Return-Path: <linux-kernel+bounces-121966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD75588EFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4841F2FA00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B4152520;
	Wed, 27 Mar 2024 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EmQs82/6"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C15137764
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570486; cv=none; b=lnMS3wsoLJeU79jqm/cd+/PADm8IIZHr1hdvoW2Ew2RZK6YoBGF3zQIMFfUH5xS5kd/Z4HJJ/e6g82vxCeqtdiVILBY51lkq/oFlDYQK0mKFyXuCMaKwod0LtA7pPQQ4r0qbXp0LdP3Uklhio1JIjTOVeS5mubUa9ouvZjQtS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570486; c=relaxed/simple;
	bh=neQf4eKiBF6fjnhAkZORZQaKoNsXJqfl8RdUdwaGnjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzOUQkhSELunGONm60wgK0tAnpUUtTvT1a7NrHaGhpfvNJ0UJz/NbzsqAYLeEif/1DzdnaLcgznxnmFrNzQcsB4ycf0BILWKDkDsna89AERcf4HRe/SJf0/FHAu4XCFt0yqwutqPsQyUEVtawOon9CjIRqJojVBQHerukXBixpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EmQs82/6; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cc77e74b5cso9668339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711570484; x=1712175284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCYK7bXPxC3buWagK44KXlYoaMMqT9xkSSzlJu6d89E=;
        b=EmQs82/6Armje5j3LNcur5raGfMx5qSvGFQU0P1z9XUUl3bKndGfeaUusVJUBEws4c
         bBr7ZHBMTafSqmMcFuanSlOgkNF53XqL9ZiVmm/5IheFGYX5ZzF0b/bvGp/TNclXNbRc
         JFHXmtJVDooKNW6iuBGi10gJfZa25yS2XxzTFZDIsh8KzOOUcrmkyjIMdmEv5Wf/OHOe
         W7amXAosOxRXSsVhYh+37Z75vgRm6Ew+tU0sXJZ97fFt2Ypo/ptbmT7I5I2vm9vZ4fhU
         UIYzViC50dVi7tTLFP7YDVKcYY4o9hrvLs8mvKNQGQBMj2AubhD5tSxoYi6gqaCPTFt3
         NvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711570484; x=1712175284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCYK7bXPxC3buWagK44KXlYoaMMqT9xkSSzlJu6d89E=;
        b=YQdcuYmujRLP2SxbcAbY0HPQ/mR7XvpmQvVUxGoW46zvDq0RzVAxRWu1maXAhrRO5h
         /IglWTY8J8Jwalf3qdeoTsxZMQ/RnlRa8UDva3Ty2v5FX0QyYeSQJzhuaAUl9+V3YRWg
         XQIYf8GVSVN9LdAD+TBwIXFIYKBwsyycJGc5zl3yc0vRF5iZ/c8WAxEm9iVeo6oFx26J
         TrCArA5/lv35vH0q54/SvPbQiZAUDkhW3S/YPMn0OPMWgnZweu6CzSYA9p1P0UqgUbDV
         jbP2lA/uXqKURDXqcsLZY3WHG4q1MGmGxRv+Qf42nAqiddsvjxl4jsQtmv2wS/4Dc/wH
         0m5w==
X-Forwarded-Encrypted: i=1; AJvYcCV7jw8rQvgjuWL09G/NWKQIGbwO03d1e5n5WOvsFoCmCVEBn0hmvoHN6cLEFageIdVPt968PJdf3s1of+nngDIEiaqg5tc5A/67pIQB
X-Gm-Message-State: AOJu0YxdNku6LX4jDnBooCtqlVJKIdDkynP6CNqfWlYUfC4O5P30s2tV
	SZgI7Lofv+lQwSLpMzqVjIny6TfkA7tgIas4WqxJVXYz96JGYpvv8AfLGcvfNWM=
X-Google-Smtp-Source: AGHT+IGrYJKauK6ZcJyKJz7JlCwCofgjda6+JxtqTQ2saoYuavom2kgtDdRJaPeiZoY+65A1na55Lg==
X-Received: by 2002:a6b:7311:0:b0:7c8:4c27:810e with SMTP id e17-20020a6b7311000000b007c84c27810emr520564ioh.18.1711570483944;
        Wed, 27 Mar 2024 13:14:43 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id g8-20020a02b708000000b0047469b04c35sm3465108jam.65.2024.03.27.13.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:14:43 -0700 (PDT)
Message-ID: <e409d77b-0dad-45c2-a507-a8b697ff4702@sifive.com>
Date: Wed, 27 Mar 2024 15:14:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v6 05/13] riscv: Only send remote fences when
 some other CPU is online
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
 <20240327045035.368512-6-samuel.holland@sifive.com>
 <CAEEQ3wm4SoC6rvv2qtVdP+4ZF1q41EEHUpwnagNgFwxkG5iw_w@mail.gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <CAEEQ3wm4SoC6rvv2qtVdP+4ZF1q41EEHUpwnagNgFwxkG5iw_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yunhui,

On 2024-03-27 1:16 AM, yunhui cui wrote:
> On Wed, Mar 27, 2024 at 12:50 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
>>
>> If no other CPU is online, a local cache or TLB flush is sufficient.
>> These checks can be constant-folded when SMP is disabled.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> (no changes since v4)
>>
>> Changes in v4:
>>  - New patch for v4
>>
>>  arch/riscv/mm/cacheflush.c | 4 +++-
>>  arch/riscv/mm/tlbflush.c   | 4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> index d76fc73e594b..f5be1fec8191 100644
>> --- a/arch/riscv/mm/cacheflush.c
>> +++ b/arch/riscv/mm/cacheflush.c
>> @@ -21,7 +21,9 @@ void flush_icache_all(void)
>>  {
>>         local_flush_icache_all();
>>
>> -       if (riscv_use_sbi_for_rfence())
>> +       if (num_online_cpus() < 2)
>> +               return;
>> +       else if (riscv_use_sbi_for_rfence())
>>                 sbi_remote_fence_i(NULL);
>>         else
>>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index da821315d43e..0901aa47b58f 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -79,7 +79,9 @@ static void __ipi_flush_tlb_all(void *info)
>>
>>  void flush_tlb_all(void)
>>  {
>> -       if (riscv_use_sbi_for_rfence())
>> +       if (num_online_cpus() < 2)
>> +               local_flush_tlb_all();
>> +       else if (riscv_use_sbi_for_rfence())
>>                 sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
>>         else
>>                 on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
>> --
>> 2.43.1
>>
> 
> From a perceptual point of view, the modification here is not
> necessary. There is such logic in on_each_cpu(). Can you share your
> test data?

The logic in on_each_cpu() doesn't apply when riscv_use_sbi_for_rfence() is
true, so we would make unnecessary SBI calls, and cannot be oppimized out when
CONFIG_SMP=n. The cover letter includes benchmarks for a representative
single-core system (D1). There was no measurable performance impact from this
portion of the series on multi-core systems. If there are specific benchmarks
you think I should run, please let me know.

Regards,
Samuel


