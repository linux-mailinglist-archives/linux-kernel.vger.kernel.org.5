Return-Path: <linux-kernel+bounces-38313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273E83BDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980AE1F30FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652D1CD0A;
	Thu, 25 Jan 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oRweHhD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GjeCDBB+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FD1CD03
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175825; cv=none; b=LpZpUPtt2IZxFdTetdNNxTKruGQxoJas8F6t1CZ68GxEpXjUKUTgq07X1jNhFHhV2FMgD5Rw+ka9L73JqG0Ir+SHPm1jr82Fr8KbZm9R0UBPN0ArdIXW/h894avgVJDUz/pZKuyRB97NFR0E9cf9m2HEcfjxiKZ2WxWKW8z90pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175825; c=relaxed/simple;
	bh=Yr9dAi+HF3e8xeG38C7Z8bramYoSGYC5W2XMpzSL6QQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FmpUs5BnSEiX9X1+JQNwhexwIKJQgXWPXModEJ7sabDiHmI+hTG+lllQ2Dte7LfVcg++TBsljd08D8p1QA2NQTtJHDbdndZiIia3Ke5aK8ytAL8o8Ni71C0aq607J/kW9Y2WpXBwccIQRyBj44crxn5NTEBT65y/7yp62yvJLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oRweHhD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GjeCDBB+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVKIZDXyohVuLgWytwkihjnuLVIZehHyrbXga6PEsN8=;
	b=oRweHhD2DsD2ynBsTuWLLrL2xnsEgDv0/zU4UH1V0fH7P9/2BF+nJap/vC1ja3WVNEyOFp
	4jESfd63bWktIYJHnZ3ydOsyUyDa0zhk4lKCvzTub/eUmOHJj8HJ9zbiHIGx2lbfWfl8aD
	QOnHtnpt8zIg8QEsqnAdvHU44qb/nxJaGgjs7nOIQf255Dj+FF9CbvJajvISyRXG2FLKhQ
	Hgjai+YV2nqvOA/x3gaUpz2b1TIS1EsDuH3MlIX3aYdUc2TrZVejYr9EPUJGykSpYyod8j
	Ll6wI85D57jxP7n1MCIeEivtcQfINMxfUNqQg+W20MEg8ODlAJ2BnHFnrR8liA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aVKIZDXyohVuLgWytwkihjnuLVIZehHyrbXga6PEsN8=;
	b=GjeCDBB+jvltyKsxEDLAtPdFUaPcck6KzY43OGZnHe3aJf4P94Qp4OescV04qgjna1QINo
	MdSMcgc4Am05T4Cw==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 15/15] tick: Assume timekeeping is correctly handed over
 upon last offline idle call
In-Reply-To: <20240124170459.24850-16-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-16-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:43:42 +0100
Message-ID: <87bk99iw8h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> The timekeeping duty is handed over from the outgoing CPU on stop
> machine, then the oneshot tick is stopped right after.  Therefore it's
> guaranteed that the current CPU isn't the timekeeper upon its last call
> to idle.
>
> Besides, calling tick_nohz_idle_stop_tick() while the dying CPU goes
> into idle suggests that the tick is going to be stopped while it is
> actually stopped already from the appropriate CPU hotplug state.
>
> Remove the confusing call and the obsolete case handling and convert it
> to a sanity check that verifies the above assumption.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

