Return-Path: <linux-kernel+bounces-60867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4352B850A59
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CF2283373
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1628D59149;
	Sun, 11 Feb 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQhLpUHS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDB1DFEF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669478; cv=none; b=IHDTtHJrSAof7DAKEviNREg1CtO1JMAKFEb61qmfMUfNq91MycpRWol4D5/+ZTL7KEqLqE2OAzmRpgYLM4eK0+SLTdt08nL5ejhW2WXfOxSgOw3R2eWsDustuQDx7QEfmn2tuv8kFa1PqcVsF7YJa07irZOlAQpBw2MaHblgODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669478; c=relaxed/simple;
	bh=/vp/xpvdzp+it6uaTqP56blON+Qr0c5TcUv+xUCkXEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rtlp0hZ/ZxYOtsNd+38pa9xB+eAzlY3lcWzFUFsfb7SyaoYPvtHUR+xs+QV9Mt+aFsAGqyLzOo2/G2fJKiHZ2wQbOVmfQWlpNEBY7jZ+RazZRGkxtLMFDJPSgGcoy/79Fm98GX4op/IB+pbe2J0OwgjhU324daCYKUVrkpVDS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQhLpUHS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707669475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTL0yAz8fq7LGGFzfajeK6qM2p5IWjpDft9khrjZiUc=;
	b=UQhLpUHSqUCSxQpWwZTMm75clddPQVcJSvM9dBQLonNttQV9rQouVOlRycgpIzEUHiBE42
	XNZ1VS0NIEe86Fs/DY69f4HHaa15thRnc3Nv055I+t1OYMEIXyZIjRk95MLMEmrwNVW/cC
	OHmYhQ0kWcHlWMs4OrgjyZYwF2G13Pk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-c4Q_0PqSMbOT78k_2HeR4g-1; Sun, 11 Feb 2024 11:37:53 -0500
X-MC-Unique: c4Q_0PqSMbOT78k_2HeR4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D261828CE5;
	Sun, 11 Feb 2024 16:37:53 +0000 (UTC)
Received: from [10.22.8.61] (unknown [10.22.8.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 163D8AC1A;
	Sun, 11 Feb 2024 16:37:52 +0000 (UTC)
Message-ID: <c0ffb409-1498-4eeb-ab1d-27a46cadc43f@redhat.com>
Date: Sun, 11 Feb 2024 11:37:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hrtimer: select housekeeping CPU during migration
Content-Language: en-US
To: Costa Shulyupin <costa.shul@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20240211135213.2518068-1-costa.shul@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240211135213.2518068-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


On 2/11/24 08:52, Costa Shulyupin wrote:
> because during CPU deactivation a timer can migrate
> to isolated CPU and break CPU isolation.
>
> For reference see function get_nohz_timer_target,
> which selects CPU for new timers from housekeeping_cpumask(HK_TYPE_TIMER)
>
> Inspired by Waiman Long <longman@redhat.com>
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Nit: It is unusual to begin the commit log with "because".

Other than that, the patch looks good to me.

Reviewed-by:  Waiman Long <longman@redhat.com>

> ---
>   kernel/time/hrtimer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index f82997cf53b6..460d916e24b7 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2227,7 +2227,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
>   int hrtimers_cpu_dying(unsigned int dying_cpu)
>   {
>   	struct hrtimer_cpu_base *old_base, *new_base;
> -	int i, ncpu = cpumask_first(cpu_active_mask);
> +	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
>   	pr_debug("ncpu=%d, dying_cpu=%d\n", ncpu, dying_cpu);
>   
>   	tick_cancel_sched_timer(dying_cpu);


