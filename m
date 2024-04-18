Return-Path: <linux-kernel+bounces-150313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD138A9D28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC171F255D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3E22084;
	Thu, 18 Apr 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zdD33CJz"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CB16C85B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450619; cv=none; b=BabaAXng4P0kCf671yhVa9yZ3WykZoWAg+zqwdT02xGE6ld3UmfkbPTUi9kUtsuLZYRc5gSb5Z4WCe2vyUCOhTz7+MRBWL0J47OhKAW7QN6ehtd+0plx2IsBwEijw7LEQxkGlEvGDILCVczK2YLomc5PKrZD+NPdN9x6gvKCCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450619; c=relaxed/simple;
	bh=9/TQR1IEgTwqNlCPaqpr/Jnitj09THPvfGG3tVGKatE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cfj/1F3ZD2sYXBgyOORmXEOmtszbcDavQWCUxFtvwwsUqzPAgKQON2kHCzkxr1kXYqHAPjQTYYdL/gcCf1/u1HvaSsWMj/WVBNmzxBVBhXqi+uXlk+fYPKfRp0Ds0PeU8qkG1rTGHtS6QCvIve3uWC/HnZ4g7O+qI3fUlnCKhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zdD33CJz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so38987a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713450616; x=1714055416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s34+6Noa47tUC6nDFg281DMAoJ2FA4565ND1y1auC10=;
        b=zdD33CJzGPVBemwX8Vq2/tgYQv9NzMqDiUvkeXC9vxZGy13lqozfDI5sWnapncpxLp
         Qggkf8doo3qga/RF8pGt/E9DSnV8VMSV6T0LjLB/5er2gIs29NKrF5fi8UXsP5WDErgQ
         csxtzO0smFZkESrZlvdMZ4pxS++LWn9k0r/nm4jw0oF3pSgApuw6JGdZo5BA4WOHLu04
         +qdraGIKYq0ugk/DqivMCln49aZ1KFL+4E5mM37iUpb9fD/eJXlqliVJ5V7lMZwKDU44
         nXgF6SvthZb7E3URO5gmtWYDye7ysp/1BTQf6i9VCAb2FC3syS6eKnG97n5wl7rTPjov
         cJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450616; x=1714055416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s34+6Noa47tUC6nDFg281DMAoJ2FA4565ND1y1auC10=;
        b=ngdkwIXlch+vyjIYdt/a52Az8lQBllYoS4Ud+6CVmAEmuSWEQaM9IJfT9FiuUdGiLl
         2eGdEV9rIycIl4bv5vDISk8u9g8n8avHUHGktsFQvVmLmoM6VHvuXCMayfPEL0/KYIwg
         xpFT0QLKBhhyapdlnMQ4dJprv7UXf7WITkMcAamxAp2yHpoePuDyKQUAwO1QD7Si1Ivu
         gni8Dp3YXsVGIKwUJm0q+KT2WMzbh8mw7B/ab4LfPDROYAFIx3Nc8I1x3V8b/Mdaz3hO
         c282rglRy3bbMli5u5a5S8BR2As3+eeWG3QQuaiaMgFsg2l1w+ZLP4rG+zujIEOt33Hl
         acbg==
X-Forwarded-Encrypted: i=1; AJvYcCX45s471n7dY/d59DfOTIxb/nnMoFDgBHbdm30/6pXDVfpD8//ovXXpP7wpG700TkRf189Acf8a21mM5Gg9j6A/CvIkB05qMKRDfxa1
X-Gm-Message-State: AOJu0YwLKDMVt4b0fqJS91Q7fbRbtvAdQ3QZWEvIiC2Szx3BlNo9Yqmv
	A2LbYEfWRnF8Oe5Sje7ej1rC5uV6G9HnOfsNfJxZVO8EdyLccDb9ad+o4r0fn5E=
X-Google-Smtp-Source: AGHT+IE/r+6kGQWQgTrRuvZsXt5Jk/7zTOFdGOX/gMa9HL2erOx+JLXrmh+ZxfohkV9kQ/nVsaSU0A==
X-Received: by 2002:a05:6a00:6013:b0:6ed:6944:b170 with SMTP id fo19-20020a056a00601300b006ed6944b170mr3128716pfb.1.1713450616403;
        Thu, 18 Apr 2024 07:30:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id v10-20020a62ac0a000000b006eadf879a30sm1578618pfe.179.2024.04.18.07.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:30:15 -0700 (PDT)
Message-ID: <5f3d434b-e05c-445f-bee5-2bb1f11a5946@kernel.dk>
Date: Thu, 18 Apr 2024 08:30:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
To: Christoph Hellwig <hch@infradead.org>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Snitzer
 <msnitzer@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Guangwu Zhang <guazhang@redhat.com>,
 dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
 <20240417175538.GP40213@noisy.programming.kicks-ass.net>
 <546473fd-ca4b-3c64-349d-cc739088b748@redhat.com>
 <ZiCoIHFLAzCva2lU@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZiCoIHFLAzCva2lU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/24 10:57 PM, Christoph Hellwig wrote:
> On Wed, Apr 17, 2024 at 08:00:22PM +0200, Mikulas Patocka wrote:
>>>> +EXPORT_SYMBOL(wait_for_completion_long_io);
>>>
>>> Urgh, why is it a sane thing to circumvent the hang check timer? 
>>
>> The block layer already does it - the bios can have arbitrary size, so 
>> waiting for them takes arbitrary time.
> 
> And as mentioned the last few times around, I think we want a task
> state to say that task can sleep long or even forever and not propagate
> this hack even further.

It certainly is a hack/work-around, but unless there are a lot more that
should be using something like this, I don't think adding extra core
complexity in terms of a special task state (or per-task flag, at least
that would be easier) is really warranted.

-- 
Jens Axboe


