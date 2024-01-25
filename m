Return-Path: <linux-kernel+bounces-38293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6AE83BD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23832937C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14261BF38;
	Thu, 25 Jan 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gg5hIz7m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lvpdltox"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF61BF28
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175572; cv=none; b=b1P1VyLfbIaw9M6MMjZs1sInbd0c35tCVScn+XpmFzq0lsQOqtt/T/vTdd/Tie3AowoIrzLFKaOCL9G2J3RRdpZNhJkyLjytvYC0DglLIPAnZRQAwcrbtYQvFpvh3Uhye41WacKJ6heCnWTfjkWXTP2ZOKTVxBtipv2xpeCePm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175572; c=relaxed/simple;
	bh=prZOw6tKpFn/6JU4veL7w0WW1S6fKNMT/YrEaAwZZM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dvoju0k4bntOHjLFlXc1lyzhjdJAM+aF8H6KbBIunkXgmKtkeylPd9oVxhMKMWDm78rYSLwV5EQvxFxDFHearxG1LxeZFKEG5lHWiF9BKHjJYXZPJ6+gbbanKFWgaVIVXef39Ta+idOsPXOz7QSfgHR7N1oO7UgVKxlcRMEdmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gg5hIz7m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lvpdltox; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prZOw6tKpFn/6JU4veL7w0WW1S6fKNMT/YrEaAwZZM4=;
	b=gg5hIz7mtx30q1cjK9rRUqiaH0ZuTmvcU7chA38OHY+pYCNMVMLzrze2CMgpysKkQ9kAwT
	nfbzIyhZ0N2t4qXGSY0B+EgHvoz68DaGQish9eDxb0L4a8eRXsvCqSFOIwB1HgYoAWg3Vc
	3SwpMmrK0K8VdX8M8bcRIeSLMlgG3tkiVXVzB8T1WTPGXu08AysxlAXfc3moMLBFepNCJK
	3XdiG1yO/XEunuhJMZ0DtO0a5nlpAClgnd4AldL5NPdU60wnhkoWIzL9oh0s3Q5rCw+Oaj
	OUFJAyMkeFbgmkKjpbVU4Td2egGXE+DsL+Ux8zrFSN4y/hHGpjEVQKQ1+Zj8Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prZOw6tKpFn/6JU4veL7w0WW1S6fKNMT/YrEaAwZZM4=;
	b=LvpdltoxW9NZZxeXyLhJEMpPiGi2j/7Wl4KyuhVozaCrvtzCrSZ6gDhCmmRb/XQCjEY8LB
	h07ujrJGqhDmkODg==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 10/15] tick: Assume the tick can't be stopped in
 NOHZ_MODE_INACTIVE mode
In-Reply-To: <20240124170459.24850-11-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-11-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:39:28 +0100
Message-ID: <87r0i5iwfj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> The full-nohz update function checks if the nohz mode is active before
> proceeding. It considers one exception though: if the tick is already
> stopped even though the nohz mode is inactive, it still moves on in
> order to update/restart the tick if needed.
>
> However in order for the tick to be stopped, the nohz_mode has to be
> either NOHZ_MODE_LOWRES or NOHZ_MODE_HIGHRES. Therefore it doesn't make
> sense to test if the tick is stopped before verifying NOHZ_MODE_INACTIVE
> mode.
>
> Remove the needless related condition.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

