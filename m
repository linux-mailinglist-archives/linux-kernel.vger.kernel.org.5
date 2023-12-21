Return-Path: <linux-kernel+bounces-7678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD5481AB89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B820286791
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE51F64C;
	Thu, 21 Dec 2023 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khdjqgR7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13457623;
	Thu, 21 Dec 2023 00:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A42C433C7;
	Thu, 21 Dec 2023 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703117418;
	bh=AT6oW+jJMtXQdbHwL9Z7usTmZeeTh2gPN9oXGptOnQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khdjqgR73FEoW4JYOO+cdYW83Uzm0FwwMneYhDyioUEKP3fYxuLfhq5eHFc8UT1gF
	 /VGjWKVf5syU2P9hlY5lnKW4I0u9FTIC+2Dc52Gu4pqAFD9fVDGngJEu0o2VfrPQCY
	 MfZD7pDTp55xEgS5F/10whm+ZHm9nMVsCbSemk4kP1fyPa7STEQ2bbdxkV5tWfA04x
	 CKeMj5dTcB5iMKoqS2MIVZ240R68LAxCnVJ+xCIaJXf8nhRek/vRaTVDSw1Lug2ou1
	 2MaKKoyLuEg6fcZBMhW/hnkClXfr/chmjEk7OCuyrRySJvMZ2HsBbVQwm+Jas6QkAI
	 XOcQEiKFs6TGw==
Date: Thu, 21 Dec 2023 09:10:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 03/15] ring-buffer: Add interface for configuring
 trace sub buffer size
Message-Id: <20231221091013.9af9f0a5ff926069babe4989@kernel.org>
In-Reply-To: <20231220094030.5d13438b@gandalf.local.home>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.298324722@goodmis.org>
	<20231220232619.67f0b175578d14f9341fb30c@kernel.org>
	<20231220094030.5d13438b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 09:40:30 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 Dec 2023 23:26:19 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 19 Dec 2023 13:54:17 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > +/**
> > > + * ring_buffer_subbuf_order_set - set the size of ring buffer sub page.
> > > + * @buffer: The ring_buffer to set the new page size.
> > > + * @order: Order of the system pages in one sub buffer page
> > > + *
> > > + * By default, one ring buffer pages equals to one system page. This API can be
> > > + * used to set new size of the ring buffer page. The size must be order of
> > > + * system page size, that's why the input parameter @order is the order of
> > > + * system pages that are allocated for one ring buffer page:
> > > + *  0 - 1 system page
> > > + *  1 - 2 system pages
> > > + *  3 - 4 system pages
> > > + *  ...  
> > 
> > Don't we have the max order of the pages?
> 
> Actually there is. I think it's 7?
> 
> Honestly, anything over 5 is probably too much. But hey.

Ah, I see. It is checked in subbuf_order_write() method (and it is embedded
directly). I think that 7 should be replaced with a macro, something like
RB_SUBBUF_ORDER_MAX and check it in this exposed function instead of write
method.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

