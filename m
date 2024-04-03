Return-Path: <linux-kernel+bounces-130687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39063897BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34B31F28BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AEB41C76;
	Wed,  3 Apr 2024 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m5etxihm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E642C79CE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183428; cv=none; b=sI6ziel/NJ8kbIxzqOpuiQwC/JEbryzjmlpn7cwWbUSuuoSoP1vwr4BDFKvd8eTUck2UJaYCRgwYsWSolzW90zMaH8TXEeRWMspOiT1MDyFFie+12RN1WeJTwByzWtkJIjpx2zO3/oozbxJ1P7OTpTJC6eTwOhNb7LVj+k/PsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183428; c=relaxed/simple;
	bh=NmvgbW7Sm0mAm8nmqZZnMBpYjtRAf35SBOpTAb2DvFM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b0xVR8QqkILSqMi/B+HpO0EZGFgp3TLu6Bir9Wzpb5ujPXxofdddE4oneRg7cBB6KKEaT9UCtVnsfUuAK3thvvymeZUdNDRTFAA+NGjJmAPvQ4pOvjDKOjuIWjPV8LpghIfnCVDwgVocJttukcvEUZcANLcIAlEf2N+W3ojIM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=m5etxihm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF32C433C7;
	Wed,  3 Apr 2024 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712183427;
	bh=NmvgbW7Sm0mAm8nmqZZnMBpYjtRAf35SBOpTAb2DvFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5etxihmQOvcb9UVNcbjrO63Ix2qyAx5+BU0CantyCTeW3nfSbLLG9Vj3cevAZS81
	 wIanup+4rk097w4C+d6SPb8CTo22pZeCYp5WwpfcCzsLxC9OutEUhMEaAj+9yZiRlX
	 xkmYZ3B2eVuVOI6g5xfSJxNASGIS7ACSJDItWemQ=
Date: Wed, 3 Apr 2024 15:30:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, rongtao@cestc.cn,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] memblock tests: fix build error
Message-Id: <20240403153026.67f05e557304c97078a3e13d@linux-foundation.org>
In-Reply-To: <ZgxX-5Eu4MU_SEqV@kernel.org>
References: <20240402132701.29744-1-richard.weiyang@gmail.com>
	<ZgxX-5Eu4MU_SEqV@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 22:09:47 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> On Tue, Apr 02, 2024 at 01:26:58PM +0000, Wei Yang wrote:
> > Some kernel change break the test build, just fix it.
> > 
> > Wei Yang (3):
> >   memblock tests: fix undefined reference to `early_pfn_to_nid'
> >   memblock tests: fix undefined reference to `panic'
> >   memblock tests: fix undefined reference to `BIT'
> > 
> >  include/linux/gfp_types.h    |  2 ++
> >  tools/include/linux/kernel.h |  1 +
> >  tools/include/linux/mm.h     |  5 +++++
> >  tools/include/linux/panic.h  | 19 +++++++++++++++++++
> >  4 files changed, 27 insertions(+)
> >  create mode 100644 tools/include/linux/panic.h
> 
> Andrew,
> 
> I can take these via memblock tree, what is your preference?

I'm seeing no conflicts at this time, so go for it.

