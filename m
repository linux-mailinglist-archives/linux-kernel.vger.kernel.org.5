Return-Path: <linux-kernel+bounces-108574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE61880C69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA589B21231
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22F29CFD;
	Wed, 20 Mar 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RikP5jal"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E222313
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921186; cv=none; b=uNYQNOpvo1xBp6A7ce8lFkvY4hF29BkTchqH+ImhmaaE+HZBurP+e+KzTOBBWaWGI80i7qYAguGiHFDS10JHVAkpJKyTgMPw5SHfj3FUfaTrWzdxJP6t19m5U5t5HNywslsrjL6XjTWZZM+WpZOHX/Gpjvj3lT/kuM3odHfVyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921186; c=relaxed/simple;
	bh=iWv3UbxELsI0tthGfnSMTkPZqi9OTXEW5xAM+9p1v2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=getIXLcY+K5usiVjeKynhz/3MU5HpGiT03H+Vn27LMD2EEZ04EcwCAFXxalTY1Rn7i4QYtb2mUbIOBnLXohvED7nm/mcfYdSKe5vOO1w5fqc3BwWcFVsPatk4BumV4dSDwnt6IhskP+OtLSC1EQv71owHyIx9Ejv2Vdq6y7W9PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RikP5jal; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710921183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqiMQHqORmeDjYjtn7CCiO+1Zj4Lkm+sgSbsT1labdI=;
	b=RikP5jalDf2CGsFKb/RjPHJz51yuXMyArv6csH6fishEwKctZMLxhvgQdlVOULUZgDn0uP
	M79no1xS7FecL/JM+ejbV2HgOq91u1KPm9XssVH0aBlwDu4ELW/w+p54zR7LPdbka1Xp+Q
	ZtY3tJcKM3GUfsgNs+H8OXliUPdfV+8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-IpUFOGt-N_aQBzw5f2DQIQ-1; Wed,
 20 Mar 2024 03:53:00 -0400
X-MC-Unique: IpUFOGt-N_aQBzw5f2DQIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BEF5383CD69;
	Wed, 20 Mar 2024 07:53:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC8A91C060A6;
	Wed, 20 Mar 2024 07:52:59 +0000 (UTC)
Date: Wed, 20 Mar 2024 15:52:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH 2/6] x86: remove memblock_find_dma_reserve()
Message-ID: <ZfqV1IEo3+cf9f9I@MiWiFi-R3L-srv>
References: <20240318142138.783350-1-bhe@redhat.com>
 <20240318142138.783350-3-bhe@redhat.com>
 <Zfmz_1sbbvSWMj9C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfmz_1sbbvSWMj9C@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 03/19/24 at 05:49pm, Mike Rapoport wrote:
> Hi Baoquan,
> 
> On Mon, Mar 18, 2024 at 10:21:34PM +0800, Baoquan He wrote:
> > This is not needed any more.
> 
> I'd swap this and the first patch, so that the first patch would remove
> memblock_find_dma_reserve() and it's changelog will explain why it's not
> needed and then the second patch will simply drop unused set_dma_reserve()

Thanks, Mike.

My thought on the patch 1/2 splitting is:
patch 1 is removing all relevant codes in mm, including the usage of
dma_reserve in free_area_init_core() and exporting set_dma_reserve()
to any ARCH which want to subtract the dma_reserve from DMA zone.

Patch 2 purely remove the code in x86 ARCH about how to get dma_reserve.

Your suggestion is also good to me, I can rearrange the order and
repost.


