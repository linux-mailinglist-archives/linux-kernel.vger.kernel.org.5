Return-Path: <linux-kernel+bounces-80738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A2866BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C001F23BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4F1CAAE;
	Mon, 26 Feb 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xID0BP+M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/rRB1ng"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E61CAAF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935327; cv=none; b=TIxQe1Ppd0C5LJTE7KVQoEt6s1WaRhWQSKiTYANvNjpu17varXiRwk4ubt7lt6d6CWKIoiTOkvC3ZwauaXZjQzaBw0v0hax5wYCW+noBMqfvo2MC9xVfejROFsUGH3jr6MLuoUFu7hT1z+JlX79mVb9tkEnZj0/43mpNmI/kvSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935327; c=relaxed/simple;
	bh=y+U9v8RalDvKxA8GYD5es91kGHKIiVKGdn9ZyMUAuyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IphFyfknUh1hyQ5X9CXuf0xggN1JYp4kyg8gvGoqwe2J+qeolW97n146NEVbRlyo42Stj2rJibIm+Gp8KUD/XL4KOQlBrSiFFwPZa6IiiyrZjHx0AY7P33HHS9H22/O9Pe2LgWUVxjKtYcqSmhe64ol0wnneIrXjhrm/G1NEoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xID0BP+M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/rRB1ng; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708935324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+U9v8RalDvKxA8GYD5es91kGHKIiVKGdn9ZyMUAuyI=;
	b=xID0BP+MgyBOUYSphroggrW0JKnOXX/5zPs9E7gOtOguhROj+riFJ1vfd7J9rrDQXuZjam
	XOkABpizZl/UjYfuEnk/gvRsXr+I3ap3zjSNS1qmb69L7EopA07TSWleqsqII/gKrxJZEJ
	/aOVXza+JUao7IKwWJYBmoyMLQizuqRGMJF0GI1dg9K0FwOMJSyRqwMz7HkqDpKF1UYOVT
	EQhuPgnzqAG4e0kdoh+0gZQ84IC6e94GbgK9TIFFP9S9P4GsPcK0Sm3LIX1f7ev95jf4GR
	iFm6ui1YsQL33bIU7QhjM85zKaCdkxosJgMFLMUieaF6dj0ue87Y4mYniH8wFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708935324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+U9v8RalDvKxA8GYD5es91kGHKIiVKGdn9ZyMUAuyI=;
	b=Y/rRB1ngIcos3Ho3KRJf2SPoodec4x1rSs6thZB80+RbONoq8M1kkYhlhY95jp5QgJm+9x
	EmQkGcWIWiU6zGDQ==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peng Liu <liupeng17@lenovo.com>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 02/16] tick/nohz: Remove duplicate between lowres and
 highres handlers
In-Reply-To: <20240225225508.11587-3-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
 <20240225225508.11587-3-frederic@kernel.org>
Date: Mon, 26 Feb 2024 09:15:23 +0100
Message-ID: <87o7c3bq04.ffs@tglx>
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
> tick_nohz_lowres_handler() does the same work as
> tick_nohz_highres_handler() plus the clockevent device reprogramming, so
> make the former reuse the latter and rename it accordingly.
>
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

