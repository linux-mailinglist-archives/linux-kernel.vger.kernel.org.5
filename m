Return-Path: <linux-kernel+bounces-84416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9D86A67B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49929B24C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C31D681;
	Wed, 28 Feb 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SngeE6jC"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC451CFAB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086896; cv=none; b=W7QUQWKcMRRlM1OzqWJDOQh/LtZ2MS3aNWPApR7bV1V6NKkfZvt3rBux957foO/XRWy7YQLOAnhicNXyJ/zwsb7KJsjbHXfZE8V8yWNrdw53oinYEXuafITUf3QeHBJ6I1Wnw5u004qGQE7VZE0af+xvWqSv/fLBpNas53pUGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086896; c=relaxed/simple;
	bh=HBeoi49AtWrwcA1YXjOAEF9pCMq19HVqnzoTgMaEEL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GrOSDPtuHVTvOyGJIvaswBVRI6VK+KDeHRzkP4M84gtU50vgKdk1eA+hp6dEFlRYtRbGoasHAq3A+wTo65c3LGl8pf5Ma/IhO7lQemlUgBpsYw3Xa9724HG94UxM76pERZAzQHkMFVHk7CbDXRVWLxjHl1V+9q2ZfK4jiXR/hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SngeE6jC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso1981649a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709086892; x=1709691692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ouK7PQziAYWSA6KvAKGr/XRg+XRrA8daY9DtIOAAFgc=;
        b=SngeE6jCXDJyfrT7YkU5y2wKNPA9bVo8YQmManUa2upAbSTYyDFGmHytF0rDDav2+d
         +uvqYdHQsmUz5UnTrXgxRObjsuUxIwo3soYIYLhp1q7eyjT2yJn4umeVL+DIbVCH79Ei
         7WX6GDjHHAoTCwCQZnyYdbPavDi88M57GN6hB1OCgexQ0fq4XjTVyau9ECw/yC6HX0WF
         P6lx2Rt0AU4c092cHYVMlxgqDKwMFrw94Lt+0JFo9nbnws8+hvYIane3G4FgotBQQibh
         HF/kHcD6TVMGiAYeuo8fFVRRTASK586IsZfnntlnxLt0psXDJkcGNHCdtE5oozsu7Jdx
         vebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709086892; x=1709691692;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ouK7PQziAYWSA6KvAKGr/XRg+XRrA8daY9DtIOAAFgc=;
        b=PTPpAW2xhw2Qu7uvQwYMOva8F4kQtPwPLTKScRbIm6qVSKWIouNhiYiZSCsEIUGXVu
         gAz4B5KYvifJ+VJAqtpt0vMCArhwNvBpoYdrmPejl2tAJU1xE5QlmXtXJYmUvI7uKxtY
         Jc7WkKVWbJMmL/qnGhXZt6D7Qr5KJbRkmpVKETOx5/pY5+Dj1A9aKkfDB0F4WHvQ1Oo2
         kR4DjeGGHc6K0An0Y+zUmxApndBYEg3lxsL5K9WN2/Vn+g7Vup3WXj1XlUTimy+sQ7uF
         tP2ngFQ1x6xzZUyeJiD5FgIjPmlBe//zUb0UVSf98+GmAngwjrgfmVpxrs0qxw9m7z0x
         BCiQ==
X-Gm-Message-State: AOJu0YxcXbyZJPI5yntMCRWK1kjxxTmcziyBzZidAHIIj5Cb8iHn65co
	Yl5b9wAaa7/WUhQ4v/I7bAYnpnQHjYfJKYjN0WW128u3XHb7mbqzZc8FN8f9PN/oyI4u/vZh2ah
	P
X-Google-Smtp-Source: AGHT+IFiav33n+E0Hx5YXdX9F77d4nu6ZvUO+5ZVGWNkBEEdSqjvTnia9JTZ0ZYojvk9f62GT0hkgQ==
X-Received: by 2002:a05:6a20:938f:b0:1a0:f897:738a with SMTP id x15-20020a056a20938f00b001a0f897738amr10262128pzh.0.1709086891915;
        Tue, 27 Feb 2024 18:21:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id m22-20020a637116000000b005d880b41598sm6558904pgc.94.2024.02.27.18.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 18:21:31 -0800 (PST)
Message-ID: <fe642c2f-4a7e-451a-b918-277c22904a7a@kernel.dk>
Date: Tue, 27 Feb 2024 19:21:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v2 0/2] Split iowait into two states
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com
References: <20240227211152.1099534-1-axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20240227211152.1099534-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/24 2:06 PM, Jens Axboe wrote:
> I haven't been able to properly benchmark patch 1, as the atomics are
> noise in any workloads that approximate normality. I can certainly
> concoct a synthetic test case if folks are interested. My gut says that
> we're trading 3 fast path atomics for none, and with the 4th case
> _probably_ being way less likely. There we grab the rq lock.

OK, so on Chris's suggestion, I tried his schbench to exercise the
scheduling side. It's very futex intensive, so I hacked up futex to set
iowait state when sleeping. I also added simple accounting to that path
so I knew how many times it ran. A run of:

/schbench -m 60 -t 10 -p 8

on a 2 socket Intel(R) Xeon(R) Platinum 8458P with 176 threads, there's
no regression in performance and try_to_wake_up() locking the rq of the
task being scheduled in from another CPU doesn't seem to register much.
On the previous run, I saw 2.21% there and now it's 2.36%. But it was
also a better performing run, which may have lead to the increase.

Each run takes 30 seconds, and during that time I see around 290-310M
hits of that path, or about ~10M/sec. Without modifying futex to use
iowait, we obviously rarely hit it. About 200 times for a run, which
makes sense as we're not really doing IO.

Anyway, just some data on this. If I leave the futex/pipe iowait in and
run the same test, I see no discernable difference in profiles. In fact,
the highest cost across the tests is bringing in the task->in_iowait
cacheline.

-- 
Jens Axboe


