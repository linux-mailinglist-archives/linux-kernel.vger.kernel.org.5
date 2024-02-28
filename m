Return-Path: <linux-kernel+bounces-85557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A986B7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E1D1F21E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025E71ED5;
	Wed, 28 Feb 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jz8yh18x"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D971EB3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146245; cv=none; b=Gli1a/y4dd3rTh0epKKWVbrU7sQ62gDJGbQb9zPJay08NFCxtP6XPI5QHsr69s0E5VJj/JS+R9Sl+MMe9qxEEBvvuNM40YGsESK+dSN8qztM1xeX7SzxKbcbLYet1svrprfwVmnJIRI7pfxCaUyiEkItCrOzEwZwPzSYCpW1H6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146245; c=relaxed/simple;
	bh=uCNk9xZssjz88SO3HgKmg/6pNPAs4j9cZ22qRa/0FUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2pvOsw2ysYKOG7M9GrlmBlXXMCSqFojO7RESjOFcNtMv0bf700Z1ciC69AK63SPqTfp8etwyuktJshSUy5zj3TNi7tEdvqcg6cDiruw2j26ZgL/SnK5AuxfsytAG0Q4XpPXtY5hHC2C2iWDr7jftOD7FtUvODZ6TqJgIry8C8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jz8yh18x; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a3ebad2aso523695e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709146243; x=1709751043; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzx4HJfLML4JQaG7fROeK+a0qZNaeaLXumU4hcnOH5U=;
        b=Jz8yh18xpafJEnQQlffADR/JWLGW90uMfpbJK/V8qPEbJflGfIZ8msGjAds/C4hFOZ
         hu6ikyWwAojPdrBeIjOhh4i2zzH3AQz8QXm36XuNgKBQ+P432WmD2Rf2DV9NyoxSidun
         vaNUfc9ElXoq92QN5dQzELXifRLmvt6zoDSFLNbSAmOVJKHHZ4S6sRGAFutDRiDDHoXV
         DW2Zq24Q+IfvGra77G9IDtsqHL84elno7uuxeoVc80LeynNO/Fzzo9SKCQUrETulwEN7
         vwpxgWGTrq5yoNBIq5sxL/RXKAIRVbZb9YUEFBJOBCYPuoIz43jnL7FxY5zmjcC44LdF
         5wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146243; x=1709751043;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzx4HJfLML4JQaG7fROeK+a0qZNaeaLXumU4hcnOH5U=;
        b=TWooc5+kadGfG2YgOxfb99W0fJWyIB+4wiZZOpf+Zlkqa/BFtHTRMwwn5hjRilYKa6
         GazFphy5HTfuwGqUL6755DTtnacIVze7vSjU9kb4LUfX9z0RMi2roqmBSBGazsJ7okWv
         Egdd7XkyXFx8qMvMMfxHgiON3A3rRJHOlqRZy7hGOHZhTPWq+8GiUWtn79kjBRt9PcEh
         bcK4Oxa+RjP0kcN5Rrq4yX9N3lGLb1U/+qpPCNdZqXpmOIKYkt+LixeA2rXWA07qXyOw
         0JZ86Hjim+CfRWKslG4RQHvA3oBNbTtHw/7cRqQ88SGMHiJXVj4rM9P+cpXzTXsIdyU6
         RyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz7Zi5k49TVhSWdYiSmk3ykl1gZVtplQ0dyy1LkElEHTASu9VZ6CvagtrlA/TOj5nyGDDFYay0Q9gOmdp0lNV5fXoQU9CCYMnaqR98
X-Gm-Message-State: AOJu0YxMSwK4A2DmnXEidLsDagqQWja7LGkQNavossG22OnTSLYlplBu
	a1Pbt/oBfr3V5tpead7haxTu1+ulg8rnp2vQttezBUrf36gtCb08oG6HRK0wNw==
X-Google-Smtp-Source: AGHT+IG2H+YrKQ5fSobiXEyDPQnan1RYKk8JYEWcjEAIGT6HGiPQq/QjDtUbrthdPJ6TZz1M9/GBOQ==
X-Received: by 2002:a05:600c:468c:b0:410:85ab:67f3 with SMTP id p12-20020a05600c468c00b0041085ab67f3mr81884wmo.21.1709146242594;
        Wed, 28 Feb 2024 10:50:42 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:e9d0:d027:ced7:cf52])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b00412aff7874esm2890521wms.48.2024.02.28.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:50:41 -0800 (PST)
Date: Wed, 28 Feb 2024 19:50:36 +0100
From: Marco Elver <elver@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
	carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Chris Kennelly <ckennelly@google.com>, dvyukov@google.com
Subject: Re: [PATCH 00/30] RSEQ node id and mm concurrency id extensions
Message-ID: <Zd-AfDcQ-r04CMXk@elver.google.com>
References: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122203932.231377-1-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Mathieu, all,

On Tue, Nov 22, 2022 at 03:39PM -0500, Mathieu Desnoyers wrote:
> Extend the rseq ABI to expose NUMA node ID, mm_cid, and mm_numa_cid
> fields.
> 
> The NUMA node ID field allows implementing a faster getcpu(2) in libc.
> 
> The per-memory-map concurrency id (mm_cid) [1] allows ideal scaling
> (down or up) of user-space per-cpu data structures. The concurrency ids
> allocated within a memory map are tracked by the scheduler, which takes
> into account the number of concurrently running threads, thus implicitly
> considering the number of threads, the cpu affinity, the cpusets
> applying to those threads, and the number of logical cores on the
> system.
> 
> The NUMA-aware concurrency id (mm_numa_cid) is similar to the mm_cid,
> except that it keeps track of the NUMA node ids with which each cid has
> been associated. On NUMA systems, when a NUMA-aware concurrency ID is
> observed by user-space to be associated with a NUMA node, it is
> guaranteed to never change NUMA node unless a kernel-level NUMA
> configuration change happens. This is useful for NUMA-aware per-cpu data
> structures running in environments where a process or a set of processes
> belonging to cpuset are pinned to a set of cores which belong to a
> subset of the system's NUMA nodes.
[...]

Just out of curiosity: is anyone aware of any libraries that have
started using CIDs? It looks like the cost of CID assignment is always
paid (even though it should be small), I'm trying to understand if after
1.5 years there are common libraries that have started using it and what
their exact usecase is.

I'm aware that TCMalloc was the inspiration for vCPUs [1], then renamed to
CIDs, but am wondering if other users are out there.

Thanks,
-- Marco

[1] https://lore.kernel.org/lkml/20220218210633.23345-10-mathieu.desnoyers@efficios.com/

