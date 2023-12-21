Return-Path: <linux-kernel+bounces-9060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE381BFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D3A1C24282
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2E76916;
	Thu, 21 Dec 2023 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3X9S3IlV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aISqnKjo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9D768F2;
	Thu, 21 Dec 2023 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Dec 2023 21:46:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703191578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDpN/Xhyn5m1p8kB7S59OLjKw5oKnDxtPh+QUsbyR3M=;
	b=3X9S3IlVx/9oXBclGG2g9ReByy2aQWK2APEOj9FgdOOqRsLXVCmEJh3A4aSCAwP7Z44g+V
	lhe6SuPe5oK/emYs+LlDRjJaApN6P9UXJUZVuaNE5aO5b6uZ4SCZtlS72T6jm7YOwZMb68
	s79zAUbwW7TRTPss8PZbzN0/Do0XIGzmMliO4LSQPqYCXFDNpMRJ6vqNE9jvw/Rtm3QBWf
	/bCbIodeZsz5QBibBG/37++zsPWRi4L/EqV7rQRZmxGB0XdF1qRACkddADXC0ve8m+YmLO
	erdDNQqkrYLxUKzM79dfib5uhYnq/yqu9ACuL2taz43B4sHNeNC1m6F7txQDlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703191578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDpN/Xhyn5m1p8kB7S59OLjKw5oKnDxtPh+QUsbyR3M=;
	b=aISqnKjoLZm+vTGgD/aSbnuaVhf00wWb6YqL1LDPGGZSppSSm4/eqSUJTdO0mjYMjWf0Rn
	JQ7GItXpxErTz0Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net-next 00/24] locking: Introduce nested-BH locking.
Message-ID: <20231221204616.04CZKAKf@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
 <20231215145059.3b42ee35@kernel.org>
 <20231218172331.fp-nC_Nr@linutronix.de>
 <20231218164142.0b10e29d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218164142.0b10e29d@kernel.org>

On 2023-12-18 16:41:42 [-0800], Jakub Kicinski wrote:
> 
> To make progress on other parts of the stack we could also take 
> the local lock around all of napi->poll() for now..

Okay. Thank you. I will look into this next year again.

Sebastian

