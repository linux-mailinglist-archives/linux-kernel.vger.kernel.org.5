Return-Path: <linux-kernel+bounces-62907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E012C8527BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED821F24118
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFC8F77;
	Tue, 13 Feb 2024 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MYxAUPHN"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855108C17
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794725; cv=none; b=T7UjRz9EKpesOeeolZyzGgy7PJJBxzhBioK3nG3bKLDXSyzL+fsbjNDE3nfPj+f/1PAMd1kd/KfgAddC7szNVBaDdXJOWVT+BPoxTXq4Z7B+pTclwZSYsel9BSCbWcWVnE6dmoG3ldUU0qWPbZq2zsNVQ73heEd2UXKIL3/lN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794725; c=relaxed/simple;
	bh=6CxxssLo05mXziTeSFtD+zska6iXGLCRihBC/F1iGPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkocvOfpJGPiv5deGfWQjC22G3B+AqZT9Dr1ElB/s5eKCDL3F9qjncLRVqx2n1h2m5ronA4+jBK8uKp43Nxb8ckimLOvyMpDpaS3YYQvUc4Njf5L5nlduc7Q1zHrMa5Eg5HUaaNY9VvlOonvYbMaNPFE3BzXs4olS/UhN81bSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MYxAUPHN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42c6b6ec76eso24177911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707794722; x=1708399522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=if1pmLTRVcuqiS5WFrEFaB+wVVF4073IHWC80dtkSxU=;
        b=MYxAUPHNCSFWCPevfH7tNoy8KKGnf4O6Ql5J5/rhT9rkcIJjKtG5KFTOB5uOhWNf3y
         lG0HUmCSNoHZ6cfgTEZPFUZ+YDoxhJtt1WmHc7fowFBXWs0y9qeKCoFBAkXPrI6kQuCH
         BuKdrxrwXWYdwJlcxKxz8HxyUoTzrTq9Cj2sA8CVTvpbne2KNRtkCvQ6uaEJ4Ofrzfmk
         qO5y8jSFcc9d/sqXnY9gP9Yh0F4kEbmxBaJHRXHpLattywY2+O48AAJk1G/H1FGIiGka
         qfnd0XGVN3Q/40D//i7ggES2pQoDH5rBsH/7rENScoF15f3kIv+OAuzAcJwZ3zz/NFe4
         0FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707794722; x=1708399522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=if1pmLTRVcuqiS5WFrEFaB+wVVF4073IHWC80dtkSxU=;
        b=TIEmfUdXaVJH9ukPzoBawyFmC4EQRJ2M0M/6OU+nMk0kvLGoLkOAtKrw48XOGMgyqJ
         SQY0E14IsoPeKWUUWjiyIB1eUCNBSg1p7YpD5Hz562wjurfluJbEklSz1dpTwKp/vtrI
         tQLG9C2fRWmJYziWMGwxtzJP9xOuzs6snDVHLr1t+FTfVhqWXXPWWxmddbtPwGmqTZPP
         zEw5NdqU7Z/0Qlb+U6ZtD8Yr7l4fDxUttSOjoI269WLuE0BhSfhcio6zIWYnXhd7z7df
         3K5gdg+Dq4UhUQBop2qkqf22qij7Gb94T03be2fUk3D2LLA+2TQ756fBTzC+6ppqIbw9
         kokw==
X-Forwarded-Encrypted: i=1; AJvYcCViIQXVVBlf8iYJr/ipMlYsdP+296CPzmxqK3zBu7SSqcZT5mhYdWW34162JoXBPzCMGCSwlZJcrzWjd66RY3/eB1UtKk2/QeLspAnj
X-Gm-Message-State: AOJu0YzTPlhn2g2w/Lp+If3EF0I5LF/NhnNvJ2SvQ2KR3L46eVIzbIiS
	ZePI7ebsl3Cs9Jr0Lkhst+/3cp0wCEBr+pMxJddi+Ky/x35NELRCJ4FFyZEL+DI=
X-Google-Smtp-Source: AGHT+IE75L1rBHzIjR4WwTBVySu0DX1wyH/fN/xoGrEKXFF0KM/tu6CQv7/Kk/HiIQ0UN/hmyZvvFg==
X-Received: by 2002:ac8:5f53:0:b0:42c:3c54:6f20 with SMTP id y19-20020ac85f53000000b0042c3c546f20mr13275386qta.10.1707794722333;
        Mon, 12 Feb 2024 19:25:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBGqZV4wDvnXDxxc2cMc1N1ZZswMYG/Wbwxt7v1ZN/KLBlfkAF7pU/O5lCiyWAeGtDH1OAtyC2ZhnHUPSq62pEkGZGzXRVK8oa8SzX/sv7Bj4xKlTEXbsia2AYBrvzdPtgWXFDmygyqzZPDcQ6IgeG+8Yhyv0ICa9nxQbbDmiJ5aV83xX+sKR/ysHCcA==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id p20-20020a05622a00d400b0042c72e4074esm753096qtw.56.2024.02.12.19.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 19:25:21 -0800 (PST)
Message-ID: <ca69d83d-90e9-4401-bac2-1782cd4e2318@sifive.com>
Date: Mon, 12 Feb 2024 21:25:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes 2/2] riscv: Save/restore envcfg CSR during CPU
 suspend
Content-Language: en-US
To: Stefan O'Rear <sorear@fastmail.com>,
 Andrew Jones <ajones@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20240212022642.1968739-1-samuel.holland@sifive.com>
 <20240212022642.1968739-2-samuel.holland@sifive.com>
 <f1d370c1-a7d8-4240-a15a-a55616f5b4a6@app.fastmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <f1d370c1-a7d8-4240-a15a-a55616f5b4a6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stefan,

On 2024-02-12 7:21 AM, Stefan O'Rear wrote:
> On Sun, Feb 11, 2024, at 9:26 PM, Samuel Holland wrote:
>> The value of the [ms]envcfg CSR is lost when entering a nonretentive
>> idle state, so the CSR must be rewritten when resuming the CPU.
>>
>> Because the [ms]envcfg CSR is part of the base RISC-V privileged ISA
>> specification, it cannot be detected from the ISA string. However, most
>> existing hardware is too old to implement this CSR. As a result, it must
>> be probed at runtime.
>>
>> Extend the logic for the Zicsr ISA extension to probe for the presence
>> of specific CSRs. Since the CSR number is encoded as an immediate value
>> within the csrr instruction, a switch case is necessary for any CSR that
>> must be probed this way. Use the exception table to handle the illegal
>> instruction exception raised when the CSR is not implemented.
> 
> We support non-conforming extensions, so we can't assume that if an
> implementation does not provide the Ss1p12 extension which defines senvcfg,
> the corresponding CSR number will not be used for other purposes.

Yes, you're right, I'll do this for v2. Though this does prevent us from
supporting hardware which implements senvcfg but not all of the rest of Ss1p12
(e.g. Ss1p11 + Zicboz).

Regards,
Samuel


