Return-Path: <linux-kernel+bounces-56493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4984CACF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509FE1F27428
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FE576032;
	Wed,  7 Feb 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uubl5FkQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYII8niw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E7D1D689
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309700; cv=none; b=VSNtvKeJtip8vV3W+SVezyIaY+TqNqik0WcwC8VLFzwP/rX0AFotvDkkyKgueeTIU/J6hvEZ3MvvyvXXlM6dNMaVJcY2JDZUDhHjTSdBkFHLU68W7kYBAEsPj3YfDJboE77TS4jnL86kXfeQQXJp9No/brb0nQTWxw0OQb9Cmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309700; c=relaxed/simple;
	bh=lWGBGQc+QfecZW51XPazX31oQlJerXe3Pe9pVPK1NGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFGqxl1ALvwvL2ydPHxgSDy7wBYN9aJbhQzWOEIwomjByajO9uhCiERj89Wpk3RBJ4yFMEzXvkWeQX7mTZBUl1nQmlCD1U4OprWcAlWwBri2rf1R+W46DKCySVufPZloDV1pGHJAWtMo+C1w88GrPLN3w88/GbUjmainINyomlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uubl5FkQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYII8niw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707309696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVIbUHMqVVyjB7JP4FhbkXQA5ZZ35lu5Vq3yQdkzZaE=;
	b=Uubl5FkQbWU1XFY82rYhYvDfKKPQuj4pBr79SX5lA8WK4TZDqz1TcOtj8DsKJ0HYXiWS95
	ZewqpseUxXuzCZKalPb++Xk02ZH1RPHZ3z2WXVfKTTTgsgEhfXFGcWzUVEUD5hTu/RJK2L
	j5+GlwtWwVlZkQIcSCzV3wrXNb8oXjvRphOz5Sc2GwDir267mNIu097ilQzunbtTgiz82G
	JWlbt6l8x/naiPir6TB8CjkpOFyO/lp994PvLShu7gwinUK5Agy81HAJct97+jtwCdUl68
	1JXer2O5USvlIFqNTXOwbulMqAXiyCTaiIXVaW6JqhvUA1N05MWfGc3c20TKuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707309696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVIbUHMqVVyjB7JP4FhbkXQA5ZZ35lu5Vq3yQdkzZaE=;
	b=uYII8niwrzn+/M6AutzBDHcIUQKnxcVwAfbusupkjSA3uAB0Z3MDRnmFihAF7LHMkoOQ3v
	VXImjdpT+e6P3JBw==
To: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, Leonardo Bras
 <leobras@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Marcelo
 Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 12/12] x86/cacheinfo.c: check for block interference CPUs
In-Reply-To: <20240206185710.142514323@redhat.com>
References: <20240206184911.248214633@redhat.com>
 <20240206185710.142514323@redhat.com>
Date: Wed, 07 Feb 2024 13:41:36 +0100
Message-ID: <87eddomoov.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> @@ -396,6 +397,7 @@ static void amd_l3_disable_index(struct
>  	 *  disable index in all 4 subcaches
>  	 */
>  	for (i = 0; i < 4; i++) {
> +		int ret;
>  		u32 reg = idx | (i << 20);
>  
>  		if (!nb->l3_cache.subcaches[i])
> @@ -409,6 +411,7 @@ static void amd_l3_disable_index(struct
>  		 * is not sufficient.
>  		 */
>  		ret = wbinvd_on_cpu(cpu);
> +		WARN_ON(ret == -EPERM);

What? You create inconsistent state here.

> -	amd_l3_disable_index(nb, cpu, slot, index);
> +	ret = 0;
> +	idx = block_interf_srcu_read_lock();
> +
> +	if (block_interf_cpu(cpu))
> +		ret = -EPERM;
> +	else
> +		amd_l3_disable_index(nb, cpu, slot, index);
> +
> +	block_interf_srcu_read_unlock(idx);

Again. This is a root only operation.

This whole patch series is just voodoo programming with zero
justification for the mess it creates.

Thanks,

        tglx
.

