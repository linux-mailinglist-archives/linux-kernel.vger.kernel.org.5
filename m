Return-Path: <linux-kernel+bounces-159548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAEC8B301A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0A91C21BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083C13A41B;
	Fri, 26 Apr 2024 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ap5js1Vf"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C92F2F;
	Fri, 26 Apr 2024 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111987; cv=none; b=Xm7Cm1Tt/SKiYq0SdMJFL8O5ekLuMSA+ot3ozKIbMtmUlccaI0rEths7/tVZy2EJF14s2nFA8sbqrA/Vmgh4YGhfAoDPHBXGyXfEDOiLiFJ8Ze9+wnAeWALeqKQCO4kIYKiPHpj0j8LOqKVOuBEvcT25h5A5iNsTEd1XYm/FpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111987; c=relaxed/simple;
	bh=5fiEOv77X5MtDshrhcX7AT7EaPP4Cfvs3HIW1CqwulY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBcUE1zdUcIyPFIZqgBnPoYS0LoNgHcgCO32JVHzeOd9sVGs8LfdB+VkPgPriV5vz0YcLE1D3Uid+ZEjvdlB4j4yekJAtDitmty3q8iAYtyVcHJD/I9jqxGQYUp23Ystuov/uNnjq1z+r96VpMZLxZhwd5Gy8FZUUN9GWjixY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ap5js1Vf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bXuxQSeK9EhyAEvn7EIbpyezyLZhRR4SZi6ic3qEHyY=; b=ap5js1VfrH/g8G8XbPp1QnRWe8
	GNFhL6G/y7S24a7lmUv9ZiTH/d9yipZXWlqNYb1EHFWkmSZSYVaHFWC/ahi6krrscrNJK/cn4lX8E
	Nld7M7FYXExhEKNd0W79+2Xs6ZrW39Cxkg8I1xd8wSWNXvfIXSsNo5DX65kRktfXtXeFKiDiUcWK+
	3LPgxS0IqQFOofZx0z25LCImjqQ9EcXVdOMH0C/wnsITtdbiwC+1dFIX4nkjkokGOByPDJYX5+7S1
	UOgXFfR+uoWt/jrxEwvFom2hyMbJb+L+p/Kt0zIRKZd0uFmCCcva6RnHik0K6l97hnNVikigDoVXS
	6oEOd5Kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0EpV-0000000BGaD-0O3G;
	Fri, 26 Apr 2024 06:13:05 +0000
Date: Thu, 25 Apr 2024 23:13:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, djwong@kernel.org,
	chandan.babu@oracle.com, syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: Re: [Linux kernel bug] KASAN: slab-out-of-bounds Read in xlog_cksum
Message-ID: <ZitF8eqWEYECruXo@infradead.org>
References: <CAEkJfYO++C-pxyqzfoXFKEvmMQEnrgkQ2QcG6radAWJMqdXQCQ@mail.gmail.com>
 <ZipWt03PhXs2Yc84@infradead.org>
 <ZiphYrREkQvxkE-U@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiphYrREkQvxkE-U@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 25, 2024 at 09:57:54AM -0400, Brian Foster wrote:
> On Thu, Apr 25, 2024 at 06:12:23AM -0700, Christoph Hellwig wrote:
> > This triggers the workaround for really old xfsprogs putting in a
> > bogus h_size:
> > 
> > [   12.101992] XFS (loop0): invalid iclog size (0 bytes), using lsunit (65536 bytes)
> > 
> > but then calculates the log recovery buffer size based on the actual
> > on-disk h_size value.  The patch below open codes xlog_logrec_hblks and
> > fixes this particular reproducer.  But I wonder if we should limit the
> > workaround.  Brian, you don't happpen to remember how old xfsprogs had
> > to be to require your workaround (commit a70f9fe52daa8)?
> > 
> 
> No, but a little digging turns up xfsprogs commit 20fbd4593ff2 ("libxfs:
> format the log with valid log record headers"), which I think is what
> you're looking for..? That went in around v4.5 or so, so I suppose
> anything earlier than that is affected.

Thanks.  I was kinda hoping we could exclude v5 file systems from that
workaround, but it is needed way too recent for that.

Maybe we can specificly check for the wrongly hardcoded
XLOG_HEADER_CYCLE_SIZE instead of allowing any value?


