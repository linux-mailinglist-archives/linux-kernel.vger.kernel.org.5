Return-Path: <linux-kernel+bounces-45448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9ED8430E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3881C1C2420C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7854276;
	Tue, 30 Jan 2024 23:10:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9817EF15;
	Tue, 30 Jan 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656245; cv=none; b=Bf2O8HYLs/Pgn+bNJvdgmWSYe7geyMcJQ/BxhpBl4jHmnbhjZj6Z02vO8AhdLeQMOMT9hVT6fHHNgvDZychNRaYmMOprDiFV0FJtC/XIURo+1P7QR8JdlmV2adpbb+m5vs6Cw3If+YZTGVWHlkpNsnjSQxXyseyPJGz6U3O7avU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656245; c=relaxed/simple;
	bh=qQGsXULyrB3Ryczms+iBaRXs0qHPwY0/zFdVSrn4PO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oa4PsV8H6d7qsJ+P1QwdOsA/c8KC/mP0+qk792JIz1MRVjp+dPQaa1C73YAuK98h/FX7TXzFGPu+Ol2bD6BqvJy8NQ8sF6P1IuNEjE56IyH7QeDmQ13TYHiaIptl7kPaP+jyVULoYb/Pg0eIK4Hc9s0ih3hFaejerJ4BoOWp1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AEAC433F1;
	Tue, 30 Jan 2024 23:10:44 +0000 (UTC)
Date: Tue, 30 Jan 2024 18:10:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without
 refcounts
Message-ID: <20240130181057.278ac05c@gandalf.local.home>
In-Reply-To: <CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
	<20240130190355.11486-5-torvalds@linux-foundation.org>
	<20240130155550.4881d558@gandalf.local.home>
	<CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
	<CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
	<CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 15:06:13 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 30 Jan 2024 at 14:56, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > With that, the base size of 'struct eventfs_inode' actually becomes 96
> > bytes for me.  
> 
> It can be shrunk some more.
> 
> The field ordering is suboptimal. Pointers are 8 bytes and 8-byte
> aligned, but 'struct kref' is just 4 bytes, and 'struct eventfs_attr'
> is 12 bytes and 4-byte aligned.
> 
> So if you pack all the 8-byte-aligned fields at the beginning, and the
> 4-byte-aligned ones at the end, you get 88 bytes.
> 
> At which point a name pointer would *just* fit in 96 bytes.

Does that mean I should keep the kstrdup_const()?

> 
> ...  and then some debug option is enabled, and it all goes to hell again.

Heh, I'm not too concerned about debug options. As anyone concerned about
memory size should have already have audited their .config to turn off
anything they don't need.

-- Steve

