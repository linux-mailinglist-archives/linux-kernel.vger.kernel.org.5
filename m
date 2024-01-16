Return-Path: <linux-kernel+bounces-27736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC582F50F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022C81C239E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D981D528;
	Tue, 16 Jan 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="d/OeJr2K"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81671D521
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432273; cv=none; b=i9Uga6WqybmiMpFcPghHxHLCkJ/IGeCuz5HYbk5RpHIIwnM85vMiiiNF9YNrWiw/wwVSGfu2X/jL4VlnmyI1eAJgFuocloPqjy+gLxTlQmem0Ya3O88rsdRzmBIgll2JpaEWGAmDbIqXfXT45zPoyE6ckHpVKvVwxmqkg8uNYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432273; c=relaxed/simple;
	bh=QHoB78cJOL25PB7cy0vQdTJF5vkSAXmPONmp3oHOHMA=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Bpl; b=ODKUX7c8G2Xb+R3mkhC7C3JtnlEYpKy4GBZw5nMWWZsFc4lPMX8olU79GwZKzFzN0O9KMQXijDjeAFrbUkERV+8nj3laeW/LlIBOG0x4JOWxd6LDKtjxLY4XV7aJwTH6kCKz1yBhnKerwtGxhth1KUqoljsqAu2qz2TMigqg45g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=d/OeJr2K; arc=none smtp.client-ip=51.81.211.47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1705432272;
	bh=QHoB78cJOL25PB7cy0vQdTJF5vkSAXmPONmp3oHOHMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d/OeJr2Kt7RWSVtin71qo4ogb2W/phbU7XMAbxF0oKasjko4er6LZfiFhgq4t9HeG
	 kRPd+VS6CDrfswitnxKlnZtKcIAbq+TrTPaVM3eT71XUn3L4mIT3thOwOmoo9M9u4s
	 3pUcPMSKMKZJKj0vupYGhrHz4Kq981MeRp+6ylNuDEBNdAhzkVyoOIkFIz0MaMvmJi
	 uD7cNvndVsjo1dHBHwh88v10NZcAgMmY1Lu4kTHqF8eFerLrXeEcXDHmAXFlbmVV+u
	 MGbqDdB0BxOM1wbrzrcgZQq2gHk7IV9Y4RRiLHn156JUGP4aJX14WElYsB7sk1Qlls
	 MFDoN9sYwRz4w==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.189])
	by gnuweeb.org (Postfix) with ESMTPSA id 55C7424C3A2;
	Wed, 17 Jan 2024 02:11:10 +0700 (WIB)
Date: Wed, 17 Jan 2024 02:11:05 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Charles Mirabile <cmirabil@redhat.com>, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Message-ID: <ZabUyZG3C3LUax6f@biznet-home.integral.gnuweeb.org>
References: <20240116181147.2230944-1-cmirabil@redhat.com>
 <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>
 <ZabRwdcgU/H8i5Ja@1wt.eu>
 <ZabSG4R45sC0s23d@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabSG4R45sC0s23d@1wt.eu>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Tue, Jan 16, 2024 at 07:59:39PM +0100, Willy Tarreau wrote:
> On Tue, Jan 16, 2024 at 07:58:09PM +0100, Willy Tarreau wrote:
> > On Wed, Jan 17, 2024 at 01:52:06AM +0700, Ammar Faizi wrote:
> > > What do you think about other architectures? Will it potentially be
> > > misinterpreted?
> > 
> > Indeed, it would fail on a 64-bit big endian architecture. Let's
> > just declare the local variable the same way as it is in the spec,
> > it will be much cleaner and more reliable.
> 
> With that said, if previous code used to work on such architectures,
> maybe the definition above is only for x86_64 and differs on other
> archs. Maybe it's really defined as two longs ?

I just took a look at the kernel source code:
https://github.com/torvalds/linux/blob/v6.7/fs/binfmt_elf.c#L226-L261

The auxv is stored in `elf_info` variable, the type is `elf_addr_t`. Not
sure what kind of typedef is that. I'll check.

Each auxv entry is added using this macro:

 #define NEW_AUX_ENT(id, val) \
         do { \
                 *elf_info++ = id; \
                 *elf_info++ = val; \
         } while (0)

where `id` is the type. That clearly implies `type` and `val` have the
same size on the Linux kernel.

-- 
Ammar Faizi


