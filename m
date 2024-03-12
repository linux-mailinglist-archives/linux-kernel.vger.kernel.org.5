Return-Path: <linux-kernel+bounces-100839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FDC879DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A11C20A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981214375A;
	Tue, 12 Mar 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XogGqnUM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A594AEEB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280416; cv=none; b=FaKDA5c5PuRb6WEI/+1EsGnPJbCMVgY4DjRzzryepQJf288PwQUDxVTxYQhs7PKwCNUSgeLKy63mQrPLzHzTFPRUixKnK1Tj8PKIJkBwiEvHB5/AIfQpuzKNN+e26Qr0p4Mrhjv93Th57A3oVYUvcV/MitLgSQRZHl4Q1G8aOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280416; c=relaxed/simple;
	bh=GoH2vZtMQEyHzGMu+xjFvhPYeQ0PSvOxNtV0ej76tc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov/TAZdZwx/hBG+IN36WHWTKIhJ9yadFlpE7W45BMnpCYxqla/wpdthWccBfcXJJRtHI4aBjltGcZpivAuN341CY0fuQdPMqKpmWQNlAy++F6BELuj5po2FwWMOAG19DhwExcUOgJfE4OATBJsrotl54J6g2VRCcXd5YD6TScBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XogGqnUM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd3c6c8dbbso10043095ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710280414; x=1710885214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgAoRXoGVuTzBazMoZQBPTv5bpPC2DD6aVA+CvxbndY=;
        b=XogGqnUM7Bh5JnuGKX06R/t/aiIHEjMIZc3n0YJXm9qy17C5KE2EMmkT4jIjsZRc+H
         iHaaWfyDOtg8cY1T1XXgkM4hhZcfH6mx4cBz6rxxk0LoEPf/RIlo/H2Cz5XlBawAjnC4
         cHVf975xy9zEAKCSx7CRpeU54++CYA5IrKic0EY03Y/Jf7lwgNRe00mWQGzhOLtakdy9
         QsO2GuZIeP5uUUbpkU8epQ6F+4dNH0DKJQVU5lzhkC/3iuJhYkoDXfhqjQYYOeYUiTk1
         cveG00kt4oO+O0PdddOwdQCvFbawaTvKxu6zdu9ZR4I06nMVbZ35RE5bFb1pz6PUxr5l
         9xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280414; x=1710885214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgAoRXoGVuTzBazMoZQBPTv5bpPC2DD6aVA+CvxbndY=;
        b=d3v8PSZhZwl1pMVU/aHR9JfpzI2yfpO4/UTBMmpbiVsAqw4WZi3PwzQ7nB60jBlKvc
         s6k7zAyZ5YHPoVG3bhl0dmyCIx83lMsVEDQoiOu9n4Mc8lfIpxpBoO6RVJAajR6LlkGX
         jazrigQkc/iQEQ0IbMEbWMt1l44C3M+kjXf/Ex7iJNFswsd0LXrmKI7a7Wjtz+LZGcXl
         1NDaiImqNQe2qeCOC8Tmyt7sgUzxHjuXVvP9AbcSeXQfJyS9dwcG6NS6UwdTCfSoy7Ah
         +mFeFsVjqlpl0Y3LI9NoORPpnO0cQrSSGH3+19kQLCFSuBU3NvIZ8W0wWO+N8eM4K+g9
         5SBg==
X-Forwarded-Encrypted: i=1; AJvYcCWLIjBanEK+qGqaqUAPCXa5wpxzIW5jf/1tdS/cwNDE+v+MIzxEXPVA72FRa7aj2qRlXvCXKwHUauUHXgCxWPh26ww9HoO1KCaZ9zIZ
X-Gm-Message-State: AOJu0YwodyoljhIjAcAZDgL4JQQHGmtfwwDpEwJS/EAVymg+auCUlzD2
	/18WpAGUWT7aIfaEiiwsdtiEUKEZJMu5ewdt1Djrks2tCLuc6UX7lF3QLUTQYe8=
X-Google-Smtp-Source: AGHT+IFm+/i67+6f03mMl5NqpTg05G9OjYuNth18e7nFR3xYoxgZgBTMSLZXo7FSveVxVdE8GFo8GA==
X-Received: by 2002:a17:902:8a91:b0:1dd:7350:29f6 with SMTP id p17-20020a1709028a9100b001dd735029f6mr3069799plo.3.1710280414017;
        Tue, 12 Mar 2024 14:53:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b001dd69a072absm7228013plf.178.2024.03.12.14.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:53:33 -0700 (PDT)
Message-ID: <72921846-16d0-438f-a6b0-eef704542e6d@kernel.dk>
Date: Tue, 12 Mar 2024 15:53:31 -0600
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240312144806.5f9c5d8e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 3:48 PM, Jakub Kicinski wrote:
> On Tue, 12 Mar 2024 15:40:07 -0600 Jens Axboe wrote:
>> Hmm, I wonder if the below will fix it. At least from the timer side,
>> we should not be using the cached clock.
>>
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 9a85bfbbc45a..646b50e1c914 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -1044,7 +1044,7 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
>>  	unsigned seq;
>>  	u64 vrate;
>>  
>> -	now->now_ns = blk_time_get_ns();
>> +	now->now_ns = ktime_get_ns();
>>  	now->now = ktime_to_us(now->now_ns);
>>  	vrate = atomic64_read(&ioc->vtime_rate);
> 
> Let me try this, 'cause doing the revert while listening to some
> meeting is beyond me :)

Thanks! I think the better fix is probably the one below. I pondered
adding a WARN_ON_ONCE() here, but I think just checking for in_task
state is probably the saner way forward, just in case... But I strongly
suspect the previous one should sort it for you.


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
Jens Axboe


