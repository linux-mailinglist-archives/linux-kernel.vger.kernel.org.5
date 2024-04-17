Return-Path: <linux-kernel+bounces-148940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072CB8A896A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AA61F249C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80F16FF3D;
	Wed, 17 Apr 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0WEyWUJc"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452A16FF55
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372964; cv=none; b=VkSjRNst3miRXUOwblvaLCfmkBybChCE0H4ImzMHRDlZT8f1eg9JqA0KmzztBh5Yq3JMGbfCQfjDQE+C8dtOchQYHDEXur6+EivqzQskrLsTuJZSIYRT3j099DEfTfaflkz+0LmP073lBC3GM+DiD1rqlUf72qQGYvm7qDakgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372964; c=relaxed/simple;
	bh=NVzcN5A1MDUCRNGN1j82k+y9l46oc2GyJO6/C/mgrHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHrrGaCcRUJbKGvzsM0uL84xXrvGqlYwjN63hADWEq8YVTUbz0cg1Yha95uknyykM7Bwivv5bxnTgoQt9fqkPnTwtB1lu3QO4k6xo6/6sQPtmixKCGNlrJFHfoA4JeKC3k0SdqrTFrpJn3dmuTuxk4vfow/in+ma6iNQUX9w8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0WEyWUJc; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6b362115eso81991839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713372961; x=1713977761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUAHB5bPJ+iDHtRK1ERMDUYx1czMuNi349CzQq6TWhk=;
        b=0WEyWUJcrZR3aCAi5Ej9l7OgvRRvl7Lz27A0cl0wV26+Bv03MiiW97JdgbGrlH1EaS
         j8TxhrjPkSxDafHJXZGXrSC+LU4WFkoeASwLkWQDBrvHhepkD+pGOq1r9EPMXWvhslip
         vVvFFfgQnE0CQEEmSCGo963slscTIcNbWn14BNcetvJTJepuQEBsfa9JLOHWOjFVcr7q
         Vq92x1qtZJNCWaq7oNqnpku+y0OC3cjItCI27s5wHFVKbOu0sYdfKnTLXEfkn8ytomno
         YmhPOQDc62yfIml9ZuQDIFIzsVXRdkbZm0Ls8wHWmc7DPqZBbYlq1K9aPHTJzqxE/fUa
         /p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372961; x=1713977761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUAHB5bPJ+iDHtRK1ERMDUYx1czMuNi349CzQq6TWhk=;
        b=aexQ3XHCSwmyjkSGnRSIiEA7k4uFhAr+nKPNx6kbUHbo3Qq3Qf3UxIa5ToyBWytFhf
         HfnIPeCT7B7dYqcuJMwJnpI7wHQfVBUf7Eyk/Px3P2ItpzXc98YQiXNKrhxbFfIW8fsb
         8KzmLwKaMvORHt3L77vvaypGOKvOrO8Ulh9iD6ACf4IUIw8fM0p7cJWohb0e8WQdT3KN
         AGd3y83zmLhE8D2xxd50EPghc5gnQHx1b3ELno3fSUHZmWEDo2OtHPxuWmESwfS59Q79
         LlCoR2WxymEZawBFcyVY/FzumCJgpivQVUAFfLOhMRBD97OGOBya1x2FQ161K0LrAy3D
         EI4w==
X-Forwarded-Encrypted: i=1; AJvYcCXq2/EZuVnQKegyhlmVViSYIPUisbLNg3F9c16EirDiaWOoqDbrvXdYnm1rxhp3koHsIvSCfiDEKQcRnuYuc5+UBfOomozWCglbfBzg
X-Gm-Message-State: AOJu0YxUAzOEyq6rUnQwkZNwDz5uZxezcOoOIeoHfVFPEZV92d7fCS5e
	mHNcRhqjdI5BESJid1HqQvv5HSgTxov54C9Y8lGL/Es81jdCz2VLxyZ0d+d0viw=
X-Google-Smtp-Source: AGHT+IEq1tXs6bVu+t+KS2pPXVs3KAV+KvjBYxSJrIs1bc6wfc93/z+DAVpdNKnzJU21HV/Z+81VKQ==
X-Received: by 2002:a5e:c907:0:b0:7d6:a792:3e32 with SMTP id z7-20020a5ec907000000b007d6a7923e32mr241839iol.1.1713372960935;
        Wed, 17 Apr 2024 09:56:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dq3-20020a0566021b8300b007d5ebc40f82sm4010155iob.31.2024.04.17.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 09:56:00 -0700 (PDT)
Message-ID: <e843abe1-0561-4ee7-a73e-4ffd407d523e@kernel.dk>
Date: Wed, 17 Apr 2024 10:55:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dm-io: don't warn if flush takes too long time
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer
 <msnitzer@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <65c83995-1db-87ff-17df-20c43c1b74d7@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <65c83995-1db-87ff-17df-20c43c1b74d7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/24 10:51 AM, Mikulas Patocka wrote:
> There was reported hang warning when using dm-integrity on the top of loop
> device on XFS on a rotational disk. The warning was triggered because
> flush on the loop device was too slow.
> 
> There's no easy way to reduce the latency, so I made a patch that shuts
> the warning up.
> 
> There's already a function blk_wait_io that avoids the hung task warning.
> This commit moves this function from block/blk.h to
> kernel/sched/completion.c, renames it to wait_for_completion_long_io
> (because it is not dependent on the block layer at all) and uses it in
> dm-io instead of wait_for_completion_io.

Looks good to me, though I'd probably split out that dm change as it's a
new addition where the other parts are strictly mechanical (moving the
helper to where it belongs, and using it where we already do it).

-- 
Jens Axboe


