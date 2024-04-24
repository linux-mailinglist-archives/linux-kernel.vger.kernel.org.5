Return-Path: <linux-kernel+bounces-157360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B918B105C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE702822FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E9716D302;
	Wed, 24 Apr 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3t/UNtO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB716C450
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977776; cv=none; b=mkHoIyeNy6/TsqANnbqsvC7HJJDieuui8Xubn9HpbZF8pLeN4I374mRJc4sBDldg0+vfDfUM3te7udV/qSDPvS8TvkxiNTQNG1usW9HyaDchrU3NAlUm7wsHihaoonQCUL/0JzcnvGotF+mllrMOWynyWqWCHdT6Qb2mSaFc0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977776; c=relaxed/simple;
	bh=uh4EFCiUkvNxBgNn87BtDStOjyNE9tszgONKqIyv2zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjxNf5ZLmncne/P1nOd/xWBIptvVpX62qEIgrz3fPymUICWXhFbOSLKYM6XEmNIZurYrffo9ey/rjcAmP0j45bmzcf5Ey6YJGKiAD0ZhMjTh36EO5Pn+YOn6wLeupjwy5CT83jmJcUbCfWYL/usz2YYYmz03BMfQ5mJQyKPgvyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3t/UNtO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713977773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpwjXgW96cugkI20yNxhEPChiJUNlZGdch2EYu8uvM4=;
	b=V3t/UNtOXoC+b6xDV2CEjsAQeki4xMT65SqOVeLIAg+Hk9Puw+zV3xMmF++4AWBF0RCQNQ
	TpAGZd+OcSKSQmbLt8I1KLlIuHkTK+BRqoa62pKUWR2NE2nAXBQFYu3mPs3XrQdHdgsUui
	reCgslcXcjc9U9xWQYOrR57wLWTzO+U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-eD2EIFcIOwCkS1egBXq31g-1; Wed, 24 Apr 2024 12:56:12 -0400
X-MC-Unique: eD2EIFcIOwCkS1egBXq31g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4e9ac44d37so5013266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977771; x=1714582571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpwjXgW96cugkI20yNxhEPChiJUNlZGdch2EYu8uvM4=;
        b=YxuEbqN7dMdg5tB7IPROeB4VcxLIW9leVF1o0qB2AXXy1S76mbF/3HpN2P31kgAoCK
         4vpHtL2VkWn2/SSzt1xZeeohym5C/T/YThc5E95mMll4S4WklmsW3jSlHig0I6rU4kX8
         2flndTjZvo5JC4IBbp/wgf4ETeKUVL9mFZVqhdRdCP0N6L6lYWGJB+necny0gc8nqdV4
         Z/+UxrAQCnuNhyX40cUDQgrRPpK/UwYzBvyEBxAWdN+d7y2PuoIDx3ezuk453549krXh
         X6cH5LHVqrxhStp+IpErjEibfkwMcGSRYFUwj3BV8+GRsvzCeNRAtU9kr9Xt5is+0kQq
         Uo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlh1D/zmAIyZ5uu/SLbA+7G/HKSnwpo27Vi5I/owDkaYRS10Emi3Uqk4cNg9kzce8pSg+SQfRWICnRvLc2mk/6LY+3ZmFTejgSt6Ch
X-Gm-Message-State: AOJu0YxaSNp2Qvh9Cko+/cyEU3FZhjBqTSxjUNfVuggZl0t3/o3OdJT2
	7JdZqjYbG9wIf1fGYmjWJovDnXgDMLEu+xbxHuWrbuarKMZfCEQaKD2vNo16ND9A7CS/6b1nWT9
	RZJrn0xi9yrMqCZ6WalI/Bwzu8PfrrBnnh4Us5DNa+qKtHkXcZiLeNOT2FYyEdQ==
X-Received: by 2002:a17:907:a0e:b0:a51:a288:5af9 with SMTP id bb14-20020a1709070a0e00b00a51a2885af9mr2726807ejc.51.1713977771191;
        Wed, 24 Apr 2024 09:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAzyv6HKiopDyaSXvCgdVur8CKCKopDhm7+o8rXN9GohklOErE6TQm1AsBp5DYN4EuFUjHog==
X-Received: by 2002:a17:907:a0e:b0:a51:a288:5af9 with SMTP id bb14-20020a1709070a0e00b00a51a2885af9mr2726782ejc.51.1713977770773;
        Wed, 24 Apr 2024 09:56:10 -0700 (PDT)
Received: from [192.168.0.222] (host-79-51-196-100.retail.telecomitalia.it. [79.51.196.100])
        by smtp.gmail.com with ESMTPSA id bt15-20020a170906b14f00b00a51eed4f0d7sm8575225ejb.130.2024.04.24.09.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:56:10 -0700 (PDT)
