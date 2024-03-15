Return-Path: <linux-kernel+bounces-104701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989D87D28C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC721F257DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AE4D9F5;
	Fri, 15 Mar 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mCex2oa9"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BE74CE09
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522825; cv=none; b=DN5xyqvV4nDFGqS22QfWO18v5VFKi7Mrnz85zEkru4Rd7r+KMCF5cbxWlBtOOYMawnQ+eNLesocay7cm9USNPMoq3HmQxn8WBGJGw6n/TvMyeO4JftfK8vr6hcwUDMLPCmi4F0S/dozLxDd2F3mAQuVKKf66LPO+yZ+uK2p76pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522825; c=relaxed/simple;
	bh=aZ8rwMULBoPPaxzJOHFAyuKbYEBSOxO6PUvmQlIALBc=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=ptq88Hyk3e1RpEBE3R2lK47K2Jd8TCmGJvF4rHZR6YKqBmalYrGuFYa+MfQuIex38ijAN1cP9nE9MbyvU4b8pHiOa8xLma/vxXutreBloKIpKuDAwFX+QL+OLl6JCAKalI2EPUJHd1Fk1XtoM39kjIj0Fvs01mWc8PJEWJ0hl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=mCex2oa9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6c8823519so2298028b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1710522823; x=1711127623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zc35f3DVjPDaoxA34gP7gqIyNIz6eucHoZmbR7gwzIU=;
        b=mCex2oa9W3SLLDrKtp/KppOsHVnMH7COXB4GYl488LPTo5ysSTmAryhCU2UxG1phPe
         9LFZa2MaJvgg8lAO7pIFp3GM3VU77WyBXCHGfRzafmIUHE+DyQubNkWxdwQq+TTydakn
         AezJPE6SWXfyTy93tv4z+pqcFGuLLGlwMfQ/YIR8/Rd2qL6gfiCtyUMwtNYRNCfeczYv
         rzGD0TrlCqRolU7Vl/K0EeRvUM69H1Id8YAQOp6yM0LOwcRfi3egO6o3lu4F86oWShP9
         7GDsvGy/QM+Ya6Vj5KZOYmZglcqBoonI1kTpjH1+oeHMZWh1fAQElFhR02j3B3Bs+qxw
         +SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522823; x=1711127623;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc35f3DVjPDaoxA34gP7gqIyNIz6eucHoZmbR7gwzIU=;
        b=dxlVma9EK7B2wf/uX9RIfW+LGF//jx2uMahcLHGud5VMqSMiJGy/XwKAiG6xgb61IA
         85WO8yPDgLvkIwoLKGPF03OZ1/fle7J9WkfwPh2g7Dw8rEeSRlgQ6T515y4UZAMOkxFx
         RkaWE8Ui5MeSkI4FhRyPHNH72kFz+oRYmCgmzRD+Kq1TKjghts/esf7j2XTzntplLK1M
         G+ZSse78mpmJjzV5Z/oV/Wk14MxInL9bXVPSzLhn2v/ZmPInYXZV5SApRLnU9qregI6v
         LFSy2MjzzChsU7vRKyKVmDtyWv/zTbhxu5BEKgA4N+Q4HctMQW5isu0p/pQJkop1IV5F
         nwGg==
X-Forwarded-Encrypted: i=1; AJvYcCUcPy9XjIqJhj/tpbMCo6ehO/nQrf8gY6G/gjSk0ZDZqZZJVuvlKyf64tG6Z63bUo0bbS8P9hEmAzVg6jq3qR2dbpBxKOHgWGJyJF0u
X-Gm-Message-State: AOJu0YxOjK0YFBfJpQgOKFbwW+urDUXxSEzh2atSA6p0ttEaT9PYbS0S
	zOg4VpHsPYhwgyA5Y2EpkQHbyZQ5Sq/PIVhMJO0l+WOc85D1efi1d8kIArxSYoY=
X-Google-Smtp-Source: AGHT+IHPwRwCrXAn3nRslKddvfiuhhbKJi8Iu271fDD/QcfPvpbSTe0krho6bBCJ9L1Q6iqwxpTGrQ==
X-Received: by 2002:a05:6a20:12c2:b0:1a3:50fb:4f7c with SMTP id v2-20020a056a2012c200b001a350fb4f7cmr1930770pzg.29.1710522822795;
        Fri, 15 Mar 2024 10:13:42 -0700 (PDT)
Received: from localhost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id r12-20020a62e40c000000b006e6fc52ecd0sm1361552pfh.123.2024.03.15.10.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:13:42 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:13:42 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Mar 2024 10:13:31 PDT (-0700)
Subject:     Re: [PATCH] riscv: Fix compilation error with FAST_GUP and rv32
In-Reply-To: <b7f3fb0c-6c26-42c7-858c-231f4982a761@infradead.org>
CC: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: rdunlap@infradead.org
Message-ID: <mhng-25af42ad-53f6-4f13-9613-8e1d463df758@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 04 Mar 2024 08:47:43 PST (-0800), rdunlap@infradead.org wrote:
>
>
> On 3/4/24 00:02, Alexandre Ghiti wrote:
>> By surrounding the definition of pte_leaf_size() with a ifdef napot as
>> it should have been.
>>
>> Fixes: e0fe5ab4192c ("riscv: Fix pte_leaf_size() for NAPOT")
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Sorry for being slow here, I just realized this was a result of a 
fixes/for-next semantic conflict.  So I've merged this (on top of the 
broken series) into for-next, but I'm going to hold off on sending 
Linus a PR in order to let it get through the testers.

> Thanks.
>
>> ---
>>  arch/riscv/include/asm/pgtable.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 25ca14f6942c..54d26a07fa63 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -439,9 +439,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
>>  	return pte;
>>  }
>>
>> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
>>  #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
>>  					napot_cont_size(napot_cont_order(pte)) :\
>>  					PAGE_SIZE)
>> +#endif
>>
>>  #ifdef CONFIG_NUMA_BALANCING
>>  /*

