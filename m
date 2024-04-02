Return-Path: <linux-kernel+bounces-128066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C74895598
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72767289505
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F90986151;
	Tue,  2 Apr 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2EZej/8t"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4F82D86
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065301; cv=none; b=gq3F1p+uDXHoOSVwpRbN1RnyWEygBB2K44XHcmvNZS1hecZqt0bzS7nN4w/fY+ipcUyRHOsSe8Zfq1WJcoAxrk6D17qCFHRqfdRkJkQEIvxl/qr3YB/lBqpUlGPts0+HPKCKbZgJhECwtV/YxnR5qwbW2AhUnjZw6bWDFSJ2buU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065301; c=relaxed/simple;
	bh=0LtRApWIgSlpJ9ww/YIqK7ZhGrxEnPNn5T2jGau3Mqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TP2J75XX+x8F0Oi2Ioi/q6pmFRVr3tSE0vI6zrkjswhnCJv6skyq3Lkzuh2wSJp+swVO0mtFPx+CjhuNTWPUEzq2WisRLMvUf0jafRQNJYqGpGcnAy9KX5MArtYe/j5nv40RPSB2JOItJIqNTMe9VBCBT6XTLlhqMkq67KVBCf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2EZej/8t; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso32155539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712065299; x=1712670099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ayu5f1JpVyjh9EymQM1sQHOrd/giDk3ss1JwfvraeE=;
        b=2EZej/8tfFfaTOOX95T9KAJg10lp4PXkT6jn1C7LiXCjN5WS3dwzcy1DCWxNFCGGfv
         8kiAglMtxO69/47BJASC6t5M0R4dE4M4+FvlzJcuICsomBrtDXmIP4VEzsquX648L6ZV
         0hNcdiRxQGRMu9khCkr6mpOdLt3TOkmBaZHh4cg+0y2S9CvgcShknHjWeWdWWNJ77Lo0
         gJxs9MPG67Mx3qdNOCUSIO+0i88BJki+DOeIa8ZxuTcrmIKOFqNRDu9labKWvMTg9Qpx
         rhpkVkkCaAYyuJAS5meMpvzDjvqV3aKKsKhcu2XtEVSEhEW+ZNqT5EG6DU/cnV5zK+6R
         XtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712065299; x=1712670099;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ayu5f1JpVyjh9EymQM1sQHOrd/giDk3ss1JwfvraeE=;
        b=aeipADRxS3ScnbFWXPxuYJ3dsk+gTtnsbbIXghl9dIGoEpJeuv6WKmrOlY0Q2YEk31
         i1GVCmaouUE5Uu1F9DrqCEBXHBWbB03MkMPe2E3Z3MyD3b1YNAqezOUZKQc9RzqitAnN
         TgeoLHlaelIktAlwBRZ/9fc1eytBGyePx6BYGuVMzYbaI6yq5h7bU4165xhHc2MAT/1A
         rSzvoC9w6SdHvt79URcKNSLSAvMpuBs/v7JyTNLV6+WilLg8xgFq3bQR4YWa4slSG2bA
         tOw4wlrV8rdzGuMNLA0InSItwX/jWOHXtiFcq4+hTS1xUFfgEPozplpguUQpvKD31R+7
         kn+A==
X-Forwarded-Encrypted: i=1; AJvYcCUVDj9zlWoZWpBvuSbf81W5l7F2LNkDeKE5Cti8HLcasI7fCJSIRAS6e/6m6x8vvzy0Fr8Jymdx6oC4zbP4GCtO/mW9HDt79zMtQt/M
X-Gm-Message-State: AOJu0Yzs3muREy4GGOBVJIhVHMWQ9N9eCPf4quz/Lh+1JXEWiYw9soTz
	O3jIVJ3Sec/OPPwtoSoOvbecnik5mqD/yAwr+YXi5y80ycr28BsF155yAe9HkTjnTTc0k1xnKzb
	Y
X-Google-Smtp-Source: AGHT+IGDUMItsDY7XwZRAzi1VsGUdRgc2+dwdqgArOafC34sSXfwfBgED9VOJLRu6JugwPpSDO3KfQ==
X-Received: by 2002:a6b:7d0c:0:b0:7d0:3f6b:6af9 with SMTP id c12-20020a6b7d0c000000b007d03f6b6af9mr12019000ioq.0.1712065298876;
        Tue, 02 Apr 2024 06:41:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id it37-20020a05663885a500b00476f1daad44sm3194814jab.54.2024.04.02.06.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 06:41:38 -0700 (PDT)
Message-ID: <2ff5d891-2120-475d-be8e-82bf20a8b7b7@kernel.dk>
Date: Tue, 2 Apr 2024 07:41:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 015/715] io_uring: remove unconditional looping in
 local task_work handling
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-16-sashal@kernel.org>
 <bcf80774-98c2-4c14-a1e7-6efcb79a7fee@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bcf80774-98c2-4c14-a1e7-6efcb79a7fee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 2:12 AM, Jiri Slaby wrote:
> On 24. 03. 24, 23:23, Sasha Levin wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>>
>> [ Upstream commit 9fe3eaea4a3530ca34a8d8ff00b1848c528789ca ]
>>
>> If we have a ton of notifications coming in, we can be looping in here
>> for a long time. This can be problematic for various reasons, mostly
>> because we can starve userspace. If the application is waiting on N
>> events, then only re-run if we need more events.
> 
> This commit breaks test/recv-multishot.c from liburing:
> early error: res 4
> test stream=1 wait_each=0 recvmsg=0 early_error=0  defer=1 failed
> 
> The behaviour is the same in 6.9-rc2 (which contains the commit too).
> 
> Reverting the commit on the top of 6.8.2 makes it pass again.
> 
> Should the test be updated or is the commit wrong?

The commit is fine, it's the test that is buggy. Sometimes test cases
make odd assumptions that are just wrong but happen to work, for some
definition of work. Eg it would work fine on an idle system, but not
necessarily if not. For this one, the fix is in liburing:

https://git.kernel.dk/cgit/liburing/commit/test/recv-multishot.c?id=a1d5e4b863a60af93d0cab9d4bbf578733337a90

-- 
Jens Axboe


