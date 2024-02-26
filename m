Return-Path: <linux-kernel+bounces-80737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBFD866BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E36B227B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A831CA9A;
	Mon, 26 Feb 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3+hFNdNT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPJF0vUS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00A1CA8C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935317; cv=none; b=srVkAajO0StAcdmXZifWeNKcwB0YlvvoX8ooVISWUh7EJRgukTVjyxHJ/IKUrzqwfhl+JMlPmYHXj50dEiPlFooclDimU0fbSFIi+zS++4Jwu5nfwlWRHCruOL412FB9UG3P821SlyyD7UwZ1RjxxwQOXoMEiVDjfKCj+XvvyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935317; c=relaxed/simple;
	bh=WrBQzEVdkr9eFlDo6TfTnyixqRJuUi9ObIKqgKXSr1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DWb0TwUfpnQbXR9O1MklUSVlOzmvaZ2dc0Nm39t3iHl7LVZ+yXPpVi0wFbjLhw1IHWmnCkrbcjHcjHGOZYieozjpceOOzFThzVFIMyDUrL8ptVszHM3wTxaEp/YAZfckTy5QIPYcIo0iZkSHpejJcM+rO619XaLlMJIVM3yr+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3+hFNdNT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPJF0vUS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708935313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrBQzEVdkr9eFlDo6TfTnyixqRJuUi9ObIKqgKXSr1I=;
	b=3+hFNdNTwTyhcQ4gji7UQoN236No0WL6XgQ1WNM4PJCrNqgbjexH4p29tk2jToh66k/Box
	GHTbIN2x5NZ5+1cs5g6M03TDYPlNAXnpnDNpQbNs9V9hulxihk6PX0xKzzc+F9tQVqmzRm
	xdwBsgDvdy14mxBpIJWMkJdX7zO8b7s8cNPd/YA4gO5wySNN4oKLyn10F+suLuLK6g5Tr/
	qFMWPsF5a6xAt9Ewu1M7NVKIvDwo4so+MR0TMwezqcpleE/orWgqnANF8lPxWu6HGM+oaF
	+o+G8/Nrlo91aOEExlhQ/dTKVPcj2nNDlHunmW6iCRszIuchcwEvAHJ8czPpsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708935313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrBQzEVdkr9eFlDo6TfTnyixqRJuUi9ObIKqgKXSr1I=;
	b=EPJF0vUStO0jQlZ8jSCpR8WvjPGzqfzIdXit4FOjn+doEok6SL2KUVBF1qnVqfkfJ4qhCR
	D1QkLAyNVtOucuAA==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peng Liu <liupeng17@lenovo.com>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 01/16] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
In-Reply-To: <20240225225508.11587-2-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
 <20240225225508.11587-2-frederic@kernel.org>
Date: Mon, 26 Feb 2024 09:14:56 +0100
Message-ID: <87r0gzbq0v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 25 2024 at 23:54, Frederic Weisbecker wrote:

> From: Peng Liu <liupeng17@lenovo.com>
>
> The ts->sched_timer initialization work of tick_nohz_switch_to_nohz()
> is almost the same as that of tick_setup_sched_timer(), so adjust the
> latter to get it reused by tick_nohz_switch_to_nohz().
>
> This also makes low-res mode sched_timer benefit from the tick skew
> boot option.
>
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

