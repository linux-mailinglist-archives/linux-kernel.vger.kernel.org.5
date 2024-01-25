Return-Path: <linux-kernel+bounces-38278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51F283BD72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3AC28B8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76641BDD9;
	Thu, 25 Jan 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlrwF079";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mYMdvAj/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55AE1BC5A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175207; cv=none; b=o+WbEQaDswa2M/g6zahqbZ2fYxB8iOceoFGbjggKhzPdyASjRWx7WlTrwyw4n6TgdRKqv/OOiKAic3TBOnWRtl9pzlcTRSuaL/jIrJb8VWR7SEM61P+3AH32R0SPC3pW6zPsJHsteFzJ4PTXL/EGwJXgaesSAtqiybWe7WMs6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175207; c=relaxed/simple;
	bh=TEjImORvCFHxMVp3gGbH9R3DIpPWtss48HY4Y5+qn64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r0zApHsF1I9W0RmeI1e0jihi+N/7L/IG1ZgklaAegzYYf57teR9iuTXtNurRnPE9vWBqfCJjA0gqVWhQjtJB9aPYk84YT7WeTFPoB7OXvm761ns+ZElZcHogwmbgux5D7jMQ3v0VnwzpGsNNivMfa0c3TSyE203UNNClGsL7WgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlrwF079; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mYMdvAj/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEjImORvCFHxMVp3gGbH9R3DIpPWtss48HY4Y5+qn64=;
	b=qlrwF079mtwmZS2gyv9m9Cy301m5vV1fFA/VBFq83w9GHej5opnVp0zHveW5xAqNgdOH6Q
	IDoj1hW/XvOcKv3jduTyxpRX9U1lQ3j5GmeBqxJO8bNRD6a8DNbJAWEOG9wxkXnz/zQ0cm
	k3VXpuSK0FF0QPg/0iAmagU3oQS6tYBI7/gxmzCafUYZaDWBBrc7DQFAwMIGpPH4sN9IHD
	JLFGTUZPlwkbZTyiebqZzJFd9ergYg/fyDmOT4vUAYKxiY/pRe/HZRyEybg+pBqgWJhlIf
	L0lmWq39LQw+QSqMGuQ5+3KI5Dz27peiuG0EsXs1jnr8oPSdVTQyyGBDuaASig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEjImORvCFHxMVp3gGbH9R3DIpPWtss48HY4Y5+qn64=;
	b=mYMdvAj/fXrMFbZZMXwF5pVWIEZ4kC3+urWdDHQ0lkK50trk7W/F73gAVvXUqdi4rGL4PC
	parCgzM44A8offDg==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 05/15] tick:
 s/tick_nohz_stop_sched_tick/tick_nohz_full_stop_tick
In-Reply-To: <20240124170459.24850-6-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-6-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:33:23 +0100
Message-ID: <875xzhkba4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> tick_nohz_stop_sched_tick() is only about nohz_full and not about
> dynticks-idle. Reflect that in the function name to avoid confusion.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

