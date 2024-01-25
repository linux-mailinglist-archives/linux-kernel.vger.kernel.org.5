Return-Path: <linux-kernel+bounces-38154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF683BBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81748B29130
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F3175B9;
	Thu, 25 Jan 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXwG0kiB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pb/Gadxq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AF17582;
	Thu, 25 Jan 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170658; cv=none; b=V9iqG6mCkpxSz6+GeZNElWiqc+eJTXlJVM1MsfRenqexCfqmuEr6yMzt82bVrcuYST5Fcg6D4BL7mTCznOmvXQkshOBfOrP0uvlCZ0WO9T5bZPN6gfw83hqHyMtlQxGnDif3NIe33iyLE2+OhlmKs3QPR4/KJq0OMLeUew1UtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170658; c=relaxed/simple;
	bh=c9ylNmOpoK6fJRr7rZhApY7lYLUo47DvsHflZSxtHwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ExXYdo6VZl8vC47SSDoqQTeLxFii8p/99c3Ab0dN3iY8bM+W3nGjLPJZ1lyzoAoAOsVzdXSY/35PWYpwMm2dt6yU5EZefLs1KZ7hqHHkV6soRQg2ZDrxWBxjQCn1TjFQdacMil98stlsmvE+zioMihRM/Gba7XTIVxcRVEjLxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KXwG0kiB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pb/Gadxq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706170655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvJrGVEDSZUiAKEsDwsxgKXyf5HFxmJr3f9c4U5+1pY=;
	b=KXwG0kiBfkWzfksjES4eyuwHUO5CwYmDTHQOgKp/J34D+crHA/Z1sl0/46DqAgHxrY5f37
	dhtQv3U5wcD569rIjK6p1zXcpSOtdTXtWs6KG9t8JGglh790S+wg9PlSDfEi/tlNvQbjz3
	XztA7d6cJmF6E9o7ESt1w9+2N0TelhvbMvfR6TNhdY+nXophqwZk5UKIcJdJRTB88i6Xof
	QiQNP/XXSHD6IJVgWJYa9q246FuV02dABybszUR+cZzCFBfNb0qsgElJHDJIMm0Bl0q9GM
	Aahe0aBa0a0pj79EGPTLY7U/RB7jr3A439q8MprrSwn9nrQzzHEszkr0649HIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706170655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvJrGVEDSZUiAKEsDwsxgKXyf5HFxmJr3f9c4U5+1pY=;
	b=Pb/GadxqakmqBb/Afo9MpqBqaK9eNDpw/Q0JXEoT27goSvpTvweETIKXf/gsWaqZpNpEGI
	aXJF2LgCt/7QMjBg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Subject: Re: [PATCH 1/8] include/hrtimers: Move hrtimer base related
 definitions into hrtimer_defs
In-Reply-To: <20240123164702.55612-2-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-2-anna-maria@linutronix.de>
Date: Thu, 25 Jan 2024 09:17:34 +0100
Message-ID: <87plxpkesh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 23 2024 at 17:46, Anna-Maria Behnsen wrote:
> hrtimer base related struct definitions are part of hrtimers.h as it is
> required there. With this, also the struct documentation which is for core
> code internal use, is exposed into the general api. To prevent this, all
> core internal definitions and the related includes are moved into
> hrtimer_defs header file.

Shouldn't this simply move to kernel/time/... ? Nothing outside of it
needs hrtimer_base

Thanks,

        tglx

