Return-Path: <linux-kernel+bounces-112185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334BC8876AB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86168B228B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC71B1841;
	Sat, 23 Mar 2024 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IklhGGfh"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EC372
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711161457; cv=none; b=j99B9NYR4tmryFQVh/XYvhI7mlpa/6Na8+wxZsesD1F+Zz/oIBGuBJfiDVRGxZ+TWXxY9Y2ME/4HHdtEXiOn/0bI1iY8wuHk4wPytDVdUg0ibksG+5YxpgZ6jHg3AdbIF7L/T5aeL9Phzzl2halnrnJ4KlXCrUz12JA2vJcTdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711161457; c=relaxed/simple;
	bh=Yy64m1IRXHxmsx1znea5FvNab5fRsJ3MKuSDKTiLnXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+DzmsaAc5k77RuHh1Yf9BQyVV7iLOKQPyy9OGpYMipjYCEppQ1VGrtQH8ki7gj4pIRHb9eNdtZL5TJvbq/UMf8a7gtR3USa+qK+vQh7wKSKZ81ad2j/41PftPvl9kbBMLCVIcX5zAdeR8zIUsOSK+97Vx3IHKt+I4/oLisExug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=IklhGGfh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690bff9d4a6so17259256d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1711161454; x=1711766254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/QtWTHq6DiyGIfSxYeEvvq0bi71oVOicNhuyd4rz4Y=;
        b=IklhGGfhCrGGh3B82Gck3Cv8RbYDB6UAq3KJoMt5e6pO7XvtCIBvliBPBok3dG6QPN
         JqQ6mfLMEcRfEyxPm+t59ULJImO8TAO50XUo8L4O6/3fWHGGdVS843rRV9aDeijOgBhX
         aMddBM/oSfA0endkoBadGaNHQBOyk8pHyDyGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711161454; x=1711766254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/QtWTHq6DiyGIfSxYeEvvq0bi71oVOicNhuyd4rz4Y=;
        b=jkzp+bBQTR5VVVY7dbxM72Q0UDRHZKLmeJ2xigcWXOzyuIvjZcxmiRxBbLItSgDap4
         qw9AJ0xbyA5gIC90GY8QPN2vRG1UZNKVSoZIQpj3Jf3LDJNOZ1VNUKo7Qr1u8qOPVTeB
         8mO66pRO2rAC97pIPnhZMnMb6Wxe+NRDdpjuE9zNwlJAAK5i/+ZqX1nGOfU34bFrFnk3
         vXbjfc/bQG2qjaBxksTN+5y/2gr29nQaXFfUh5GvYMPD5lIPo7qav2xsTr0QNMccPb5J
         xA9e6AY5T3l/u3cx2xfK90ZSV+PfJBKOD07MhW+e7xR02EmZt+ax0i6A3qKO7lnvwdmb
         iaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9pZn/xSuQ+LHFh99A0gALtjHnW2hKGDKobeP2oKuVkHBmyFScssj1bG02ZjEfiEA4Tx8o64Caji8xIQ76KawiPTGp0IYhOyMrRxWg
X-Gm-Message-State: AOJu0YyYBS2j7g+77jZnFOxCIo3P++68gKA1QYAqp9qFJv3zhmaC2lIH
	7rNy2Lm676DZqVam3qA9+b2CpUcy66b9g2OIihdBs/NFwONwdMkuipbyYNYVQGY=
X-Google-Smtp-Source: AGHT+IG0dO6NUgsAT5UayKSGjwlmja7ZteKDWDuBNbZ1R2TlslgJbmgIXioijvVIy1dicjdkbhoFtQ==
X-Received: by 2002:a05:6214:2407:b0:690:a707:8857 with SMTP id fv7-20020a056214240700b00690a7078857mr1564140qvb.62.1711161454179;
        Fri, 22 Mar 2024 19:37:34 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id jp14-20020ad45f8e000000b0069678dcab9dsm280027qvb.16.2024.03.22.19.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 19:37:33 -0700 (PDT)
Date: Fri, 22 Mar 2024 22:37:32 -0400
From: Joel Fernandes <joel@joelfernandes.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com, Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <20240323023732.GA162856@joelbox2>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111024835.2164816-13-tj@kernel.org>

Hello Tejun,

On Fri, Nov 10, 2023 at 04:47:38PM -1000, Tejun Heo wrote:
[..]
> +/*
> + * Omitted operations:
> + *
> + * - wakeup_preempt: NOOP as it isn't useful in the wakeup path because the task
> + *   isn't tied to the CPU at that point.
> + *
> + * - migrate_task_rq: Unncessary as task to cpu mapping is transient.
> + *
> + * - task_fork/dead: We need fork/dead notifications for all tasks regardless of
> + *   their current sched_class. Call them directly from sched core instead.
> + *
> + * - task_woken, switched_from: Unnecessary.
> + */
> +DEFINE_SCHED_CLASS(ext) = {
> +	.enqueue_task		= enqueue_task_scx,
> +	.dequeue_task		= dequeue_task_scx,
> +	.yield_task		= yield_task_scx,
> +	.yield_to_task		= yield_to_task_scx,
> +
> +	.wakeup_preempt		= wakeup_preempt_scx,

I was wondering about the comment above related to 'wakeup_preempt', could
you clarify why it is not useful (NOOP) in the sched-ext class?

wakeup_preempt() may be called via:
sched_ttwu_pending() ->
	ttwu_do_activate() ->
		wakeup_preempt()
			

at which point the enqueue of the task could have already happened via:

sched_ttwu_pending() ->
	ttwu_do_activate() ->
		activate_task() ->
			enqueue_task()

But the comment above says "task isn't tied to the CPU" ?

Apologies in advance if I missed something as I just recently starting
looking into the sched-ext patches.

thanks!

 - Joel


