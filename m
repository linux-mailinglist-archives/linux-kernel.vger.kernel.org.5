Return-Path: <linux-kernel+bounces-121415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512688E7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2521B1F2F7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C21369B9;
	Wed, 27 Mar 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="LTb6BA2Z"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02599135A50
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549266; cv=none; b=bRlnML1Lhp3RQFJacg+nyICJrYuHo+8tdwwGZUPpFOa+GLp/0gJPvy1aTgpFmDhIPGUf48OODmV8NKlegDLTb3HF7fJOihEUyIw0ROszUnFLY83sMb1zfY0SDhFfaOMs1IH+bPHXz0HgputaTtp88B76E/iXbcpx4z+jH/k65sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549266; c=relaxed/simple;
	bh=avwi6p1nMqz6vUlRbJ6D8sCm976YDo+h6wiNCfOlhEE=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=r6pBeUTc+k9x0SBbjuXBMqAv+VL+JLY4wcm/IRNlg5Haos8pzVcif9ovtKNGjAqd25SsC6L08ZY5BJTkdiLdi5JRRGJwX6yK2fjqosS3KGt53Hiy//4SPTiz6dAqtliOIyY0zjSmbx5emPRVZqn5grT5aUuYb8egmbPHleagrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=LTb6BA2Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1def89f0cfdso7677865ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1711549263; x=1712154063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9OkgKPAxyfJOPfckAh4fQ9ROWymFhlRPpwnWkiLvmDg=;
        b=LTb6BA2ZxmLkJef8NVM3IWikH5pcVVeZ8nhh68Dyg/whdz9JUFqjeOkKXyvnHHgx5E
         PlHwz2/hEDdOWwEFkbjw5x85F+hDXG8xA/Xwud5XzfUxm8tIJ1JlnxYCe69eiEUUUc9U
         17bnqD4Pu2OiurmCYkuVU3j4ox2r59fiFm2KkBKCMH4jsmgRzJ8g5bYv4sKQVTMtJH4c
         +xqpO50mbelPXoAN08RjuYxkQuqI/dwdXFhSpK7twfi1zRqNV8GX/os9kVpW57PE7A4S
         OvZt1q42ZGw60RkXXPIEUJ8A4AWSoxQNTwSvLLu3sT7MpvPahPx/rOgQwGsICXOs6NzP
         /lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549263; x=1712154063;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OkgKPAxyfJOPfckAh4fQ9ROWymFhlRPpwnWkiLvmDg=;
        b=ECcatgjz5Ao/kkzCG72tgbeqNARljX6YoSr6e2CVjhKuQzy8vag4QTYUoEqSfwJUPR
         kMzvYqwE43yaOeX6lTd/wXIpH5phbA8HORyafSCZq841YCLGX8hCCnCtI3RZZorC0D2j
         oH23LhoXAXAgfApdoY6ncB5ioF6b3v9MWGg5TAUtiPvTOIy7k/Mx636HF6LciC6ux7aP
         mJCZpa65gxFG9lbjrLFh6YUGMdxYfzdzKARL2sbA+auVkihIVxRgbWPcqTZtM9Qz+D8S
         oYDcRfU/bc5LbfnN86FUVGOwAPJPnWtDdp2tM6y0+yR1oA1zPJOUQE3321Ty1+pWxb4b
         uJEA==
X-Forwarded-Encrypted: i=1; AJvYcCUT6mc2ZE0zPnRAtQzsOkBXpgX9QdcCx0Kvf1Yse7xUuTZGbwh9oQWxZMsTmq8Igq6oRgrI1yeJLjZ9AHHct31PmleGsuV8Oq0LiVKC
X-Gm-Message-State: AOJu0Yy5wG2Lda2E1Dl3AsmP58JXPL+p3SUoVsItKIbrQfJgnwWDlSA4
	QKgxrIc2YAeBNQZy8HeStH+K0EQYIqpYMvkM1KXaJqgZ8jYWlH83fJVKF2pQFddsd50k01BvI0o
	U
X-Google-Smtp-Source: AGHT+IGj0H8wddyVpJYathwsKQ01aXo/mhOioGyXZjPvlpsI1o++lQ02DxLCeo2ElOxEmY/tL8qzyg==
X-Received: by 2002:a17:902:db08:b0:1e0:b677:293b with SMTP id m8-20020a170902db0800b001e0b677293bmr7337175plx.29.1711549262937;
        Wed, 27 Mar 2024 07:21:02 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id i10-20020a1709026aca00b001e03b2f7ab1sm4715467plt.92.2024.03.27.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:21:02 -0700 (PDT)
Date: Wed, 27 Mar 2024 07:21:02 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Mar 2024 07:21:00 PDT (-0700)
Subject:     Re: [PATCH] riscv: lib: Implement optimized memchr function
In-Reply-To: <8002710f-66f4-32aa-df45-fb8901773a26@codethink.co.uk>
CC: ajones@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>,
  Bjorn Topel <bjorn@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ivan.orlov@codethink.co.uk
