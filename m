Return-Path: <linux-kernel+bounces-120863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A288DFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917B328FB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739B130A50;
	Wed, 27 Mar 2024 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rF1gxh5g"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F813F445
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541421; cv=none; b=tBlUuo73LhYi6mpv/mrZPwbDwAb2oMtUexdwQ1vZKcPOLSDitGUVloSx3OVal5XU3pnCdcYLFsTXkQGVpAS5AgKLZzFW1gkVZ1BTc4jpEtjt8HwA2mTCkB5owb45pGogc3ERTi2HlIU0IM+PKS0Nda3U+MM1vH+VZzAAzutRUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541421; c=relaxed/simple;
	bh=T2jvMXTe1SOLfEanpTmPTf4uFqXpkG3tnrz2T0d3HLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5q8tvxGnC2Br9vAYjOuSttEkUkmGpUuizpp10ZvpDCvGyduC+jtyubuLx66Tx+FDLZDX/fsjPZ1FAQ5sEPEUKnsWYhM4csNahlW1RyspI8uy87KogvAd8AyDhhc/ixtgcvwkooUUzkbewEB4xiEESRED+Rl6BrkQHPB603b3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rF1gxh5g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WStYxaWmdcAd0EHdZG7F8WzduUaXJH+PLdTWTFJ9Was=; b=rF1gxh5geKNCFhMxyw1MJ6ZYRi
	XSYU32Cju0TUtaZK/8AUtAXqCfpPT5DCMbGbZY6EuHenzsaWIwA7vRY6OWkWpEjRpp4g5eFBY+l5p
	k+U678aYExmKK+QIJ+fUZGMHZuvMkGTFuDsA19ladr17nHufjRzQVSy1MwJ+Iv3o4XB5wvBmrcUDd
	e/6wCnJuLUiKH4lDwbnBioVxD3tFXOd7UQUiVA6Yu1ChvQ5rmT7ZY24LJH0dv7sVptOogsRs2mYhv
	z6IdmbsABmiFpvXjZ0JaOtzwViy9Hud8tjb6+V4Y5QScWR9tLBPcTIJsRYas2NrWDdUp+VxcWQ+ng
	UXuwnJKg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpS6Z-00000003nvt-482Q;
	Wed, 27 Mar 2024 12:10:08 +0000
Date: Wed, 27 Mar 2024 12:10:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: get the folio's refcnt before clear PG_lru in
 folio_isolate_lru
Message-ID: <ZgQMn_-GHfcWtScR@casper.infradead.org>
References: <20240327075516.1367097-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075516.1367097-1-zhaoyang.huang@unisoc.com>

On Wed, Mar 27, 2024 at 03:55:16PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Bellowing race happens when the caller of folio_isolate_lru rely on the
> refcnt of page cache. Moving folio_get ahead of folio_test_clear_lru to
> make it more robust.

No, as explained to you multiple times before.

