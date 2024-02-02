Return-Path: <linux-kernel+bounces-50587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81278847B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32781C235C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01D80636;
	Fri,  2 Feb 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dc7xZzbI"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A67E111
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907773; cv=none; b=LkSHoLcn28IohBCOdduZXjjzccTsy+9SdsVXu3gPIvBUHcr1Zx/FrKpOV3GklcLRtjZ/pvzNiVwbZWGKviitdkQgC53XHz+jrLzhnsE3Xv8JlkSlsxWELLF8Kx8q13aDpt7BpLDcCUYxqFTLFqM0CnIiYAjdlGw0bMiXQZsJUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907773; c=relaxed/simple;
	bh=JWsKFngwH8votK+4WexIivHhiapSnu4LNbbiE0EB1kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdbcyeOt7rmZoMMEOKAZ80QYpEHQJtlRjrRzydUn/pD/tCBivox7LjnhgY+PQfEsQqbgegbfEpAh6aOg7tejjIle4TaZarM6ItPVp6vBrmHIq/rhTbNJuZ0WNqlzxcMk6bJRA3X/3BNeWMIixFdn+/ZdBM2dfvc8i3WGtqHukI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dc7xZzbI; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2192ce71854so359166fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706907770; x=1707512570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwv1t/9P2eD8k32faLH8OAi3mAtA+or2AT1hGZahOn0=;
        b=dc7xZzbIakdzMj46W8qEEwJofmRaX9IjUk3EOCJgFKVIN0idJHzj7wa8U5p2G+eIqS
         7HFVCZQYRYv5XiuT0+D7zgD8b6NvT+suRBSVZzkTuCYL0uIq42ePiGO1tfOF6h/6QMsT
         eVSZREc9gjDwjF5QbkDIBXuajhrk7coc3S1Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907770; x=1707512570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kwv1t/9P2eD8k32faLH8OAi3mAtA+or2AT1hGZahOn0=;
        b=ZLaMxkwvSQtE77hZj/VqTodLaHTWIIcs4JuV35XfEIjpONwbbAlB2k8QWtD6RElbAn
         w1uDu5QwEc2vXTD4Zg+Z7jEERjs4Aqq/gkBrJj92DG7C2VrZnm+2fE7ya6OeeB2VwJqc
         vLtx0zMLXOXfoT2wzL7jlbmZpczxrnAlF8MVKrQBgDl5HX91uKeG3weqlEJP9kuA26Ix
         QQ86N0lQPHCsYyAQQ6spDtenWQQv2oHytXWbP16xVpjMTabtBGNJI2JhCsFBX7H4bkDi
         Cxe4KxDOqFTVvDbM1YNoX8FVAhWJ31/U0wxCA2JGR7g2ckMPkLRP7xfx8DuU+DZrjhE4
         XPKg==
X-Gm-Message-State: AOJu0YzFSR5Jp0AA1jecNCcjVIwjcLFKp96nxy/E90rg6kct4IfV/vLq
	WI+VcTzZMSJ670wumnfTSvOsQmZ02V1jyNLWzPprBnFwpslAMzT5a9HikzV1TyWO3/Mwn6NR+D7
	/iw6NwrJTtXdKJE0oiurmgAEJAQpFI7lXzVqe
X-Google-Smtp-Source: AGHT+IFLfI+QVnBGQBrrQmHn9pIjxz6rn+Ig0eY7W4cofKy0FCCei109/RonMNR87LrdLiyaoj1zg6HqjAXh4M4gOWE=
X-Received: by 2002:a05:6871:8aa:b0:215:17f1:3aa with SMTP id
 r42-20020a05687108aa00b0021517f103aamr370639oaq.3.1706907770631; Fri, 02 Feb
 2024 13:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
 <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
 <66496.1706893543@cvs.openbsd.org>
In-Reply-To: <66496.1706893543@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Feb 2024 13:02:38 -0800
Message-ID: <CABi2SkUkFLpLaK3nivWz-wNUC=eqiR-uq9PG0YSdmaT94MUAuQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 9:05=E2=80=AFAM Theo de Raadt <deraadt@openbsd.org> =
wrote:
>
> Another interaction to consider is sigaltstack().
>
> In OpenBSD, sigaltstack() forces MAP_STACK onto the specified
> (pre-allocated) region, because on kernel-entry we require the "sp"
> register to point to a MAP_STACK region (this severely damages ROP pivot
> methods).  Linux does not have MAP_STACK enforcement (yet), but one day
> someone may try to do that work.
>
> This interacted poorly with mimmutable() because some applications
> allocate the memory being provided poorly.  I won't get into the details
> unless pushed, because what we found makes me upset.  Over the years,
> we've upstreamed diffs to applications to resolve all the nasty
> allocation patterns.  I think the software ecosystem is now mostly
> clean.
>
> I suggest someone in Linux look into whether sigaltstack() is a mseal()
> bypass, perhaps somewhat similar to madvise MADV_FREE, and consider the
> correct strategy.
>

Thanks for bringing this up. I will follow up on sigaltstack() in Linux.

> This is our documented strategy:
>
>      On OpenBSD some additional restrictions prevent dangerous address sp=
ace
>      modifications.  The proposed space at ss_sp is verified to be
>      contiguously mapped for read-write permissions (no execute) and inca=
pable
>      of syscall entry (see msyscall(2)).  If those conditions are met, a =
page-
>      aligned inner region will be freshly mapped (all zero) with MAP_STAC=
K
>      (see mmap(2)), destroying the pre-existing data in the region.  Once=
 the
>      sigaltstack is disabled, the MAP_STACK attribute remains on the memo=
ry,
>      so it is best to deallocate the memory via a method that results in
>      munmap(2).
>
> OK, I better provide the details of what people were doing.
> sigaltstacks() in .data, in .bss, using malloc(), on a buffer on the
> stack, we even found one creating a sigaltstack inside a buffer on a
> pthread stack.  We told everyone to use mmap() and munmap(), with MAP_STA=
CK
> if #ifdef MAP_STACK finds a definition.
>

