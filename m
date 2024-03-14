Return-Path: <linux-kernel+bounces-103567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3149887C135
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37591F219EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD667351B;
	Thu, 14 Mar 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRuU1cRZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89FF73515
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433523; cv=none; b=PREUeGClAaxmi9pAukTYf6TQ7uMFFrUqFP5P3HLuAliWtZJVHAMC9LejIcNQ91IlArX05Ww/SPTPFeq8EEPQbgrGfa+1v9IZZA6s54XW+C4IhQAhJfiSi2Trg2nv3bn5zB43s0BVEnR60Y4Ba3dla9GA/fQvGbtkLAYcF2fRfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433523; c=relaxed/simple;
	bh=IywCOUaveC1KjSCNVC6eAwIEHLUXsNaG65RDMgK7M7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tn5UHUeFE1jjBFYr7mP6JgT+6X+eaZctXEC2Qs8KTDlEVMLKv1769+lrVVbDXAUWRXeIZsKPD6iM5mABk8JDf+tS4V9GuJnEbzL1bWE3aWng4YHPwzPw8m/0ytsdZN+PvcCQZaMcpuuIIrC95cn28+RPFN5VJ20w7qlq7DPj6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRuU1cRZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710433520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ieIQDmWwT09ptX/upWFSc4Na5Oy9iPn4qQemFyAinnQ=;
	b=MRuU1cRZh/+Mu3RAtnoWyzS3AupSRhMDRhBlOOe6fCKn/aNIZ45xR4+7oi5fedk9vVmg6O
	YxHTiL2eSrOUOkY7Kaf+R1vnFoOqMim4kKYvkM6Qqg35kpcJcn0x/eQW7UJyE4O6nS/pok
	eNXYfDl5J/erSsd9JWeYhxA9x7sVLQ4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-R8cYr2glOvaPJW5kCnwUIw-1; Thu, 14 Mar 2024 12:25:19 -0400
X-MC-Unique: R8cYr2glOvaPJW5kCnwUIw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-789dfb04239so36866485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710433519; x=1711038319;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieIQDmWwT09ptX/upWFSc4Na5Oy9iPn4qQemFyAinnQ=;
        b=EwMcp1aMeigHhoyRy7JkpmHxV3DtKAI2XvQTUp3PgpLgU0CDKDwj74+w2Q/lOfW+lI
         8MXL/1y9zgCDMsXAOaMZoJxMC8RaL9Wnttrc954Rv64Y/uuo1/8UXzcw5pdR1EOfwxSQ
         a6CEVL6b6/6pq2RuN/KSj9Tf7fEZFyb1y3sYR+0li/m/V3McFIiDbuFSoxMg0ZzmRv5c
         OMo15URsdcsMRKK2FJY4vuQGrywEJ4IjjS7N9ZmH3MbldiutrmP7ThcNL69RP/yVnz0s
         uXH997u93C+hTjUii0nhk+z618CBKKzcUiOcyQjTmDnId1A4kbTJ7uesym+IaGzG2mwy
         eC8w==
X-Forwarded-Encrypted: i=1; AJvYcCV+7b39JxRE4Ia9VG96wLf7oQoCYOIw+OasWVsjBOdyBLIT3vJUgc+GBW8mWPH0Dfc1EARtmhGXThiSSajNBkmhGATR562ha2KlANCq
X-Gm-Message-State: AOJu0YyvXoNBNSVTenFr9lyEURtSIKiCHX5HIUElfqAScVTcwn2YmjgT
	jDNZkRf3NcgaqsX/oQkL8RyYqx52J4UUaznVv9l7bkP+zqQC6DO4tct2/0QXIfWr+Y3ntBmdWU/
	GzxG485kUdhEuEqc9h0a2iVpk29CPN0ROZTiDpumvwZGp13O9hLjtuuEXeuDQNA==
X-Received: by 2002:a05:620a:1363:b0:789:d823:ef8c with SMTP id d3-20020a05620a136300b00789d823ef8cmr1085770qkl.53.1710433518740;
        Thu, 14 Mar 2024 09:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw/9rPcx6WQhsKMwZwAcAcPc31vsE059Glzrm0vr3a8BQNMYJTa41TItW9dRGrWMCmkydL4A==
X-Received: by 2002:a05:620a:1363:b0:789:d823:ef8c with SMTP id d3-20020a05620a136300b00789d823ef8cmr1085742qkl.53.1710433518379;
        Thu, 14 Mar 2024 09:25:18 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id i20-20020ae9ee14000000b007883184574esm988413qkg.98.2024.03.14.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:25:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Daniil Dulov <d.dulov@aladdin.ru>, Ingo Molnar <mingo@redhat.com>
Cc: Daniil Dulov <d.dulov@aladdin.ru>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] sched/topology: Check return value of zalloc_cpumask_var()
In-Reply-To: <20240307132340.13192-1-d.dulov@aladdin.ru>
References: <20240307132340.13192-1-d.dulov@aladdin.ru>
Date: Thu, 14 Mar 2024 17:25:14 +0100
Message-ID: <xhsmhle6kdbmd.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/03/24 16:23, Daniil Dulov wrote:
> zalloc_cpumask_var() returns false if mask was not allocated.
> So, let's check if cpu masks are allocated successfully.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 8d5dc5126bb2 ("sched/topology: Small cleanup")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  kernel/sched/topology.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..2df98ffdfe16 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2600,9 +2600,10 @@ int __init sched_init_domains(const struct cpumask *cpu_map)
>  {
>       int err;
>
> -	zalloc_cpumask_var(&sched_domains_tmpmask, GFP_KERNEL);
> -	zalloc_cpumask_var(&sched_domains_tmpmask2, GFP_KERNEL);
> -	zalloc_cpumask_var(&fallback_doms, GFP_KERNEL);
> +	if (!zalloc_cpumask_var(&sched_domains_tmpmask, GFP_KERNEL) ||
> +	    !zalloc_cpumask_var(&sched_domains_tmpmask2, GFP_KERNEL) ||
> +	    !zalloc_cpumask_var(&fallback_doms, GFP_KERNEL))
> +		return -ENOMEM;

Despite returning an int, sched_init_domains()' return value is ignored by
sched_init_smp()

The int return was added in 2006 by:
  51888ca25a03 ("[PATCH] sched_domain: handle kmalloc failure")
but it looks like sched_init_smp() never checked it.

Now, allocation failures this early in init really isn't good and more
things are bound to explode, but I suppose you could add a return value
check in sched_init_smp() and WARN on anything non-zero. Without
sched_domain's, we'll still have the boot CPU doing useful work.

>
>       arch_update_cpu_topology();
>       asym_cpu_capacity_scan();
> --
> 2.25.1


