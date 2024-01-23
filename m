Return-Path: <linux-kernel+bounces-34592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CCB8381DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B6C28BCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130CC5674B;
	Tue, 23 Jan 2024 01:34:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57D5644F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973664; cv=none; b=f7/1v5RzzFLvDoYb5bIRciyZXWS8Sp9XAoCVOy7pXnjpXDh5laW5a6/H/Mubw5KxTNbQAR5OHjc9ViS12/3LfG+pwMe2o7072aPuSbY7nu7KGEGjmGXd+X6pmMkvHLAHB9+z1+ehe9Y6XGRelK9hWg2E2jj5q9bbj8oMDA8xeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973664; c=relaxed/simple;
	bh=dq5g7WPUL5YMpbRJHlT9UsHcaC74VI7W43l+aqkk4OI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV3SseRrIQ8j/8NGbdl9sIBWpd9Fce9XfQOeDqzY8b2EOexEtiw2rP7sZjfc/8McsQVGTRO++XMr0VgYY2IdRUKHSqfyzuyleloWO9nc2esidwp9+uzPYdjd0jWXdKGjmnANVRJr9MatH7Yoldirl6lfMoRRhZc621kF2M4bojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E61C43390;
	Tue, 23 Jan 2024 01:34:23 +0000 (UTC)
Date: Mon, 22 Jan 2024 20:35:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, Fedor Pchelkin <pchelkin@ispras.ru>
Subject: Re: [BUG] BUG: kernel NULL pointer dereference at
 ttm_device_init+0xb4
Message-ID: <20240122203552.529eeb20@gandalf.local.home>
In-Reply-To: <27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com>
References: <20240122180605.28daf23a@gandalf.local.home>
	<20240122181547.16b029d6@gandalf.local.home>
	<20240122181901.05a3b9ab@gandalf.local.home>
	<CAHk-=whry+-JUDiiCkDkDn2TDg7SA5OvZpPbcQ_jkM_J5=ySdA@mail.gmail.com>
	<27c3d1e9-5933-47a9-9c33-ff8ec13f40d3@amd.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 19:56:08 -0500
"Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com> wrote:

> 
> On 1/22/2024 7:43 PM, Linus Torvalds wrote:
> > On Mon, 22 Jan 2024 at 15:17, Steven Rostedt<rostedt@goodmis.org>  wrote:
> >> Perhaps this is the real fix?
> > If you send a signed-off version, I'll apply it asap.
> 
> 
> I think a fix might already be in flight. Please see Linux-Kernel 
> Archive: Re: [PATCH] drm/ttm: fix ttm pool initialization for 
> no-dma-device drivers (iu.edu) 
> <https://lkml.iu.edu/hypermail/linux/kernel/2401.1/06778.html>

Please use lore links. They are much easier to follow and use.

  https://lore.kernel.org/lkml/20240113213347.9562-1-pchelkin@ispras.ru/

is the patch I believe you are referencing.

The fix doesn't need to be mine, but this should be in Linus's tree ASAP.

-- Steve

