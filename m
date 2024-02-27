Return-Path: <linux-kernel+bounces-84187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB386A372
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6AB1F298E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB956767;
	Tue, 27 Feb 2024 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HEKgN3I6"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15155E44
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075859; cv=none; b=efETpfv8eiFNN1nas5aKemP9bhCoGuSfzRPhfA/P4SO/KsxcobtleIFZxbkbPybG2IqWPUErKm+/7uI++/sfH7uv31Zqmr5CeBi+T2U37UHPmrl4IeTZshEtDnvYLk1g9LSvFHehyjZnJfsLWwjL7jVMikXCH50JJx71IfcPee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075859; c=relaxed/simple;
	bh=6AWfXB9wV+jk2EsGTu3m3bw/qXC54P0gEWrshMLMjnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKxHdV9sz9F0gquGRTY60CifV3XnHw9g5i258LkqRmQWDE7y2dkqlSpUOtoqhIyTCVCsecqkZPuHnaMYVDLDdpKZda7o3pWiryaYCqYzsBQF91EXmIfL5VnH4FGOCjmR2kg7saqvJjI7p3pX5wGGVF79no7ddR4IFLt4kxTtfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HEKgN3I6; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21f10aae252so534493fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709075855; x=1709680655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9nUEfGFVPEB6L5s0RszzmFIPyk1Iwqo3wiIakS/5S4=;
        b=HEKgN3I6NlvpTXEFhPNESxhzAUoJAQCgnvAQs/syBQn2BNllfOZCcpOLYMfrFr/LO7
         IxoBLQeVpkedPvk9giB8j6WUCK4jXoLT2R8fDPbSxt9JPvObvkJUXyxHk7NGthyetFdY
         HlRXVwV5ViaG2ncUHG2oYi9ghqVCtu3PvegzT6oVNLOZaDhy6WMEvqnRDkg2Fhm6gC6W
         4/Qh3JlBzFCi0e9hhC/7RqtOm8oNyn3lq3EL0PKuSDb/67R7LQy01lH38Q3giVLVpqxt
         dkI12DNbiKrAUso4qrE7kyAIF0Popw+z3wb+ZIbqwIYGZcIqog3aI8KF5p6e5O+K8Zm0
         TWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075855; x=1709680655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9nUEfGFVPEB6L5s0RszzmFIPyk1Iwqo3wiIakS/5S4=;
        b=Mfc/Q2y8RI15RNPNNSdjDoNQpCi8n9bD8a5NU/pL71Ast0s01XW5h+GgHT3U8XZWdh
         5OwlbbpFFgYwjvhPrTfXJ6xyJa8narFH5AYHtV+w/e3S4fyeDsUUTYKtr48uwRdkgIZp
         Xk8yx4GW2tFPbc1YeEZZvOagbxcrkg+V97uc3GjeRS79LfsSpKbGvkN4BkwqrkLTlUBo
         gcMXNOMCl6U0hiU2sgpiGFxKrGKdZXY18dPxm5s3B1UzdxlhgnqmTGFmvwVKrXmpqMxj
         KUFcShMOdPpfMKdPpH8FJnSMPDL8Z0/gosFhvsC0eLrBCj494DvIB6hSiQ1dvw10r9nK
         mOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUTYL9/wwOhc5ATN4IVnhD5XYdzdPPkYxdB1PJJCBuDEpZAay5nha2oToM5JBkCp686dEIK9gIjK2sMcR6XfWEOYIeqtGwsiDcxnED
X-Gm-Message-State: AOJu0YxdppkTyRHM6bBmkAlcJeqL3+8a9pVKVeWfQtTPcaG3CbSmLpcw
	WvDPDVu2vj2DbDwVEbzbrq0Jlln62VjA889XgSCJR0B4ejS55VNKb9mZsHO3G9o=
X-Google-Smtp-Source: AGHT+IG0Eu3Rn14MVi2GS1hIn5CTJMXEO+QYbnGEH9xiaLIg7Afa8nCW2F3NKluVlH98QJvP91io3A==
X-Received: by 2002:a05:6820:c04:b0:5a0:2cbe:43dd with SMTP id eh4-20020a0568200c0400b005a02cbe43ddmr10590567oob.1.1709075854709;
        Tue, 27 Feb 2024 15:17:34 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fa29-20020a056a002d1d00b006e47b5b67d1sm2041572pfb.77.2024.02.27.15.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:17:34 -0800 (PST)
Message-ID: <a02799bd-d8e8-488f-952f-2c507bd26261@kernel.dk>
Date: Tue, 27 Feb 2024 16:17:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to an
 unsigned int
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com
References: <20240227211152.1099534-1-axboe@kernel.dk>
 <20240227211152.1099534-2-axboe@kernel.dk>
 <14d4705c-48a8-4d38-8132-7b849286137c@davidwei.uk>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <14d4705c-48a8-4d38-8132-7b849286137c@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/24 4:05 PM, David Wei wrote:
>> @@ -4354,8 +4354,13 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>>  		cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
>>  		if (task_cpu(p) != cpu) {
>>  			if (p->in_iowait) {
>> +				struct rq *rq = task_rq(p);
>> +				struct rq_flags rf;
>> +
>> +				rq_lock(rq, &rf);
>> +				task_rq(p)->nr_iowait--;
> 
> Could this use rq directly, or does it not matter?

It certainly could, I'll make that edit. Same thing, but may as well use
the variable as defined. Also makes it clear we're modifying the one
we've locked.

>> @@ -10029,7 +10034,7 @@ void __init sched_init(void)
>>  #endif
>>  #endif /* CONFIG_SMP */
>>  		hrtick_rq_init(rq);
>> -		atomic_set(&rq->nr_iowait, 0);
>> +		rq->nr_iowait = 0;
> 
> I checked that both ttwu_do_activate() and __schedule() have the rq lock
> held, but I couldn't find it for this. Is it under the assumption that
> the rq is in a pre-init state (maybe because scheduler_running = 0?) so
> no lock is needed?

This is run at boot time (it's __init), so it's before anything is
running.

-- 
Jens Axboe


