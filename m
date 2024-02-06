Return-Path: <linux-kernel+bounces-55004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8B84B624
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018AA1F24265
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72AA130AE2;
	Tue,  6 Feb 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZQfftgF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDE12E1D8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225374; cv=none; b=SCqARHgSACz6njrXOeQb1kIRKRUvbvW6U/GzZhV90vqxUIqYfO6eVUh0gSOOJ5yqtfgWI7N3x65PS5YIRXFWsia8NPGGx/2dFR4pttU5D/XHuBf3h4bEduMT6usx6f1tInlhFO6K0Y/h0IZ328DMn6Z5PT8Vfk8WgRj4hE8LOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225374; c=relaxed/simple;
	bh=xGhAyef5gKcUopmqF9ZdFqc26uV/9dtvY7xqf78/dD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5qeBEUKeH8Yw9tYBI5manwr3P+cfOs1NY1w751ZddFxXwBy2sLxOfCG4Os5wBIynRl0JS/YAkybQ5GA68JKeTOxTtzD42lg8RJice5kmMnoCNNdbKjwL4dOh7Xf+UaRXHojr2UtnfrLGYLDEYh/m0f7RD7hTllrBci0v3FvS0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZQfftgF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707225372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUQdnsHyyYvM7E51Qc7vCziWG4asdOEfT7PonQth7rQ=;
	b=TZQfftgFDrkL6ajsROdZVwiM82INLIVKEF4w/2E2fMB+NM4yGYpJGAoUVhdvxF6vPLjC3p
	aTwSxnb2Fz7V63aTkVe8SWtAGEUrHAuAjkOV+WNzcR3RYNxWoaXFS7YObAGg2y4/YzN5ry
	VFy8ar+WVgvao0q3+oXfBy4icYnVuVk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-RqG7-gudMnGnRvzW1wzmdw-1; Tue, 06 Feb 2024 08:16:11 -0500
X-MC-Unique: RqG7-gudMnGnRvzW1wzmdw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68c4f4411f8so11131156d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225370; x=1707830170;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUQdnsHyyYvM7E51Qc7vCziWG4asdOEfT7PonQth7rQ=;
        b=O2ALXNSuDT1/Fy9cKamB3sDNlywL9+X8T0hNLQu2sA2su4WpvCr5haOBSH4OLRzCOk
         Tno7X30VowG2bSkLKOvteJY3y9Lkl3z8FdHxrcN9LFy0nmIiUVbC6btwHaSGaAkDhfzW
         rzgEVdcvo2486d6HwFdNfGYXlwmLJAVPb2LJbPx6iH79InkFiTxD4zgoOUSUhigt6Vyo
         38pYOZmDYm4/LLaLZ0DVohrX64fCPJJJ0VXzGWOQLnPMVRWaIQqRXiQTpEnnbW1pEsyD
         5KbRlUULwjF+7R4ytveJSJ1k8HhuZaP1jdx9QltOVdYaZA2YWFO3NMxwg3lSEnnylbMK
         kJkQ==
X-Gm-Message-State: AOJu0YwViK/DBRf/JLO79EV201lbbAptE45nEiQFq7tnTRuL5/1G9hu9
	ZuAVbbAyyZROTEdNuUTnX/nusPtPJ6tIEDSNqFxNDi4ox0621lUZDU2feK5fTwFVkVZwCz4Yl09
	mxiKU8ufHrBi7WUhmi1nzClbYAlldA8QSRQyU3qS8wPjcT3duPytd3AnfExj7qA==
X-Received: by 2002:a0c:fb07:0:b0:68c:a6c3:d399 with SMTP id c7-20020a0cfb07000000b0068ca6c3d399mr7041773qvp.30.1707225370562;
        Tue, 06 Feb 2024 05:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG/uCHRwCDcljiNfLYp477ptasflFo7TvsntAQejc1jOaxrIupMSTwDFENSbqAGLZD2FsxEA==
