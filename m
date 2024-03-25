Return-Path: <linux-kernel+bounces-117143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC0B88A7CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2377B1F69180
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BD155749;
	Mon, 25 Mar 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxRCf5ZX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F75155741
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373149; cv=none; b=Wqd82kyKwcNM6drECXQ9xG+UI0/aJ27W0Vj2EoHSft6zqg839EdFSthc4lMfwm81r64j39fXH8u6668/44Im+/uYk5LL7D+XEuNxGey7VtbPVLtBk9V2zs2kbhChikI2+/ZqGsw0YF9vOI2txfcV0mX+2BDn2jSDRcZRz+suUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373149; c=relaxed/simple;
	bh=buDSj9sxd7VyhoJ0ULHLFZhzaVyHLXeiYNtKSWCRDTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNe8wLNpBrBlGfcBTTTSwIDLNc5GRlZFRWBz8WbWPvpVMtDAdiexGDvQGnHA4KYGxC/Otj97U7sR1uASv3668U9EC4ruDTdcBcqaGdoP3AXopnpDLf4UWVQVA+Ctluxh6CLOlBCGnQsGxEoAQ+k/C/wihEjTskGcl6t//8TCF1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxRCf5ZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711373146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rsTyywAg29LCuVZyTkBA2UQHPKiAemlnTeHvMeLWIY=;
	b=KxRCf5ZXHYWMRxhiECp5gkENDw2ewHigLXkeSYj9TqYLjIuL7rKagfKzSaZTwz77vY2DKo
	uTpfw3Yo/I00M5sesElPdqBfaJzJQqrd2IlTP9rj8ipzd+BiSuVZ62R9QP6rR/zno5CZPX
	jdrjIhQ9UW/fT1yDM1spHEpSuDv1VCQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-rHvBGZYgM6qH6BXl-2fBvA-1; Mon, 25 Mar 2024 09:25:40 -0400
X-MC-Unique: rHvBGZYgM6qH6BXl-2fBvA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35251185A786;
	Mon, 25 Mar 2024 13:25:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F091492BC7;
	Mon, 25 Mar 2024 13:25:37 +0000 (UTC)
Date: Mon, 25 Mar 2024 21:25:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <ZgF7SVhskMZvVjGe@MiWiFi-R3L-srv>
References: <20240323141544.4150-1-urezki@gmail.com>
 <ZgC38GfEZYpYGUU9@infradead.org>
 <20240325093959.9453-B-hca@linux.ibm.com>
 <ZgFNVtp3EsJRaSN0@MiWiFi-R3L-srv>
 <20240325111650.16056-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325111650.16056-A-hca@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 03/25/24 at 12:16pm, Heiko Carstens wrote:
> On Mon, Mar 25, 2024 at 06:09:26PM +0800, Baoquan He wrote:
> > On 03/25/24 at 10:39am, Heiko Carstens wrote:
> > > On Sun, Mar 24, 2024 at 04:32:00PM -0700, Christoph Hellwig wrote:
> > > > On Sat, Mar 23, 2024 at 03:15:44PM +0100, Uladzislau Rezki (Sony) wrote:
> > ......snip
> > > > I guess this is ok as an urgend bandaid to get s390 booting again,
> > > > but calling find_vmap_area before the vmap area is initialized
> > > > seems an actual issue in the s390 mm init code.
> > > > 
> > > > Adding the s390 maintainers to see if they have and idea how this could
> > > > get fixed in a better way.
> > > 
> > > I'm going to push the patch below to the s390 git tree later. This is not a
> > > piece of art, but I wanted to avoid to externalize vmalloc's vmap_initialized,
> > > or come up with some s390 specific change_page_attr_alias_early() variant where
> > > sooner or later nobody remembers what "early" means.
> > > 
> > > So this seems to be "good enough".
> ...
> > > Add a slab_is_available() check to change_page_attr_alias() in order to
> > > avoid early calls into vmalloc code. slab_is_available() is not exactly
> > > what is needed, but there is currently no other way to tell if the vmalloc
> > > code is initialized or not, and there is no reason to expose
> > > e.g. vmap_initialized from vmalloc to achieve the same.
> > 
> > If so, I would rather add a vmalloc_is_available() to achieve the same.
> > The added code and the code comment definitely will confuse people and
> > make people to dig why.
> 
> So after having given this a bit more thought I think Uladzislau's patch is
> probably the best way to address this.
> 
> It seems to be better that the vmalloc code would just do the right thing,
> regardless how early it is called, instead of adding yet another
> subsystem_xyz_is_available() call.
> 
> Alternatively this could be addressed in s390 code with some sort of
> "early" calls, but as already stated, sooner or later nobody would remember
> what "early" means, and even if that would be remembered: would that
> restriction still be valid?

I agree, it's better to let vmalloc code do the thing right whether it's
early ot not with Uladzislau's patch.


