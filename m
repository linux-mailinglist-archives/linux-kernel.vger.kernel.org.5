Return-Path: <linux-kernel+bounces-38283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B436B83BD7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CA51F2F7EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D21E1C2A3;
	Thu, 25 Jan 2024 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B4r5Tfdw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0y2FWHx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AA1BF28
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175419; cv=none; b=mKv5Lqba7dXmvMbo/bJb5rYrsMGU8CU2BW34LjHDpY+QighepHpJ+Tk+NF7J5/88jBGBklmhs04LyO8HRvbZogkhU2jdoFnrPqxxLK4ChODcjZIClENsbfTCgUKooQJMob3jeCY6BaCjcSbmUxpa4neVM884ntI0jm0olUyFCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175419; c=relaxed/simple;
	bh=G+cCB6XECDMU/22rzO1zomcVrk/RseTD0sBJaJcEVFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PXexpVnQXHHTGheUnet9rRTNhooiYHPk4MFyAI7We7MS0b7fWYf1SESxLJAH+xPkd2qEW++b40y6YUw2qGViPSHbLIDD0bk9QSruBFClwVyvmPt0ASy5h5gjoM8kPDotOrNbUHVVeKEoufob8w+rJo4sNeqBnubrEMG87cysvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B4r5Tfdw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0y2FWHx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+cCB6XECDMU/22rzO1zomcVrk/RseTD0sBJaJcEVFI=;
	b=B4r5TfdwC0vgHSHR14MjcQHPTT0pRKi2obQcM2QWfkKTd1etBuQ3mmLWD+K+e+I29As/XH
	sm2QtjgWUYSxPcJsGI9Ad2x8H/29Msh4EXHjK7qYnkcuWwbX/bl4+hEXs6B6P2CE1KX2tf
	NbzR8v61Fq0SruEmFguiDPJ6dQ9oSg0jh+dcx77myiJ+g6Rv90A9itB6DL1iWMokVqqo9S
	U3b+4l12zh1T8sJsqVXVLeGZkt9TsMWFILjRBNj83cgqndWM40/2+cgFn4gmlnscFSvGy5
	NKohRKKsAlZSEb1M/hgIOHiyycr8GiOfOWQXSuZ35dvQnCqRDYDGQqnugU0gKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+cCB6XECDMU/22rzO1zomcVrk/RseTD0sBJaJcEVFI=;
	b=R0y2FWHxQRIT7j4naMF+aPnHuQFSaYXisbguBlJZ75jPBUTWCnyc0oFmjj6vc9lrayNqmy
	KYYN1Mb4H/QwqMBw==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 07/15] tick: Start centralizing tick related CPU hotplug
 operations
In-Reply-To: <20240124170459.24850-8-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-8-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:36:55 +0100
Message-ID: <87zfwtiwjs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> Sort this situation with creating a new TICK shut-down CPU hotplug state
> and start with introducing the timekeeping duty hand-over there. The
> state must precede hrtimers migration because the tick hrtimer will be
> stopped from it in a further patch.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