X-Received: by 2002:a0c:fb07:0:b0:68c:a6c3:d399 with SMTP id c7-20020a0cfb07000000b0068ca6c3d399mr7041750qvp.30.1707225370304;
        Tue, 06 Feb 2024 05:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0xcTMAlbTklvW27rZ4wpDjfAHnPvakairxcnP+fCNRXfrf5TwsaFV1vFTlmQQXl+oyiL6MKnb15fow3QrKSBeQevg0WH7d5gHCFmE4zlACaNvLrglAmGLO09l16QNALKYks3lqdQItuf+k3hhGx0yvSaU4LiYFN4jmWNl2GeRiG1Ky/5s8Fan92KexZZKwZZsws+TGvjS01Mtx/ULzeker/ZeLZSe759suLTRnk24zZRJEyR2dY0pXk806Dmc09nh8RSf7/FC0N9OVLavQPEbqXmDyZy0VtrC1eb5TSHo3Vsu+gbgHVQaNZbPU669ugoQ8sB70qY0cm6SxY/OjsKQhKnAiUHwmcJvQxHqPSFBTdw60J4N
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id nd23-20020a056214421700b0068ca9ea78cbsm995749qvb.21.2024.02.06.05.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:16:09 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
In-Reply-To: <20240206024633.GD17602@ranerica-svr.sc.intel.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240206024633.GD17602@ranerica-svr.sc.intel.com>
Date: Tue, 06 Feb 2024 14:16:06 +0100
Message-ID: <xhsmheddphgx5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 05/02/24 18:46, Ricardo Neri wrote:
> On Fri, Feb 02, 2024 at 03:27:32PM +0100, Valentin Schneider wrote:
>>
>> Subject nit: the prefix should be sched/topology
>>
>> On 01/02/24 19:54, alexs@kernel.org wrote:
>> > From: Alex Shi <alexs@kernel.org>
>> >
>> > The description of SD_CLUSTER is missing. Add it.
>> >
>> > Signed-off-by: Alex Shi <alexs@kernel.org>
>> > To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> > To: Valentin Schneider <vschneid@redhat.com>
>> > To: Vincent Guittot <vincent.guittot@linaro.org>
>> > To: Juri Lelli <juri.lelli@redhat.com>
>> > To: Peter Zijlstra <peterz@infradead.org>
>> > To: Ingo Molnar <mingo@redhat.com>
>> > ---
>> >  kernel/sched/topology.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> > index 10d1391e7416..8b45f16a1890 100644
>> > --- a/kernel/sched/topology.c
>> > +++ b/kernel/sched/topology.c
>> > @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>> >   * function:
>> >   *
>> >   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
>> > + *   SD_CLUSTER             - describes CPU Cluster topologies
>>
>> So I know this is the naming we've gone for the "Cluster" naming, but this
>> comment isn't really explaining anything.
>>
>> include/linux/sched/sd_flags.h has a bit more info already:
>>  * Domain members share CPU cluster (LLC tags or L2 cache)
>
> I also thought of this, but I didn't want to suggest to repeat in topolog.c
> what is described in sd_flags.h.
>
> Maybe it is better to remove the descriptions of all flags here and instead
> direct the reader to sd_flags.h?
>

Yeah I agree on less duplication.

>>
>> I had to go through a bit of git history to remember what the CLUSTER thing
>> was about, how about this:
>>
>> * SD_CLUSTER             - describes shared shared caches, cache tags or busses
>
> AFAIK, this describes a subset of CPUs in the package that share a
> resource, likely L2 cache.
>
>> * SD_SHARE_PKG_RESOURCES - describes shared LLC cache
>>
>> And looking at this it would make sense to:
>>   rename SD_CLUSTER into SD_SHARE_PKG_RESOURCES
>
> but not all CPUs in the package share the resource

But SD_CLUSTER never expands beyond the package, right?

Regardless, my main point is that having both SD_CLUSTER and
SD_SHARE_PKG_RESOURCES is a source of confusion (at the very least for
myself), and given SD_SHARE_PKG_RESOURCES is really used to mean "shares
LLC" (see update_top_cache_domain()), we could make that flag more explicit
and lift some ambiguity with SD_CLUSTER.

>
>>   rename SD_SHARE_PKG_RESOURCES into SD_SHARE_LLC
>> but that's another topic...
>>


