Return-Path: <linux-kernel+bounces-143786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E528A3D77
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C79E1F21A58
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790A5481A5;
	Sat, 13 Apr 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CeiU6+GY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4447A52
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022650; cv=none; b=QOfXKQ5Wfasgu0alSMg7HSgq7jm74PwBMwbTMt3YmbU1J3J/m03ZN+tiKYJLffhgZgKJ5us7Kd2UTd2nKAJsHXX+P2R2qs0ZjA3ms9IGZtDOhhUEvmXYbG28d95mJ4d39qEdyuWeo5os8N4EyTssaFoKWcbtp2Q9NrTssi28OsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022650; c=relaxed/simple;
	bh=zdiyRGeooSWP5pvS0+7HeX50Nk8+IvWk1rGHJTHhILA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPURJxeLmopA8T+zM2vy2PlUPqALPzY9gySXkhhSMdKr5iwMRsuxzXzTv41Q3KrT2gUm5TEu8WGj1aaDSnmoK2rNkhpKYYJ2g0X7h5cdMi/8wsJ6KedP+P7qoQ2TvXNvj+8Gr21Buahl9Sq0E69PnIqqsdkE5ffDtd2eHiV9R3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CeiU6+GY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e2a1654e6cso4252945ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713022646; x=1713627446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEquu8amiB2wVboaCCSnNACWolHHULyORulIDsvatsY=;
        b=CeiU6+GYMhuIU5T4u7/0WTcCi6s4RssOol4gMR5XK1qUoBG0MD15KZVV1dMVdDn3pT
         +RA6CqtvtReR97hWHsBU255Hv8CaPmrvl+ZV0BfXRYWIi9T9arAwDuBklOPoleYx1X5A
         lJ4ZTwMkfj9glQGHdVE4rEu/E7T01ogYKfvPpPgXblQOKXyA7yjUd+xjwSbLLs95RW6C
         aZ9JzhR4CC08STQ9TEWIGIh8GOKMeb7qQr9lSZsEEqDmJo6Cad6os2m5uoXeDSPnpfQ1
         ajX0O9AS5IqktmFzBFCaMrgi73lMMIkEQYdCxxJN4JYNUTcnAF4m0UhxdObKsw3Yj69Z
         rZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713022646; x=1713627446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEquu8amiB2wVboaCCSnNACWolHHULyORulIDsvatsY=;
        b=GRMris916yw9WYhSsDna1xJ/llN0nUz3XSGHxT0OzSlWa4wIi0NY1rWNy0IS7ts4iA
         mKlYOjSK8nnhW7aVBkJU3cuKurQn/0h90FCRjdvQZ9qCnMrT0HIunwe3T6ZzAQJkgYdX
         D5MvgKGAqinwHVVg6VcdY8R2rdVgTalYYNHnkiTfWjXNuosQx5l05OrPrLteqiRxegTc
         k9Cq1a0Wfsqhyrtz+Co8i5Q5wqicegwLJ28/+ZSo5RdCl/ZgYbQR7SJzKARsH4ZVw3F4
         +GONvhs65d/SK5voNANUFIEeaNAZajFEgegk1gpvXvo0ulGrEEdEyfSQ0Gkv4FryKh9X
         Oo2A==
X-Gm-Message-State: AOJu0Yy6SOos8oIcpW+0XtU+p07jCKqSGqaHEx39vMC2TYtPg2+8PB3D
	4v6OsJ5i9zza4pI8ZmmZ/7eAh67/cF6GYzPjhjAr5X4G6WE6DtWjeTNh77h/OTfR2C5pepOtaVJ
	d
X-Google-Smtp-Source: AGHT+IFPpXEIfsTlHcjdhOfCkM8eutnCDFqBhEQdGQ4ezPOqK6pXjEx6UrWh/yj0Q28E8JgwYlo0hw==
X-Received: by 2002:a17:902:ea11:b0:1e2:2ac1:aef0 with SMTP id s17-20020a170902ea1100b001e22ac1aef0mr6549398plg.2.1713022645798;
        Sat, 13 Apr 2024 08:37:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090311d000b001e2b6baa838sm4726478plh.122.2024.04.13.08.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 08:37:24 -0700 (PDT)
Message-ID: <8513fceb-6a5e-4dcc-8df1-8ae81b6db77f@kernel.dk>
Date: Sat, 13 Apr 2024 09:37:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC 0/437] Kill off old fops ->read() and ->write()
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240412042910.GK2118490@ZenIV>
 <b6725c23-ad82-4082-9e72-b219fc2b453e@kernel.dk>
 <20240413041534.GO2118490@ZenIV>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240413041534.GO2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 10:15 PM, Al Viro wrote:
> On Fri, Apr 12, 2024 at 07:58:13AM -0600, Jens Axboe wrote:
> 
>> I'm aware of some drivers that do different things from write vs writev,
>> or read vs readv for instance. But those I did cater to, by having a
>> flag they can now check.
>>
>> Can you be a bit more specific on an example of a driver that does the
>> above?
> 
> Consider e.g. your #39.  Current mainline: 1 call of ->set() for each
> segment passed to writev() on any of those.  With your patch: call
> segments concatenated and if the concatenation looks like a number, a
> single call of ->set().
> 
> If nothing else, it's a user-visible ABI change.  And in cases when
> ->set() has non-trivial side effects, it just might break a real-world
> code that is currently correct.
> 
> I picked that one because I didn't want to dig through the drivers -
> I'm pretty sure that there's more to be found there.
> 
> It's not just "write() and writev() parse the data in different way" -
> we do have a couple of those, but that's a minor problem.
> 
> "write(fd, buf, len1); write(fd, buf + len1, len1 + len2); is not the
> same thing as write(fd, buf, len1 + len2)" is not rare for character
> devices and for regular files on procfs/debugfs/etc.
> 
> For any of those you need to use you vfs_write_iter() helper or you'll
> be breaking userland ABI.  The cost of audit of several thousands of
> ->write() (and ->read() - similar problem applies there) instances,
> checking that property is the main reason this conversion hadn't been
> already done.

Thanks Al, I see what you mean now, and yes  that certainly makes
sense. I'll go over the conversions and see what might be affected, and
for those we'll probably just play it safe initially and use the FOPS
iterators helpers to avoid changing behavior.

-- 
Jens Axboe


