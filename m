Return-Path: <linux-kernel+bounces-96240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B287591C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414A72860F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F913B783;
	Thu,  7 Mar 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5PcvpdB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN/7fdgE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA213B2A8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846123; cv=none; b=C8mgAK8blOuFNsOLGPluU5MfHba8kfJZhIcVKYLa1GaSMQwN6ux6EC72tQj7zOfgDaft/uQpa3aHUNHR40g/tLPJMo5lJkRXilvxOMO7MOHys3G1eiW1RP2lt+KxRqVDP969TUhUvtLGzJOKnqVYX+eZvc1ayxP6HlrznXgSsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846123; c=relaxed/simple;
	bh=uHALnd92rxoOGlPKL7M9tlu3O3dJwMeBTQGHchr9R54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XMm1CroWTWF9eh4c85mOCFlOhAQLgwfHpDtj8HQY7EzQF8HfVW7vmyBO1RzOR8iuD/h/xiOvwWG9s5VBkP5NdOAU3OcyxgmzbmYrvjWxCPd6aVmTQ/nPS7BDvVUJqN3zHjxhX0/GlM1jscSvBHj4kj+uGTVwciKxgffW8ocfjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5PcvpdB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN/7fdgE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709846120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t64qr7Csu0YwoaJV3ZkiF7k9jXyu8u7PLpXFQ/EeP+0=;
	b=R5PcvpdBaWXBuHHCDbeqcUlSjYLQBB/OaWBMGJzbyCHdPjyifO/k/hKmcw9Bllskan7w1F
	G1WersPGEXEMzrFxchUeHSv7h7hRnW6li0CA8W9kB9HD5L+ptc5npNt4WRrLvFk1owwpLr
	o8iiplcd/aUF4Bgef9sR7bm9cMKoxN6WqlzWiL8NXIeGPKuH2o1DN7degUwTQQ3wSl8L9d
	k7WSR7KZFtoqXq1jyZNwxMIrXanksXAvwD7nEE9ydC757stQiMsiLOp0udVbD1RtyMp7U2
	ujb/ExwLJuCa7xff0JeLpCxgYniwD/3ysQWMEt1R3t7u1toc7Xmmx0BwVKmAzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709846120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t64qr7Csu0YwoaJV3ZkiF7k9jXyu8u7PLpXFQ/EeP+0=;
	b=LN/7fdgEtEk/NwmrcN483lvhjFS/QDe22SLvFM6W0t4bgmXOodIVM7czSihu7xbcIZI1gL
	f79jUmpFc7/R1tDQ==
To: linke li <lilinke99@qq.com>
Cc: lilinke99@qq.com, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick: use READ_ONCE() to read jiffies in concurrent
 environment
In-Reply-To: <tencent_8B422629CF388976D1303D2C5B0720089305@qq.com>
References: <lilinke99@qq.com>
 <tencent_8B422629CF388976D1303D2C5B0720089305@qq.com>
Date: Thu, 07 Mar 2024 22:15:20 +0100
Message-ID: <877cidu4k7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 25 2024 at 11:12, linke li wrote:
> In function tick_sched_do_timer(), jiffies is read using READ_ONCE()
> in line 224, while read directly in line 217
>
> 217	if (ts->last_tick_jiffies != jiffies) {
> 218		ts->stalled_jiffies = 0;
> 219		ts->last_tick_jiffies = READ_ONCE(jiffies);
> 220	} else {
> 221		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
> 222			tick_do_update_jiffies64(now);
> 223			ts->stalled_jiffies = 0;
> 224			ts->last_tick_jiffies = READ_ONCE(jiffies);
> 225		}
> 226	}

Please do not paste the code which is changed by the patch into the
changelog. Describe the problem you are trying to solve.

> There is patch similar to this. commit c1c0ce31b242 ("r8169: fix the
> KCSAN reported data-race in rtl_tx() while reading tp->cur_tx")

The other patch has absolutely nothing to do with this code and . Describe
the problem and the solution.

> This patch find two read of same variable while one is protected, another
> is not. And READ_ONCE() is added to protect.

This patch finds nothing. Explain it correctly why it matters that the
first read is not marked READ_ONCE(). Is this solving a correctness
problem or are you adding it just to shut up the KCSAN warning?

> @@ -214,7 +214,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>  	 * If the jiffies update stalled for too long (timekeeper in stop_machine()
>  	 * or VMEXIT'ed for several msecs), force an update.
>  	 */
> -	if (ts->last_tick_jiffies != jiffies) {
> +	if (ts->last_tick_jiffies != READ_ONCE(jiffies)) {
>  		ts->stalled_jiffies = 0;
>  		ts->last_tick_jiffies = READ_ONCE(jiffies);
>  	} else {

Thanks,

        tglx

