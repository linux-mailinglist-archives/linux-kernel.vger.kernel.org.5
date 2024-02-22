Return-Path: <linux-kernel+bounces-76446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F185F773
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7915B28327E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC82047A6B;
	Thu, 22 Feb 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNHlvWpD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8E47781
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602620; cv=none; b=AXwafH/2aoaPLX1CNQJb93H1TOZDYldTZqlM3dRi4NYF8kWs4jShGJhWsA7Ko7b0TOcVf9wHfDHNGiJM0ik/P9BG4DrGYlf4YDdLt6yO8mm5Ljd6UhVxkYCxuqP0iNAPisS6gfTd0A2lPON9tcRDT38ElY32n4ZSFsFUoUNOt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602620; c=relaxed/simple;
	bh=ma9DfQIGiAa5vr3ks75PfINXo2TPrC0w7A/88yi8pA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VmJZJTnW6kkpzpuRhVpEqDaS2EMygcF5SvOkR5ZdQzegPV2avFddb3oJ33WHQYGgdyKLhmjOUNIEJ9MH0Gu+5lmNCvNpsDZ6USyC12nmw2ZYpui+nBgdQNmQBIfgIxiCC+CRZ3I6+kN29DhlJ+eQZiwQQqZTDxvrNP/354N8R84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNHlvWpD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708602617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldC5iLR/TjfHxpr5I8kE+2L9PTCMZ2jj1k9txMQpdfM=;
	b=LNHlvWpDPvqy6mIpfwQBe7iBjXqd28ML5ZmGBOpEMRu1nPlpHyWxgNMk6N4czt4mPdsSNw
	EkNAUkQeAsQWv+W58bVedLlLGDy8CWVecJCD/r19DIyPYLNKVp7pOJHqgDh2NCRfiiGFCg
	XRwa7yM8XhJhwk95PwaQFQbgc+ynhvA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-g0UZMkfeNbWkzyUAlnhfUA-1; Thu, 22 Feb 2024 06:50:16 -0500
X-MC-Unique: g0UZMkfeNbWkzyUAlnhfUA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3bdd99a243so79437866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602614; x=1709207414;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldC5iLR/TjfHxpr5I8kE+2L9PTCMZ2jj1k9txMQpdfM=;
        b=N05hOo/rwTMB8aJAy+VgoGPlXQdvKYxP01tFucyh8frQHj+tD4mBIJZa9ZRYQlGZnP
         Ss+YYl1m71XZ9X+RY5G4i9/HtggsIUs9qgxh72gyt5nMD8Zo6eQwZTnAghFofrZpl8FT
         EEH8KCbUe2nytdP9rVPtd4IstJIuQ+Dkqqx7CmGyaGETbdcwB+x60lxkUJXiJEu21OEg
         lBYh2sW+RgXjZ9ixBq2eY65+GsjnMyMJwcXnuas/omGSqcaQUIb20QUeTk8UsjpJgMFK
         HHFMAEwwJFbjOtV6pdYbY238SfUIA57VlSpesg97nyryl7tB8O1hCxuk64pZGaEz9zqr
         lyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+LncBH7w6LI2ooI6en8FVK9nQT9aW+G2bdK4DqVJb9zNQucRIS1Acm1KV+/KeIFOT0ZDdC/xYcClJKbTdcbGTucGV7r/44EbpWJU2
X-Gm-Message-State: AOJu0YxKeyW09EiVvnhX1TaPMT9pLeArrB/rlc3a0k67QOaG/bvVRMZB
	3tiN2As9u5RMR1rZ3SZT14zK/rP1JrCmPBDrWyQ8pNK/6NC4ugLwfzk0q8Q8pBWHEtXe1+fzKST
	/C4lJSBi62Cmv6Vr3xTjGdXzra2P3xKH8W34QTpxgfmKrMkAUHThvCLttMUReHMUSD7wseA==
X-Received: by 2002:a17:906:393:b0:a3f:4ca8:f93e with SMTP id b19-20020a170906039300b00a3f4ca8f93emr2003789eja.24.1708602614217;
        Thu, 22 Feb 2024 03:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFqkM/gRLrevRcPSWpe7we5hg0Pbu6lFDxiRpmiSyGCXmYKdK+uwM9zZOtenBwAxZkzrXVHw==
X-Received: by 2002:a17:906:393:b0:a3f:4ca8:f93e with SMTP id b19-20020a170906039300b00a3f4ca8f93emr2003757eja.24.1708602613833;
        Thu, 22 Feb 2024 03:50:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906398a00b00a3f99497456sm259912eje.90.2024.02.22.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:50:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 63345112DEFE; Thu, 22 Feb 2024 12:50:12 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable
 bpf_timers
In-Reply-To: <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 22 Feb 2024 12:50:12 +0100
Message-ID: <87le7chg5n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Tissoires <bentiss@kernel.org> writes:

> @@ -1245,6 +1294,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		ret = -EPERM;
>  		goto out;
>  	}
> +	down(&t->sleepable_lock);
>  	prev = t->prog;
>  	if (prev != prog) {
>  		/* Bump prog refcnt once. Every bpf_timer_set_callback()
> @@ -1261,6 +1311,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		t->prog = prog;
>  	}
>  	rcu_assign_pointer(t->callback_fn, callback_fn);
> +	up(&t->sleepable_lock);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;
> @@ -1282,7 +1333,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  
>  	if (in_nmi())
>  		return -EOPNOTSUPP;
> -	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> +	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEPABLE))
>  		return -EINVAL;
>  	__bpf_spin_lock_irqsave(&timer->lock);
>  	t = timer->timer;
> @@ -1299,7 +1350,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  	if (flags & BPF_F_TIMER_CPU_PIN)
>  		mode |= HRTIMER_MODE_PINNED;
>  
> -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> +	if (flags & BPF_F_TIMER_SLEEPABLE)
> +		schedule_work(&t->work);
> +	else
> +		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;

I think it's a little weird to just ignore the timeout parameter when
called with the sleepable flag. But I guess it can work at least as a
first pass; however, in that case we should enforce that the caller
passes in a timeout of 0, so that if we do add support for a timeout for
sleepable timers in the future, callers will be able to detect this.

-Toke


