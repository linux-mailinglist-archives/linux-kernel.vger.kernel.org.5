Return-Path: <linux-kernel+bounces-75160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86A185E3FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BCDB22164
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2E82D7B;
	Wed, 21 Feb 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P+Qs26aP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nAYtU9cr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36897FBDC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535111; cv=none; b=rgY+5YGr4l35/fry5LG5XfLuCY0XK986R29Ab4bNKHifIkPilM/biSjscr31Zg/Fcql8y9TdsdZNMwXhDNEjw2VZ109OhhAIfjEw29nKJumG22KP2JHKkUGCgBGQvF8uTYNqevPHDTjv2BF3dk25/N5pYlXeVvFzlurrSQKv2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535111; c=relaxed/simple;
	bh=x24PyqKUc1hsMPtepg2CFDTZ6CtjMH3YwJ5m1aqgwac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xe91+AAXEtgx1bo9ksSU6efHLswviH+cQ0Fo2weZw2C3vIDRWBTplLOqSw9R11KaBk3cHusV1uz0Jn4gVgiCYOB+3MiHueV8esIHfgf9PMpJfTah8x/3fLYlKMAZYS1w6QuEGGREeoHeY+8XWvs0FRV8XwsFcePfCRNNEJT5gcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P+Qs26aP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nAYtU9cr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708535107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kby4gEwuJMAp1Ov6kJ/hMBEc+9lSUMNWBq74TN3AABU=;
	b=P+Qs26aPpN/G97iS7l9TsaLTVoiXW23FZB5RqH39WNB1b7HlOkRZuKhMNnOJ2fcO6b0ay/
	KJp4p9dZO+l2o2LNDS0yg4wQC7EdCO5hbN8nFIdZIbYANy5Mv62GvloPblF1lyNuWErmr3
	QOWPcn5MuE+U/E9NiPrkMwM5SU2QVfraQBDFAARTBCV4OJr2JfG7+GtLtC8uOq77JTCSj9
	oaPTl8PP8/+JSdxQTQyzGMhMmI8WYIiBjJ4Jg/TpD7KbtZ/ZCMYtQ5ud8wHyA2SqHiBh0b
	TQKuePD4Dj1C8KipK62va+jDO339oaQpg70YwsMkn1yTfxKKR9p4zHGaC7fcWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708535107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kby4gEwuJMAp1Ov6kJ/hMBEc+9lSUMNWBq74TN3AABU=;
	b=nAYtU9crsJ2owVQDCREqCD37iAgxugWmOOqsGJ27JnpxHIiUjyFMdawvitjCs1e1TR20xd
	kTJB8XMauhFcesCA==
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
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
Subject: Re: [PATCH 02/30] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
In-Reply-To: <87ttm2hhsl.fsf@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-3-ankur.a.arora@oracle.com> <871q98a3h2.ffs@tglx>
 <87ttm2hhsl.fsf@oracle.com>
Date: Wed, 21 Feb 2024 18:05:07 +0100
Message-ID: <878r3dhhoc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 14:50, Ankur Arora wrote:
> How about, something like this?
>
>  +typedef enum {
>  +	RESCHED_NOW = 0,
>  +	RESCHED_LAZY = 1,
>  +} resched_t;
>
> Still, not ideal. But I think it's an improvement over those two.

Fine with me.

