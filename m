Return-Path: <linux-kernel+bounces-136487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E589D4AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEDB283C07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853086AC2;
	Tue,  9 Apr 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEaJ+7fo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602B8626D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651496; cv=none; b=DC/N2AFdXwgdHvV9Cl7+9SQOldshKapKOC9v+CqgH7B+Jt6uLjXVBVQ4QxXp6JjINE04eWKL4aNbaf1wHlRvrMVaCC7r18KcWAmDuL3JBjoildNBn31qOzFviVgbggMfEQZygPWTBXA3+m4CEoFgbf9rnoLx37BB0GjW/6u0eg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651496; c=relaxed/simple;
	bh=+Zvyv60nCP6ay79oTSz8gUiQ+riYC2zZTyuewIqr/WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnFgp1JwNI5o9/jpbLF8i3C3yirVm2NbuVKXKSp9Tahxri9A+CiFQD0rhiPwwVPbOnPm+P9cW8NImF+CeeYh8sgr42Jy8ziT9RW69zGywvFxAtG8zoNR/mx4IpFH1VNSRlBJXD8FeNyBseahIrpBFJGDdsz3sg3PHINfh6XuAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEaJ+7fo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712651493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M1pp3vyhpR3kVM8srrD3+NzGH0CJnkNjMtWq1cGuQIo=;
	b=EEaJ+7foxDFtQl9Zf0vqkWkAZ/JE5aoEsJQEXKen/UCB+wXRiRDTYTAKthba8bgJsLKCXc
	G+nfonERQG3sbYKr023wrDvBqBavbU6LpBZ7Vyk4QrIXrTKREMeA+taDZu+Vqb7CZhwPs1
	e4FCvTLTBKp3klP5aF529z+SZYyjYTM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-uCyzcyt-PZaxG-mzbx-5Ig-1; Tue, 09 Apr 2024 04:31:31 -0400
X-MC-Unique: uCyzcyt-PZaxG-mzbx-5Ig-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78be8028b56so738753185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651491; x=1713256291;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1pp3vyhpR3kVM8srrD3+NzGH0CJnkNjMtWq1cGuQIo=;
        b=KPSqKbKU2X9YPd/82Fh1vW61dU1u3vtnUCSImevluOjEq9sDFaJ3Xs9Zy7cn2zY/7l
         2sxSO1fUt6MVF1pgRH9B3iXFpPqjvSMT4fZraygXbXgiZGPzNaq1+rls08GcPFJ6dz1e
         gHcEvyPGdOD9usu1mU/6WUsj9GXKo4rr5endrM/Skz5E6p14IqD5sBcI/3a3XiF7P10J
         +xekAQTb1VePsWPGLefL5orsQH2Xd7FW5sIksD4nUwETTrtQkpHsLD2ffAO6raOx+ewK
         HyXwjeKMdLHw5ZNzzvRIrxoj50ox49hKWpsTt7S/J2RpyzL0opcs2rBDNHorMxjb+Id0
         vo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyDSYjPHEUi3bxl30tavx5PX+SmJg6mt9mNjHcxBWqDAACCQg9uHMA4KwV7tYCqXKcUGlXUnisnT07vnT8Fhv9BEJy8Kql8kRq5yQS
X-Gm-Message-State: AOJu0YzayHRa8RXNVynSCwAZheJmpOeOmPHVN+XETN5gxxwmoq8UFTZD
	SQl9NdjwL5JQl7MhxLlDcaQTyZF/z9US3sWjaqTe3VH8WEnXxsJzSniJUFYOsDDEqoM7uawpHda
	hRVJN4tgdgmKz2uQkz5Ve7MlEJ4t1Xh8F+7zrHevKi8qElit+3cTb9VVUN1djUQ==
X-Received: by 2002:a05:620a:1197:b0:78d:6654:24e0 with SMTP id b23-20020a05620a119700b0078d665424e0mr5186467qkk.23.1712651491089;
        Tue, 09 Apr 2024 01:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX4o1GhfHM+Og7zpQoGJNNJNY+ihudofOlAnOAoYpyWrdGgnlcJ/Kx87c/VQzsRxLnpsQIGg==
X-Received: by 2002:a05:620a:1197:b0:78d:6654:24e0 with SMTP id b23-20020a05620a119700b0078d665424e0mr5186446qkk.23.1712651490775;
        Tue, 09 Apr 2024 01:31:30 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id k26-20020ae9f11a000000b0078a43996ab7sm3926608qkg.1.2024.04.09.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:31:30 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Kyle Meyer <kyle.meyer@hpe.com>, yury.norov@gmail.com,
 andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 linux-kernel@vger.kernel.org
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
 Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH 0/2] sched/topology: Optimize topology_span_sane()
In-Reply-To: <20240319185148.985729-1-kyle.meyer@hpe.com>
References: <20240319185148.985729-1-kyle.meyer@hpe.com>
Date: Tue, 09 Apr 2024 10:31:26 +0200
Message-ID: <xhsmhle5n9btt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/03/24 13:51, Kyle Meyer wrote:
> A soft lockup is being detected in build_sched_domains() on 32 socket
> Sapphire Rapids systems with 3840 processors.
>
> topology_span_sane(), called by build_sched_domains(), checks that each
> processor's non-NUMA scheduling domains are completely equal or
> completely disjoint. If a non-NUMA scheduling domain partially overlaps
> another, scheduling groups can break.
>
> This series adds for_each_cpu_from() as a generic cpumask macro to
> optimize topology_span_sane() by removing duplicate comparisons. The
> total number of comparisons is reduced from N * (N - 1) to
> N * (N - 1) / 2 (per non-NUMA scheduling domain level), decreasing the
> boot time by approximately 20 seconds and preventing the soft lockup on
> the mentioned systems.
>
> Kyle Meyer (2):
>   cpumask: Add for_each_cpu_from()
>   sched/topology: Optimize topology_span_sane()

I somehow never got 2/2, and it doesn't show up on lore.kernel.org
either. I can see it from Yury's reply and it looks OK to me, but you'll
have to resend it for maintainers to be able to pick it up.

>
>  include/linux/cpumask.h | 10 ++++++++++
>  kernel/sched/topology.c |  6 ++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> -- 
> 2.44.0


