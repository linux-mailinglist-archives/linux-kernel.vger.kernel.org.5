Return-Path: <linux-kernel+bounces-100847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3C3879E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CF928142B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64397143C7A;
	Tue, 12 Mar 2024 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zffCSK6U"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862D143C6E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280933; cv=none; b=a+pQwNUEDFOfdZ+ZHFSaXAkwpowx5enlibYw+ZL6efy6ktiE7P69GTZmqg4X6N/Kl0vEJjtJ21BxCMJbo5fgiif5+sEUtz2jE4x9VlEO95Clqf1N1PmUQXa2CBICZoPTgw8WC4Ln7MRTXQmHAp88qqNTDQ87XSc/SL1wXj70W9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280933; c=relaxed/simple;
	bh=hpOocF6nkIxTwnygMo+B0FnTx/CKPmw71nxhkKfDxvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lk0mOchItwW6/efO2yLqTtj8vYStocF4PiYwjKec5Y8Fpt3HlXUCSb9NSI4a/XopeG3avAJkhZn+HlWoENjWz+hwC9ct3NZRUtifU3TFzwi3pXrKE5LvOZi7A4aogGAiZgiAR0qpPSxNHzEO7h3RzXRgXvuh7tAK9mBJrTKjRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zffCSK6U; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so2238438a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710280930; x=1710885730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vXs+O61Mv5vydrV7OLqPBU73CQL7EwumC1ohewx/Hw=;
        b=zffCSK6UgSvS1Bcn0GCJFwJV0+DAF0xtqkYHIsIBQda7ohxHsxBgSmOKovAU6bsek1
         baBtGBlyuV0LzS5hZYcXYPWL7nxUsnrmRSrbpYa+9jIUS32inJD5FGWP1J4/kg0zRmL5
         dWsTRrkaR//hTzxTqhhGLwRsN7Amt2+VrpBgaHjMN10rHYDXmEF97JQcYUA5j4KYBNsj
         b0SUEY2tg+f8hxTkv6WU1/pGMu8m3E/QA7KQ5X0ZYxhwe7j84K6BGt7JlahUsvaMq/db
         //MOPwjStLjgpSUOwFkN/PXjQzv5VXL8rv7/ntapy02SWUBOI3uUM9Rdo1SvHquYD2Rm
         FFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280930; x=1710885730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vXs+O61Mv5vydrV7OLqPBU73CQL7EwumC1ohewx/Hw=;
        b=TZRZgWZYzqdLdGNkvbAKoHE/a/GStkAsPWpvlLpMSsyZqOeVXvPHEW84kG7SAqKinj
         0kLpuKERbWta9/BLsSHMJ1vtcjncRKEPCVooP9IDpYVqOTuQT3Puw9rwlesMV4gVo4cx
         6Xu0gFq42R4m2nr4I3qGAxoH0ddb0j9Kq0FbIa/9kDwIvFbnQCP+EpXyn/o5U2vV0w6l
         nlf2BzHTo/72tsjiJPaW4utUZKuRWlg4rd5Ea3DZRQR/XvEFmHvNwtcNwCe6vwT6O04W
         nVsYhn11e2IQ+b/38gGpMi0ni4Iz5u3UYzvwxSnFybOxKqFgP7T2W45cQcc68LjJLJS/
         peDA==
X-Forwarded-Encrypted: i=1; AJvYcCUvI60DSCJbnvGX5ykanGnyFJzpBR94B6/reawsOtN0BJKE0Y0rBr42QUCYv+mc76uapLGdcpKf+XDJJfMm2Ag4hAxmSJCEZ4sWtpwp
X-Gm-Message-State: AOJu0YyEWj4L16Utkg8DDZBiC0EMbHV0Egxj2XWENonTnQABA0yaoqqS
	ZdD6UMy5a8kUAIv3Kx6Mkebf6c9PSaNO9Y/qw28ihmr/mrJk/a9Fpjz6QneVdJk=
X-Google-Smtp-Source: AGHT+IHEoDWXSVuogvPsX9Dyo+IxRFBIM6bT08O79mjq5Xede5cVxcMUUJeg5RKa6bE230vujQY1OQ==
X-Received: by 2002:a05:6a00:987:b0:6e6:3b49:c4d with SMTP id u7-20020a056a00098700b006e63b490c4dmr3404100pfg.2.1710280930324;
        Tue, 12 Mar 2024 15:02:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r19-20020aa78453000000b006e627d0e97bsm6527711pfn.181.2024.03.12.15.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 15:02:09 -0700 (PDT)
Message-ID: <fee2fccf-ef4d-4595-8f20-07ba4dc67d42@kernel.dk>
Date: Tue, 12 Mar 2024 16:02:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.9
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
 <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org> <20240312134739.248e6bd3@kernel.org>
 <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
 <39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
 <20240312144806.5f9c5d8e@kernel.org>
 <20240312145455.403b713f@kicinski-fedora-PC1C0HJN>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240312145455.403b713f@kicinski-fedora-PC1C0HJN>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 3:55 PM, Jakub Kicinski wrote:
> On Tue, 12 Mar 2024 14:48:06 -0700 Jakub Kicinski wrote:
>>> index 9a85bfbbc45a..646b50e1c914 100644
>>> --- a/block/blk-iocost.c
>>> +++ b/block/blk-iocost.c
>>> @@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
>>>  	unsigned seq;
>>>  	u64 vrate;
>>>  
>>> -	now->now_ns = blk_time_get_ns();
>>> +	now->now_ns = ktime_get_ns();
>>>  	now->now = ktime_to_us(now->now_ns);
>>>  	vrate = atomic64_read(&ioc->vtime_rate);  
>>
>> Let me try this, 'cause doing the revert while listening to some
>> meeting is beyond me :)
> 
> That fixes the crash for me!

OK good, thanks for testing! Linus, can you just pick up the below? I
can prep a pull as well, but not ready to send the remaining merge
window fixes just yet.

From fb280ede759d1918fec03bc22d32eeaaa45500bb Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 12 Mar 2024 15:58:41 -0600
Subject: [PATCH] block: limit block time caching to in_task() context

We should not have any callers of this from non-task context, but Jakub
ran [1] into one from blk-iocost. Rather than risk running into others,
or future ones, just limit blk_time_get_ns() to when it is called from
a task. Any other usage is invalid.

[1] https://lore.kernel.org/lkml/CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com/

Fixes: da4c8c3d0975 ("block: cache current nsec time in struct blk_plug")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index a19b7b42e650..5cac4e29ae17 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -534,7 +534,7 @@ static inline u64 blk_time_get_ns(void)
 {
 	struct blk_plug *plug = current->plug;
 
-	if (!plug)
+	if (!plug || !in_task())
 		return ktime_get_ns();
 
 	/*
-- 
2.43.0

-- 
Jens Axboe


