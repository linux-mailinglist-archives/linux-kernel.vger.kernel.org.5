Return-Path: <linux-kernel+bounces-131576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5818989A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816AB2846F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3DC129A99;
	Thu,  4 Apr 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyAUxtnE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089D1C14
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240065; cv=none; b=QLqcxLI43qEMeeSRJwg44RyXjx0lAMNK9pWi62yUehNDy9x6yZVgiBVr4g2xWDMSiaL+4OCydOMFVaoyPDN4B1WMe8wKf8jTZ2eqG5t5ATXI78xsAJGjU0xK9uT3VlWQGkudwZlFqnmhE8hTQPS9Y5A6/B5cBDjz5tQW1dvkga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240065; c=relaxed/simple;
	bh=M5cKSgIktruIPlmfo2M4VwRJUWCSGqh1YHcsOA1luPM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uz9UOSgK1VU5cKa+jEfl0RPZt/jJEBiQnzJmmGkiGb9SAm1HwIWY4wCkpfi//qSNElRPmvLFouEz60iMs83pc23dJPHOVKO+3Ag5AaxWTkiCsCkcqilYez0+dE/bvYewtUYpvfbPQcYMk3sk5WS7MSSLsTzpvjGP7hOItOyNLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyAUxtnE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712240062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ptd7fVXwM8iorXoyMAIOxNI8I0XxkLrDM0twBrkDu44=;
	b=HyAUxtnELeU2sWnr+56SHshEUUbm9oWd1d4R8DfOo9G+9B91Fvw+eTIkt0/tUGwu5fCLt7
	LxtIgnV3npsm6jL1Hd389wQHuPHg6h+RaSaawCAIoo4TkD/DLbt2YN8F/ADfXSsJD3E178
	lxmMjQsfbizFh+1Y4TMRyZ1+Bfmm/WM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-v92L5T_TOj-6fMhIC_fWzA-1; Thu, 04 Apr 2024 10:14:21 -0400
X-MC-Unique: v92L5T_TOj-6fMhIC_fWzA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34370ba4105so590857f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 07:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712240060; x=1712844860;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptd7fVXwM8iorXoyMAIOxNI8I0XxkLrDM0twBrkDu44=;
        b=VevXWRi5r6rY2LJWtOyW2fNBO+8kbnDPrlqD/eQIgSSFl1fnDE5izA5YdUo+dOKqEL
         l+neKNVyLPjtWV1FZkCzbz600UBMexA2/uT/C9FFxiL1scPOmtO9AK1aWtpj9DompmPT
         Wh90MjctOlclNjN2eth+CVwf4k4QzrgoYA/cJlnO81+UuRFZtYRe64iLk12wpvMOkRxn
         m9/T65Mr+YKEFU3NDP+wvKk2Jqvwadq3mk6K+qsG0HKLAQZah4Io6lpPZ+4N/ujPyg8C
         OplSsEpiSJoj0ak5+9ARXuO44+sZk026pjTci1+GN1pwT3QNOgDtzRUiuE+GKJ5PdyQc
         xNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVReYdzgcFwP1RQANJkDM3+YFW9PrCbO40TN4koIOh+J/Rfzzp2hVZzcfb+qKFhIM9ZhqIZDhbh7sx6mP5wvFB81lyAbHoKOiWVNAQ8
X-Gm-Message-State: AOJu0Yy2fQ6OdLlFJt+tm7NrCgTPuGQl8Ii54yhWytmlgx9egS6I7W1h
	MQupOe2d+PARKzhLjZySQEFfQP8FdhWQ4CSFznnVLpSDd/jJmeIlO6tB7hxiR0W6q+DfWANE2JQ
	viNIhR79OAUAz9MbcUW+HgJxaIfy9Ckcv/i+Mf/Br26HmN8uHHQqTLmtQ4pxKdw==
X-Received: by 2002:a5d:5451:0:b0:343:8026:1180 with SMTP id w17-20020a5d5451000000b0034380261180mr2349310wrv.4.1712240059806;
        Thu, 04 Apr 2024 07:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwpBDR7805QXJg7IA/g4KxO9VQlvmx8d0MZnCbT+O7PvsHwMpri+5HFHTI30p2vEtFSZ8rQA==
X-Received: by 2002:a5d:5451:0:b0:343:8026:1180 with SMTP id w17-20020a5d5451000000b0034380261180mr2349293wrv.4.1712240059473;
        Thu, 04 Apr 2024 07:14:19 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0034353b9c26bsm10255716wrb.9.2024.04.04.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 07:14:18 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Vitalii Bursov <vitaly@bursov.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org, Vitalii
 Bursov <vitaly@bursov.com>
Subject: Re: [PATCH v3 1/3] sched/fair: allow disabling
 sched_balance_newidle with sched_relax_domain_level
In-Reply-To: <e97fd467bbe1d7168bbd73b7c9d182f46bf47a90.1712147341.git.vitaly@bursov.com>
References: <cover.1712147341.git.vitaly@bursov.com>
 <e97fd467bbe1d7168bbd73b7c9d182f46bf47a90.1712147341.git.vitaly@bursov.com>
Date: Thu, 04 Apr 2024 16:14:18 +0200
Message-ID: <xhsmh5xwxb4g5.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/04/24 16:28, Vitalii Bursov wrote:
> Change relax_domain_level checks so that it would be possible
> to include or exclude all domains from newidle balancing.
>
> This matches the behavior described in the documentation:
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
>
> "2" enables levels 0 and 1, level_max excludes the last (level_max)
> level, and level_max+1 includes all levels.
>
> Fixes: 9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on cpuset domain relax")

Not that it matters too much, but wasn't the behaviour the same back then?
i.e.

        if (request < sd->level)
                sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);

So if relax_domain_level=0 we wouldn't clear the flags on e.g. SMT
(level=0)

AFAICT the docs & the code have always been misaligned:

  4d5f35533fb9 ("sched, cpuset: customize sched domains, docs") [2008]
  1d3504fcf560 ("sched, cpuset: customize sched domains, core") [2008]

History nitpicking aside, I think this makes sense, but existing users are
going to get a surprise...


