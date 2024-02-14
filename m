Return-Path: <linux-kernel+bounces-64867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECECD854406
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D4F1C2282D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E3125AD;
	Wed, 14 Feb 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dKVupMZJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030F125AB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899365; cv=none; b=FTwiWPBl4T6oRYrA0qi/kpwTyNGe6hopT5NNHT1b81Yn3NosrXW4s6wT9oWO8F8SxsGZYwF+dppM83VXDLHXfY06zisEerW1iTceExNLURNZ8bH19pCQwePAbyQDrL6blGl9yt6GpGhFe7mH6KVHWWcnyrAiICLmP1Ifj+d1trQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899365; c=relaxed/simple;
	bh=lr1cpTq9SDjQGx44axcCjzlI0LjYViMDYTVhzqfBjd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsG02oN1XuZA9iWeFLO7QDKtfbh1DziH0qNuTckbBOdecr/LEjSFMAhwIQ5yGs2npUT7wnOhH59/w4OuOg8IWdwcjAit6Hd6Ih40/CyENzLvBdfKC2Pb91AMz5v71jUOeqxMFRklm5O6mXLck3IcSss1GzeuetSrDBmM8pIY8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dKVupMZJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kgB1w54Os+DFr02nZaUKpHD/K1vIgMJvD2Vwb8Vk+I8=; b=dKVupMZJPm90DTsuhbaWNd2YTP
	bhOj1aQ3k0oQ+9HOf/DwfNl+CRVRjmwneXcfbST1Lj91dCOYgZOcMYWIOrKCsI0PAQoLeB903l36z
	jJY+TjucUI2AekrDPtkIvKwgUu4AWCjajCth6Ndf0+VKw6fbn0G4iBcknrndwVA/VAWEkHy+mPOWQ
	AcOuPTzzknK6bADKTKiipBQ2q4A+6mneK1IGcnHTqzQiVvZpxTmD8Az1aZQSUkgkDOwj+iaUGkc6d
	E3psHePQTRGyykuVvYc4gaAqGDTQ9GNf5GCOI4fn8XPpvETlbg/917rokpfkRg7c7ZWGrU26jVCKx
	j7R0DWbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raAdo-0000000C9Ei-2Nne;
	Wed, 14 Feb 2024 08:29:16 +0000
Date: Wed, 14 Feb 2024 00:29:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <Zcx53N8lQjkpEu94@infradead.org>
References: <20240207072435.14182-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207072435.14182-1-saeed@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Chmining in late after a vacation last week, but I really do not
understand the discussion this cause.

Complex devices need diagnostics, and mlx5ctl and the (free software)
userspace tool provide that.  Given how it is a complex multi-subsystem
driver that exports at least RDMA, ethernet, nvme and virtio_blk
interfaces this functionality by definition can't fit into a single
subsystem.

So with my nvme co-maintainer hat on:

Acked-by: Christoph Hellwig <hch@lst.de>

to th concept (which is not a full code review!).

With my busy kernel contributor head on I have to voice my
dissatisfaction with the subsystem maintainer overreach that's causing
the troubles here.  I think all maintainers can and should voice the
opinions, be those technical or political, but trying to block a useful
feature without lots of precedence because it is vaguely related to the
subsystem is not helpful.  Note that this is absolutely not intended to
shut the discussion down - if we can find valid arguments why some of
this functionality should also be reported through a netdev API we
should continue that.  E.g. just because we have SCSI, NVMe or product
specific passthrough interface we still try to provide useful common
interface generically.


