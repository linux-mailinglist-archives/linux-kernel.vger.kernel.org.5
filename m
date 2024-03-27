Return-Path: <linux-kernel+bounces-121438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900D588E7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290D31F36739
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8E137742;
	Wed, 27 Mar 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="02ZwANKB"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6373136E35
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549761; cv=none; b=TB8KRm4dYpAr+AsfwsZfvLJbZjYdqRuNSUC98PKj30pUe80jnDOIrUZjBVw3HqZQtQXU7ennw2OOqbIKRSJ2kF4gd3CArpu0mvg99w23sy1PVBsIa0rQFamDIoLzNivBncgFr2/41vOUPrWHg7EXIoVyJmAm/f8BRoXUkf9YhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549761; c=relaxed/simple;
	bh=PBQlmfRXw+C2/GPTCK5OFB0LP80OtagUw+30P4geKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcP5fIfA/j4lbVMH0LPjmEYzd34Ap9hs9eV/OrjXxqexHlAhxOQW5eDy53K1cIUUNoFiWruNKUEoCLZdVhlihdgX2jV27UXByJBL/Vtbm8wmpJO32UArF8/cN2tuPV33tdVSVsuhuR+uXmRIAf6rOOSEvKYtCnNWXHt5hGbjShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=02ZwANKB; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c393b5f0e3so3285809b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711549758; x=1712154558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AX2k+WxbCH6W0Cg5+nLJLICZuKMNPkboTga9aWIYEyc=;
        b=02ZwANKBl2I2ZR+GfggQ55X4yNNOrcbKMeM4LFTzfWpmITii4ug3zvWbcpqnyETIU4
         QOjc9rkQQ2t4r+nP94PGYZg0Wj9hHpuq4YTLZcl9KZBJntnPT7tyZLkh5l/CBk8rRjUy
         FpxRdgfhK/Ml4yszGbPalf1yOaBYl8AxO+0jfxUgyPP+TLTEzI0qTsZdCRkXjdCjlpEI
         fQHiXs7ZOMZ/nIx27AmXFqKv0KBuhhMaja/3uyw5BqJVIFro9od3IjmopSQTtQntiubs
         tdA+6pL9epQlmpHpQ2ddRSdnUlkJ1+bWaG3J1mgo08zCwW76g4g7prbtD7llCsx5lEk4
         PgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711549758; x=1712154558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX2k+WxbCH6W0Cg5+nLJLICZuKMNPkboTga9aWIYEyc=;
        b=M4sA2gvNv92Jpw+/j5GxcQHt4RzubnH7bpXyJ0Stcz1QWMHi8jhAJBU8P5eLZ/keCw
         lU45Q28k/KrtM99htUOPrFHIyC2N6b5u0wS28wPbMiYvLi3JsiCouYlgKUnPceb0F5KH
         OZp68hw2Ba0BjKGhxeRTQ0snMlu6E+IJ0pnOVle3qUfnD22Ci4aJEZ5X2cCP1C0qvpNW
         JjSfR7QDQYRsTdlBQrbfD9KIA7w33vjD6OK7EMsXAFXtQZtCdGLJ/vHKzZwF3gSsO0Kd
         l0CN+WpcKsj2b41h/a1oXrq4qIcpvdBjN1shmy/478OeP4iaQWCUACBrjSa6pq+Oyuw9
         i5AA==
X-Forwarded-Encrypted: i=1; AJvYcCX+yo3wdK8Qo9JNl7HZ4taQP+uFegycbw9C2RIfNu15dxzEpCXPZB1fI09D5c53JKE8/vUEtH1yV4aAYKeK2Od+6N/P83TaEsJqpFwQ
X-Gm-Message-State: AOJu0YwC/M8uLiXrj+4rYPH5O9PBdJVHNGwWUtMr0ICuCxxjjc/tuLcJ
	06k+GXhaCiafyNbvSo4fdxL76wOCXUF1q7skvE+8pWmR6lySYpGUUUDhVs4HS0I=
X-Google-Smtp-Source: AGHT+IG6j5njfE+KNAPPcFNUQHYRSgSqtx3Os1NLv6Ea1jUvkvE6vMMZ9aTkCDkVaRIxyde0vafigQ==
X-Received: by 2002:a05:6808:318:b0:3c3:d556:5d1c with SMTP id i24-20020a056808031800b003c3d5565d1cmr69399oie.54.1711549757861;
        Wed, 27 Mar 2024 07:29:17 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ha9-20020a05622a2b0900b0042ebbc1196fsm1058700qtb.87.2024.03.27.07.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:29:17 -0700 (PDT)
Date: Wed, 27 Mar 2024 10:29:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20240327142916.GD229434@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <81b1d642-2ec0-49f5-89fc-19a3828419ff@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b1d642-2ec0-49f5-89fc-19a3828419ff@suse.cz>

On Wed, Mar 27, 2024 at 10:30:30AM +0100, Vlastimil Babka wrote:
> On 3/20/24 7:02 PM, Johannes Weiner wrote:
> > V4:
> > - fixed !pcp_order_allowed() case in free_unref_folios()
> > - reworded the patch 0 changelog a bit for the git log
> > - rebased to mm-everything-2024-03-19-23-01
> > - runtime-tested again with various CONFIG_DEBUG_FOOs enabled
> > 
> > ---
> > 
> > The page allocator's mobility grouping is intended to keep unmovable
> > pages separate from reclaimable/compactable ones to allow on-demand
> > defragmentation for higher-order allocations and huge pages.
> > 
> > Currently, there are several places where accidental type mixing
> > occurs: an allocation asks for a page of a certain migratetype and
> > receives another. This ruins pageblocks for compaction, which in turn
> > makes allocating huge pages more expensive and less reliable.
> > 
> > The series addresses those causes. The last patch adds type checks on
> > all freelist movements to prevent new violations being introduced.
> > 
> > The benefits can be seen in a mixed workload that stresses the machine
> > with a memcache-type workload and a kernel build job while
> > periodically attempting to allocate batches of THP. The following data
> > is aggregated over 50 consecutive defconfig builds:
> 
> Great stuff. What would you say to the following on top?
> 
> ----8<----
> From 84f8a6d3a9e34c7ed8b438c3152d56e359a4ffb4 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 27 Mar 2024 10:19:47 +0100
> Subject: [PATCH] mm: page_alloc: change move_freepages() to
>  __move_freepages_block()
> 
> The function is now supposed to be called only on a single pageblock and
> checks start_pfn and end_pfn accordingly. Rename it to make this more
> obvious and drop the end_pfn parameter which can be determined trivially
> and none of the callers use it for anything else.
> 
> Also make the (now internal) end_pfn exclusive, which is more common.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Nice, that's better.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

