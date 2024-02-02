Return-Path: <linux-kernel+bounces-49950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 699098471E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76380B228AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE8145333;
	Fri,  2 Feb 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMllNi6U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80B140771
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884060; cv=none; b=XsE7Ntl7CpVI7ovpuHUNtiWBlb9m6lIXc4T/jMtGInELGyfCq7haiRG9/9Q/7/QkWB4oBWdk/X5pfRKKztIbDVgslqTaXoh8f7YX5iZjQAWm36gG1EvVYgeHFyqK2oGnkScoSR2M0X5aklNj8MAsUgKh4tpsboO6KMHT0La0Bco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884060; c=relaxed/simple;
	bh=yDcL2KfbFxtb7xCOjAMFq0PIgN0wUaLrWlq2fUyJpmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XomHvCkdnfuHPDZpODaO7ZF9k3IYgyx2B7EPhvBo9YcvbkPP8YI967pE8IKpgJqhdRtpUI1bpNVXlkAGdBXQNOD950ig6li/qzhKhzrKR2aQU38YcWdkYgh+LSy16yxLtzeoswQGaQjzeld3c3NzDODVsj8pbMHsKBlyBxVet2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMllNi6U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706884058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eEGsZLjkUv6BEa0yzFDQ5+acv6od8EAIcMWVbjc/LKg=;
	b=XMllNi6U1FQefCVhW2o/N/UhlUvJAbOFFOtC9V8q8GSkICpx/4mibFbCiSuHwgplMgwMUg
	FlUJ18YBnatxJFor3fq3tqVDzP+aMZO4+yjTrHwRE3oRrXVYK6lx5nx483bXSZ4ABBtadW
	au5wwK5LbPkYYrbicbMHCs6spcL3ssM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Xu2tNwd6N0aJxrewnS1WpA-1; Fri, 02 Feb 2024 09:27:36 -0500
X-MC-Unique: Xu2tNwd6N0aJxrewnS1WpA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-218f0b7f3c0so1456009fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884056; x=1707488856;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEGsZLjkUv6BEa0yzFDQ5+acv6od8EAIcMWVbjc/LKg=;
        b=dwuRFhW9igxve8kF4VJFVZ0oo0hDv+svIiaponvnv3v+cD305OEIXpWGo4GziKS8xF
         bkO8m8Sdigg3ynDwfNFTW3SAcnPgsgzGHaMdsYwV/qSczt60zmUYRenWsMdXTStm1GRK
         DVRxsNT5fUUAbsAI4GLxb7SBkQVqDLMP/ITGbsGSGau7G4h0PF1nEmirJ1HYZ7+wgGxx
         x434WWuSQxWftuSKjDHYoLCM2vsw3L8Pl8PegdXQ7TRnNpzCqmJGpqhAcaFL7L+ggSTQ
         e43bHOcXGsUjYWTpeYInpKpgaiLe52sEO9N+iDu01wT06s2Ci4AbLRVVwX82zCP98Niw
         P8LA==
X-Gm-Message-State: AOJu0YyvHL+L63FFSAkY2Osq8aaY5Gw+XVV2t4KgVsI3kSyr/2eIxNPq
	omxPp3HkeCNCZqFO2aYy39wuqL/o6Czn5NgMNN1mmMkhOcHGDcFeU034NZZgYo5ZTK+S4AAEbpU
	dhtKTgzV42aX9yx+iXlhufs6VB4ii4Y1MKFbBhl/uvH5pwzS82WYsp7llyd7hiA==
X-Received: by 2002:a05:6870:524a:b0:218:de3a:6bf8 with SMTP id o10-20020a056870524a00b00218de3a6bf8mr2097336oai.39.1706884055928;
        Fri, 02 Feb 2024 06:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHboOWjbd29BLhToyF46nbjvz3OH9vOSYCx5rbMx952T2U5nD6tvxp/y97tFcOEmOag7tFCeg==
X-Received: by 2002:a05:6870:524a:b0:218:de3a:6bf8 with SMTP id o10-20020a056870524a00b00218de3a6bf8mr2097319oai.39.1706884055631;
        Fri, 02 Feb 2024 06:27:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfWd7lPuV2gumd4tF4Py3EAMixN+hqB6FgmVUcINl3Lp5e3wR3s+cyahmUZK2hwa2y+LtsZie9K5ujmK0q/tH/4kF4PlAtiobwl344J0PyvrodlaNDmbIBK9h9JFO0qFHQW52gddq4CAouu9Y9z7Y9nRG3+2W+1VYY8gPCdcJKdtqkd7eNNNidtnXvJUdFjhnP8sSFMovY/WKXOfVh1mQopEytPjo/ukRm6mMHNxtvIwy6wSrGWCT0N6Pk9sl0Na8BaU1waAj6Sa0P5x9ALtlbNJeNJqjI7zm4Ux8gs4E3ZnhBrOJbyBuVrdGAIT8umQ4iMUWudIfyLS86XBMSWVZ3SG7jcQGrY5cGA+9siHanmthMh6tS2DQn7RwMaPNM5ZeOS/Am/YIeG/7JJ3qpdO3ma0lui2rdEv26uONO
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id z24-20020ac875d8000000b0042c05008905sm496655qtq.77.2024.02.02.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:27:35 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, linux-kernel@vger.kernel.org,
 ricardo.neri-calderon@linux.intel.com, sshegde@linux.ibm.com
Cc: Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
In-Reply-To: <20240201115447.522627-1-alexs@kernel.org>
References: <20240201115447.522627-1-alexs@kernel.org>
Date: Fri, 02 Feb 2024 15:27:32 +0100
Message-ID: <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Subject nit: the prefix should be sched/topology

On 01/02/24 19:54, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>
> The description of SD_CLUSTER is missing. Add it.
>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/topology.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..8b45f16a1890 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>   * function:
>   *
>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> + *   SD_CLUSTER             - describes CPU Cluster topologies

So I know this is the naming we've gone for the "Cluster" naming, but this
comment isn't really explaining anything.

include/linux/sched/sd_flags.h has a bit more info already:
 * Domain members share CPU cluster (LLC tags or L2 cache)

I had to go through a bit of git history to remember what the CLUSTER thing
was about, how about this:

* SD_CLUSTER             - describes shared shared caches, cache tags or busses
* SD_SHARE_PKG_RESOURCES - describes shared LLC cache

And looking at this it would make sense to:
  rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES
  rename SD_SHARE_PKG_RESOURCES into SD_SHARE_LLC
but that's another topic...

>   *   SD_SHARE_PKG_RESOURCES - describes shared caches
>   *   SD_NUMA                - describes NUMA topologies
>   *
> --
> 2.43.0


