Return-Path: <linux-kernel+bounces-70404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C28C859750
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DE41C20A10
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7726BFB8;
	Sun, 18 Feb 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sd4jpr+H"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009438F98
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708265350; cv=none; b=K20twj/zKvW8BcbllTPWcQ+x84izAYAu0x1/JTpKPAvgXBD21GvMkbFgyO56H/1XWIKx7tdCzoAQHIjuLBTVUq2R8BtdQqi8aqYJW+bATrzjyykcDb37SncuAFvhggzw5chhqC1pbE9hvDizQN1daeV3tGHiTk20bm7HdZnQPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708265350; c=relaxed/simple;
	bh=fhwbM8Vdmum2UVwG45KDhPSYEYQ/y4rFd+Vl6UM9DKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVEOF+oS3y0adDBwEIz9hc0qWTpDTyAq+LwxbDmJWdqjwhDuz6sVMkXJvFbaHFEFDAdw2/e+aXXsgZt9xoNZkb2tfaf5e/7YMmIO5T6DLf3wpYb0kEg+tKPrxQzWOjIn7i6RRi5+OsrujI48U2QC1uMJBo4xiw1Fe5rnPDXb17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Sd4jpr+H; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e0a37751cbso2573747b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 06:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708265348; x=1708870148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRGb3mX7HcgDDvjFe46dagDpGQNmLyrCz8IWS2FWblE=;
        b=Sd4jpr+HIFkY3M6FHj1QYvnLydrtPhrIYDaqpgpkm9IFqIvSsQ2NR2ptnVPNc+pj0S
         zG91Lmv4MNd+4ahX7gOpI/RTYDfVygNoh0Kva1fPPOkBs5meCXzXzK0AlTk43fdHDXHM
         3avb4a0JVYE8tj45YQ1AeZtj84L/gA4pm3YfZ18q8PA5hPdFi4IP3wio/Jet9yh3JE07
         jfbHTiwMrtsV3V6iwC2M8fh7nQw13Pw1BQCump9E+j2qs2Yc1Y49k2R191A5OpVBR1Za
         0jQyTwv9jNu2CcFW58OXOyXndzcs4rm2XSXp7xsF/fbQEbqV3mQeukMq/oysNTq4Dke5
         CpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708265348; x=1708870148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRGb3mX7HcgDDvjFe46dagDpGQNmLyrCz8IWS2FWblE=;
        b=wRlryWpxE9PhcvYTWophzzK39Mpd/Z36At/36tPdlwNPNXs3xK5nin1ryi1CD8o8+b
         w7iILpSwXNl70QKCJfiiPuRkXie/l2bR+F2lQ0I53J/QTxXB4G0sEVO/E5LnqUTuxC0t
         Ey7nYpwF9+1Ob5wvqltP7oo7ClS6RjKPg3N8bEYY100bXVf3iwBJXMZ4lhaRhnGnK51g
         zKK5g2elxACgGV3P+fV39/oT2PK96VEEKVqDt5PgF3rTipHy3okjUtuGvQ8qLiktmcSh
         Z+HYGGuwj6GR3LgbFQGVxXJpklRbkn71cszX2m3mm9be0VJbYSH8qRR1gaPew6tkNAfC
         RiZw==
X-Forwarded-Encrypted: i=1; AJvYcCUqsUe7u2TTUrwQL1BYYno1i5+915EJOOtTnLY+QstdrSa11BcSPayJqA7Npj9/4Wfh6ldv0NHhLmJeEdRjhWN6DlAUk5UkhXsPfa7s
X-Gm-Message-State: AOJu0YydwmlF76QsTye9R4M0/WYyFd4wBwOPZ6c5slSQghduBlKBhmVa
	mGeVFRmJENzsND1FfIS0FmL6msJ/efW1NFEwLz1976B8DVmvd5u2FI2F0MPj9NY=
X-Google-Smtp-Source: AGHT+IGZueP1XhtEkxOygwlGosvd1hAAIICkpyELEX/5HlzrfzCc/ANAAbrp0uNstOSRE3cqH8XXRQ==
X-Received: by 2002:a05:6a20:6f07:b0:19e:5fe5:ff98 with SMTP id gt7-20020a056a206f0700b0019e5fe5ff98mr10072947pzb.52.1708265348435;
        Sun, 18 Feb 2024 06:09:08 -0800 (PST)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id y5-20020a62ce05000000b006e2dde36edesm2783886pfg.120.2024.02.18.06.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 06:09:07 -0800 (PST)
