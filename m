Return-Path: <linux-kernel+bounces-100815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56271879D94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B6B21DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BEA143C6A;
	Tue, 12 Mar 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="j+n4Me0M"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8614372E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279613; cv=none; b=nR68OLVR6FAmHbPOC2AlTaER549NNVt3P9Ucf9ZN+W3Ha/1xUkCx7GBv255JAC2hG8Oh5783GHrQANHi2yF7WTHWggGmEGJZ1kVbIZ37A3MtVwWXxdu9qKqO1VwBRAVexbI7BNj+5vyv7gpYQx4CM9VgkvVqYHpM8w+t4Aq6QUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279613; c=relaxed/simple;
	bh=+oBn997uJy8z3i7Q2nllLFrjuAE+yfb7uicD9sTksS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7OFIf98qf9RqdjFAl7aaTQM2tYtiUc8ZBLDZH60MQO3Gk/+hEy7uw2ZD1g4IUEOdDhPNglJqp7iihNRBM6w1dUwCTzh38IsmpqWOVlhE3hJJq9TIU3WlRZ8WeSVlLvR6o2qsLm8cTx5Sg0c6Yb1vJNrxNu0lEBZshsUdBIas8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=j+n4Me0M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dd6dbcc622so15095265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710279610; x=1710884410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13av1ABYbiDWPdHc/R8lHWJKgGvE+CGOg+xLBagHaA0=;
        b=j+n4Me0Mj8GkIVow7fO085ckPWgxKscTmbxh8OP9y+9WxUZwqYyoAd7vmmzxzf1bR3
         M2ax98fIgA0dRR7Mg1XklfDNoZdMn3j1xLuvgehkrjv2spL8Dwcwipr80l8UcAXBRW7m
         6oUvMAY6sThSMK4bwd/WtMzf4aGGV3pg3G5XxdAbF6+Os2BlFJvBGoKw7ofL78AcOd3P
         nuN/IS7w+Ka0shlR1/ktrJHPD9U7U7jnTifnNYqBL0POomQ2QRcTyzJbi3sFTYSBOXF9
         ygJpVL/u8HCbIMxO1iUNKMtbYPlJmIUHzLf6bphNeD0IGoPge1wJWfoQ7fxOv7OCk0aG
         m+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279610; x=1710884410;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13av1ABYbiDWPdHc/R8lHWJKgGvE+CGOg+xLBagHaA0=;
        b=r1q2TMirwSMevbdO8Qsx/BP0CcUkH/TM7olRTp6a/n7uTez0MhP6DGPlqqtv4vqaKC
         5Om+94tAw2hXe5LMvTGOdaoleVGQZWvJJTfpoJcf4NMH28R3fDQy46ldq+Bx/AIZElsX
         YVXcbk3IuTLI9AJkFxhwcpRBWykntYLJsZPmFHyoP2Yp1KdYXMC7psab48n1bZp+VBHL
         I9Qp7ln5YF2Fz+De7CJxfQggDv390RFlM9t6SkNPXIJ53EovdD/jLHmkB3nYD59UdHWX
         Lzw3vQKuJcdbgb3zJulokNslKFwOY/2Wy4yblhmMSgwe+Jikiygi/o/htiDXYfBIRg5g
         lk8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoHceg7SMJhBlL0UAE8237eeLUFGyUqU34tMAnv1r0eUOfPqLmdqp0yirC6OjGEyC9lIUxkUFID3bwQyPraciNdT75q7CR7uZ1qDZ0
X-Gm-Message-State: AOJu0Yx/bO5SfCVgYVPloY2QzGWeDx0L5pk3uupY3VLjZb3SzhwtYe+8
	SDT001aMAjy+SC9HegK3TecaP0jiJwFzHrkgnQDeOSKSKcEu5g1v/ZAZ2p1oD9A=
X-Google-Smtp-Source: AGHT+IGdYi2xZX0kb/ozpi6PxI13btmek8Z08XjtS6L9vyMY2hkWQRaJtCAcvjr2u6yGZr5py/o1qQ==
X-Received: by 2002:a17:902:ac96:b0:1dd:67ce:4a09 with SMTP id h22-20020a170902ac9600b001dd67ce4a09mr11971479plr.0.1710279609732;
        Tue, 12 Mar 2024 14:40:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dd79b9b5c7sm7066176plt.161.2024.03.12.14.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:40:09 -0700 (PDT)
Message-ID: <39c3c4dc-d852-40b3-a662-6202c5422acf@kernel.dk>
Date: Tue, 12 Mar 2024 15:40:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.9
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org,
 Tejun Heo <tj@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
 <CAHk-=wgknyB6yR+X50rBYDyTnpcU4MukJ2iQ5mQQf+Xzm9N9Dw@mail.gmail.com>
 <20240312133427.1a744844@kernel.org> <20240312134739.248e6bd3@kernel.org>
 <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiOaBLqarS2uFhM1YdwOvCX4CZaWkeyNDY1zONpbYw2ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 3:11 PM, Linus Torvalds wrote:
> On Tue, 12 Mar 2024 at 13:47, Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> With your tree as of 65d287c7eb1d it gets to prompt but dies soon after
>> when prod services kick in (dunno what rpm Kdump does but says iocost
>> so adding Tejun):
> 
> Both of your traces are timers that seem to either lock up in ioc_now():
> 
>    https://lore.kernel.org/all/20240312133427.1a744844@kernel.org/
> 
> and now it looks like ioc_timer_fn():
> 
>   https://lore.kernel.org/all/20240312134739.248e6bd3@kernel.org/
> 
> But in neither case does it actually look like it's a lockup on a *lock*.
> 
> IOW, the NMI isn't happening on some spin_lock sequence or anything like that.
> 
> Yes, ioc_now() could have been looping on the seq read-lock if the
> sequence number was odd. But the writers do seem to be done with
> interrupts disabled, plus then you wouldn't have this lockup in
> ioc_timer_fn, so it's probably not that.
> 
> And yes, ioc_timer_fn() does take locks, but again, that doesn't seem
> to be where it is hanging.
> 
> So it smells like it's an endless loop in ioc_timer_fn() to me, or
> perhaps retriggering the timer itself infinitely.
> 
> Which would then explain both of those traces (that endless loop would
> call ioc_now() as part of it).
> 
> The blk-iocost.c code itself hasn't changed, but the timer code has
> gone through big changes.
> 
> That said, there's a more blk-related change: da4c8c3d0975 ("block:
> cache current nsec time in struct blk_plug").
> 
> *And* your second dump is from that
> 
>         period_vtime = now.vnow - ioc->period_at_vtime;
>         if (WARN_ON_ONCE(!period_vtime)) {
> 
> so it smells like the blk-iocost code is just completely confused by
> the time caching. Jens?
> 
> Jakub, it might be worth seeing if just reverting that commit
> da4c8c3d0975 makes the problem go away. Otherwise a bisect might be
> needed...

Hmm, I wonder if the below will fix it. At least from the timer side,
we should not be using the cached clock.


diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9a85bfbbc45a..646b50e1c914 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 	unsigned seq;
 	u64 vrate;
 
-	now->now_ns = blk_time_get_ns();
+	now->now_ns = ktime_get_ns();
 	now->now = ktime_to_us(now->now_ns);
 	vrate = atomic64_read(&ioc->vtime_rate);
 

-- 
Jens Axboe


