Return-Path: <linux-kernel+bounces-38311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB283BDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587A52947BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFBB1C6BE;
	Thu, 25 Jan 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SvGUA8iD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o14sfim9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897E1C6B2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175805; cv=none; b=jws0fISkMCCR4+575snp4MOcLjXcExW5a3LkWUMM2+kuqKWLDY3DRuHzjbppMrcbDClkyUyExXAN8kQejIV+whAw0RVyGS5TfnSyrZzF/vCCdsGKUlGlRvsQxbavfQqmc15QhVzPlK1vKmuR29h04q0Kc4ymA1pTPJfkd62PPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175805; c=relaxed/simple;
	bh=koPDz8HneqIFQoDSxgsc41QMv27DcPBkMJMXFk2+xZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MqQr6IzuTLUTdK2FE/y+QIlfcBujneKXK5N48lsL/60RChaSRZlqsy9LTwfk3DdhDr/ObpET3zbBJuVgTk9Xb8cH/fpqcddIBtM94LQJEjIjYNwnfWXALcyHk+HZauJMYRl7GNplz0n7J2EDKK3nYs3+BgZThzpCjM+7CuuBvio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SvGUA8iD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o14sfim9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=koPDz8HneqIFQoDSxgsc41QMv27DcPBkMJMXFk2+xZw=;
	b=SvGUA8iDWMow6WuNG6RZmydsgSlfg5YOAtQbM+AY9u222XbgUe098GYp8gcbGwzuI72ung
	rpAWn5A7hC9vND70c7d54JEYi+vnvSS+H7SsZut10HgaqtLbrXYzQg/T88ovuo//E6ERQi
	snA09Ph6gg034jbvfMNbkZggVxkcnwCKDPeYSL88Qau0ZXao23psV68CNbWlXa5fyHjMev
	CnA2+AfKA7niAFyOguw6k0dqRQ4B+o4CrsFt/rK83IjjyPMc8WsYwO+Pihpps6vlOX1Ti8
	+5EKJuljP8pueBYoYR2rdnDzjOOQQ0L8qCGFMjvcYioJ3ZjoBWt3LDe92yUKNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=koPDz8HneqIFQoDSxgsc41QMv27DcPBkMJMXFk2+xZw=;
	b=o14sfim95l9bbc/kt6d1W+wISyECkYmuI1de81Adyzb1KmLwoX46b2WwEVi3/Xh5PuTFmx
	UhPbZzfg1Y7EgdCw==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 14/15] tick: Shut down low-res tick from dying CPU
In-Reply-To: <20240124170459.24850-15-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-15-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:43:22 +0100
Message-ID: <87ede5iw91.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> Prepare for consolidating the handover to a single place (the first one)
> with shutting down the low-res tick as well from
> tick_cancel_sched_timer() as well. This will simplify the handover and
> unify the tick cancellation between high-res and low-res.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

