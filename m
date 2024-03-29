Return-Path: <linux-kernel+bounces-125319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47CE8923EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F3D1C2246B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DF13B5A4;
	Fri, 29 Mar 2024 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zVLXaclt"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCC58127
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739581; cv=none; b=RJ0fPNwrep+5XzM/NOTDzalhTpXn/laMw2LiceYJxtD8SupRis8qxPlXK0sHC/PQVn5G0y6ekDpRL5tBJEORICaCmaNb/BpMKDHYig1BlYlsuaPu4h1PbxKZ+pWg9UScu58zWYepv1ROIqD1MFLRIwcZtRRVKgYK1zJGHADWzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739581; c=relaxed/simple;
	bh=hkDPtZAj4mEBH+E2ODm/oYL9vxFp6ZkJdLxiGUQwOf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHfR11GpdGWNRrg6ew75YJqdPGn3dRXDuVsl4I67f6H/ghVWMbXvikrVzUAlWduWsEpvNc8jD/oPoVwsVqYw93oqDuBzh1cUEF31Rb7KF7OYLRrUUpDxNtpXbtnBxBzH3wfQNi9CgUKZ5DhxI1g/YgXBxSAsgw+YHqqjzAUaNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zVLXaclt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29df844539bso689381a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711739578; x=1712344378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VBNKvDbVSXWscDx2hlPOat6rwmlhFUpp4tFOtD03l0=;
        b=zVLXacltvY79RZB0AiZ2AWaSCTOJvw4mLG/Vi4nVOMt+q6bOnvvZEJd+/HDf8yS/pm
         QfPNtlOSqHda0W6iaXAxccRmtJXsEcfd9cKpkthVomlls2kLTPZ64Ee2nkfChu81A3hp
         eRi1546q9wPaywzBa5OjisqOKkvD8bfK4A/ECC3B/T03pz6kN74zHlMf/9DxuAUmL2zD
         iLRONFuFq5xXWFR8YfAKL3Kk0n2EmqYwQMpc3eSPxq9WIEetn0uSaUdd2ANtNBgbiFO2
         mFGYNdlUgZRNXul4j9uyp1U0dDkRfoMfEPB0WNMbzdC6ViKOVppr3SBhUHVk7QlaE9S+
         gPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739578; x=1712344378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VBNKvDbVSXWscDx2hlPOat6rwmlhFUpp4tFOtD03l0=;
        b=Z4R+AmRlwW3dG3sbgkHhyORY0ACBOWoaZELn13MuMLQHMp0df3DhQiRHEwGQFkr3H9
         YvQoytJskbR/B7hGT+pggCJr80Nq8oUjFhZcKGdo8HLZWXe2GqFzOdcv9734PcdFoZ25
         hv4wx316Fp8JxiYbjuGoudHVMKZHcxpzX16K5BxmDPRsHCMopebFN4Fu5NaD7ODjT82Y
         OzXt8FW4vEouSJTJOWZ944JlRlr12LIJtsBWubKcdqy35aEbJrrHDdT7n+wnLTX/0XbD
         FyNOxAvm97uyRo+GR7lOdUTy7olY4u4/pCneNyPDbpaEtPX6vSYffyqzcRPOt0dvehn6
         XCOA==
X-Forwarded-Encrypted: i=1; AJvYcCVdCGLOFY4SkTEasBL4ew0ObX5zXV8HIoCzk1x0N8a4kcMUPxA8aiYRAkHeaFzweTVdMWWnaFG6t90dwCYPMUlWXkbvgBh0aoo6Q2OG
X-Gm-Message-State: AOJu0Yyg8iNJ/TOMZN3Eb0AOkdfkoh056bICEW5nEjPCS0dnDemaypz0
	QEzJaf4iJB5VqSCgCSLAmJ5v1lMEVOHPuuJwJFZcj3hZF5RvsXP6qd7ITrFk06Fko6q4MvjbVql
	U
X-Google-Smtp-Source: AGHT+IHzrTpKVu3zpcysw/Cf0jw8pV9XJkpAzWgws7EQo9UlGHeDEs00hxVoRGiuAfLZi4CwVuuaIA==
X-Received: by 2002:a17:902:ed46:b0:1dd:7c4c:c6b6 with SMTP id y6-20020a170902ed4600b001dd7c4cc6b6mr3221673plb.5.1711739577898;
        Fri, 29 Mar 2024 12:12:57 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:a5ff])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001e0a7e5a34dsm3806504plf.81.2024.03.29.12.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:12:57 -0700 (PDT)
Message-ID: <be8e14ec-3d46-4d67-88b0-f3dbf7ff22b2@kernel.dk>
Date: Fri, 29 Mar 2024 13:12:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-wbt: Speed up integer square root in rwb_arm_timer
To: Bart Van Assche <bvanassche@acm.org>,
 I Hsin Cheng <richard120310@gmail.com>
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329091245.135216-1-richard120310@gmail.com>
 <848d1259-ff6e-4732-b840-a02a5e5fe2cb@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <848d1259-ff6e-4732-b840-a02a5e5fe2cb@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 12:15 PM, Bart Van Assche wrote:
> On 3/29/24 2:12 AM, I Hsin Cheng wrote:
>> As the result shown, the origin version of integer square root, which is
>> "int_sqrt" takes 35.37 msec task-clock, 1,2181,3348 cycles, 1,6095,3665
>> instructions, 2551,2990 branches and causes 1,0616 branch-misses.
>>
>> At the same time, the variant version of integer square root, which is
>> "int_fastsqrt" takes 33.96 msec task-clock, 1,1645,7487 cyclces,
>> 5621,0086 instructions, 321,0409 branches and causes 2407 branch-misses.
>> We can clearly see that "int_fastsqrt" performs faster and better result
>> so it's indeed a faster invariant of integer square root.
> 
> I'm not sure that a 4% performance improvement is sufficient to
> replace the int_sqrt() implementation. Additionally, why to add a
> second implementation of int_sqrt() instead of replacing the
> int_sqrt() implementation in lib/math/int_sqrt.c?

That's the real question imho - if provides the same numbers and is
faster, why have two?

I ran a quick test because I was curious, and the precision is
definitely worse. The claim that it is floor(sqrt(val)) is not true.
Trivial example:

1005117225
	sqrt()		31703.58
	int_sqrt()	30703
	int_fastsqrt()	30821

whether this matters, probably not, but then again it's hard to care
about a slow path sqrt calculation. I'd certainly err on the side of
precision for that.

-- 
Jens Axboe


