Return-Path: <linux-kernel+bounces-32087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC7835655
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2CF1F22340
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8814B376EA;
	Sun, 21 Jan 2024 15:33:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2303B376E4
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851208; cv=none; b=QXPxyUc/TBRMb6OpBR/P6ZzOR+mmwiOy2A/3XVJ6BSzj88N0ZcONBycT2m4jaB4C/l5MF72BzAPsfKbX/AM/hkdjnbumjyuq/E9pgyB/5dQtSShrAw0S+X6034oOulYV9e2jWdzkCJbWef10GzEpfs08p93cKzpfMUxDM+b7D4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851208; c=relaxed/simple;
	bh=XG/dvvYf9k8MLBIuMCvsrnd7cswnth45vyBhRWGvND4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZGNZqggVZ55TB7d0wKHogjjnUDcZv8psln5ns5acG8f99g3xZuZJ/DiGmbKxXxoTozCpczwGzP7pHiE4z+uxstO6I4S1nlaFUcMsQRUjMubTw3Tvyfp2nUJkzEx0W5rUG87leBryYdfprl8zGy3ZLcWJ20Zqpd1OjarCCZ8sI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F22C433C7;
	Sun, 21 Jan 2024 15:33:24 +0000 (UTC)
Date: Sun, 21 Jan 2024 10:33:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>, Jinyang
 He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, "Naveen N
 . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Message-ID: <20240121103323.6a48d0fb@rorschach.local.home>
In-Reply-To: <20240121103144.4bf735c6@rorschach.local.home>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
	<06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
	<20240120170517.5cadbc20@rorschach.local.home>
	<20240121112852.381ebd7bf37ea6d2236db9f2@kernel.org>
	<20240121180544.8c663977651d2a18291318d5@kernel.org>
	<f8bbf989-f709-4ceb-af5c-87e1e20de914@kernel.org>
	<20240121103144.4bf735c6@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 10:31:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> My guess is that qemu does not treat the IPI being sent as a memory
> barrier, and then the CPUs do not see a consistent memory view after
> the IPIs are sent. That's a bug in qemu!

More specifically, I bet qemu may be doing a dcache barrier, but not an
icache barrier in the interrupt. If the code is already in qemu's
pipeline, it may not be flushing it like real hardware would do.

-- Steve

