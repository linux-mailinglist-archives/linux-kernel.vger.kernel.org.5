Return-Path: <linux-kernel+bounces-73946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D785CDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0015E283C77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A0CF9FD;
	Wed, 21 Feb 2024 02:20:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74279C6;
	Wed, 21 Feb 2024 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482018; cv=none; b=ZvRMS/2Ld1xvs9jvwphQethgSHKRbs7Ev0kodsU33RfNZLNhSMy3ZIQa2B3Q3tvXlTqHB2Dp9EL6tVUGSzKDVwQk/zjY/8pUDkiM1YyyEWPJqIt9vmSDIBnO1yZCPGj4zFHEV5fM6cY5dZsyisLRsjfrkFLCpRcjqmuSgJdkVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482018; c=relaxed/simple;
	bh=EyOscyrB9L+KcSmf262hDy8n/KnQJ8E+Ww/wGwrHIxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2nC9EIOvmbbBXAVJpgJbAUWltHf4alkpLkzzwMxTqdqRFqiUppm6HVCiUKky1Bq35e24ZUri2nNnpTFhxXg+dJG15SYXnh5CFGTZ+yJyI7cNsYUC6tW8UgvXAwo7SqiBqaUWLWWD1yBoc4Vep+gu+ENYsYnPYhE7viUk2CxXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A91C433F1;
	Wed, 21 Feb 2024 02:20:16 +0000 (UTC)
Date: Tue, 20 Feb 2024 21:22:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
Message-ID: <20240220212202.59ddc123@gandalf.local.home>
In-Reply-To: <fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
References: <20240105013607.2868-1-cuibixuan@vivo.com>
	<fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 09:44:32 +0800
Bixuan Cui <cuibixuan@vivo.com> wrote:

> ping~
>=20

It's up to the memory management folks to decide on this.

-- Steve


> =E5=9C=A8 2024/1/5 9:36, Bixuan Cui =E5=86=99=E9=81=93:
> > When the system memory is low, kswapd reclaims the memory. The key steps
> > of memory reclamation include
> > 1.shrink_lruvec
> >    * shrink_active_list, moves folios from the active LRU to the inacti=
ve LRU
> >    * shrink_inactive_list, shrink lru from inactive LRU list
> > 2.shrink_slab
> >    * shrinker->count_objects(), calculates the freeable memory
> >    * shrinker->scan_objects(), reclaims the slab memory
> >=20
> > The existing tracers in the vmscan are as follows:
> >=20
> > --do_try_to_free_pages
> > --shrink_zones
> > --trace_mm_vmscan_node_reclaim_begin (tracer)
> > --shrink_node
> > --shrink_node_memcgs
> >    --trace_mm_vmscan_memcg_shrink_begin (tracer)
> >    --shrink_lruvec
> >      --shrink_list
> >        --shrink_active_list
> > 	  --trace_mm_vmscan_lru_shrink_active (tracer)
> >        --shrink_inactive_list
> > 	  --trace_mm_vmscan_lru_shrink_inactive (tracer)
> >      --shrink_active_list
> >    --shrink_slab
> >      --do_shrink_slab
> >      --shrinker->count_objects()
> >      --trace_mm_shrink_slab_start (tracer)
> >      --shrinker->scan_objects()
> >      --trace_mm_shrink_slab_end (tracer)
> >    --trace_mm_vmscan_memcg_shrink_end (tracer)
> > --trace_mm_vmscan_node_reclaim_end (tracer)
> >=20
> > If we get the duration and quantity of shrink lru and slab,
> > then we can measure the memory recycling, as follows
> >=20
> > Measuring memory reclamation with bpf:
> >    LRU FILE:
> > 	CPU COMM 	ShrinkActive(us) ShrinkInactive(us)  Reclaim(page)
> > 	7   kswapd0	 	26		51		32
> > 	7   kswapd0		52		47		13
> >    SLAB:
> > 	CPU COMM 		OBJ_NAME		Count_Dur(us) Freeable(page) Scan_Dur(us) Reclaim=
(page)
> > 	 1  kswapd0		super_cache_scan.cfi_jt     2		    341		   3225		128
> > 	 7  kswapd0		super_cache_scan.cfi_jt     0		    2247	   8524		1024
> > 	 7  kswapd0	        super_cache_scan.cfi_jt     2367	    0		   0		0
> >=20
> > For this, add the new tracer to shrink_active_list/shrink_inactive_list
> > and shrinker->count_objects().
> >=20
> > Changes:
> > v6: * Add Reviewed-by from Steven Rostedt.
> > v5: * Use 'DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template' to
> > replace 'RACE_EVENT(mm_vmscan_lru_shrink_inactive/active_start'
> >      * Add the explanation for adding new shrink lru events into 'mm: v=
mscan: add new event to trace shrink lru'
> > v4: Add Reviewed-by and Changlog to every patch.
> > v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in t=
he trace event.
> > v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at t=
he same time to fix build error.
> >=20
> > cuibixuan (2):
> >    mm: shrinker: add new event to trace shrink count
> >    mm: vmscan: add new event to trace shrink lru
> >=20
> >   include/trace/events/vmscan.h | 80 ++++++++++++++++++++++++++++++++++-
> >   mm/shrinker.c                 |  4 ++
> >   mm/vmscan.c                   | 11 +++--
> >   3 files changed, 90 insertions(+), 5 deletions(-)
> >  =20


