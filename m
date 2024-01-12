Return-Path: <linux-kernel+bounces-24387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6EC82BBE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DAF1F2358D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F25C91E;
	Fri, 12 Jan 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0J3FRSe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDD5B1E4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705045166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Btb+Nkd76BScAGZ0KbC8/OACivjuRPWvQS8QIQEFPk=;
	b=a0J3FRSe675u2tVw2KHhbrbvolhot3EgSbdJQdZBmb5KUZE2V7xIbFXUolQCL1z+ttbY8J
	R279AqNs/g24vbcezv6PafO0dHH5Y0/OzBgpNrFsw7CoISW4I3ZKTC7A+iMsvugsoPXF9B
	aiIi94H/ufYjuVOCrxhyammwuU0wosY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-ra18yDtFPuWOXEsLCnJq3Q-1; Fri, 12 Jan 2024 02:39:24 -0500
X-MC-Unique: ra18yDtFPuWOXEsLCnJq3Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2bc6645267so178670866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705045163; x=1705649963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Btb+Nkd76BScAGZ0KbC8/OACivjuRPWvQS8QIQEFPk=;
        b=oRXphyhVGA49drCokiB58q433bgGtwR/5y0mwP9/cbOBa+hYa9JXnYQEDy0nVVjBT1
         oEEZLP76a8cxo73hcefX78fJGqU6tbueASTFqd+nzKE2dGM6LNGr8owJw7k+jIvKOCsI
         7Sr0YUUyA+gPHUmBkuNO3PSntMyvCGqf31pLwUSLnm2A1p2lJ6mgfTrrcVViH5UDpAck
         2C7yVfttT+lzpRXxE2PAOMlVCxBdpUvgvuOi9trt7kE3j5H6s2gNogZpYoRlPT7wiQZQ
         Pm3yh06KMNUfAWJ6gtg+HAkYQL9vPr2R5yaEocWNJRiydq20nurd2nzbXTd9ve2TiT1i
         70AQ==
X-Gm-Message-State: AOJu0YwDR60QCobwc+Q3ZHtm8NED8CY8gtCi5uzDdGOmPsPV9md+0bNi
	8iU0GDSxEWjCB/dhGQ047igcFnkCjHpYDGjHBHjrXtR8Lh53LkHzql1tLuFLIr+PvzZJzNUuIeh
	aTgknnATsmQGAR3AYMq2CAgBKoLCFEysn
X-Received: by 2002:a17:906:801:b0:a23:3298:25fe with SMTP id e1-20020a170906080100b00a23329825femr274259ejd.232.1705045163348;
        Thu, 11 Jan 2024 23:39:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMjnqy/B1vYtx9+feQ1GimNFS8D/HrxDCf8Hs3NZLd+HxDzrQaAJkIjGhq6ccyoWkgbGmbYw==
X-Received: by 2002:a17:906:801:b0:a23:3298:25fe with SMTP id e1-20020a170906080100b00a23329825femr274246ejd.232.1705045163089;
        Thu, 11 Jan 2024 23:39:23 -0800 (PST)
Received: from [192.168.0.182] (host-80-181-166-228.retail.telecomitalia.it. [80.181.166.228])
        by smtp.gmail.com with ESMTPSA id bm19-20020a170906c05300b00a2362c5e3dbsm1478884ejb.151.2024.01.11.23.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 23:39:22 -0800 (PST)
Message-ID: <9ce7c466-ce9d-4673-b89a-d3244226dbde@redhat.com>
Date: Fri, 12 Jan 2024 08:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sched/stats: Fix rt/dl task's sched latency statistics
 error in sched_stat_wait tracepoint
To: Junwen Wu <wudaemon@163.com>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com
Cc: mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 laoar.shao@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com
References: <20240111150147.182937-1-wudaemon@163.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240111150147.182937-1-wudaemon@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 16:01, Junwen Wu wrote:
> The sched_stat_wait tracepoint is showing unreasonably long
> latencies for real-time tasks. For example:
> 
> sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]
> 
> This error happens when the rt task balances off the source CPU because
> the dequeue operation is not updating the sched_statistics. So, follow
> update_stats_wait_end_fair() and update the stats. Do the same for
> SCHED_DEADLINE.
> 
> Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
> Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched class")

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks
-- Daniel