Message-ID: <mhng-36b05ed9-dd1c-45ad-aeec-921b30a75f7a@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 11 Dec 2023 07:25:15 PST (-0800), ivan.orlov@codethink.co.uk wrote:
> On 11/12/2023 15:08, Andrew Jones wrote:
>>> As you can see, the new function shows much better results even for
>>> the small arrays of 256 elements, therefore I believe it could be a
>>> useful addition to the existing riscv-specific string functions.
>>
>> Looks good, but do we want to maintain both this version and a zbb
>> version? I'd expect a zbb version to be even better.
>>
>
> Hi Andrew,
>
> Yes, ZBB analog would be much better, and if we use ZBB operations we
> could avoid the most part of bit magic happening there.
>
>>> +	add t1, x0, a2
>>
>> move t1, a2
>>
>> and for the remainder of the function s/x0/zero/
>>
>
> Alright, will be fixed in the next version.
>>> +	sltiu t2, a2, MIN_BORDER
>>> +	bnez t2, 6f
>>> +
>>> +	// get the number of bytes we should iterate before alignment
>>
>> I'm not sure, but I think even in assembly we prefer the /* */ comment
>> format.
>>
>>> +	andi t0, a0, SZREG - 1
>>> +	beqz t0, 4f
>>> +
>>> +	# get the SZREG - t0
>>
>> I'm 99% sure we don't want to use the # comment syntax.
>>
>>> +	xor t0, t0, SZREG - 1
>>
>> xori?
>>
>
> Hmm, I'm surprised that it is actually compilable... Yeah, should be fixed
>>> +	addi t0, t0, 1
>>> +
>>> +	sub a2, a2, t0
>>
>> nit: Looks a bit odd to put a blank line above the sub line above,
>> instead of above the below comment.
>>
>>> +	// iterate before alignment
>>> +1:
>>> +	beq t0, x0, 4f
>>> +	lbu t2, 0(a0)
>>> +	beq t2, a1, 3f
>>> +	addi t0, t0, -1
>>
>> This addi t0... isn't necessary if we do
>>
>
> Yeah, sounds reasonable, we can make it faster
>> 	add t0, a0, t0
>> 1:
>> 	beq a0, t0, 4f
>> 	...
>> 	...
>> 	addi a0, a0, 1
>> 	j 1b
>>
>>> +	addi a0, a0, 1
>>> +	j 1b
>>> +
>>> +2:
>>> +	// found a word. Iterate it until we find the target byte
>>> +	li t1, SZREG
>>> +	j 6f
>>
>> These instructions seem oddly placed among the rest.
>>
>>> +3:
>>> +	ret
>>
>> And this is an odd place to put this ret (after unconditional jump and
>> in the middle of the function). We can just put a label at the bottom ret.
>>
>
> I agree, thanks!
>>> +
>>> +4:
>>> +	// get the count remainder
>>> +	andi t1, a2, SZREG - 1
>>> +
>>> +	// align the count
>>> +	sub a2, a2, t1
>>> +
>>> +	// if we have no words to iterate, iterate the remainder
>>> +	beqz a2, 6f
>>> +
>>> +	// from 0xBA we will get 0xBABABABABABABABA
>>> +	li t3, REP_01
>>> +	mul t3, t3, a1
>>
>> I don't think we want to implement an optimized assembly function with
>> mul. We can just use a few shifts and ors.
>>
>> 	slli	t3, a1, 8
>> 	or	t3, t3, a1
>> 	slli	t4, t3, 16
>> 	or	t3, t4, t3
>> #if __riscv_xlen == 64
>> 	slli	t4, t3, 32
>> 	or	t3, t4, t3
>> #endif
>>
>
> Nice point, thanks! Will be optimized :)
>>> +
>>> +	add a2, a2, a0
>>> +
>>> +	li t4, REP_01
>>> +	li t5, REP_80
>>> +
>>> +5:
>>> +	REG_L t2, 0(a0)
>>> +
>>> +	// after this xor we will get one zero byte in the word if it contains the target byte
>>> +	xor t2, t2, t3
>>> +
>>> +	// word v contains the target byte if (v - 0x01010101) & (~v) & 0x80808080 is positive
>>
>> s/is positive/is not zero/
>>
>>> +	sub t0, t2, t4
>>> +
>>> +	not t2, t2
>>> +
>>> +	and t0, t0, t2
>>> +	and t0, t0, t5
>>> +
>>> +	bnez t0, 2b
>>> +	addi a0, a0, SZREG
>>> +	bne a0, a2, 5b
>>> +
>>> +6:
>>> +	// iterate the remainder
>>> +	beq t1, x0, 7f
>>> +	lbu t4, 0(a0)
>>> +	beq t4, a1, 3b
>>> +	addi a0, a0, 1
>>> +	addi t1, t1, -1
>>
>> Same comment as above about being able to drop the addi t1...
>>
>>> +	j 6b
>>> +
>>> +7:
>>> +	addi a0, x0, 0
>>
>> li a0, 0
>>
>>> +	ret
>>> +SYM_FUNC_END(memchr)
>>> +SYM_FUNC_ALIAS(__pi_memchr, memchr)
>>> --
>>> 2.34.1
>>>
>>
>> Thanks,
>> drew
>>
>
> Thanks a lot for the review!

Do you have a v2?  Sorry if I lost it.