Message-ID: <99c1761a-9c00-4167-86e5-8a69cb6d9e5d@redhat.com>
Date: Wed, 24 Apr 2024 18:56:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: fix dlserver duplicate start and stop
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Phil Auld <pauld@redhat.com>, Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>
References: <20240412192304.3201847-1-vineeth@bitbyteword.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240412192304.3201847-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 21:23, Vineeth Pillai (Google) wrote:
> dlserver is started when a cfs task is enqueued to an empty runqueue.
> Similarly dlserver is stopped when the last cfs task is dequeued. But
> this logic doesn't take care of the cfs throttling scenarios where the
> root cfs runqueue's h_nr_running stays zero while enqueue/dequeue can
> happen on throttled runqueues. This causes duplicate calls to start/stop
> and causes issues with deadline logic. One example is a WARN_ON in
> task_non_contending because of duplicate calls to dl_server_stop().
> 
> WARNING kernel: [ 1970.747755] ------------[ cut here ]------------
> WARNING kernel: [ 1970.747767] WARNING: CPU: 0 PID: 14202 at kernel/sched/deadline.c:352 task_non_contending+0x404/0x500
> 
> WARNING kernel: [ 1970.747868] CPU: 0 PID: 14202 Comm: tpm_manager_cli Tainted: G  W 5.15.152-22017-ga797d64dcd15 #1
> WARNING kernel: [ 1970.747874] Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.250.0 01/25/2021
> WARNING kernel: [ 1970.747877] RIP: 0010:task_non_contending+0x404/0x500
> 
> WARNING kernel: [ 1970.747910] Call Trace:
> WARNING kernel: [ 1970.747914]  <TASK>
> WARNING kernel: [ 1970.747918]  ? __warn+0xa3/0x131
> WARNING kernel: [ 1970.747923]  ? task_non_contending+0x404/0x500
> WARNING kernel: [ 1970.747927]  ? report_bug+0x97/0xfa
> WARNING kernel: [ 1970.747932]  ? handle_bug+0x41/0x66
> WARNING kernel: [ 1970.747937]  ? exc_invalid_op+0x1b/0x4b
> WARNING kernel: [ 1970.747941]  ? asm_exc_invalid_op+0x16/0x20
> WARNING kernel: [ 1970.747946]  ? task_non_contending+0x404/0x500
> WARNING kernel: [ 1970.747949]  ? dequeue_dl_entity+0x112/0x2cd
> WARNING kernel: [ 1970.747952]  dl_server_stop+0x17/0x2b
> WARNING kernel: [ 1970.747956]  dequeue_task_fair+0x262/0x4c4
> WARNING kernel: [ 1970.747962]  __schedule+0x17c/0xf13
> WARNING kernel: [ 1970.747966]  ? update_load_avg+0x9b/0x611
> WARNING kernel: [ 1970.747970]  schedule+0x4e/0xd0
> WARNING kernel: [ 1970.747974]  schedule_hrtimeout_range_clock+0x10f/0x126
> WARNING kernel: [ 1970.747977]  ? add_wait_queue+0x4d/0x84
> WARNING kernel: [ 1970.747982]  poll_schedule_timeout+0x33/0x50
> WARNING kernel: [ 1970.747987]  do_sys_poll+0x4a3/0x626
> WARNING kernel: [ 1970.747993]  ? __se_sys_ppoll+0xdf/0xdf
> WARNING kernel: [ 1970.748000]  __se_sys_poll+0x70/0xf7
> WARNING kernel: [ 1970.748003]  do_syscall_64+0x51/0xa1
> WARNING kernel: [ 1970.748007]  entry_SYSCALL_64_after_hwframe+0x5c/0xc6
> WARNING kernel: [ 1970.748012] RIP: 0033:0x7bc815769510

I saw that as well.... but from a robot.. not with a reproducer.

> dlserver should be started on an idle root cfs rq, when
>  - enqueue on a non-throttled cfs_rq causing the root cfs rq to
>    go non-idle, or
>  - untthrottle results in the root cfs rq to go non-idle.
> 
> Similarly dlserver should be stopped on a non-idle root cfs rq, when
>  - dequeue on a non-throttled cfs_rq causing the root cfs rq to
>    go idle, or
>  - throttle results in the root cfs rq to go idle.


seem to make sense, I will add this check on v7.

Btw, as this is an ongoing thread discussion, instead of sending a patch, next time,
please reply to the patchset... it is easier for everybody to keep track.

-- Daniel


