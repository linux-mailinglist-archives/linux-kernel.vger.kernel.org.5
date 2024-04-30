Return-Path: <linux-kernel+bounces-164288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1CC8B7BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE444288481
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307E17554A;
	Tue, 30 Apr 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rY4nvTaq"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8877172BDA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491341; cv=none; b=gmf7PfTN72DvevSliB+0jeSKG3c/EBhRjCzsjudtgHl8dGM7RbHLwioW+ODxy8ZTbrtY5WUn4mmH6JBP6tq61n4lYZWHbr9SbIVyMXeMlETVeBMpMAK08UlVEqZZyu0ynvXuIQOFyNGE961zT4zBZVyXkIZkPbkC8CgO9m3o2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491341; c=relaxed/simple;
	bh=3BFwiOHCYaU38l0ewgMfQbgWxwkzbz05CkINxTEtWKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnddRGlZkOVizLPY/9yR7twWGDkrdgUV+LTqr4SeBfb3Xh6gjufcYWckG05TIrBAJBeFnCsdCe2WrsN5/3DaH3KWn4/Po1CNHpLztciFx0PtVDjvtEo/Q7+t3llN9u25RBC/yW5qju6uOH8zPOWKwxeHwsdkw+U+Ky9llmRTmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rY4nvTaq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34a42d6e216so1300119f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714491338; x=1715096138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKIJbDUVjXcCbxtnsr2n+MGPFjkYZK2XnzHwiA9YwSY=;
        b=rY4nvTaqH8hzNVdqnIW6pdl9Eo2IqzLwDKpzAbvIDGdL+VmnAslLu8zKAfFkvCMDIF
         e7+Ki7rqESmZK0w8iP39mlpqZSDY+lLxfhZGEwZz7t5YU5Fvm7lMDRH3edSL/574CoKt
         zPwm4HU1YUitjsmjsbW5PYmq8QkeNxhJq145vQoMdBNmrNTkTJqB3mS3NNDAwkYBQ1DS
         tdn4FAL+CblIKsJtUleoeqWE4milxk2EHWtKoicfWm9CV5nb33NKL/H7TNK+NFFicRLz
         jhHSErE2lYfgNVp7NWZLHG3tfUV1PrNQylDPcXuNvbNF95n++z5kCb3y0ESk7U/DC8Yd
         tI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714491338; x=1715096138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKIJbDUVjXcCbxtnsr2n+MGPFjkYZK2XnzHwiA9YwSY=;
        b=Jk3rh2HYJ5S7JLhuzIaiSGKwMjXqbUz8ZioeveiV4lS3LZWJ6c9b9/irrR40s0iIkw
         Ba1REzVzgbN//LHcx9+6UQHGqOm6FNTi9gtmGyaAt89o/00Ee9O4Sf/WDiu2vRO5TreX
         NlarY6hKPl2Z2LaFdABX41E/OgdEhloP3S0tjnNH2aZGHRcJ0QKs120qguhd2YTJZ/Ci
         qb0e+lJFphTSqXkp+9pzkAHT/UXheOyFM14D6t5NamxGx1axdtX+BpCuNYE+ccXfr3CT
         wrdWLVkrdnlBR49nnAdyPQ8UoKAQsElwiHqZdmYPHOT+VErPqeBcfdzBn24b5aVU1Dg3
         qmXg==
X-Forwarded-Encrypted: i=1; AJvYcCXY/sLRhkZIGEj5uZj3QhSnsv2yTeWKpxxlOahaSn3qzO8EDa4UrbaPZMFsdpCLqnKR68NtZW8qJBzYcEklRFMxDvkWXczwj3Ww6Wpa
X-Gm-Message-State: AOJu0YxbCqP+9XZba8ssHPKAmXuPx7kw7PTQSM3kWMBWAKaFrEke9ZXe
	CJ/uCyuhAsbGlJu6jbsUDJTEiErLb2Dpj4eDAE1mhyn774iDOxCkNn7vbmOOpG4=
X-Google-Smtp-Source: AGHT+IG/6WtaAQPF462A9lDDrfPcBnLbUoVX6HNrNaquPuIq1fx7JA2M96lwMw2ZYh9NFqb4zyLJTg==
X-Received: by 2002:adf:ed4b:0:b0:34d:a29d:a8d5 with SMTP id u11-20020adfed4b000000b0034da29da8d5mr19585wro.4.1714491337672;
        Tue, 30 Apr 2024 08:35:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:c21b:67fd:90ab:9053? ([2a01:e0a:999:a3a0:c21b:67fd:90ab:9053])
        by smtp.gmail.com with ESMTPSA id r30-20020adfb1de000000b00343e392829dsm32637498wra.97.2024.04.30.08.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 08:35:37 -0700 (PDT)
Message-ID: <b4228cda-b072-479d-bce0-3af42ce49811@rivosinc.com>
Date: Tue, 30 Apr 2024 17:35:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] RISC-V: KVM: add support for double trap
 exception
To: Deepak Gupta <debug@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, Ved Shanbhogue <ved@rivosinc.com>
References: <20240418142701.1493091-1-cleger@rivosinc.com>
 <20240418142701.1493091-8-cleger@rivosinc.com>
 <ZixV3lCe3jYQN3Qx@debug.ba.rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZixV3lCe3jYQN3Qx@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/04/2024 03:33, Deepak Gupta wrote:
>> /**
>>  * kvm_riscv_vcpu_trap_redirect -- Redirect trap to Guest
>>  *
>>  * @vcpu: The VCPU pointer
>>  * @trap: Trap details
>>  */
>> -void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
>> -                  struct kvm_cpu_trap *trap)
>> +int kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
>> +                 struct kvm_cpu_trap *trap)
>> {
>>     unsigned long vsstatus = csr_read(CSR_VSSTATUS);
>>
>> +    if (riscv_isa_extension_available(vcpu->arch.isa, SSDBLTRP)) {
>> +        if (vsstatus & SR_SDT)
>> +            return kvm_riscv_double_trap(vcpu, trap);
>> +
>> +        /* Set Double Trap bit to enable double trap detection */
>> +        vsstatus |= SR_SDT;
> 
> I didn't get it.
> Why do this without checking if current config allows us to do so ?
> I am imagining we do this only when henvcfg for current vcpu says that
> DTE=1
> for this this guest, right?

We actually do not really care since if not enabled, this bit will be
masked by the hardware when writing it to the CSR. I could indeed add a
check for that but in the end, it will yield the same result. In that
case, just ORing it with the value seems more efficient than adding an
"if" to check if the extension and DTE is enabled.

Clément


