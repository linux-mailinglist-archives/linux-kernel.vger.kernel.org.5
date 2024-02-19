Return-Path: <linux-kernel+bounces-71584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1520685A75C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D410B20C88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCD383B0;
	Mon, 19 Feb 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vpn+Z78";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBpjmYWN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40973383A1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356578; cv=none; b=js92YDxPNJwVP4621fQyXyzlPey3Ap4GfxyeIg8zj/q5i1V6GWs/n9cUr9+O4ByVR+8P697B+RR1Kev5ewaDZ/qAjwgYFC3In8RoAQSLNESXSZF0060mHgCLlCWgNczsFpqgtZrA/8MZyGGnT3SvHoxH0FRq/hqDk7fIWAEm0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356578; c=relaxed/simple;
	bh=NNge+DiPJ11bEmNgg0BaxsrHSS4x7ZUk63hYvJ7Eyxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzyF/0a+xvfFIbzOgPUnlxrDTodJEUSo2XplBEHo/UU5vXULtuRCqcY7fQoRJ1wYa2/NNM7dkkf74PMaLeDaQ10h1Zsne9PSAMTvysNa7fiei9Lx4zoRUdGJUoDyyDJ/egzqEliPevzWFUD3d3/cUR1VN1AnZl7oXU53go1712M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2vpn+Z78; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBpjmYWN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708356575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSTeQBcKNQ8+VhtrTp+eNttn9HFU+s119C7tD60G8MQ=;
	b=2vpn+Z78L8cIfTIOhn/aHwAqfNXLrW52pifCKDB2PRVhZevpkcWwnwfzf3tP+iU89chDl1
	KNCelMw6PjxSVsaTIWCVks2PWia3NAA894bReR8vHqhilf/b5I1G6/B4jM78/dKpzdhN2z
	OOiho7BEkfXLvqTX4pSqoR3mWYYtZkkkzTQcH3sCOYcfN7/7svgAY+qf6BV65JfdauhFY9
	4nrJseH5SR+bWV2COGMrM7jg2Q65cw8z03Fyuu2t9r93CWqsx+m2U79E6XXj2bYJbC/pac
	qI+GvxMGrd+nCo+2tXMHAb90NNzEtm7IhnIj9yLOlYL1/6CHCWEHCQtdhvxrzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708356575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSTeQBcKNQ8+VhtrTp+eNttn9HFU+s119C7tD60G8MQ=;
	b=BBpjmYWNVmNnpedWayf7kdpF/bztAg0qfCMiqGDfpK894Pi/rFxouton4Lkq/2ezvF83TP
	kuKsOYDyX9oBcKCw==
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 06/30] entry: handle lazy rescheduling at user-exit
In-Reply-To: <20240213055554.1802415-7-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-7-ankur.a.arora@oracle.com>
Date: Mon, 19 Feb 2024 16:29:34 +0100
Message-ID: <87plws8obl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
> The scheduling policy for TIF_NEED_RESCHED_LAZY is to allow the
> running task to voluntarily schedule out, running it to completion.
>
> For archs with GENERIC_ENTRY, do this by adding a check in

Please write out architectures. This is not twatter.

> exit_to_user_mode_loop().

Thanks,

        tglx

