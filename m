Return-Path: <linux-kernel+bounces-71208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB89C85A1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989342815E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE802C1AC;
	Mon, 19 Feb 2024 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3mVrcyt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDtAxRPl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6A846D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342328; cv=none; b=rCwR+osHJK82/WpikcJAlB13VhsLZdBdwE9Yi+E2OV7SZSj6wUzd0pxqP+Rhfe0KCdy14yi+5SKBGMe5pj4x3zfoBLFCntZfHudMnqo1UjSfks7H7yBVa5P6+5k6Q+cvWopF7AC4q9GR/VW2A2l8bD2FUWJ8ODBKUN1adYqVF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342328; c=relaxed/simple;
	bh=VB+iI+fug3eSv+fm6efC/2HzoubUcnoN5nHFZ5Ilajs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DRKFeb2E2OoJzaDt3V7Zq3EeaoBpg0qAy7nzmBjGdICN9MBzKcuYDdjqQQopWDkHJto56SlnsywPrl6iwaOF4IQJUwbTZmwlXbSxpUvu/qe18ahyPwrOHC4bbPXv1QVLfQQwYtQWmM/akeXjxDbNwi5QraB5duR1iVKInkXvRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3mVrcyt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDtAxRPl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708342325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9GKMP7xsT1loNPYfLVLghc8f51mY65KwFSji6d7V9c=;
	b=r3mVrcytCIs8QLqrdWr39/DIFhcznwBqlN3h4H9o8F/dC0wT/URiiTyk00llHe23DJ3r/e
	PVy50mxs2O2Ix72eXn6rlAr9QD+VNvFcZ+0el1nAKiu/YiXky4GvarLmK+Ut0HZlqpNQuu
	6fQGEL4ykjTQqLFQRnO+nydQIOTXUkGSSJpa1LWWmZHG2Es7DUc2Tf7KszIpSoyxixR28R
	gnY7uJj+iCWklWIeBuHki9gdU31WCsvKICfBeMCnj65+4PLJ+TDODJZ9o2XSlaiXccDEbC
	EpjVdw2tG56Fp6tKxS3jrAvnV1HdCc8n/I7V8w3RpGNPP+uViVLEUseg1UWBcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708342325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9GKMP7xsT1loNPYfLVLghc8f51mY65KwFSji6d7V9c=;
	b=ZDtAxRPl7wR51qRS5OnoEFuZY7Ks2O8U9b2bi+nLIyvPjZmAyNVCX8/T/gdGNmeA92rezm
	LOdHX7yg3SmDzsAA==
To: Feng Tang <feng.tang@intel.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, paulmck@kernel.org, Waiman Long
 <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH v3] clocksource: Scale the max retry number of watchdog
 read according to CPU numbers
In-Reply-To: <20240129134505.961208-1-feng.tang@intel.com>
References: <20240129134505.961208-1-feng.tang@intel.com>
Date: Mon, 19 Feb 2024 12:32:05 +0100
Message-ID: <87msrwadvu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 29 2024 at 21:45, Feng Tang wrote:
> +static inline long clocksource_max_watchdog_read_retries(void)
> +{
> +	long max_retries = max_cswd_read_retries;
> +
> +	if (max_cswd_read_retries <= 0) {
> +		/* santity check for user input value */
> +		if (max_cswd_read_retries != -1)
> +			pr_warn_once("max_cswd_read_retries was set with an invalid number: %ld\n",
> +				max_cswd_read_retries);
> +
> +		max_retries = ilog2(num_online_cpus()) + 1;

I'm getting tired of these knobs and the horrors behind them. Why not
simply doing the obvious:

       retries = ilog2(num_online_cpus()) + 1;

and remove the knob alltogether?

Thanks,

        tglx

