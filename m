Return-Path: <linux-kernel+bounces-43872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE97841A41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799781F29D53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D13717D;
	Tue, 30 Jan 2024 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAsBdjQY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4236B11
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584289; cv=none; b=K+HT4yDQ8CXnFiK8eH/suYAA8RiWrEdA3LJ8SuFmZuI4C8GWR02XEa8xLxRuDPuofAlTRe0VFuze6cPQ30SWL/bfTQ3sgF9QA8hsK8Uzh4AfA7kd6/XUYKAL8grKXnqsq1C0JLEY95QF3Nb5dvv0NS+7HLknZj5bgtZNIG+Eeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584289; c=relaxed/simple;
	bh=7lCzqa23miHQT0SQxdA/QHucXVVy7h6ka44nXjfyoyU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QuEs/4LIgJ26VR+Kxh6AM1oi5Au8QjlvVjCDm+U1dLm7uHTjk+ulivrU/tTXTvCQuWi0EcHDt0NaZDHjLnoIxl+qWM18/scYmq3tc5whZ2QyjDkUiZVcUqMKzZtKTSNTM1ldRJZBPM3lMzqlm+kY8TWIHnbXu+gSb6R8yCLiTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAsBdjQY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8d8bb7628so88235ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706584287; x=1707189087; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2YWDa1CdHQ6mQIhukUOsTsYdhGWB7ZlEzy7qkLsrzM=;
        b=BAsBdjQYXcX5zquZses2hGfZEwWzUFz7MoK9eB77FVgL34o5RZl3mHSg7KPdukgcg6
         ctSfEsr1sk4QVoZ2e/df3UaMVt8QorZgztX7gnhM6UqVIyCHLcY1hOV3n6W7QSqNqM0I
         7uN3NdEmJlU8FuKmszGj//RHFPPJaPn2UatSIze8rJ20GVxOj9ZE+aC/aNz8PkgoHu4J
         NP4IeyQL9Eh09zeZ4RgIKlAGi24NXv07vLk7LJBPCQ+bHzdXV+/9t6DbuyLoIbMgRcfh
         0ONHXHLjHwX42vusCvq69GMtVQ9yOHgJ68aiWo7gZXGv5o7jwoBAja9aHe4eYDLn3yli
         qkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584287; x=1707189087;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2YWDa1CdHQ6mQIhukUOsTsYdhGWB7ZlEzy7qkLsrzM=;
        b=H74SHN8AgcSWbeSbXYPickx6BRPREMP8iigktyKagz0VM1hhxCywfnS6pMZCz0A0Oj
         sZlAC12DFFRIAACPbnUovu8GYsUqnkuo/6P/ObYAn/IYf450j8Pm1OJpQYwXp9LxudJH
         KE2nrWEiElB9vMKssastw5+wnC9I9kGudSvKwRjCmFS43u1CKOWvluOGDktwrk3/M2ps
         U3ctuGFXxHmt6x6OxdS9Xjad5cUWmeqMCp5DJffvAgmDqbXOmP0Bi8TbBw9Snndfm6Qm
         o5fvzg65DZAcmXe9uSagV8rUBONN8vb0/R+xzIBkTMTkRFNYsUtGz9UCu6me5yvWzCD2
         sUqg==
X-Gm-Message-State: AOJu0Yy7ryOrbZOqaucgwk90SFP7DJIW4wvB/YEUwdoRs4Zu4xLONSds
	P7VXJ60aUKzos2JYKGcL7iyK0iGk5KnKdZg5JSBR8xKKW97ZNrehXpLhGFQ2PA==
X-Google-Smtp-Source: AGHT+IG0XRJFTtE6va2vH6K0aa4X9yGtlYIGybzCZtc3f1ObkeiUulYAsH2aEVwdSjDz8tqzKm7g9g==
X-Received: by 2002:a17:903:234b:b0:1d6:ebf1:f8cf with SMTP id c11-20020a170903234b00b001d6ebf1f8cfmr138308plh.0.1706584287284;
        Mon, 29 Jan 2024 19:11:27 -0800 (PST)
Received: from [2620:0:1008:15:bf6f:6465:5fd1:5897] ([2620:0:1008:15:bf6f:6465:5fd1:5897])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001d74dd065e5sm6031212plr.136.2024.01.29.19.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:11:26 -0800 (PST)
Date: Mon, 29 Jan 2024 19:11:23 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Zheng Yejian <zhengyejian1@huawei.com>
cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove parameter 'flags' in
 create_kmalloc_caches()
In-Reply-To: <20240130014107.1262373-1-zhengyejian1@huawei.com>
Message-ID: <388197b3-6193-96ce-8e8d-261c8481eff3@google.com>
References: <20240130014107.1262373-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 30 Jan 2024, Zheng Yejian wrote:

> After commit 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"),
> parameter 'flags' is only passed as 0 in create_kmalloc_caches(), and
> then it is only passed to new_kmalloc_cache().
> 
> So we can change parameter 'flags' to be a local variable with
> initial value 0 in new_kmalloc_cache() and remove parameter 'flags'
> in create_kmalloc_caches(). Also make new_kmalloc_cache() static
> due to it is only used in mm/slab_common.c.
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>

