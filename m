Return-Path: <linux-kernel+bounces-138037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B289EB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 217E3B24CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9013C905;
	Wed, 10 Apr 2024 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9X4ZTgI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B313C831
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732432; cv=none; b=Lof2KgIg2LKBJpOJpHikdSgtlB+smKRMsjlA4T/5bAjrBHqV4UBbSu6+SD/W8n9k1xim20McBn/C+k9dxVxZit8qPa20aJ5TWXd7/DWxjFgob3vdbzOufa6qKOA5rROyz42xfKzxbHW6BrMMgFGUod6wX4taO2l5/oXfhXsJH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732432; c=relaxed/simple;
	bh=FhQsd1boIMChf7oRNrqjPNegG/mXoNr0ok8CFmIDsIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDDkYVQi+3dqYlBVsLasKl3uCm+ov9IUfs7sxH9djRJ1OPdl85jrFx3UJ5vSmO8HELbGwkfN0UOBMdYvQn0+z8jB5kcnUmeGsk7BCW2olJh2NOC3ZDUlMS/7lRXOVFbaDxU2+OUvFeAngAEz4AjLoWq/1AAyLu58KI8jmqXL3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9X4ZTgI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712732429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qpbw284sxKVH6lHTnqkMx+addOtGg8WZK0QMSoncDMU=;
	b=C9X4ZTgIaaiUTTmY1oVV+sxIZyLEYOt5bH+TqKutz2SQ7MGHAaiGEMizamBHYhrsD4I2Yj
	pjDjju3JUtNqQ4JECAEg5oxf1mjMnhnTBaaK3VNEXvFd1+84+6QHj9DIT9qDeaV83F2Inx
	yCBoy9Wlb/Ti8a1lG3NYHw7gIx9c+6E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-U8of9-GMPvGYTELGBwpKqQ-1; Wed, 10 Apr 2024 03:00:27 -0400
X-MC-Unique: U8of9-GMPvGYTELGBwpKqQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d87f5937fcso29403211fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712732426; x=1713337226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpbw284sxKVH6lHTnqkMx+addOtGg8WZK0QMSoncDMU=;
        b=vYwfGuCGHRCSViLkPxNntBigKdshd79P6kpMdttmja4f0wvJQTIs6W4dOAUnBh6wwM
         hZTiaFo5R3An6lNTMXzzhwtCBhQN/2UhPJ1qRpUQkuixXnPcfiLL0EYM4LmgqtzbkM+O
         5EnXfiJRkPbWxp2+ejLJ2VKoEnxLTj0RjWxwdqvTZknSXNIHA50X+oQoMPwKDsiVSR15
         3R3pQSXzyN2TPMJXAhm+WdHZG+d+60xjRkJwHleP+vVTMLn+pRQ5qlPukyqN+GwbDHVv
         DsAtCGf1lWXuJTeijl2nDIo89SnsvH+uabhIKkleQr/5yO5jT61B+gZcNwLS7Fy/ixTI
         05BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGVX1SWvKgtEZNd5CUjhr6D+J5GkpWUITV0T7AZabrKkBl3bbGz8FGkTi3JhrGeZh1WH9iPFj7SYjzzblSMWwG8eOKFsI5VAyYItbp
X-Gm-Message-State: AOJu0YyzqfFSDlpAo5PzowQb2sXeXndKAzOAsIiNnwxHyEmfviyXNsWl
	de4Knvp852ItsGMzlY31gOrDxJQSjJLA51L40/l/zXaYIL4RjAjzPmbvrR+x5WJSeM4jj4Lm5QR
	Q7OYuyJegUVD1Ept7J6+QJuTIk464SMzyfxJEPAOpMWdPu8USrQXBhSwevmKhbw==
X-Received: by 2002:a19:9117:0:b0:516:d729:5c3a with SMTP id t23-20020a199117000000b00516d7295c3amr1168407lfd.50.1712732426391;
        Wed, 10 Apr 2024 00:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZwpgzhlS04wJSv2+6nilTveCTk3jDGldjMnH79vAQfGE3vGSdklHYnK7RIL1Ki2VjBojH5w==
X-Received: by 2002:a19:9117:0:b0:516:d729:5c3a with SMTP id t23-20020a199117000000b00516d7295c3amr1168367lfd.50.1712732425800;
        Wed, 10 Apr 2024 00:00:25 -0700 (PDT)
Received: from [192.168.0.182] (host-79-51-196-100.retail.telecomitalia.it. [79.51.196.100])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709066d9500b00a4dacd6b8b3sm6618742ejt.68.2024.04.10.00.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:00:25 -0700 (PDT)
Message-ID: <7578e8f4-03ac-4234-90c3-0585af4eca4d@redhat.com>
Date: Wed, 10 Apr 2024 09:00:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] sched/rt: Disable runtime accounting for idle
 threads with SCHED_FIFO policy
To: Atul Pant <quic_atulpant@quicinc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: kernel@quicinc.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
 <20240410045417.3048209-2-quic_atulpant@quicinc.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240410045417.3048209-2-quic_atulpant@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 06:54, Atul Pant wrote:
> To prevent the throttling of RT idle threads, like the idle-inject
> threads, skip accounting of runtime for these threads.
> 
> Signed-off-by: Atul Pant <quic_atulpant@quicinc.com>
> ---
>  kernel/sched/rt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4ac36eb4cdee..d20999270e75 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1075,7 +1075,9 @@ static void update_curr_rt(struct rq *rq)
>  		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
>  		int exceeded;
>  
> -		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
> +		if (sched_rt_runtime(rt_rq) != RUNTIME_INF &&
> +				!(curr->policy == SCHED_FIFO &&
> +					curr->flags & PF_IDLE)) {


FYI, this will not be a problem with dl server because play_idle_precise()
disables preemption, so the dl server will not be scheduled until preempt_enable().

with the DL server, the time consumed as an rt task will not change the DL server
behavior because the logic inverts: it provides bandwidth for the fair
scheduler (instead of throttling the RT sched).

-- Daniel

>  			raw_spin_lock(&rt_rq->rt_runtime_lock);
>  			rt_rq->rt_time += delta_exec;
>  			exceeded = sched_rt_runtime_exceeded(rt_rq);


