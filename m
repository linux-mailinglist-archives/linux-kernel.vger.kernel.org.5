Return-Path: <linux-kernel+bounces-27749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755682F540
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC65B23451
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB071D527;
	Tue, 16 Jan 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="TJ9asV4B"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DF1D520
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433041; cv=none; b=apPcDXCDLla4EtY2MfaODt7uMohbGfuwJcU3cHJTMQnA8ngl3sX/BDrwkeHHAlivd0WluNbxUsFfbxYiwIPaN9LQKROl7skcMqx5/74Y6qX3yD0oj5NGHi01fwIvvXFGgjihJn+SYOvqsCErnIzPUZkgTvexNZTxkVwqCvUY6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433041; c=relaxed/simple;
	bh=CJ7g0DeUZB0QrtvedOt7eXQmDHJZHSUzbYyX7LzgXWw=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Bpl; b=niwDBGBH874bm42cqJrcuYylVBzfhwwAL9BktkOtRB6DxDKLADLqKcUMbhzfPqxO18/L7P/yuFdEYs8LMb59bPwoWsk+GwS5GvEjdrC4jSujhhmOVvn2s9PHK8grYDIf47ZBcnC/hRXl7JuLuWCXhU5btjhYiPAzxoMXoTzc4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=TJ9asV4B; arc=none smtp.client-ip=51.81.211.47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1705433039;
	bh=CJ7g0DeUZB0QrtvedOt7eXQmDHJZHSUzbYyX7LzgXWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJ9asV4BoSng9oirPy4OMuQKteQlYm92oHmrprjdQYtR1ml+lHq4NPw53tPesfql9
	 5Ri8yQFWx7Bi13QIybjjPNDJIrqQhdCdW2i9cjh4FglZPV0+nWRFM8AB/G1FkxFkmW
	 hsvy0o/lPRF8cuI2FRe/CMOqGcK4OAkbRw2mr1jJRuAPHyckY74lGnctZbHQERf5yH
	 SQe+0eqiA8uRyiswc6V/xq1LUbrMnFakZdAK5OXGfwzgQAdA5Hm4K6Nn0BiqIgNMmn
	 HpRVQgsiXjSPwjIQLEnKYORwJrFXkN7YgDaYJwDHSpbVWsEKkDXSnPHk8iq1iQn2BI
	 alhqiRhGMXEMA==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.189])
	by gnuweeb.org (Postfix) with ESMTPSA id BC4A724C3A2;
	Wed, 17 Jan 2024 02:23:57 +0700 (WIB)
Date: Wed, 17 Jan 2024 02:23:53 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Charles Mirabile <cmirabil@redhat.com>, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Message-ID: <ZabXyRMECEnMUizk@biznet-home.integral.gnuweeb.org>
References: <20240116181147.2230944-1-cmirabil@redhat.com>
 <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>
 <ZabRwdcgU/H8i5Ja@1wt.eu>
 <ZabSG4R45sC0s23d@1wt.eu>
 <ZabUyZG3C3LUax6f@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabUyZG3C3LUax6f@biznet-home.integral.gnuweeb.org>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Wed, Jan 17, 2024 at 02:11:12AM +0700, Ammar Faizi wrote:
> On Tue, Jan 16, 2024 at 07:59:39PM +0100, Willy Tarreau wrote:
> > On Tue, Jan 16, 2024 at 07:58:09PM +0100, Willy Tarreau wrote:
> > > On Wed, Jan 17, 2024 at 01:52:06AM +0700, Ammar Faizi wrote:
> > > > What do you think about other architectures? Will it potentially be
> > > > misinterpreted?
> > > 
> > > Indeed, it would fail on a 64-bit big endian architecture. Let's
> > > just declare the local variable the same way as it is in the spec,
> > > it will be much cleaner and more reliable.
> > 
> > With that said, if previous code used to work on such architectures,
> > maybe the definition above is only for x86_64 and differs on other
> > archs. Maybe it's really defined as two longs ?
> 
> I just took a look at the kernel source code:
> https://github.com/torvalds/linux/blob/v6.7/fs/binfmt_elf.c#L226-L261
> 
> The auxv is stored in `elf_info` variable, the type is `elf_addr_t`. Not
> sure what kind of typedef is that. I'll check.
> 
> Each auxv entry is added using this macro:
> 
>  #define NEW_AUX_ENT(id, val) \
>          do { \
>                  *elf_info++ = id; \
>                  *elf_info++ = val; \
>          } while (0)
> 
> where `id` is the type. That clearly implies `type` and `val` have the
> same size on the Linux kernel.

So here is the result:

1. 'elf_addr_t' defintion ( https://github.com/torvalds/linux/blob/v6.7/include/linux/elf.h#L38-L62 ):

  (simplified)
  #if ELF_CLASS == ELFCLASS32
  #define elf_addr_t	Elf32_Off
  #else
  #define elf_addr_t	Elf64_Off
  #endif

2. 'Elf32_Off' and 'Elf64_Off' typedefs ( https://github.com/torvalds/linux/blob/v6.7/include/uapi/linux/elf.h#L8-L23 )

  typedef __u32  Elf32_Off;
  typedef __u64  Elf64_Off;

Assuming 'ELFCLASS32' is for 32-bit architectures, then it's two __u64
on 64-bit arch, and two __u32 on 32-bit arch. That is identical to
'unsigned long' for both cases (on Linux). So it's fine to have
'unsigned long' for both 'type' and 'value'.

-- 
Ammar Faizi


