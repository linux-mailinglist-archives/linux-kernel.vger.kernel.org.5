Return-Path: <linux-kernel+bounces-75602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396985EBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF451F2371F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233C512D752;
	Wed, 21 Feb 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IKSCSYPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A6129A6C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554616; cv=none; b=FvWB9Ii14DhM/8WJLMlic0udQJTfbjI8VFe3zhz3Q7gdHwripb0UJw5+whrxm1plAq9lOlFNfI8eZOsG3+69g9RrYU6hlzuPmYH2yrRYHZ4KhcZaezOpn0HHZukWHH6Y6qWyavRyZ16TqsH3aNI+lxiDk59UiY6QDQvCa2bCtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554616; c=relaxed/simple;
	bh=GU7BcpQegK/Po/OrazsdN3umuvQx2U8gfB37BUk9oaM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eKjk9tHBEEUnRnQeVyj8Tw5Wp0fT7kaBq1cKjWhlV3Uf8dRDNaGxbTe5QRn2RlOHjpAFzWDC95dDLW1zxfgYqA7Hc5yxCl9XyXov2v0Db8mbNt3bLouxsgfAgizD8j9JjEPih3sZyeqjusenYD6gb4dqBHzft5VpTw1RVzeAwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IKSCSYPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91630C433F1;
	Wed, 21 Feb 2024 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708554613;
	bh=GU7BcpQegK/Po/OrazsdN3umuvQx2U8gfB37BUk9oaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKSCSYPdaXS3m4XBwaV529Y9WSat1k7rPJMU+j1OFvO+L2/5dr5bBeBIdjalBytpi
	 TkqTHqaYMLShAITeks9Zs4m3aAUQFs2azGSu9G7UWUjPGjTQOQ4qelDkCrDUlTn+Ly
	 SYmU/YF2+MdeLaGeAafH+HLapQtdF+8eAL/jrYDI=
Date: Wed, 21 Feb 2024 14:30:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH] mm, vmscan: Don't turn on cache_trim_mode at the
 highest scan priority
Message-Id: <20240221143013.d130b310a1306dfed0f6603a@linux-foundation.org>
In-Reply-To: <CAOUHufbGQ_ZFLhVSPG78pbMtvcfZ5v-E3oRdfZDP2mtHtkrPVg@mail.gmail.com>
References: <20240208061825.36640-1-byungchul@sk.com>
	<CAOUHufYUC-oWePfqbbmm15Ue9QLfPg1G2nhXn6iSX_A460O6Uw@mail.gmail.com>
	<20240216072434.GC32626@system.software.com>
	<CAOUHufbGQ_ZFLhVSPG78pbMtvcfZ5v-E3oRdfZDP2mtHtkrPVg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 17 Feb 2024 00:11:25 -0500 Yu Zhao <yuzhao@google.com> wrote:

> On Fri, Feb 16, 2024 at 2:24 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Fri, Feb 16, 2024 at 12:55:17AM -0500, Yu Zhao wrote:
> > > On Thu, Feb 8, 2024 at 1:18 AM Byungchul Park <byungchul@sk.com> wrote:
> > > >
> > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > > > pages. However, it should be more careful to turn on the mode because
> > > > it's going to prevent anon pages from reclaimed even if there are huge
> > > > ammount of anon pages that are very cold so should be reclaimed. Even
> > > > worse, that can lead kswapd_failures to be MAX_RECLAIM_RETRIES and stop
> > > > until direct reclaim eventually works to resume kswapd.
> > >
> > > Is a theory or something observed in the real world? If it's the
> > > former, would this change risk breaking existing use cases? It's the
> >
> > I faced the latter case.
> >
> > > latter, where are the performance numbers to show what it looks like
> > > before and after this patch?
> 
> Let me ask again: where are the performance numbers to show what it
> looks like before and after this patch?
> 
> > Before:
> >
> > Whenever the system meets the condition to turn on cache_trim_mode but
> > few cache pages to trim, kswapd fails without scanning anon pages that
> > are plenty and cold for sure and it retries 8 times and looks *stopped
> > for ever*.

Does "stopped for ever" mean that kswapd simply stops functioning?

If so, that's a pretty serious issue.  Please fully describe all of
this in the changelog.  Please also address Yu Zhao's review comments
and send us a v2 patch?  Thanks.


