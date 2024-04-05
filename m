Return-Path: <linux-kernel+bounces-132743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B1C899982
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9C5282393
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E29160781;
	Fri,  5 Apr 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK8Y21U0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E4A15FD03
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309585; cv=none; b=ohi4upXnUUaakButxvxV4MpGjDioigRX9lPmkEepT8bpROLKhMmTDWZqaULMaOZDqriNjXeKUAZtuhanGWJ+opVz48uSuln2XveaNQOuc/1o8/N7iHVxvYkGcYLb3kyLSRYXfVX/5xebebD1ZvsIMYx1HOEDXnsJ8MLpBf7j41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309585; c=relaxed/simple;
	bh=hkPVGwBmVD7ihnEXpVgtNZRIfqAFunLkt1pfQIFSt5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eT4XcJODwx2k6+fdM4/3TUbkfVnSlazc6xwZg2lxJ++7uPK9sUMBl/cAE0AwOKyVoR4kRkBQegWsG9vomsBCJgYkVgNuq0paZ4pifOoOc8C/jK2VeYWiycZN1v7P9ajlGxOaaQftXd5xGny/fd77Xbbf4aGdvPSE6Bm/duxWR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RK8Y21U0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712309582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywQpA/QfFdpPbjmyHe7xktblVhjEeZD4PsxANAsEjxE=;
	b=RK8Y21U0Ma4meNEr5JsBnHMyrIQgh+L8o9e/OlLPyzXduMuuYCH3lb8FEjhTWrllTTSIIq
	escTrUQcBADQtBUn4MmPhtmMbKcDZRihdNxdT7KJQMK4qF2ommr4+js3cbeywTqfkb+Zma
	3L62UDOnPCHdMVLFSb1UrpqL4JlGcdc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-u1ndIt_LO-qAAO6QC_9ufA-1; Fri, 05 Apr 2024 05:32:59 -0400
X-MC-Unique: u1ndIt_LO-qAAO6QC_9ufA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a473f5a84aaso148912366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309578; x=1712914378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywQpA/QfFdpPbjmyHe7xktblVhjEeZD4PsxANAsEjxE=;
        b=d4+SVuZvdCoBB9Kdyl5xuCbs/HOOWgmFCSqylsF3hfDZAywZoKnWIqhT9Ud9brMsmQ
         or0yCB0RCFAMu7kTZ9P5VV9ejgduz9V8kuy/2vs5HZfWBLd4uwZAY1tLc5RR8JzpYC/l
         Bsa3Wwu1UFoJTqcjdT3PS33tXZIxkDhUDcc8XP7y2ofWBDDWPuJhP20aFlZPXWxmGBCE
         ENUd32ArRNY8xcyizuwAEK7QbniQmyvoSw10SwKmTn5Gd9qI1NdLHp+kVLova3MTRg0v
         JTCEFlozkP/kZkX5k0R2TweACG7iaNaSQgD7ljimpDLOtJKzoClESE3LGLBqT4OgjaFe
         xygQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX/4S4vvwE2dt4rploRY7zJJL9Um+fnq8hu2JlVFpI7JYTwz1nbLa9EU+4SMvG3ouSNuor/nebzppz0irSxGz5w9dlhvOHZWdJdvex
X-Gm-Message-State: AOJu0Ywo6MsrkCe+QG/o1LDcgtR9wQjQRUki27jkg7rq3l3qssaGCBgv
	eOI/39KM5G1uhTi8tbE6LksJq+RWKLiQvgWG/Dxs/qq6gvjoQGLTr8WsmpyRAl9sOIZ6D6rBOQk
	DOrHRjjU82yoeHcBGfAz01cUrBJwlVvU92wIbHImNtY2qkH0w7VqRguG0TJnaTg==
X-Received: by 2002:a17:907:20b7:b0:a4a:aaa9:8b3b with SMTP id pw23-20020a17090720b700b00a4aaaa98b3bmr509670ejb.77.1712309578706;
        Fri, 05 Apr 2024 02:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo/jC1iL77xtRF3cYmwc4nBQXUi2dBv6dcKWKDGgI80I4aC+GwND4tcy1uVlgo9kAaPz0uXg==
X-Received: by 2002:a17:907:20b7:b0:a4a:aaa9:8b3b with SMTP id pw23-20020a17090720b700b00a4aaaa98b3bmr509663ejb.77.1712309578348;
        Fri, 05 Apr 2024 02:32:58 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id he41-20020a1709073da900b00a5195ee5d62sm617936ejc.164.2024.04.05.02.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:32:57 -0700 (PDT)
Message-ID: <4c0a8190-bd9f-4886-a156-854ae831b16a@redhat.com>
Date: Fri, 5 Apr 2024 11:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] admin-guide/hw-vuln: Correct prctl() argument
 description
Content-Language: en-US, pt-BR, it-IT
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, David Vernet <void@manifault.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 linux-doc@vger.kernel.org
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-10-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-10-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> Correct the description for arg4 which appears to be outdated.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Maybe it is better to keep these tests into a separated thread (?) Because they
are touching things that are not about the server, so it might create conflicts...

What I did in the past when adding a series that was part in the kernel (tracer)
and part of tools (rtla) was to split them into two series, then referencing
one on the other - Steven suggested... and it was a good thing... and
reduced the number of versions.

So I am not adding these self-tests on top of the dl series for now... because
there is also discussion about the patches... and I am not an expert in the
selftests.... I will add a reference to this thread in the v6 cover and keep
updating it as new versions show up... in this way, one thing does not block
the other.

Thoughts?

-- Daniel

> ---
>  Documentation/admin-guide/hw-vuln/core-scheduling.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> index cf1eeefdfc32..338d639a8127 100644
> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -62,8 +62,8 @@ arg3:
>  
>  arg4:
>      ``pid_type`` for which the operation applies. It is one of
> -    ``PR_SCHED_CORE_SCOPE_``-prefixed macro constants.  For example, if arg4
> -    is ``PR_SCHED_CORE_SCOPE_THREAD_GROUP``, then the operation of this command
> +    ``PIDTIME_``-prefixed macro constants.  For example, if arg4
> +    is ``PIDTYPE_TGID``, then the operation of this command
>      will be performed for all tasks in the task group of ``pid``.
>  
>  arg5:


