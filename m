Return-Path: <linux-kernel+bounces-103152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B587BBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0F01C20A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D82E6EB45;
	Thu, 14 Mar 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLKPJyf2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576225DF0E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414037; cv=none; b=biBx84/VNIwLjwZRHTd91tDkps0Nc8UcmaTjT/0557uvZflDyH0OV71PC52Ylxvxqvwvldiy6uldTbQT671Jn+xnpbRRKgELfxsumZJ97JohU4aJ68QCBRavVDUjYg5sg97eZX3xW+2m5/Z+HH9xDtx+T82sK5Pl9L68izLyWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414037; c=relaxed/simple;
	bh=Utfl7eVL2A/Yn7ldJ477YCResQeeN1De+evYR7QounA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOSvvg9yB23b/PXjV+7lOniHLoLWBN6YfONyoX8/ncZFpEKE0J7CbU1x3+LyvpnJUPpwpREVgmXhmSlvjvTy5FjzVPx9smx5Gh8bjQAYtoHJy/aUXY2SpzNumHjY1RHEi++wd7ionwBD/yaUA2+UVtJlkigG67f1yXiCx+oXftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLKPJyf2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710414034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv56JItLno+xJgYVqa03le6TGHMKCxHdwV3mIZ+6lVs=;
	b=MLKPJyf2k5DrQwA1pW5R6Qc+sT5umOctBzvm9YoYACA8679Jaxxe/iSdIq6CUbcdRpJxxL
	QwuCO57FfoW90hJGXL210P038KNYkvQ7AvPV1nfVNQMh4FGRFMRykw/XtCBUwGfDH0wErQ
	eTzyX42Gdh4HJAjsWtB4xilmTIZJa8g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Y2-wRrodNX-a3uFaPFSRwg-1; Thu, 14 Mar 2024 07:00:32 -0400
X-MC-Unique: Y2-wRrodNX-a3uFaPFSRwg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e97ba772bso463699f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710414031; x=1711018831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv56JItLno+xJgYVqa03le6TGHMKCxHdwV3mIZ+6lVs=;
        b=NuGglDSwsaDPO66LEJSME6tr9f7FZPJiiy9SL9wO95FxyUkjS5QOrXtQ6PzosM6FK2
         NL8BoidGKhvzXPQY5wGU4xEyYMEwxhxDZW2FXnXrs/h6HX4czHC+WbQoXhMNTSH1uvFc
         SZfYwD6VdCpL5ZZBENdRTcaWV+X+dMyBBDOvYuKJc34v7PVirWKDI8DND8SF/VNiUJnp
         MT0Y4cEQTMdqbD19cH0lCD8zixYf4hF0il3iiPlJSnz3WVXuoSepc0ZFjp7nNkXSKEPO
         jgSChhpg1bBB+2v1LtBLIdHSIDzxvkwyzfcJUWW5VfNcgrk0VdSTMH5M+UFuMxC8cTvC
         KAEw==
X-Forwarded-Encrypted: i=1; AJvYcCVTR1JtvQ+H19bWDJspKCF3HxhVFSDEP5nCKxMOatXiurIKeAlLt3phOecsZq9Xb0WuPEkVeymI5Z9ulmDONFyM9m0WjNEaISr1Ffc/
X-Gm-Message-State: AOJu0YxhDC1UpL/D+QJF2YwZTHC8n8ob1eMldBFbp8uCot4P1WCJg7wb
	wbLfjxf297RdOTAzaTuYHFtCa1a0KY6OjRdgNRTJeVCu4QcTWwsc+y0ti9H0qYId2XEdGiODj5k
	OZoJgohmuJf5YYSp67c0Dg4EDrdAz62O3c3xA0Kk6cSnkgnJG5tS5evvp8xjtlw==
X-Received: by 2002:a5d:54cf:0:b0:33e:34b7:895f with SMTP id x15-20020a5d54cf000000b0033e34b7895fmr1052286wrv.24.1710414031570;
        Thu, 14 Mar 2024 04:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYZBTk/XxK63hTcKS/G0YEzbaExS+9ULrKO/tiSQjdZ4ZtNAEHZh2UP2gWuO/Xkwja2xgkHg==
X-Received: by 2002:a5d:54cf:0:b0:33e:34b7:895f with SMTP id x15-20020a5d54cf000000b0033e34b7895fmr1052266wrv.24.1710414031124;
        Thu, 14 Mar 2024 04:00:31 -0700 (PDT)
Received: from [192.168.0.207] (ip-89-103-134-229.bb.vodafone.cz. [89.103.134.229])
        by smtp.gmail.com with ESMTPSA id w21-20020adf8bd5000000b0033e0ed396bdsm478948wra.106.2024.03.14.04.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 04:00:30 -0700 (PDT)
Message-ID: <9925a5bb-ebca-44d9-b73b-5593c66c0efd@redhat.com>
Date: Thu, 14 Mar 2024 12:00:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/osnoise: init osnoise_instances list before
 registering tracer
To: Jerome Marchand <jmarchan@fedora.smtp.subspace.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240314104930.319754-1-jmarchan@redhat.com>
Content-Language: en-US
From: Jerome Marchand <jmarchan@redhat.com>
In-Reply-To: <20240314104930.319754-1-jmarchan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2024 11:49, Jerome Marchand wrote:
> The kernel panic during the initialization of the osnoise tracer when
> booting with "ftrace=osnoise" or "ftrace=timerlat" option.

BTW, while this fixes this issue for osnoise and timerlat, another issue,
remains with timerlat which prevent to boot with "ftrace=timerlat" option.
It apparently related to hrtimers:

[    1.489168] Starting tracer 'timerlat'
[    1.506835] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.507355] Loading compiled-in X.509 certificates
[    1.507652] #PF: supervisor write access in kernel mode
[    1.509639] #PF: error_code(0x0002) - not-present page
[    1.510425] PGD 0 P4D 0
[    1.510888] Oops: 0002 [#1] PREEMPT SMP NOPTI
[    1.511582] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-63.osnoiseinit.fc41.x86_64 #1
[    1.512819] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
[    1.514175] RIP: 0010:rb_erase+0x18b/0x3a0
[    1.514871] Code: 48 83 c0 01 48 89 01 e9 b3 30 03 00 e9 ae 30 03 00 48 89 46 10 e9 17 ff ff ff 48 8b 56 10 48 8d 41 01 48 89 51 08 48 89 4e 10 <48> 89 02 48 8b 01 48 89 06 48 89 31 48 83 f8 03 0f 86 96 00 00 00
[    1.517486] RSP: 0018:ffffffff99403e08 EFLAGS: 00010046
[    1.521008] RAX: ffff95e06fa2de49 RBX: ffff95e06fa25050 RCX: ffff95e06fa2de48
[    1.522067] RDX: 0000000000000000 RSI: ffff95e06fa2de48 RDI: ffff95e06fa25050
[    1.523111] RBP: ffff95e06fa24b20 R08: ffff95e06fa24b20 R09: 0000000000000000
[    1.524151] R10: 0000000000000000 R11: ffffffff99464880 R12: 0000000000000001
[    1.525195] R13: ffff95e06fa24ac0 R14: ffff95e06fa24b00 R15: 0000000000024ac0
[    1.526230] FS:  0000000000000000(0000) GS:ffff95e06fa00000(0000) knlGS:0000000000000000
[    1.527433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.528295] CR2: 0000000000000000 CR3: 000000014a422000 CR4: 0000000000350ef0
[    1.529331] Call Trace:
[    1.529783]  <TASK>
[    1.530192]  ? __die+0x23/0x70
[    1.530736]  ? page_fault_oops+0x174/0x530
[    1.531394]  ? srso_return_thunk+0x5/0x5f
[    1.532040]  ? srso_return_thunk+0x5/0x5f
[    1.532681]  ? ttwu_queue_wakelist+0xf1/0x110
[    1.533377]  ? exc_page_fault+0x7f/0x180
[    1.534007]  ? asm_exc_page_fault+0x26/0x30
[    1.534677]  ? rb_erase+0x18b/0x3a0
[    1.535251]  ? __schedule+0x3e9/0x1530
[    1.535863]  timerqueue_del+0x2e/0x50
[    1.536457]  __remove_hrtimer+0x39/0x90
[    1.537095]  hrtimer_start_range_ns+0x2a6/0x350
[    1.537918]  tick_nohz_idle_stop_tick+0x69/0xd0
[    1.538646]  do_idle+0x221/0x270
[    1.539195]  cpu_startup_entry+0x29/0x30
[    1.539829]  rest_init+0xcf/0xd0
[    1.540374]  arch_call_rest_init+0xe/0x30
[    1.541031]  start_kernel+0x717/0xa70
[    1.541623]  x86_64_start_reservations+0x18/0x30
[    1.542352]  x86_64_start_kernel+0x94/0xa0
[    1.543007]  secondary_startup_64_no_verify+0x184/0x18b
[    1.543813]  </TASK>
[    1.544217] Modules linked in:
[    1.544751] CR2: 0000000000000000
[    1.545300] ---[ end trace 0000000000000000 ]---
[    1.546015] RIP: 0010:rb_erase+0x18b/0x3a0
[    1.546674] Code: 48 83 c0 01 48 89 01 e9 b3 30 03 00 e9 ae 30 03 00 48 89 46 10 e9 17 ff ff ff 48 8b 56 10 48 8d 41 01 48 89 51 08 48 89 4e 10 <48> 89 02 48 8b 01 48 89 06 48 89 31 48 83 f8 03 0f 86 96 00 00 00
[    1.549271] RSP: 0018:ffffffff99403e08 EFLAGS: 00010046
[    1.550063] RAX: ffff95e06fa2de49 RBX: ffff95e06fa25050 RCX: ffff95e06fa2de48
[    1.551091] RDX: 0000000000000000 RSI: ffff95e06fa2de48 RDI: ffff95e06fa25050
[    1.552125] RBP: ffff95e06fa24b20 R08: ffff95e06fa24b20 R09: 0000000000000000
[    1.553157] R10: 0000000000000000 R11: ffffffff99464880 R12: 0000000000000001
[    1.554191] R13: ffff95e06fa24ac0 R14: ffff95e06fa24b00 R15: 0000000000024ac0
[    1.555226] FS:  0000000000000000(0000) GS:ffff95e06fa00000(0000) knlGS:0000000000000000
[    1.556433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.557291] CR2: 0000000000000000 CR3: 000000014a422000 CR4: 0000000000350ef0
[    1.558322] Kernel panic - not syncing: Attempted to kill the idle task!
[    1.559602] Kernel Offset: 0x16000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    1.561164] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Maybe a similar initialization issue that's easily fixed, or maybe the
timerlat option should be ignoreded at boot time, as mmiotrace is.

