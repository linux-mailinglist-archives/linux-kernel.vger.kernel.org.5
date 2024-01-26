Return-Path: <linux-kernel+bounces-40401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAC083DF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A309282072
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71E200C9;
	Fri, 26 Jan 2024 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mizim/PE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C21EB55
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289080; cv=none; b=sCjwSHLR+suAVUKKYI/aUgwGj0nIEz7l8NSU4I3t1qu9E9X5hDlLwdc5EPnlV5Do9CFMRkD60MUSjSsLBf/Rp2r7mJB4RQCncab62LkOEB/xXtXQ4aRZYzIpWT33APa+G1Mm0p5hoVqq/1UzMmiCMROwgRh9fQNY+fIqLvdtvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289080; c=relaxed/simple;
	bh=0xnwHPO9EHtMCiD14Ip4N3gyftO2gndKycahftIn+aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMDGdoPIRjOkWa7xNpDOw33kv6GJs8AqwMW+nV/MSY541fL01mtYhSxv9UrqMjOFx52GuBngmTNCrbTX2hHd8hYxlE0KcRuajNQx8UtRQKmdAmU54xaDYlfzVl1QRSRuhWsL9BFrMf5Q7tqd9VLjLXpBMJ1YIjUkorhfFE83QPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mizim/PE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zrATycB01Oq4j4FeneTzWEUxpwPXiI/UPirn0ViraPQ=; b=Mizim/PETvaSoJxj3lKnEjL17x
	VbhXRSDHp3brWIJMgndN4g3NU9NLxulg1HAaz+ya9sIQAM1ehcFewCVHOLRd+smjh+QZfuNzLKtGo
	8yJ1oJ+zgO0DdVGl+nE+2pUwS7Q2mwzo0GLdq+596sRVw7XBnuylRET01oJHlapEFvNE83rPf/xbp
	qpIDvq8yv63maY3wyHJ0Vxrzrexy+F4jjuE8qpX0SFIyMwUIUdjalRJ56VB+fCwrVlk6uhe3b3L7P
	cctt3t1llmtnILpbYbtHUE7fs1BcFNzBsoafxaXwdjGPdwbu2mVnDS2V/UynFiIYqs5zJc8k5fyB5
	nr0WfXiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTPjW-0000000EHJ0-2Q1F;
	Fri, 26 Jan 2024 17:11:15 +0000
Date: Fri, 26 Jan 2024 17:11:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	Zijie Zhao <zzjas98@gmail.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [Linux Kernel Bug][mm/gup] 3 Warning Crashes: kmalloc bug in
 gup_test_ioctl, is_valid_gup_args, pin_user_pages_fast
Message-ID: <ZbPnsnwnVKvI1rQ4@casper.infradead.org>
References: <CALGdzuqqU1PJ3BZ2PRtCHXyrsZ2xtzk38abB0=K7V-kOCYgHfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALGdzuqqU1PJ3BZ2PRtCHXyrsZ2xtzk38abB0=K7V-kOCYgHfA@mail.gmail.com>

On Fri, Jan 26, 2024 at 11:04:53AM -0600, Chenyuan Yang wrote:
> Dear Developers for Linux Memory Management,
> 
> We encountered 3 warning crashes when testing the memory management
> with Syzkaller and our generated specifications:

These all come in through gup_test_ioctl().  It's my impression
that this is something you can enable to wreak havoc on your kernel
and it's not something which should ever be exposed to fuzzers.






