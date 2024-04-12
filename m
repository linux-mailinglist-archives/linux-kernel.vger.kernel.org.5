Return-Path: <linux-kernel+bounces-142780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3078A3002
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C73FB2408E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6585262;
	Fri, 12 Apr 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lToZekU2"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297CE542
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930297; cv=none; b=agEeDaXng00/Q6LZiMtZJUgvFqkN5EHsGYxjaM/MANFXW4/DRuU6RamfMWPjhQd3RsTnJ9lNGIwzoj0+9rsbibw6yrU0RdYR4VfdAPxdsYHh4g/lBg6pR+4oLAFcV4Z1IEKki2IPWigf7wq3Sw/geoHgyj212F0Ulw5/Ca4iFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930297; c=relaxed/simple;
	bh=a06zYKPZY0IlELepRdc+zSIq63a3P8Se8fA1HWlHXt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMMp19Wmt+skin2h8QhZrRq6ckssoi+GE3a28eQ6hJhX33CQgtUjinr29c2HVmTY3NhoVPkuIq3COyZKhQc0vjyZevRig26LhZj4zjGlVYCNWqaoXLYJZAhBd4+x12J75mO60V9hlGW3it3A3hy4GBUmvKod16YRPRWv4aM0Ozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lToZekU2; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a29832cbdso1361635ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712930295; x=1713535095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6ScjY74kgdg4FFt86oOGbdWnY7h0rG+iFpxeC8IMB4=;
        b=lToZekU2VjHG884zX3LUkGCH9RkLMY8Ux3Rirt7qbi++1qZ37tm613+hWBICDE3oQj
         RYvgwyDGD2nouNxeFcQnotgggqVtJwurEe+gY2uOsP05I+Q95TY5dqDnhu/DEdMfx8uf
         x+jaHt8OeJQd+Qo/8BavOL1fqP4g7Iu6ITzO9u7JPcWoFeg7AGUKeEkFgRz/AItI5wuD
         n8BBbJxHBNfAEX8yMJgdy3bjqjuL45CTugIG+VC16itRiWRwhlB/YClyTshKlbgXJKYK
         OkWkL/RQsaBx7nQETKXlCYdzImeAcQNhCOxwoliW4otuvTLD18PHGOQQtmcajEPDCyf4
         9jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930295; x=1713535095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6ScjY74kgdg4FFt86oOGbdWnY7h0rG+iFpxeC8IMB4=;
        b=QFPQSGBYgZHhmSYTe2ytgy3szH04xwXJYWNFbFnlKMQvG0rc2tEFMMQbkFMpXU+aFP
         X55XgOlFvKNbydCfQv49FXj7XwlxkMcugOOH3mOxGpfdLfpfkJUAhBU+LmSMRc2R7TCW
         Gx6wjkLfCb+nw8RLng1BaEP3g9TwGc9XQmYA/Xx3hvm12B0uCItlTSDDu2Xcg4DkCQRe
         L/Thv4+YUKrHxKMYc7iHhSSkRWoRN5pmE3R+Hvt+VTO6nESlmiBKE5zTjT/ZDQVqkOZC
         Xw/ouyYVsL931ewwoWvFuh+YhhWeRbjU2hLv2ZTAUOErW1ikNiK9LxNrnqVTmUjdzumG
         xHtw==
X-Gm-Message-State: AOJu0Yw4vXiLaqKynkkY7G6VsnTOke35TIOlB6P6emaQMI+jfpYTnoS/
	DQHwXq9J7ygG/IE0LbFQvaoFOY5WTAdfqb4vUnu7fab+yBqpAUn5SYJZDxrAzLGfjw0k+egePQh
	c
X-Google-Smtp-Source: AGHT+IHwaqz+oQssl+Qpf49CQSnRzbCFyarkwLhead+BzfCxo5dmFgC9EM23a49kN9Fe7JjgmkJMIw==
X-Received: by 2002:a92:db46:0:b0:368:974b:f7c7 with SMTP id w6-20020a92db46000000b00368974bf7c7mr2761516ilq.0.1712930295098;
        Fri, 12 Apr 2024 06:58:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i17-20020a056638401100b0047f1b5975e5sm1040927jai.76.2024.04.12.06.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:58:14 -0700 (PDT)
Message-ID: <b6725c23-ad82-4082-9e72-b219fc2b453e@kernel.dk>
Date: Fri, 12 Apr 2024 07:58:13 -0600
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240412042910.GK2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 10:29 PM, Al Viro wrote:
> On Thu, Apr 11, 2024 at 09:12:20AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> This patchset will obviously be split, commit messages updated, and
>> specific driver patches targeted to where they belong. But I figured
>> it'd be useful to blast out the full set at least once for reference,
>> and then I'll continue down the right path for the next one.
>>
>> Subject line says it all, really. 10 years ago we added ->read_iter()
>> and ->write_iter() to struct file_operations. These are great, as they
>> pass in an iov_iter rather than a user buffer + length, and they also
>> take a struct kiocb rather than just a file. Since then we've had two
>> paths for any read or write - one legacy one that can't do per-IO hints
>> like "This read should be non-blocking", they strictly only work with
>> O_NONBLOCK on the file, and a newer one that supports everything the
>> old path does and a bunch more. We've had a few issues with the
>> iov_iter based path being slower, but those have basically been
>> resolved with solutions like ITER_UBUF to optimize the single segment
>> case that is often the fast path.
>>
>> There are basically three parts to this series:
>>
>> 1) Add generic helpers that we need to convert drivers.
>> 2) Convert any use of fops->read() and ->write()
>> 3) Kill off old cruft.
>> 3a) Profit.
> 
> The fundamental problem with that is that a bunch of drivers
> do care about the vector boundaries.  Very much so.  It's very
> common to have this kind of situation:
> 	write() parses the buffer sloppily, and ignores the junk in
> the end, claiming that everything that been written.
> 	writev() feeds each vector to write().
> 
> From a cursory look through that pile, you seem to have broken
> writev() on at least some (if not all) of those.

I'm aware of some drivers that do different things from write vs writev,
or read vs readv for instance. But those I did cater to, by having a
flag they can now check.

Can you be a bit more specific on an example of a driver that does the
above?

-- 
Jens Axboe