Regards,
Jerome Marchand

> 
> [    1.505256] Starting tracer 'osnoise'
> [    1.510214] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [    1.511189] #PF: supervisor read access in kernel mode
> [    1.511938] #PF: error_code(0x0000) - not-present page
> [    1.512676] PGD 0 P4D 0
> [    1.513105] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    1.513763] CPU: 9 PID: 1 Comm: swapper/0 Not tainted 6.8.0-63.fc41.x86_64 #1
> [    1.515485] Hardware name: Red Hat KVM/RHEL-AV, BIOS 1.13.0-2.module+el8.3.0+7353+9de0a3cc 04/01/2014
> [    1.516765] RIP: 0010:osnoise_tracer_start+0x21/0x80
> [    1.517514] Code: 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 48 89 fd 53 e8 62 2a f4 ff 48 8b 05 4b a1 ff 02 48 3d a0 32 28 b1 74 28 31 db 31 d2 <48> 39 68 10 48 8b 00 0f 94 c2 09 d3 48 3d a0 32 28 b1 75 ea e8 d6
> [    1.519975] RSP: 0018:ffffa35e40013d58 EFLAGS: 00010246
> [    1.520729] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000010
> [    1.521726] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffffffffb05ae000
> [    1.522700] RBP: ffffffffb05ae000 R08: ffff97624007a0b0 R09: 0000000000000000
> [    1.523671] R10: 0000000000000000 R11: ffffffffb0464880 R12: ffffffffb05ae000
> [    1.527337] R13: ffffffffafaa6652 R14: ffffffffb0727400 R15: 0000000000000000
> [    1.528329] FS:  0000000000000000(0000) GS:ffff9765afc40000(0000) knlGS:0000000000000000
> [    1.529476] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.530281] CR2: 0000000000000010 CR3: 00000001c9422000 CR4: 0000000000350ef0
> [    1.531258] Call Trace:
> [    1.531690]  <TASK>
> [    1.532081]  ? __die+0x23/0x70
> [    1.532585]  ? page_fault_oops+0x174/0x530
> [    1.533209]  ? exc_page_fault+0x7f/0x180
> [    1.533828]  ? asm_exc_page_fault+0x26/0x30
> [    1.534459]  ? osnoise_tracer_start+0x21/0x80
> [    1.535104]  ? osnoise_tracer_start+0xe/0x80
> [    1.535746]  osnoise_tracer_init+0x1c/0x30
> [    1.536362]  tracing_set_tracer+0x17c/0x2b0
> [    1.536998]  register_tracer+0x165/0x260
> [    1.537615]  ? __pfx_init_osnoise_tracer+0x10/0x10
> [    1.538311]  init_osnoise_tracer+0x78/0x390
> [    1.538941]  ? __pfx_init_osnoise_tracer+0x10/0x10
> [    1.539637]  do_one_initcall+0x5b/0x320
> [    1.540224]  kernel_init_freeable+0x318/0x470
> [    1.540881]  ? __pfx_kernel_init+0x10/0x10
> [    1.541503]  kernel_init+0x1a/0x1c0
> [    1.542043]  ret_from_fork+0x34/0x50
> [    1.542603]  ? __pfx_kernel_init+0x10/0x10
> [    1.543240]  ret_from_fork_asm+0x1b/0x30
> [    1.543850]  </TASK>
> [    1.544237] Modules linked in:
> [    1.545395] CR2: 0000000000000010
> 
> Turns out, it's because osnoise tracer tries to access an
> uninitialized osnoise_instances list in osnoise_instance_registered(),
> called from osnoise_tracer_start(). Move the list initialization
> before calling register_tracer().
> 
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
> ---
>   kernel/trace/trace_osnoise.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index a8e28f9b9271..122ef8a5c29d 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -3110,6 +3110,8 @@ __init static int init_osnoise_tracer(void)
>   
>   	cpumask_copy(&osnoise_cpumask, cpu_all_mask);
>   
> +	INIT_LIST_HEAD_RCU(&osnoise_instances);
> +
>   	ret = register_tracer(&osnoise_tracer);
>   	if (ret) {
>   		pr_err(BANNER "Error registering osnoise!\n");
> @@ -3124,8 +3126,6 @@ __init static int init_osnoise_tracer(void)
>   
>   	osnoise_init_hotplug_support();
>   
> -	INIT_LIST_HEAD_RCU(&osnoise_instances);
> -
>   	init_tracefs();
>   
>   	return 0;


