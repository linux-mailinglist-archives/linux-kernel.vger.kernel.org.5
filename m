Return-Path: <linux-kernel+bounces-34649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DC8385B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660931F2AD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0829AA3F;
	Tue, 23 Jan 2024 02:50:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638E7E9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978232; cv=none; b=szzmOMYypUBO0Sw9vYk8HB1aiGtyQZScLe0uR8UKghsTWqqirtv9uOmK2ITSM0htv9GOKSfdb01x4FT67TWavuRz4/Pp5P3iy0iqLFJH5DbaXokd9aeH++slBa3PALwk6k1eCG4nNaXjEPpV62xjbRa8JOIUPR/A2N5LSFqqaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978232; c=relaxed/simple;
	bh=8tsc+qA17rexfPtUShMNwu4xuggqtnUz4ZR/y0dZN4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyfbbV+mdclJLi4izsbQ2iY0gF/X6LsgNvof74kG3soEKuT7ipmmFXV0CEp+snhsNFeJjGJijS9lnKT6qCky1ash9pttD0JfWKyUovhaojFxAQd0k/KZZtHcjKmJzoe8nWVla7Oz0YqGok2UTGdoxjNo8PFDfKL4cj9PU4Mh2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D56BC433C7;
	Tue, 23 Jan 2024 02:50:30 +0000 (UTC)
Date: Mon, 22 Jan 2024 21:52:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dave Airlie <airlied@gmail.com>
Cc: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, Fedor Pchelkin
 <pchelkin@ispras.ru>
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at
 ttm_device_init+0xb4
Message-ID: <20240122215200.1ec02a4a@gandalf.local.home>
In-Reply-To: <CAPM=9tyCN1ZhvCTjoKn-Yg5BhnrMae4E5Ci4_u7BZ2vv5gDnKw@mail.gmail.com>
References: <20240122180605.28daf23a@gandalf.local.home>
	<20240122181547.16b029d6@gandalf.local.home>
	<20240122181901.05a3b9ab@gandalf.local.home>
	<CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
	<27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com>
	<20240122203552.529eeb20@gandalf.local.home>
	<CAPM=9tyQ22nw4_u366EX=PnROYcWPD7ONRFpPEKxRvTZo0B4zQ@mail.gmail.com>
	<CAPM=9tyCN1ZhvCTjoKn-Yg5BhnrMae4E5Ci4_u7BZ2vv5gDnKw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 12:32:39 +1000
Dave Airlie <airlied@gmail.com> wrote:

> On Tue, 23 Jan 2024 at 12:21, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Tue, 23 Jan 2024 at 12:15, Steven Rostedt <rostedt@goodmis.org> wrote:  
> > >
> > > On Mon, 22 Jan 2024 19:56:08 -0500
> > > "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com> wrote:
> > >  
> > > >
> > > > On 1/22/2024 7:43 PM, Linus Torvalds wrote:  
> > > > > On Mon, 22 Jan 2024 at 15:17, Steven Rostedt<rostedt@goodmis.org>  wrote:  
> > > > >> Perhaps this is the real fix?  
> > > > > If you send a signed-off version, I'll apply it asap.  
> > > >
> > > >
> > > > I think a fix might already be in flight. Please see Linux-Kernel
> > > > Archive: Re: [PATCH] drm/ttm: fix ttm pool initialization for
> > > > no-dma-device drivers (iu.edu)
> > > > <https://lkml.iu.edu/hypermail/linux/kernel/2401.1/06778.html>  
> > >
> > > Please use lore links. They are much easier to follow and use.  
> >
> > https://lore.kernel.org/dri-devel/20240123022015.1288588-1-airlied@gmail.com/T/#u
> >
> > should also fix it, Linus please apply it directly if Steven has a
> > chance to give it a run.  
> 
> I see Linus applied the other one, that's fine too.
> 

They don't look mutually exclusive. I can test the other one as well.

-- Steve

