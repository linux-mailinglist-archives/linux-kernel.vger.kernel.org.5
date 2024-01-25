Return-Path: <linux-kernel+bounces-38279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4BB83BD74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7217A28D291
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A31C6A5;
	Thu, 25 Jan 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmSUjE9T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yb6fLBhx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1C1C686
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175229; cv=none; b=fQvsIWUZqlTMjtsPuT85NnCJbR+2NhGg3kjlE5xpk//mSDImm2Tkn0Kg7F4O3KdWoWx3ANf8ZhCnJTjNKf04pozjIkY/JPJM28vl1Rz1aoPNufowNkz9Ry9WcTihAgZ5NzZ5HeWf874U0vBLs90vJGRw7UbAIAiXd1O8eXlj24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175229; c=relaxed/simple;
	bh=yo0rhXWM9QETEM2P5yv6ibPUP/SlSUa5WyJ9O8BKEGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SzKjmgtD+/lEpjZKyUsWJnKyCT2tnZHF6HjgbEWtdv7QIEdAZpL81YAoX3FH/PJz08KicGqBilKJkfHi9I2A0KSstQaQyB3C2OytcMSxtDla9nGPY+h5YNV4aMpM5AVzygSymmnTjdNbeK56Jhhgrkb92zNMV/80p6ywvxzyw+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmSUjE9T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yb6fLBhx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo0rhXWM9QETEM2P5yv6ibPUP/SlSUa5WyJ9O8BKEGo=;
	b=xmSUjE9THglvVIBgewP8zvNHcCFT1gK4C45oaE61+9tTUtyAOxBjO3+Wc/dBe0FUpzoXZJ
	5BcCKHGwp0UzMWM7Ua9PdGueJGuXiMbHqKoJ4L0n/WUW+vdZXSp9HQ0S4SFPOEWdWxt4sA
	lVhJ328bzvDzliCR6QyDPNE0Fy7R8TIzIUnKPq+ZY8rQrpjs+kWfzD8qh9KkP47beBVHSm
	2XVv08aNYdPPunOLEefGD4Q3i6Zv7JZEuFtwcZ+jmgaq41SdtawqKRc9BrtUQ9stIr6iS7
	51ehE3xhKMcw/N1fD1bq3/K0Vo58w6/kp6ZBGI6Lah79kdi5Ra81gYdn0ChZEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yo0rhXWM9QETEM2P5yv6ibPUP/SlSUa5WyJ9O8BKEGo=;
	b=Yb6fLBhxUqFSnnzEL7nsWuLrmCIVN3dSxhWKQB+Fr70bfZ/cCwVsHV1dkCcttMsXUGLNiR
	WmcxppEvf5o7cICA==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 06/15] tick: No need to clear ts->next_tick again
In-Reply-To: <20240124170459.24850-7-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-7-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:33:46 +0100
Message-ID: <8734ulkb9h.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:

> The tick sched structure is already cleared from
> tick_cancel_sched_timer(), so there is no need to clear that field
> again.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

