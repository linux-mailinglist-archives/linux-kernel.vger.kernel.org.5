Return-Path: <linux-kernel+bounces-108643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF02880DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADB22834F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908443C064;
	Wed, 20 Mar 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLZJSJL/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3683BBF2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924456; cv=none; b=SV6O87u+V5vjEAqyU+pR0jUoB6UZp5GGvTHcybapjgPAj+qKKABcEW+VguU2xJZwiv/xMBizKIcEpcnWkpX66d1e8TQps4Q6uOXRJllFTcI+N3CspU0SpkhMgMqB7CCQ6/dXTcoytZYL9bjH2vYOlxbBrj8KKGCP82+1ufrYFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924456; c=relaxed/simple;
	bh=YBVrj3LlbmgFn+2nUmXC60swRuScJqKfxHTTV6P9sDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlPKQs+Frec7ZX+o7471SoGf7bjnmBk0g+ysWlQbgrnS3aOXb6sAo8x/87OrYMz9ocrrtszVesI0Vf4baNNQ2s6HG+OuMLUdvSfdz5QErlC5KOf57n0uwTR1tKhZFheQ8lifc97+Wvs4xg00FpBBYMqFoEkUnIDitFfvGV71PR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLZJSJL/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710924454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFk7i7r/Rth0uc1ovX1/w3IsN+7Z5+mbDrMRpvOVhNM=;
	b=aLZJSJL/+MqwPyu3Lmi2IhilGxKPkVXp4xOmgmjsEQnELPYq2ufbDm/xqVh+/BdVvxKcQt
	RZhLQzYeBJQNaKZICG8qThr4eRDHV8nTfDtMz+ypZoV/+GPzAdTwlZ0J5corqiZwo5tjs+
	LnueiNCt+OoMrMyCk5sCj5qAmFSDYvg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-iyzdhYmPMSuJGahHdL-Mxg-1; Wed,
 20 Mar 2024 04:47:30 -0400
X-MC-Unique: iyzdhYmPMSuJGahHdL-Mxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 409D02806044;
	Wed, 20 Mar 2024 08:47:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AFA810E47;
	Wed, 20 Mar 2024 08:47:29 +0000 (UTC)
Date: Wed, 20 Mar 2024 16:47:22 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH 4/6] mm/mm_init.c: remove meaningless calculation of
 zone->managed_pages in free_area_init_core()
Message-ID: <ZfqimkC+L3M/3AYf@MiWiFi-R3L-srv>
References: <20240318142138.783350-1-bhe@redhat.com>
 <20240318142138.783350-5-bhe@redhat.com>
 <Zfm6gzhKUehLwM5-@kernel.org>
 <ZfqbygfNmFKpBCfR@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfqbygfNmFKpBCfR@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 03/20/24 at 04:18pm, Baoquan He wrote:
> On 03/19/24 at 06:17pm, Mike Rapoport wrote:
> > On Mon, Mar 18, 2024 at 10:21:36PM +0800, Baoquan He wrote:
> > > Currently, in free_area_init_core(), when initialize zone's field, a
> > > rough value is set to zone->managed_pages. That value is calculated by
> > > (zone->present_pages - memmap_pages).
> > > 
> > > In the meantime, add the value to nr_all_pages and nr_kernel_pages which
> > > represent all free pages of system (only low memory or including HIGHMEM
> > > memory separately). Both of them are gonna be used in
> > > alloc_large_system_hash().
> > > 
> > > However, the rough calculation and setting of zone->managed_pages is
> > > meaningless because
> > >   a) memmap pages are allocated on units of node in sparse_init() or
> > >      alloc_node_mem_map(pgdat); The simple (zone->present_pages -
> > >      memmap_pages) is too rough to make sense for zone;
> > >   b) the set zone->managed_pages will be zeroed out and reset with
> > >      acutal value in mem_init() via memblock_free_all(). Before the
> > >      resetting, no buddy allocation request is issued.
> > > 
> > > Here, remove the meaningless and complicated calculation of
> > > (zone->present_pages - memmap_pages), directly set zone->present_pages to
> > > zone->managed_pages. It will be adjusted in mem_init().
> > 
> > Do you mean "set zone->managed_pages to zone->present_pages"?
> 
> Hmm, maybe 'set zone->managed_pages as zone->present_pages'
>             or 
>            'assign zone->present_pages to zone->managed_pages'
> which is more precise.
> 
> Wwill update.
> 
> > 
> > I think we can just set zone->managed_pages to 0 in free_area_init_core().
> > Anyway it will be reset before the first use.

Rethink about this, it's better to set zone->managed_pages to 0 because
there isn't any page added to buddy. Will update.

> 
> Yeah, setting to 0 is also fine. I thougt of 0 ever. Considering
> zone->present_pages is closer value to actual zone->managed_pages
> than 0, and it may be needed in the future in some way before
> mem_init(). If no strong objection, I will keep the assigning
> 'zone->present_pages' to 'zone->managed_pages'.
> 
> Thanks again for careful reviewing.
> 


