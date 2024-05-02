Return-Path: <linux-kernel+bounces-166125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B18B968D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55BEB22E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02ED4F88C;
	Thu,  2 May 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWubIbD1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6D482EE
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638911; cv=none; b=IPNq/UpuzvmjEjWaYAiFDj4Csb6fIsNs7L23YFp1PpTQfEnA7i1wqRMswE9ritoqd730EyboZbOdBHuHGqDUm1LpedaU1dh3xhEEiFnvy+sc/2Ix9C5A8f8GlPM1VdImEyd4OlnDLVoipMFVJ/i8c4dHN3sGuw7Scu8MVz9RYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638911; c=relaxed/simple;
	bh=gHh4hBjfe6gqCc3EF3M732Q8UuAi592HmiythyyjXv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeRAT0Rrv7nYNJmw0QS5Ggvy9/wHfs4mejnOdg0IDm3StG+0lplGUCDUPRDX6ePJjusPK0UygB6gPLu2Uku2pHMt87rjvuB0WrbA7mAY6mTayexbDz3izQctC24aDT239Z0AWqYkFSq/eraUsRB9oMKMxqbsOqiZ9JiKm4A62N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWubIbD1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714638908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEtxRuezssfbvcmBYzYRZOit5KxC6U1dkwTlxYR97+0=;
	b=ZWubIbD1jbpKqPElJ7HQzDvUBoPZNwdCrBjUlOkH3IXg7rfUv0Lm3AEIt6Z7eWBMGhU2EG
	ipPCloTNmvEcF5PxcvCt4unbNjB0HiRgRmT+Bk8/k33BFd/u+G9ZwVyCNXhrH8/RUPsR+r
	t5NvMHg1ndJqxYXrmJPf8mWAXqRE+YQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-e3uQzVjdM5CJEdo7-_MOow-1; Thu, 02 May 2024 04:35:06 -0400
X-MC-Unique: e3uQzVjdM5CJEdo7-_MOow-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51e0c413c16so3100106e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 01:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714638905; x=1715243705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEtxRuezssfbvcmBYzYRZOit5KxC6U1dkwTlxYR97+0=;
        b=KmybgjTinSan51RwvKA25F0+Ia+EpzCjUifSfmw4j0xYn0vDUN59WD0HMqScX5cDoS
         5Of9JW3QSSM8VD3HNMn4hHaHPWThNGqqWzXb1KtrdsERvWUBWKlGTm4fWNCK/uOdPCLU
         IrlEaxjffCnwDhWIUKxY33awrB2DtDA9gpe3c0D1YtaGrgd+p9NT8wUTdcqyJ7bnsn2r
         jq/WH3hHTHXyCi8LQh0P5kg6k4Mq7BJbQEwcwPy8sj69MBWM92Fu54LGq5+mlgGsKrO9
         0jlExxrKAvsJ1e6QimM9lLqItSNYJcxi8fuW5+MD0wO+W7bEUiPOye+9SjaexLP9PARE
         XZdw==
X-Forwarded-Encrypted: i=1; AJvYcCV+I3Rw6CxDHyWvOR1j2YwvRMusaMcqnIhkVbRnJnMKAQls8xMyyiJU3d+8fyCzaY4TEE3KUJ9SQLi3pVNFVorP55asXkVZWEb/JBhc
X-Gm-Message-State: AOJu0Yw/lc3YmAA60FMmzIz2/eHfP0Yt99ia1L+lMoeuor8rXXKTwJpd
	mqMv+e8FJCVCj39uGweYA3AAXlkTx8IkONRB9OYv4ayiAGUiyxPx8cdLGP495WJWuwsLo7URDt8
	sxwbX/phtzrzAw8wK2bZ3v5rSB7ToFiz7ARitO0/Oir40bJZWPSfudNu8Udgctw==
X-Received: by 2002:a05:6512:1042:b0:51e:e846:2b6f with SMTP id c2-20020a056512104200b0051ee8462b6fmr1923204lfb.51.1714638905445;
        Thu, 02 May 2024 01:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX/pq/KRjH9qmgRmB5lMDiLe9PYNS0fv4eEL0gxweLKJ0nIMI73cdmkH1CWRfR/JIjF1bC1g==
X-Received: by 2002:a05:6512:1042:b0:51e:e846:2b6f with SMTP id c2-20020a056512104200b0051ee8462b6fmr1923176lfb.51.1714638905009;
        Thu, 02 May 2024 01:35:05 -0700 (PDT)
Received: from [192.168.0.222] (host-79-51-196-100.retail.telecomitalia.it. [79.51.196.100])
        by smtp.gmail.com with ESMTPSA id x15-20020a05640226cf00b00572a0550acbsm268732edd.55.2024.05.02.01.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 01:35:04 -0700 (PDT)
Message-ID: <c4c6575d-5ea0-44ba-bbdc-eadad77dea81@redhat.com>
Date: Thu, 2 May 2024 10:35:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/6] sched/deadline: Deferrable dl server
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>
References: <cover.1712337227.git.bristot@kernel.org>
 <7b9c206e914ef257a2534199f25938ffafa3e59e.1712337227.git.bristot@kernel.org>
 <20240410174749.GC30852@noisy.programming.kicks-ass.net>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240410174749.GC30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 19:47, Peter Zijlstra wrote:
>> +static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
>> +{
>> +	struct rq *rq = rq_of_dl_se(dl_se);
>> +	enum hrtimer_restart restart = 0;
>> +	struct rq_flags rf;
>> +	u64 fw;
>> +
>> +	rq_lock(rq, &rf);
> 	guard(rq_lock)(rq, &rf);

this is the way I found to get the &rf... inspired on sched_rr_get_interval():

        scoped_guard (rq_lock, rq) {
                struct rq_flags *rf = &scope.rf;

is that right?
-- Daniel


