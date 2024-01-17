Return-Path: <linux-kernel+bounces-29252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE48830B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CBB285C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01793225AA;
	Wed, 17 Jan 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEbK969K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A2224F6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510871; cv=none; b=lSF3YA1f2aSGMEL5qGMeu35dyfVbww6SJ9DF48zcVBBr9xa98BDjzAXriFlxP+5yre9hlKNge+NmRzBM4HWbJ6IjQQF6i8yPUc4VtLGaMk63hVLYgkPOvAV9n3j2PdQTKjgdXT4xcbhyMql5rT+g2Bf45WURg0lqpTwSvojqBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510871; c=relaxed/simple;
	bh=VEttfhQ1pwrDVRGckS4a10zqh/nueRRzPwdDk+mQMrA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=kEQUVF70vyRB7C2lwS2mzdtizIykKIwCrbcQRKCy9NKh3y/4lTO7318peAobEiYvBh5yDlgtgeykk1wllTTf8SPX5k3dRqedvIQHpK4j8zYf21T8LJ330BKcRwXujcHMOajGuAthUFLeLxrjKHjrdoznqDRkB+wCnnMMVRMHQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEbK969K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66484C433C7;
	Wed, 17 Jan 2024 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705510870;
	bh=VEttfhQ1pwrDVRGckS4a10zqh/nueRRzPwdDk+mQMrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEbK969KmwK8Bh26AXb670U6IIMZxfKt67vPnKDo87rXRWEsHDMvoHG+pMy1r8V+b
	 9DHX2jwCsd82itYiXcryojmvgCyhm2QF6kAEBh3z5WXxB9+v887q66WotH85l1pD01
	 fQJYqQERcsrFGvqlFfyLH1nZxSLtbsK0tws+6Iu0dAFttqFxkpSbZqiO3zWz3G9byq
	 LUamJZ0iKK/zDjeenOqKyt/EmwoHAFM88aq9cwqBT0TLmHQIPcbTeQ3qOTAeUDfuro
	 nhqnqg/42ywLhlEfgYJIPTf4rRaEworXsUUwaCinxRatZFYmQFIH38pC55MchYEXYz
	 qxDKMPTRR0O+w==
Date: Wed, 17 Jan 2024 18:01:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 05/20] timers: Introduce add_timer() variants which
 modify timer flags
Message-ID: <ZagH0wPCR9PusLxq@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-6-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-6-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:28PM +0100, Anna-Maria Behnsen a écrit :
>  timer flags

Yes ;-)

> 
> A timer might be used as a pinned timer (using add_timer_on()) and later on
> as non-pinned timer using add_timer(). When the "NOHZ timer pull at expiry
> model" is in place, the TIMER_PINNED flag is required to be used whenever a
> timer needs to expire on a dedicated CPU. Otherwise the flag must not be
> set if expiration on a dedicated CPU is not required.
> 
> add_timer_on()'s behavior will be changed during the preparation patches
> for the "NOHZ timer pull at expiry model" to unconditionally set
> TIMER_PINNED flag. To be able to clear/ set the flag when queueing a
> timer, two variants of add_timer() are introduced.
> 
> This is a preparatory patch and has no functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

