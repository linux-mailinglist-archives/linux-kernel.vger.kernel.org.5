Return-Path: <linux-kernel+bounces-127241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCB89487E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046AF2836DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD93320A;
	Tue,  2 Apr 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="enPGhwQb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474610E4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712018058; cv=none; b=p4r3/4J0p8RWNobWMXyozhn2bPhsA4BEq5PV3+07C7CJNMGFbnX7BzNnjhAhDhPKiAFTotATYJeA0uOgRdhQ0FoneGpS7q1Bm2BusdgyHCSj3d91mmuck151J5b1s6tVWwopGQQExRLFwcHyCFk3ROKVkjiZ19Nkj67J/AyD0YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712018058; c=relaxed/simple;
	bh=RCW7qNqU3+fNH7VeWyWc6RMkRuVqMYUD+E+QsNcfcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHBjPNsaH9dB8fsqrh1ix6XlJGuzJs/lQgXPfqBkQPpnASiAep2R2P14uZHldSyvloT1OkjJc6Zl6aWQYjUJSwB3IIcpi+K4ipDTuzWAwlG8naJg+DuiFXJfdfRLhGaJCuB/ErXEqde6i0xoYWxqKGhpY9AeSG++4bdmR1Kp35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=enPGhwQb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2VP4oPUjG7+cTRXLUPxAk6kKBT7PPaJfZQ6oyGi5qls=; b=enPGhwQbk1NobKHJ5OrJH/ZeuY
	vCIcgJe0U0JiI91g+EeRXANEEO5IWX0j8FEELDZqpedtUjX2wL55gDQNiQz8uUaKkUNA2jxxg2DV6
	PR7JvfK0wPKH0upfsj9NmAokcEyKAjYOCayfXB8bSPH4rwygODWkchxKJfHu3/LjQmBd7TmaIh9CA
	7s+iybS/wOEMSbQIlr/+O6dadY7CW8IRk5k3zEBi5TPfx97qkzqtcz8hzaMxgBIUzW+YrKsBhmjiZ
	Y4FT707TIcGLlPU8Zs4OCZAawNlhJZqldabxF8MP3d4tb8QJTE2mYI3nqwxQ8OftbtjncQfW9Zmga
	9vW0vdYA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrS6I-00000001nlc-3ixt;
	Tue, 02 Apr 2024 00:34:06 +0000
Date: Tue, 2 Apr 2024 01:34:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, NeilBrown <neilb@suse.de>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in
 read_pages
Message-ID: <ZgtSfsRxXiTCkejS@casper.infradead.org>
References: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>

On Mon, Apr 01, 2024 at 04:17:34PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
> unproperly during the procedure of read_pages()->readahead_folio->folio_put.
> This is introduced by commit 9fd472af84ab ("mm: improve cleanup when
> ->readpages doesn't process all pages")'.

This patch is no less bullshit than the last time you posted it.
I explained why here:
https://lore.kernel.org/linux-mm/ZgQRtQ60mrvOUKXo@casper.infradead.org/


