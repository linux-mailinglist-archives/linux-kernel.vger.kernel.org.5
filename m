Return-Path: <linux-kernel+bounces-87206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D513C86D113
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469DE1F26595
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCF6757E4;
	Thu, 29 Feb 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gafe5F1r"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D470AE9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228745; cv=none; b=DZITTMihQ5yESv8h3ypQahiapR5vZ9UWAswvgbENGN06YQ8frwAbJTw0Wwdv7wX44e1j1FhTr84XovCSC0QKxid06DQSE/kFMGvvJHj0gkiRU6VbgILt0DPSswvSEZjahT5a57k59h8u4SLOlRcOakAPzrC2AUvgy4gZ5C5V9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228745; c=relaxed/simple;
	bh=UCT6hn55RHePrDjuP9w0kS4PQbVHPbf2DK1bkX75CjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxBKgp2klpqwQYxsq1yp8G3UmaCv6q9LiFXNsu1WbmpiL5g7CTv7GrwHm+CEykfjYe6rI2oES4ieykQPnNX15LGMOj8Ht2r+renSfRNWnOjlrBqrecXXuKxqnSE6ztF3BJ0MqiQVgldaMehFPxr0GVrDHg3gHmJo/aNEnoEFscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gafe5F1r; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c787eee137so14700939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709228741; x=1709833541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZQJSc0KZQA8CADa/JynBw1thTIXDFhC1Jy7qGrAIwA=;
        b=gafe5F1rc0wsJieuqd1ZzAL4cSIGf7I5FRKZU86zr4kQ2r8vjyM7xj/qzkpaSrVLvw
         Yphw6PpRwjYn3DUVt/F8OatfMEsMWEAGaXsXlHIKZwYk77o/DW6Xx5R7KuBVHZmHtM9e
         1iXLztkgOxWaqKzFQXhRUnjYOUMkC+XJJLrwxVW0Ku8QpgCjtAN3Tw/D2igjWwSOYag5
         YzJyX5/SceAWqjzuQFTrV8eL8dvvgXZw/1pXZi9ROox2fDYJjCdvw6Wn4i4ZWRQAt/nX
         14mXxstWwLcdDMtlhJLcOZ2zGwn7GszzBRh9ksSgx2lg+emV2nZDYXgeNUqKrfCoygbf
         TFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228741; x=1709833541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZQJSc0KZQA8CADa/JynBw1thTIXDFhC1Jy7qGrAIwA=;
        b=JEn5caaH5PQ5x17FtSopTdjbnnztb+nLaPjVw76pNKABpWbasieXtzYlFlxTq7cczx
         Sze53cZgKtZSD3imbDgYen0lMSDV6irrJda1qg7Q6m7F1D5aNZVeoDzh1ybssI2yeM+V
         6pr/pUSeTqLwLCM1WJ5Uv4Uvv7RuU/nI2ugQwYDtyl/IUmGulGO0xNFdysSMx2MxhKS1
         rYfO/mISmk2IByLzw6xEzdEA7/3D/rYYGSVsjZuwupKFptI7ieFjCMnEWV9u1NJt3Q++
         ew6FFmEaXuU/CRLwTSsH9CbfeRnxKveh4ArtF4slsSAHTknub58J3YrNbiBwZy4Cz749
         1URQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPLGMy79im6wglVN6eFFeXE91lIXrxlERDnPpLaw83rxvU4KbHyMu/uapNDFT0JtDSv3p99ylNDA4Eg7rCxGj6p1B+L3dX71uBTmts
X-Gm-Message-State: AOJu0YwVorxR30W6IFcAM+2ddERdlqSz2sd3DqTckRzrvWGxXZGxfXcA
	HEXPY+XQnJW/CLmgV8PwVACl7VR21Cy2ewmA9j6T4IhM++7lfTbjH8kb0rrMJO4=
X-Google-Smtp-Source: AGHT+IE6bzkTH68f8uKG1Ag9w/DTNdxcPVprij3BgzVoP8AEB/7qrhI8o1n6dK0sEhIhPujgQDS3VA==
X-Received: by 2002:a6b:7d47:0:b0:7c7:f6c0:7fbe with SMTP id d7-20020a6b7d47000000b007c7f6c07fbemr2972329ioq.0.1709228741638;
        Thu, 29 Feb 2024 09:45:41 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q13-20020a02c8cd000000b004747d876aefsm416095jao.6.2024.02.29.09.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:45:41 -0800 (PST)
Message-ID: <c842c819-7035-45b1-8098-55a2d24a7d47@kernel.dk>
Date: Thu, 29 Feb 2024 10:45:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/core: split iowait state into two states
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-3-axboe@kernel.dk> <87zfvj6uub.ffs@tglx>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87zfvj6uub.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 10:31 AM, Thomas Gleixner wrote:
> On Wed, Feb 28 2024 at 12:16, Jens Axboe wrote:
>> iowait is a bogus metric, but it's helpful in the sense that it allows
>> short waits to not enter sleep states that have a higher exit latency
>> than we would've picked for iowait'ing tasks. However, it's harmless in
>> that lots of applications and monitoring assumes that iowait is busy
>> time, or otherwise use it as a health metric. Particularly for async
>> IO it's entirely nonsensical.
>>
>> Split the iowait part into two parts - one that tracks whether we need
>> boosting for short waits, and one that says we need to account the
>> task
> 
> We :)

I appreciate the commit message police :-)

I'll rewrite it.

>> +/*
>> + * Returns a token which is comprised of the two bits of iowait wait state -
>> + * one is whether we're making ourselves as in iowait for cpufreq reasons,
>> + * and the other is if the task should be accounted as such.
>> + */
>>  int io_schedule_prepare(void)
>>  {
>> -	int old_iowait = current->in_iowait;
>> +	int old_wait_flags = 0;
>> +
>> +	if (current->in_iowait)
>> +		old_wait_flags |= TASK_IOWAIT;
>> +	if (current->in_iowait_acct)
>> +		old_wait_flags |= TASK_IOWAIT_ACCT;
>>  
>>  	current->in_iowait = 1;
>> +	current->in_iowait_acct = 1;
>>  	blk_flush_plug(current->plug, true);
>> -	return old_iowait;
>> +	return old_wait_flags;
>>  }
>>  
>> -void io_schedule_finish(int token)
>> +void io_schedule_finish(int old_wait_flags)
>>  {
>> -	current->in_iowait = token;
>> +	if (!(old_wait_flags & TASK_IOWAIT))
>> +		current->in_iowait = 0;
>> +	if (!(old_wait_flags & TASK_IOWAIT_ACCT))
>> +		current->in_iowait_acct = 0;
> 
> Why? TASK_IOWAIT_ACCT requires TASK_IOWAIT, right? So if TASK_IOWAIT was
> not set then TASK_IOWAIT_ACCT must have been clear too, no?

It does, IOWAIT_ACCT always nests inside IOWAIT. I guess it would be
more explanatory as:

	/*
	 * If TASK_IOWAIT isn't set, then TASK_IOWAIT_ACCT cannot have
	 * been set either as it nests inside TASK_IOWAIT.
	 */
	if (!(old_wait_flags & TASK_IOWAIT))
		current->in_iowait = 0;
	else if (!(old_wait_flags & TASK_IOWAIT_ACCT))
		current->in_iowait_acct = 0;

?

-- 
Jens Axboe


