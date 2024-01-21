Return-Path: <linux-kernel+bounces-32103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EBB83567C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD05281D25
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF770376F0;
	Sun, 21 Jan 2024 15:42:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FC376E2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851774; cv=none; b=S/UJm4odM3M0hwntWVQppzGBh9t0q3/scAUkn9suLWmwi7wH4/5xOPTlvvnj3EetG3YOYUsRZdaS6WXvDLk5rL9SJaE2mfO5alsVNS7rgDC25VlkHqM3+9/gMsIIDsAXip8RgTQUThHGODFQ7hrTycI1Da7mm2HgONDlb/TZHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851774; c=relaxed/simple;
	bh=YpgNzqbUY2jSsd5b0U/oVVNDxXEDJkkFN3sLHlwC8cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6IuWBMRP5OsTApgPxpmZibL6CPub+9KlJZyw5I9dDur2b7IS698EzQSE1vxA82AV2sfXHYlHGxxWS3rOMTlFT5s2ys4bqUZxiGGFMcK13MgHergScArSMlaEEI12jmaCHhS3v+Sont3V/6PwH2puU3vBAc4HhUkcCH4jN0Gs7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7D8C433F1;
	Sun, 21 Jan 2024 15:42:51 +0000 (UTC)
Date: Sun, 21 Jan 2024 10:42:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>, Jinyang
 He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Naveen N
 . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Message-ID: <20240121104249.3997125b@rorschach.local.home>
In-Reply-To: <20240121180544.8c663977651d2a18291318d5@kernel.org>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
	<06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
	<20240120170517.5cadbc20@rorschach.local.home>
	<20240121112852.381ebd7bf37ea6d2236db9f2@kernel.org>
	<20240121180544.8c663977651d2a18291318d5@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 18:05:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> However, if the I-cache entry servives text_poke() and sync_core(), this
> problem may happen.
> The text_poke() flushes TLB but for the local (!global) PTE, and sync_core()
> just serialize (!= cache flushing?). Thus the other CPUs can still see the

Yes, the purpose of the IPIs are for cache flushing, including icache.

> INT3 after text_poke_sync()? If so, on such CPU, removed INT3 is still
> alive on the I-cache and hit it after text_poke_sync().
> This will be a ghost INT3...

An interrupt is a full memory barrier and it looks like qemu is not
honoring that. Thus the bug is in qemu and not the kernel.

-- Steve

