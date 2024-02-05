Return-Path: <linux-kernel+bounces-51980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D77E849245
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4BEB220CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18888F44;
	Mon,  5 Feb 2024 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DF8fvztd"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3F79D8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707098752; cv=none; b=mju1mQQ8uhWC++fQZUCdbF90N1RcKWtsZ9739s8h+KYWzdsK+9miKgbAe6H990xluNTriFcvOMPQ1nz0nSqhSEORDca6gKMcTFjfK9PSDUsm9J+814rDrf7lKp3o60qyXGB5x0BDndzOS0jXHPq9WLwuv+rxOfgX2+0p483azIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707098752; c=relaxed/simple;
	bh=5XwGgmp3BPmDJ0fpZR5jpmy1vISiDiiwafuKouHj0Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxyQxnydvBewUBONIvN9CNZQiWTyW/1eWv3wpMWFasU7BiCArPBLXHunChzuhE1IbnmqdX1Mm5JWzhxjrSFJv+FyXBmBLNGlPn0g0SROBSZNfCODrFEWKoAfDWvbgsBEI939ka/1OQCF2bkMahX3DTANXPAJYwf994U8I/XnLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DF8fvztd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dc13b142ffso418859a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 18:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1707098749; x=1707703549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+8ijc4eH6dLtZNsmA9IMPtPI2LG666HTBs74Wzg/oA=;
        b=DF8fvztduKDHbwxVElTu+5bf3wh7r1kQ5rK5yvVhkjhMU66RwVhkIHLzFrz0fhnzdz
         UfAVI/q/J46tRSUr4g3A0roLFeP7ozbj3wdOBN1ZCVyGjp6b1+YsbOzmYbFTtU0eaVVC
         BNCpPyu7mEVdnJlNIgJSPgtNJOMKaHdRzTYMnw02h1lzBs25pg45+Dy7+Ak2fAHz7iu7
         QkkMZX2f4I+5Gy2T4rsDI2RBe2ZmtRUrrTZzQW/T5v9iRWZOJhiU7JL8DG5ceOH0Mj3q
         7LSvO8hoPR2Aybjhfsy9WcIPO0+O2emlpAyNIZgD0pF0ZQu7qu2RQeOOldoWkVt7cfqq
         +lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707098749; x=1707703549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+8ijc4eH6dLtZNsmA9IMPtPI2LG666HTBs74Wzg/oA=;
        b=DfKoqjbET6K8IXXAxnt9e5Cxc/GbR88rN1XoHdNlT2eCS+oeJJDkZNd/G5oLAZLtw+
         Dk9dh7YYb5xvpOIXpgP1hA8q/4gc5A5m7zd1TcKTDZOygp7PKzxLurRXEckufQZs49Xz
         Ap82oUdsMJu1DQhbsg1+CKXE9t4iaVrPKdrQ8K+uF6TmP1InqTR9OqmP0yhReeNNLJ2F
         NHYYOln6nasz7PseTAwGwZUB/YB1Zex0+v1P0kfA73En0yKYFa7VTj+Ts4lqXK3nD82g
         7x5k/0LATUwFItZnkPEkj/OB/orNTX+rU1VdUKaVJsh/xuhrSbrU+ukt78y9waqZGkJm
         ibhQ==
X-Gm-Message-State: AOJu0YzCOkQs7rK84CJeBSO+GHvgXePKyRlm9wwUb/XfTemvPqmHbtKB
	uRXcycXCMM5REQdaVV8+JfbdZeDhsQG2p/OrlVefhtxBNYEnfL+bn/QnTKRivJc=
X-Google-Smtp-Source: AGHT+IEzhehZjKAhlUs4m4DTV3eBklOKslGHGUkgNKCFL9+Cs4meD2BIvUUhLUS4TWm4vHr3yHWktg==
X-Received: by 2002:a05:6a20:1441:b0:19e:317c:b353 with SMTP id a1-20020a056a20144100b0019e317cb353mr15150270pzi.2.1707098749629;
        Sun, 04 Feb 2024 18:05:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVspSycYoIEXn4EgPZz7USoAoUFNLMU/8YDPVu6q/bF+OElJehghZkpfpgkoSsXTccwcG7aH9mG22TmU81aGJgC1CzbACMVutQROUUnzkgl+HummRTkXxn+DImzjz4YgmIJM6sT2hOuMKBNi9AxnraUSFPW4Gih3sg2+BZcDSHDqEEsrnbGVk/6EwO+So0Z9RpIi8o2ugDeLG/Kqum/1eTpZ+GYE6W1eRXia+S2qz9JZGCUsJ0=
Received: from [10.255.134.6] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id mn16-20020a17090b189000b0029696f7f443sm966122pjb.50.2024.02.04.18.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 18:05:49 -0800 (PST)
Message-ID: <7fad74d9-134e-4606-abf7-3969ca01acef@bytedance.com>
Date: Mon, 5 Feb 2024 10:05:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
 david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <Zb_cmZByel4cULDP@casper.infradead.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Zb_cmZByel4cULDP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matthew,

On 2024/2/5 02:51, Matthew Wilcox wrote:
> On Thu, Feb 01, 2024 at 04:05:40PM +0800, Qi Zheng wrote:
>> For kernel PTE page, we do not need to allocate and initialize its split
>> ptlock, but as a page table page, it's still necessary to add PG_table
>> flag and NR_PAGETABLE statistics for it.
> 
> No, this is wrong.
> 
> We do not account _kernel_ page tables to the _user_.  Just because
> the kernel, say, called vmalloc() doesn't mean we should charge the
> task for it.  Moreover, one task may call vmalloc() and a different task
> would then call vfree().
> 

Got it. Thanks for providing this information!

> This is a can of worms you don't want to open.  Why did you want to do
> this?

Ah, just because generic {pmd|pud}_alloc_one() has opened it. ;) And
When I looked through the commits (e.g. commit 1d40a5ea01d5), I couldn't
find the information you provided above. And that is why I CC'd you to
double check this, in case I might have overlooked some important
background information.

So we should actually fix generic {pmd|pud}_alloc_one() (and maybe some
implementation in the arch), right? And it would be better to add some
comments to clarify.

Thanks.

