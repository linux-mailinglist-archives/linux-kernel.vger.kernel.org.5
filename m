Return-Path: <linux-kernel+bounces-31336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FC832CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E216B24129
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962F54F82;
	Fri, 19 Jan 2024 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VFHtZH/B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83754F99;
	Fri, 19 Jan 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680241; cv=none; b=sqtnGhgKdqLX296rc2Fejr4MD57NK5ro0MQD6vuFpNvq1Nx0Dyl0zLkPIB3leMgviqVl6f/p16Rmk5Hyi2LcwHU9WDU33B4sDFxq5QsY0ZsFkT7zf80y/spjGk1m1GMq4FeE3K1iWFf2UBzDw2+qXLhQdt686M7XogsMG9CwBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680241; c=relaxed/simple;
	bh=coIAvRixLjBf9zPBZMTN1uD3GQStYEqNZAtBzDJljok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QASwL+wsF2z66rtZ1E75Y6eZr/Icswy5Ahx8Jt8g3T2mS8ON5+doLop2I5jD8q98uQ661f4MVGLraUXFO2Dyg6jRSX1nZ1ucneR7EfoYiNXpfiGfc5/y6BCJgH/joo7BAl/uO0XTzewmyCa+s2ymuAuoXbzPWbXDMQxU+HpfA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VFHtZH/B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iUKkw0LVdxxgGvR/w0sJNMBB9Yzkz0bi7KdkWfHGaSU=; b=VFHtZH/BxNE1NyNn4x8zlPw3V0
	otOF4mofoFIZwnsv/SadjNj1TGnGVM9jguNmYkeKpGxgVDPkD+e9xA+IMgbAZBG33gABKChGkIgv6
	qhltfbiV4KoaGiZVTuup+I7yJ4KNkFxSFK/2SUVo8TCBx+R5oWDUtMSng4Wqa/GMlvnbOhUWrPSTs
	OC58SYzYjCfwo1jHn3meOdt3udWclzhVa08eQ4/+aNaNFCU19QDndLnLzHZzWk+Iic2zu63uCCrT5
	4sSo6bWsB1HUCiKb/CJCngxuzUrunPZ3WkgLKgDpXmqE4d/lOC5ucC2+bttrZfn4lWx2Kja5kRhtG
	uyU0NpfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQrLV-00000005apa-3uB9;
	Fri, 19 Jan 2024 16:03:54 +0000
Date: Fri, 19 Jan 2024 16:03:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com,
	syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Fix iterating over an empty bio with
 bio_for_each_folio_all
Message-ID: <ZaqdaYzEm--W8mti@casper.infradead.org>
References: <20240116212959.3413014-1-willy@infradead.org>
 <170544262659.494117.14502342650352587808.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170544262659.494117.14502342650352587808.b4-ty@kernel.dk>

On Tue, Jan 16, 2024 at 03:03:46PM -0700, Jens Axboe wrote:
> 
> On Tue, 16 Jan 2024 21:29:59 +0000, Matthew Wilcox (Oracle) wrote:
> > If the bio contains no data, bio_first_folio() calls page_folio() on a
> > NULL pointer and oopses.  Move the test that we've reached the end of
> > the bio from bio_next_folio() to bio_first_folio().
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] block: Fix iterating over an empty bio with bio_for_each_folio_all
>       commit: 7bed6f3d08b7af27b7015da8dc3acf2b9c1f21d7

I see you added an unlikely(), and I'm not sure it's justified.
It's going to be true at the end of each iteration.  For a bio that
contains one bio_vec, it will be false once and true once.  It'd be like
writing a for loop as:

	for (i = 0; likely(i < n); i++) {
	}

which I've never seen us do.

I don't know that it's worth taking out, but I wouldn't've put it in.
I wouldn't be surprised to see benchmarks show it's a bad idea.

Could you at least _say_ when you're going to make that kind of change?
I wouldn't've noticed except that I got a merge conflict.

