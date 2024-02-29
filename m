Return-Path: <linux-kernel+bounces-87104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50D86CFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A50D285BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB18A3839D;
	Thu, 29 Feb 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="enwFlzjx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/HQ67LpD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73A16064E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225624; cv=none; b=NkIeK3KYArARUDEAlpQtQELJ7PFXQ28ko541MJgOZ9nNcV/hY/WzY93Tdb5oWS7SkE7Gch38m5hqUhRkzt23zxiWMLpC0pp2A1fNhP7Vjy/kF+B5QLB53b0ZwPRE6Iyxr+OLGOAscGHD9MtkO2LgdmrUCP1ibp7ZqiheyRTTAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225624; c=relaxed/simple;
	bh=tmaQYlANBkHSGvr0jNOe1c6RMNTnCjEqaEWxEiidtqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4B3Jqg7cIXwe6vwrftkV+miO8NH1QOmewgXQYbEKM6W5zpOQswrrr334T3OgNbSRU5VGagMRQBtlqdzgdKs8FGHeRDSFo18kac6kOKtXULy7Ds9A8qqbmjBWOzl20m6y5Tx2uF2Y7IOT1WUnzkOG+7TnQkbebT20BS/VnRPp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=enwFlzjx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/HQ67LpD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709225620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmaQYlANBkHSGvr0jNOe1c6RMNTnCjEqaEWxEiidtqk=;
	b=enwFlzjxEnfgm/UeL9lbZXXZYzo2xG1hwJSw4TrlJHISWw1hjlMaqfKqVU6XSybxdgvwmq
	nQL1tZ9Z2B78yZyS/eRYmNX83pUVHeyhCf6/WjTs6nNP8Y3twrNRWjWtPp4bGntPdwOJCM
	EFpMC+YID+FQtAXVHWmNPP412faGu4wjcADS+47VnDDpvY4Eb3sHMUe7Wf1ZzEvDmJTWM7
	Tyh9SDZ91Hq8Si5lxwS/Q2KIF3pscOZIwGhy3O1BvxF14PpMmcfsWOKnMplmzNK+etyCIP
	v77Vi7M7b7k4G3T/BtCGv+ekcy2JYvFwSlVlyxB5PBJBh00MwcR2X0n71oiZAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709225620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tmaQYlANBkHSGvr0jNOe1c6RMNTnCjEqaEWxEiidtqk=;
	b=/HQ67LpDyIa/Ksy7TiBADMxvYOynQSp5AEq7rWM9rVyMrmXe4tnsfVvQSttfoUyLMs7/3v
	q1vrs+6xArcmOBDA==
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal
 int
In-Reply-To: <20240228192355.290114-2-axboe@kernel.dk>
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-2-axboe@kernel.dk>
Date: Thu, 29 Feb 2024 17:53:40 +0100
Message-ID: <8734tb8b57.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 28 2024 at 12:16, Jens Axboe wrote:
> In 3 of the 4 spots where we modify rq->nr_iowait we already hold the

We modify something and hold locks? It's documented that changelogs
should not impersonate code. It simply does not make any sense.

> rq lock, and hence don't need atomics to modify the current per-rq
> iowait count. In the 4th case, where we are scheduling in on a different
> CPU than the task was previously on, we do not hold the previous rq lock,
> and hence still need to use an atomic to increment the iowait count.
>
> Rename the existing nr_iowait to nr_iowait_remote, and use that for the
> 4th case. The other three cases can simply inc/dec in a non-atomic
> fashion under the held rq lock.
>
> The per-rq iowait now becomes the difference between the two, the local
> count minus the remote count.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