Message-ID: <d947f326-e527-45aa-ae7f-bb5a18efa399@sifive.com>
Date: Sun, 18 Feb 2024 08:09:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes v2 4/4] riscv: Save/restore envcfg CSR during CPU
 suspend
Content-Language: en-US
To: Stefan O'Rear <sorear@fastmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-5-samuel.holland@sifive.com>
 <20240213-86af3b49821630b5bdd76c0a@orel>
 <937f0593-0bc8-4df3-aa0e-9059acfd7636@app.fastmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <937f0593-0bc8-4df3-aa0e-9059acfd7636@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-13 11:53 AM, Stefan O'Rear wrote:
> On Tue, Feb 13, 2024, at 9:49 AM, Andrew Jones wrote:
>> On Mon, Feb 12, 2024 at 07:37:35PM -0800, Samuel Holland wrote:
>>> The value of the [ms]envcfg CSR is lost when entering a nonretentive
>>> idle state, so the CSR must be rewritten when resuming the CPU.
>>>
>>> Cc: <stable@vger.kernel.org> # v6.7+
>>> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>> Changes in v2:
>>>  - Check for privileged ISA v1.12 instead of the specific CSR
>>>  - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s
>>>
>>>  arch/riscv/include/asm/suspend.h | 1 +
>>>  arch/riscv/kernel/suspend.c      | 4 ++++
>>>  2 files changed, 5 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
>>> index 02f87867389a..491296a335d0 100644
>>> --- a/arch/riscv/include/asm/suspend.h
>>> +++ b/arch/riscv/include/asm/suspend.h
>>> @@ -14,6 +14,7 @@ struct suspend_context {
>>>  	struct pt_regs regs;
>>>  	/* Saved and restored by high-level functions */
>>>  	unsigned long scratch;
>>> +	unsigned long envcfg;
>>>  	unsigned long tvec;
>>>  	unsigned long ie;
>>>  #ifdef CONFIG_MMU
>>> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
>>> index 239509367e42..be03615486ed 100644
>>> --- a/arch/riscv/kernel/suspend.c
>>> +++ b/arch/riscv/kernel/suspend.c
>>> @@ -15,6 +15,8 @@
>>>  void suspend_save_csrs(struct suspend_context *context)
>>>  {
>>>  	context->scratch = csr_read(CSR_SCRATCH);
>>> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
>>> +		context->envcfg = csr_read(CSR_ENVCFG);
>>>  	context->tvec = csr_read(CSR_TVEC);
>>>  	context->ie = csr_read(CSR_IE);
>>>  
>>> @@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
>>>  void suspend_restore_csrs(struct suspend_context *context)
>>>  {
>>>  	csr_write(CSR_SCRATCH, context->scratch);
>>> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
>>> +		csr_write(CSR_ENVCFG, context->envcfg);
>>>  	csr_write(CSR_TVEC, context->tvec);
>>>  	csr_write(CSR_IE, context->ie);
>>>  
>>> -- 
>>> 2.43.0
>>>
>>
>> We're still exposing Zicboz to userspace in hwprobe when only
>> RISCV_ISA_EXT_ZICBOZ is present, which will be the case for anything that
>> either doesn't implement 1.12, but does implement Zicboz, or maybe does
>> implement 1.12, but hasn't started putting Ss1p12 in its ISA string yet
>> (e.g. QEMU). We should either stop exposing Zicboz to userspace in those
>> cases (since it won't work) or rethink how we want to determine whether
>> or not we have envcfg CSRs.
> 
> opensbi treats the existence of menvcfg as sufficient evidence to prove that
> the hart supports 1.12.  I wouldn't object to having Zicboz imply Ss1p12/Sm1p12.

Zicboz implies menvcfg, yes, but I don't think menvcfg is sufficient to imply
S[ms]1p12. It's entirely possible for hardware to implement menvcfg but none of
the other S[ms]1p12 features. Or it may attempt to implement S[ms]1p12, but have
some bug that prevents it from being compliant, and therefore prevents declaring
support in the devicetree/ISA string.

What I think might work best is to have a cpufeature flag for "has the envcfg
CSR" that doesn't map to anything in the devicetree/ISA string. Then Zicboz can
imply envcfg, and Ss1p12 can imply envcfg, but we avoid any possible false
implications going the other direction.

Regards,
Samuel


