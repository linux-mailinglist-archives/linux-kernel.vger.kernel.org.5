Return-Path: <linux-kernel+bounces-56984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2784D243
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88E9288502
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5972785C50;
	Wed,  7 Feb 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="d3lBnFXA"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7485946
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334516; cv=none; b=AYcM7hZ4Wa1siDtEtJOp5j/Slkj0RCuKE7a2qRCsiqKF5xK1gThVhmX/XXJ2jX9JTSD4P5h+BJhXYIOxZ2oN7IS1J+NXHD/RjcyCVV422fTKfG7lTtYJXOxpoirvyU4EaZbTh3NExvD/g2SOnAisQ4QdikmZiZV0+eVL79T0/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334516; c=relaxed/simple;
	bh=vwN+D5W7fSFBHcmU7F4lz9AR0Hav7hHZZc7DLd/55bg=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ky6sCqsbNgn8Q5TXge/ZmNAkm5qs/Aa9SB/BcG214KZe6lXt0w0WXc4sR3FtA4djGi9Wp5QECMzoPM4+FYw4Hs+q1/oHvGzYJYsqWaQvOUfYBt+yjdL1RKdNSO2+ZBElk56fKp0+/jUHP5K7DSE9NDX7NrZI207+fw2qfkJW8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=d3lBnFXA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e06d2180b0so562278b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 11:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1707334513; x=1707939313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5DNJ0YWZMQGJUiB/7nqMNUBTgtfVhRG2xEzHjBsppl0=;
        b=d3lBnFXADp8WiM8tKDSQeCd8vb1Oz0nWYZCRMAuv2Qi8E/Nd2BnY7ojmTxsSaUCTop
         Dg81afMOlsPLdY69WRo5lE5NekW1cG2eSoBLIkBqH1OEnFwMDIVFG3e1KfxS/ONc0bap
         B3M3wwHVH2mEygswdYbhXRQMfXAy9kZkIfovwYkz5nVeBnidHqf+ssB6eKiiHE9hUHF8
         5iRdWNsdKRn6sQLmI4Uecx6dQ3Wv468So1CQc1FLxE6litUIuMF9l/xe3oYaFbRpz4Qk
         KGePbPsoSX4bfoOA3Ak+8ZIUIJdAvQu+ZyBL/XLvEpSlI/6ysm/9C63NuAfD5oxuPBCT
         OehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334513; x=1707939313;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DNJ0YWZMQGJUiB/7nqMNUBTgtfVhRG2xEzHjBsppl0=;
        b=Zlb1Ce9MmWrF/tkkzYTzRCotGfO0CZcjSZiab6U0gWd9pbEfpaiE4SfknnYjtAb3zr
         kmePsrJOSV4hoIY9t5/u0oRTfVcdMmBqh/M24BLcpi+LhjyrVFxF6iR0Ih99rghBIS/l
         rbkaAPJ4EZauKbKklB8xuvqpGJBYSmCe1XyrKsg0PaMNn/uFcqY6zUTiGH+l3vihJGoO
         VaEbQSTYjhBiFG0CTx9HB+3qcOfRaGhG25z0o5N3IOSQlkv1WHw+Sy8twUhqVFcv8uMt
         bVP2PM0odnaiaw2djAA+IsM2ztj9TxwdtfVnF4KwJb6gaL1fuopwbBDYfkKw+WUxLW2y
         L9vg==
X-Forwarded-Encrypted: i=1; AJvYcCXFMKCYN8mdlBICFWsobYVgrydWfmfDppSiaE4KbjW3YggQzBGB9T13JFP6UAdgjQjy4DfF0R290VO/vJq0z5IO9LwkkLKTwRBLGguG
X-Gm-Message-State: AOJu0YwiO2nSTzkSftN0WtbKs+RcmFzuVHgBu3EeQAS2WnVO2sbJgTAS
	gDf6UNRw3JEWYdHksW5AqUueuw4ppvuTxKywx1lueDxGxbSLojwTRNv7k1DeVZw=
X-Google-Smtp-Source: AGHT+IHecxI00C0AysG9jk2vFisMXFVveXNnX/H4oDlFL2OOUFQ/AEV1QOpSJXJ9aHab8uyRYIlfKQ==
X-Received: by 2002:a05:6a20:a092:b0:19e:987c:78a7 with SMTP id r18-20020a056a20a09200b0019e987c78a7mr4101823pzj.32.1707334513324;
        Wed, 07 Feb 2024 11:35:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7PM5eZAdnwqPrU9TC7lCb+5kyWOLdybcxqg3gwdxj5FVcxgrXFDgek0GyZpZ25vYnaquKPDeXQYeJBu03dxalZ1OiLKQbCmuOYYkKi4snVeuasLujaeCS7Vdcz9MwBWHwGg/DodlOcuuV0ckC/ciHANKGB2iQrxKivw32mbrxR+7hXyb9UvMJWdF5se7BjgDEgBM2AUxmSWE/Fn2OO3Zr5GH3aigEDwVXPiaRPTJizzIP
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id j17-20020a056a00175100b006d9b35b2602sm2024683pfc.3.2024.02.07.11.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:35:12 -0800 (PST)
Date: Wed, 07 Feb 2024 11:35:12 -0800 (PST)
X-Google-Original-Date: Wed, 07 Feb 2024 11:35:11 PST (-0800)
Subject:     Re: [PATCH -fixes] riscv: Fix arch_tlbbatch_flush() by clearing the batch cpumask
In-Reply-To: <a21e4253-9ef6-4c44-917c-02742440d192@sifive.com>
CC: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, jszhang@kernel.org, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-e8dda78d-2d87-403f-a969-2b5ec99da094@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 07 Feb 2024 11:23:55 PST (-0800), samuel.holland@sifive.com wrote:
> Hi Alex,
>
> On 2024-01-30 5:55 AM, Alexandre Ghiti wrote:
>> We must clear the cpumask once we have flushed the batch, otherwise cpus
>> get accumulated and we end sending IPIs to more cpus than needed.
>>
>> Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>  arch/riscv/mm/tlbflush.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 99c3e037f127..c8efc3f87a0f 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -240,4 +240,5 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>>  {
>>  	__flush_tlb_range(NULL, &batch->cpumask,
>>  			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>> +	cpumask_clear(&batch->cpumask);
>>  }
>
> This patch doesn't apply to fixes -- it looks like it was based on "riscv: Call
> secondary mmu notifier when flushing the tlb"[1], which has not been merged and
> would go in for-next anyway. Otherwise:
>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
>
> [1]: https://lore.kernel.org/all/20240124080325.2324462-1-alexghiti@rivosinc.com/

Ya and for some reason it trips up "patch -p1", which applies it to some 
other function.  I just merged it manually a few minutes ago and it's in 
the tester...

