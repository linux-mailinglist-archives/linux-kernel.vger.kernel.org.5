Return-Path: <linux-kernel+bounces-27884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D900282F736
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D2F282FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CA677F25;
	Tue, 16 Jan 2024 19:47:05 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7ED76902
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434424; cv=none; b=t4TzipNhi8HHMyIg4xaclA6k2dHWPaOoTUsx0zAiA4GZoVyLbPFMDh1SoSTSt5oEf6cRmkp3KfUzAraPTC0cXZ34Sh3f5/ZWLJquZe0T3ppcBHWGlQvfNk/L847e26p69V0Fv7nxcg5u1lIC0Fl+rdwUSaOAEgdMn5/LaS4lYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434424; c=relaxed/simple;
	bh=EfwE9uaTGSc2UjtKTV2wy76THTUsBDCa58I0a7iq2Wo=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=CL4lxq6FwRgke/r4VYBOHcLrQzFBhlQ3fBn7PbrbtA94rcLzbSuKcKUwt6iLBM9afMmcjko4Te4UmX2l+VvW5QhI0ttMP+VPFEY/y0MIDPYHrj0kw8D3nxvrEfLHyvkE2MLAJq6VxjFACRV/9g/Qy9DdYjv+ALHzXWq4bFhSLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 40GJkt1u005515;
	Tue, 16 Jan 2024 20:46:55 +0100
Date: Tue, 16 Jan 2024 20:46:55 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Charles Mirabile <cmirabil@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Message-ID: <20240116194655.GA5511@1wt.eu>
References: <20240116181147.2230944-1-cmirabil@redhat.com>
 <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>
 <ZabRwdcgU/H8i5Ja@1wt.eu>
 <ZabSG4R45sC0s23d@1wt.eu>
 <ZabUyZG3C3LUax6f@biznet-home.integral.gnuweeb.org>
 <ZabXyRMECEnMUizk@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabXyRMECEnMUizk@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 17, 2024 at 02:23:53AM +0700, Ammar Faizi wrote:
> On Wed, Jan 17, 2024 at 02:11:12AM +0700, Ammar Faizi wrote:
> > On Tue, Jan 16, 2024 at 07:59:39PM +0100, Willy Tarreau wrote:
> > > On Tue, Jan 16, 2024 at 07:58:09PM +0100, Willy Tarreau wrote:
> > > > On Wed, Jan 17, 2024 at 01:52:06AM +0700, Ammar Faizi wrote:
> > > > > What do you think about other architectures? Will it potentially be
> > > > > misinterpreted?
> > > > 
> > > > Indeed, it would fail on a 64-bit big endian architecture. Let's
> > > > just declare the local variable the same way as it is in the spec,
> > > > it will be much cleaner and more reliable.
> > > 
> > > With that said, if previous code used to work on such architectures,
> > > maybe the definition above is only for x86_64 and differs on other
> > > archs. Maybe it's really defined as two longs ?
> > 
> > I just took a look at the kernel source code:
> > https://github.com/torvalds/linux/blob/v6.7/fs/binfmt_elf.c#L226-L261
> > 
> > The auxv is stored in `elf_info` variable, the type is `elf_addr_t`. Not
> > sure what kind of typedef is that. I'll check.
> > 
> > Each auxv entry is added using this macro:
> > 
> >  #define NEW_AUX_ENT(id, val) \
> >          do { \
> >                  *elf_info++ = id; \
> >                  *elf_info++ = val; \
> >          } while (0)
> > 
> > where `id` is the type. That clearly implies `type` and `val` have the
> > same size on the Linux kernel.
> 
> So here is the result:
> 
> 1. 'elf_addr_t' defintion ( https://github.com/torvalds/linux/blob/v6.7/include/linux/elf.h#L38-L62 ):
> 
>   (simplified)
>   #if ELF_CLASS == ELFCLASS32
>   #define elf_addr_t	Elf32_Off
>   #else
>   #define elf_addr_t	Elf64_Off
>   #endif
> 
> 2. 'Elf32_Off' and 'Elf64_Off' typedefs ( https://github.com/torvalds/linux/blob/v6.7/include/uapi/linux/elf.h#L8-L23 )
> 
>   typedef __u32  Elf32_Off;
>   typedef __u64  Elf64_Off;
> 
> Assuming 'ELFCLASS32' is for 32-bit architectures, then it's two __u64
> on 64-bit arch, and two __u32 on 32-bit arch. That is identical to
> 'unsigned long' for both cases (on Linux). So it's fine to have
> 'unsigned long' for both 'type' and 'value'.

Yeah I agree, thanks for checking.

Willy

