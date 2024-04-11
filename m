Return-Path: <linux-kernel+bounces-139612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29258A0554
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327AE287FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790560EC4;
	Thu, 11 Apr 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XPbVJIBA"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A46FD9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797868; cv=none; b=lOCMQPuDDv8RiO1uwgkS2AKb0L54ZlK79i4GwKS4OI3Q2sw52R/oDIZS2AJtkLsQ9/elUP00P32n6bnini9l/kyVUSLf8TcLbJtkyi3FDTHoEFfNaJM/Dxjxet6WEcY3jTGkom91sHZcMcnqPbX0KdpnIk0aq1baREOZbCDCl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797868; c=relaxed/simple;
	bh=9YyH9BgEo3s56+nSbcPZpFNHGs99BC+E0EcZLKOsSQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfizrOctEZ0w3lauxFua1CRWOmIVYpJ5b8tzQbPo+7MtL93LTyij1ty2GRiFRXngWHhGQO/oA9vOBoP5JTfPrMG28Hma0h2oZf66L3ULZ5jGdg48P8uTkQb2MIzllr1ALpP6t4nfHC5TQgDGIQ1HWkRnrFoWnuynEslXF+oyvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XPbVJIBA; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa27dba8a1so2546662eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712797866; x=1713402666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7z1/Srv4eZ2vooDSDvwwBej5oDKDz5itKY0SDj8VoQ=;
        b=XPbVJIBA5sKDJg5tWzuNq6eZ8A32Qn9WAAu5sC8HAvddiaj0Gjjrj1CWwPyBlUsalv
         WG0BrPJiDk2YzjvMDDsesu/1yKqg6dwghb+i4Yl6wgvOBndvZP2R0DsPx+oGXdyh0NjZ
         EDIrEWHhJRYI9lafNcbMvdPXhuS7gRxg5XWC4YF3T27jH08fCxqH+ZllmZ9fiYm2/h3e
         NDsgQiMAIFKQF+WVNT4Wo+ZPBmAkoi6DifFrhaI40WPnXXJLehz6mbU+BUc95rW5ZwGq
         a8e+R+CZzHQIkYIwhZf5iw/bXtrTF3wAZQtDqCyWoHYtAKaP8LCvYgT0qKp9NfUkfJIu
         W+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712797866; x=1713402666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7z1/Srv4eZ2vooDSDvwwBej5oDKDz5itKY0SDj8VoQ=;
        b=oixfyIUaOw/i7GTX8fFVfDIGnL63FVidyvB7Z/WPjiQ79f1qBhZX2GGd3hwYSfYnTp
         aFDZ3XRg0FIEtJzGPoKw4tHOXFrTmerm7D1zsXc3zD+tVZLmOhDOPAPhYwDcfVBm1JP1
         l05EvblErVdwP0xZIXhO4JBjMU64rRn2i5DURMb6kTxChpPqlKcHhFdCZ407m4hsK0qR
         zk99RFMo/h8rICySkaUGdvR07BKJ0JRC/bL+kLGCBe4DNuZJkIbTSOXjCmsOG9N1gop5
         mkMgNwE8v04Gge9pWWY/nvcMi7MXKB7DGzWASFgv8OYVNFxQAf+80u+FXWQtl8HbzG+a
         NiRA==
X-Forwarded-Encrypted: i=1; AJvYcCVT+Ibj+wu6BqrLscYxXoHapIH8lP9ap+IyA1CZD5NkZR0N/1L8o9kXpl0wTcM8726vgroXHbd2mdhxiLw58E8VJHeGq7P8JprWCrTA
X-Gm-Message-State: AOJu0Yz3pWZZW1TH7gjPwIv9enpyGfulyoEelQL5K9yM69B9xtU2Vkfh
	d7fyuttaiWHYkoxdJSBiXX6YePwTcadtZQw4gMEPXajoEtBfO6kWR1E+DtmzrPA=
X-Google-Smtp-Source: AGHT+IFvdAWGolMk2tEZ8bM2BAlC1TsYZtb/fNUYXyTQY+hWEfuiEC430lr0paNhGs3so4u/3MehIA==
X-Received: by 2002:a4a:e9f3:0:b0:5aa:6a28:27ea with SMTP id w19-20020a4ae9f3000000b005aa6a2827eamr3725829ooc.6.1712797866523;
        Wed, 10 Apr 2024 18:11:06 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.167])
        by smtp.gmail.com with ESMTPSA id db1-20020a056820270100b005a4bc907f0asm113158oob.15.2024.04.10.18.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 18:11:06 -0700 (PDT)
Message-ID: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
Date: Wed, 10 Apr 2024 20:11:04 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org> <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
 <87wmp4ogoe.fsf@linaro.org>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87wmp4ogoe.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thiago,

On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
> Samuel Holland <samuel.holland@sifive.com> writes:
>> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>>
>>> Unfortunately this patch causes build failures on arm with allyesconfig
>>> and allmodconfig. Tested with next-20240410.
> 
> <snip>
> 
>> In both cases, the issue is that the toolchain requires runtime support to
>> convert between `unsigned long long` and `double`, even when hardware FP is
>> enabled. There was some past discussion about GCC inlining some of these
>> conversions[1], but that did not get implemented.
> 
> Thank you for the explanation and the bugzilla reference. I added a
> comment there mentioning that the problem came up again with this patch
> series.
> 
>> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
>> 32-bit arm until we can provide these runtime library functions.
> 
> Does this mean that patch 2 in this series:
> 
> [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
> 
> will be dropped?

No, because later patches in the series (3, 6) depend on the definition of
CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
find a GPL-2 compatible implementation of the runtime library functions.

Regards,
Samuel


