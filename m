Return-Path: <linux-kernel+bounces-52083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 282868493F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE326B20A88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672710A01;
	Mon,  5 Feb 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3JZABWrG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C6101DE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115281; cv=none; b=lR8qpa8uYE5QelM2cBi2ieX7LilDv8M7DglSoEFju5JhJmQAQUqNinXN9/ii/DMxhgJDJHxfDNJMbuxxjEL9SnnRB9hkR3uLJreY8L/AO9/lzm8/ZQKipuQdzY62Pquf5dGzb8ZoqWE2A4BJgXYRchQ3Qn6gUWDLM7hHGC0eyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115281; c=relaxed/simple;
	bh=PnKWUET1t60GF3aKpSL/bNdz7zeFqMLxuzSnVC2jaZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfQCKgs7+Gx8GTNRSQ0+m4XPdoY3BiqBpH6t1bVP3YNyOi4UrIJvGpRyW0E1PyaRcd/3xKRPBYoMqMnWppf3VbHN67x6TbRyM9FKbJVgG0ctXHILhp6G4nadLSYaP3NOnO/l+sxwDxurdZm8ZyQ1AHXUP6Om7lV1o4rUr3zzX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3JZABWrG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PQWATaimqXPAaWg3aqQ9FiRo8g+KlIoSB6+RgRp0/hQ=; b=3JZABWrGtFXxV0XDjksetMnpWz
	m2sPYaedTweJ/ZH4j1WAeXcaZh8kGpFvrIQaU9kfYjzQYgCGDI+96Mmnpzt29acinnIEw/QHRsxDk
	sp+3axukGX5c3WYrpJVC3FOHo4h5dQUMeRh+2Hl31ng1EVy1fqrXpVDECwror++S97U4vmzslbR68
	OJixHsrzEG2yXwiEg2l5edJuqstACWbXIn8czKN/yt/U7wF3NxRRl3yeLwTpwtN+exBoiEiyodSuc
	VMIY90f40+KBF81OEtF0qVdrD/QnOwgoWFjdbb8Zr6fohk2SG8tMlPFsaKxFsCJWL2QLlWZPbsO6s
	sOUqbqlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWsfJ-00000002BZX-2mJa;
	Mon, 05 Feb 2024 06:41:13 +0000
Date: Sun, 4 Feb 2024 22:41:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Add a scan area of VA only once
Message-ID: <ZcCDCQdja-rjtIZ3@infradead.org>
References: <20240202190628.47806-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202190628.47806-1-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +		 * Only scan the relevant parts containing pointers to other objects

Please avoid the overly long line.

The rest looks fine.

> +		 * to avoid false negatives.

