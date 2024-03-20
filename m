Return-Path: <linux-kernel+bounces-108932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4F881227
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D801C23313
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599140C14;
	Wed, 20 Mar 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hq1PYN/d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326E405CE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940480; cv=none; b=t12LtSvbnI4kUIiA7GtNipcRP/6ceeb7Tt4mCfk6c3R/cecM9nPB+BCNGT1TAZ/c5MawcawKe3NyFrxN0ScREZwJ4RbDbqVFek1p5BJ9De6+IZdFb4g2v+hOccroJrt6doA/+6l+DIrwQmeB8/pnTPfiQvkmeZxhQZaEc5VPZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940480; c=relaxed/simple;
	bh=Hc8+DRycej1M3IkI1Y6rVDgHKShwuRUDYDmDgh5gpug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhSqsudPdICsx6eu9khdcVJMTDbzAT31qjy8wbNxuPMeKl5HoAIrMgBeGDdB6Cj2mmiBcwOXAEyvr5ENFc8vixYCSH0DqS2xh1LRJcqaO63iXu8b1e9K9XXusMl6zkCm7QGjuiBzXJ87YlZkM7hGuG5V7WD0mCBA88+Y2fowuM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hq1PYN/d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710940478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ey4AOs9r3AsCA3ihOFSnMBOT4qisnZYJ1SOYp7h6Xf8=;
	b=hq1PYN/dZ2W4H/xUNWcsmj0fHa3NrAT/cMkz8Rwpr5+c6IschHkDpeXWfijOQHkloY2+su
	kEuiGeZ1MXeaEGM2m7taFXsrRaVsGVE1LoC+O+oKzvF7QlaNeQOoRHOl9LGTzrUqCA6AVm
	JNDZX63u8FFkh10pfmj2993QfSNtVDQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-BG7UvSxVMe6KR0RfzBnoGg-1; Wed, 20 Mar 2024 09:14:32 -0400
X-MC-Unique: BG7UvSxVMe6KR0RfzBnoGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0615868658;
	Wed, 20 Mar 2024 13:14:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E69040C6DB7;
	Wed, 20 Mar 2024 13:14:29 +0000 (UTC)
Date: Wed, 20 Mar 2024 21:14:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH 2/6] x86: remove memblock_find_dma_reserve()
Message-ID: <ZfrhGANU2gxE5+9c@MiWiFi-R3L-srv>
References: <20240318142138.783350-1-bhe@redhat.com>
 <20240318142138.783350-3-bhe@redhat.com>
 <Zfmz_1sbbvSWMj9C@kernel.org>
 <ZfqV1IEo3+cf9f9I@MiWiFi-R3L-srv>
 <ZfquM06LOZB4vddu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfquM06LOZB4vddu@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 03/20/24 at 11:36am, Mike Rapoport wrote:
> On Wed, Mar 20, 2024 at 03:52:52PM +0800, Baoquan He wrote:
> > On 03/19/24 at 05:49pm, Mike Rapoport wrote:
> > > Hi Baoquan,
> > > 
> > > On Mon, Mar 18, 2024 at 10:21:34PM +0800, Baoquan He wrote:
> > > > This is not needed any more.
> > > 
> > > I'd swap this and the first patch, so that the first patch would remove
> > > memblock_find_dma_reserve() and it's changelog will explain why it's not
> > > needed and then the second patch will simply drop unused set_dma_reserve()
> > 
> > Thanks, Mike.
> > 
> > My thought on the patch 1/2 splitting is:
> > patch 1 is removing all relevant codes in mm, including the usage of
> > dma_reserve in free_area_init_core() and exporting set_dma_reserve()
> > to any ARCH which want to subtract the dma_reserve from DMA zone.
> >
> > Patch 2 purely remove the code in x86 ARCH about how to get dma_reserve.
>  
> I think it's better first to remove the usage of set_dma_reserve() in x86
> and then clean up the unused code.

OK, firslty remove the only user, that sounds reasonable. Will change.
Thanks.


