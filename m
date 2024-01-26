Return-Path: <linux-kernel+bounces-40694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FD983E43B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C0DB2199A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA02556C;
	Fri, 26 Jan 2024 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIYxom5C"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769862511E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305746; cv=none; b=ggvnS5jt9KzEN6T1kxS2Jk1hf+h0BR7Ai7CJcq1OuxoyObL1LoLprpPG0DrCfxYpf5rQ/1QFlJqmd7blTSIxnA//dJcWJHpQ3FKqjB7CVeqByeYBuCPCA6oMaEGMyS55fmSBgMM9cF/uUz8KdYJzjm0GD3Zqk4m7nSNJkqR8eHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305746; c=relaxed/simple;
	bh=0uo9TnLtA97puD6gdZ+DQf+JHgNgNWDZlNB6j4VlUL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu1WDzro8wA+lXF50qVFv10CFHBqjs18KLSoeaeQb/0cl/ccNLYa2ZRQ4p5o48cPGJEVs1e19hGDPx8KVMZXT86TdzSP9NgWqLJFWiiEDEZrSg0CWxcHvPrTdh5AG9t+jtKTcLYt59txQXopg3Hhoxl4oKEJLykSe9x9NL0c3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIYxom5C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d89518d3b1so5544535ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706305745; x=1706910545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOSJGt5Q97HTdpRXlnKq1oS7HmAIKYjYRAf8/RbqPuU=;
        b=IIYxom5C/jpCueISHz8VbqeQ0JYquFzniXO03dfp3YvnS68FIor4QUWS2fXogExMAa
         gYuY8RMGTbGnbefr7z0mD57myTjEERd7ILB1oaFdds9iKudt/ywXu4izq2choFg5Ei8U
         7VtMtECtXRmdXdEdhphk7fY4d081nxS0r1x+E8NFmfk3MZ7JIoJ+abf1efsky/EwQLLC
         EgZZJbwIPG+6qogpQgAJZK/vbCGIU6LsORACWIQeQGXeZqr/CeOyIzzlmbiP8UcIRtSS
         8MhAlA7YmJjrWmVYzzAIzMVtVYqSv18+OUtF0nm+Rck8y7AHRNsF08q5jIiZpc/7/qKO
         b99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305745; x=1706910545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOSJGt5Q97HTdpRXlnKq1oS7HmAIKYjYRAf8/RbqPuU=;
        b=NgIX5izbTVBEP5P25ko0sm1+pHo2uwI1sr5B8jplRNb58enhphEGdr8RzfLm4LXhDJ
         ADi82PVVGi1VW1b/yTLF5e1UkMKltZ9aY1sNbh/BhozrnGfLy8Ymj7T3zpDcv7oXVtIb
         E5d70om2QpwRB63SetrlIcywnuHK3e300QkQLIrYUTwNYzMSOqrDYftYBHOC/I775CbX
         DRERP8VohJrNiTVJDqoC+wZU4RDkGkyh1kdSnNYF5vtcptwa4IWaHxHTPy9qlXCn4P6G
         JnXLPiWtwGtfqaY9keDBZKJ3LTKzGqIL5XwGOWMx1AbChN2wCwonoov7ByNV17lu0+UW
         JmaQ==
X-Gm-Message-State: AOJu0Yw1qFkC9n60QWahYY0HOUWVWwr5t8ecztR1J9sICXZiYohOTAb8
	u3p3N61OAoJGXRFlNJdb3BB9MimMJ1prnqq2XYTi/qV+Fw388zwU
X-Google-Smtp-Source: AGHT+IHkKpaU8wkQnHqIt+ejYrS2aJMHH/K/xt+nSVA09CbLQrXQ5EaqP8VeuaS7PSL/tsvPuN/hCg==
X-Received: by 2002:a17:902:8b81:b0:1d7:6c6:9fca with SMTP id ay1-20020a1709028b8100b001d706c69fcamr1867624plb.30.1706305744532;
        Fri, 26 Jan 2024 13:49:04 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ka7-20020a170903334700b001d7252fef6bsm1377931plb.299.2024.01.26.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:49:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 26 Jan 2024 11:49:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on
 unbounded queue_delayed_work
Message-ID: <ZbQozqY9qOa4Q8KR@slm.duckdns.org>
References: <20240126010321.2550286-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126010321.2550286-1-leobras@redhat.com>

Hello,

On Thu, Jan 25, 2024 at 10:03:20PM -0300, Leonardo Bras wrote:
..
> AS an optimization, if the current cpu is not isolated, use it's timer
  ^                                                           ^
  As                                                          its

> instead of looking for another candidate.

The sentence reads weird tho. It's always the same timer. We're deciding
which CPU to queue the timer on.

> @@ -1958,10 +1958,24 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
>  	dwork->cpu = cpu;
>  	timer->expires = jiffies + delay;
>  
> -	if (unlikely(cpu != WORK_CPU_UNBOUND))
> -		add_timer_on(timer, cpu);
> -	else
> -		add_timer(timer);
> +	if (likely(cpu == WORK_CPU_UNBOUND)) {
> +		if (!housekeeping_enabled(HK_TYPE_TIMER)) {
> +			/* Reuse the same timer */

This comment is confusing because it's always the same timer.

> +			add_timer(timer);
> +			return;
> +		}
> +
> +		/*
> +		 * If the work is cpu-unbound, and cpu isolation is in place,
> +		 * only use timers from housekeeping cpus.
> +		 * If the current cpu is a housekeeping cpu, use it instead.
> +		 */
> +		cpu = smp_processor_id();
> +		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
> +			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> +	}
> +
> +	add_timer_on(timer, cpu);
>  }

I find the control flow a bit difficult to follow. It's not the end of the
world to have two add_timer_on() calls. Would something like the following
be easier to read?

	if (housekeeping_enabled(HK_TYPE_TIMER)) {
		cpu = smp_processor_id();
		if (!housekeeping_test_cpu(cpu, HK_TYPE_TIMER))
			cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
		add_timer_on(timer, cpu);
	} else {
		if (likely(cpu == WORK_CPU_UNBOUND))
			add_timer(timer, cpu);
		else
			add_timer_on(timer, cpu);
	}

Thanks.

-- 
tejun

