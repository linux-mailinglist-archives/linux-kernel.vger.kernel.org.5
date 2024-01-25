Return-Path: <linux-kernel+bounces-38297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE983BD95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2C1C20C75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BB1BC5E;
	Thu, 25 Jan 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d7jQDHte";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbeuouD8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CD1BC5B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175674; cv=none; b=WC63o7xbBxyNiVG6JLInV0LEMYpDbYNYlV/nIeSmmWHsN1RWGPpXz6tzE8vTYntnRPALZBrfw61gFCaJkXeu+fyY++BmH2d92Ux8amd0hpXuGNJFQS4ls+3l2Z5vn2TiX0OcsQBukcTPkzn4Pj0tZpYnfPSpe9LIFyqayIXDxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175674; c=relaxed/simple;
	bh=2w9Bvvn+jurd2Cj78WVPbW2DOqLlbhDiK+4nrxZRPHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nbUVx4iHDwsin5Hjks5fc0IwXJSQiR+z0/IjKMl/NFzndKm7WGDFZShGT82RHUH8togqlWNehLvwu4MtZXSMPp068vT8izSUcitnitMw60tNDRZR2fiF2AORSFsVj/ZFrpAaIx1EK8jn9G9Wl3o8KZVfS/BKv3dy6ls2QtuMuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d7jQDHte; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbeuouD8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2w9Bvvn+jurd2Cj78WVPbW2DOqLlbhDiK+4nrxZRPHk=;
	b=d7jQDHtektlYZ9+1z1ZFXgkAqms7QgMiiBBZAsTWlc3zU2pmWoVpysOX/ktDsrZXl1p92r
	X9q3ccEyC2t3UTVe8K0IeFVCsbg2NovjGiTpwG8ymriMSb8dQtI669LAtaLxqzBBx9OKFU
	TlH/shS0o6SNzJATGrYgmH+EeDajGlyD2o3Q7aEwxVg933ElMj9wz+VULK+ofKKpJ55rug
	S/04H27N+3+GLio1BH21a/7dc90IDoPO62Yq+ayJwrtwvW3Wahh+0gzlI84vN97hQbQ9d5
	GikkZeFZQvRX8SQD+TkiaV2kLaLP/sErHEpkMVdvSBiD2QqOmn8gPbfS5jlLoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2w9Bvvn+jurd2Cj78WVPbW2DOqLlbhDiK+4nrxZRPHk=;
	b=tbeuouD8d2F/1HynGk/QbDnc3UrrZ8R9cUNyBzH13Baq+Z33SZkEDK7pVzwm1immEetIsf
	xHRelxR4FcE3ZiCw==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 12/15] tick: Move individual bit features to debuggable
 mask accesses
In-Reply-To: <20240124170459.24850-13-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-13-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:41:10 +0100
Message-ID: <87le8diwcp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> The individual bitfields of struct tick_sched must be modified from
> IRQs disabled places, otherwise local modifications can race due to them
> sharing the same memory storage.
>
> The recent move of the "got_idle_tick" bitfield to its own storage shows
> that the use of these bitfields, as pretty as they look, can be as much
> error prone.
>
> In order to avoid future issues of the like and make sure that those
> bitfields are safely accessed, move those flags to an explicit mask
> along with a mutator function performing the basic IRQs disabled sanity
> check.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

