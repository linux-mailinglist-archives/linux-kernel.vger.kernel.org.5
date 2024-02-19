Return-Path: <linux-kernel+bounces-71571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2C85A733
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BED52848F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3287383A1;
	Mon, 19 Feb 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFGrOB0d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fzw0s8q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10438384
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355821; cv=none; b=AalPaMbe93kUuF0CRP54JQ7KFw/eSthl9kQJ9SR+EzeNgWyr0DFCcwaNE1xSnUDj+iUL91hW6Ib0ZOsxTVQWoc6Y052/cZSoNBHimwEWuSfQ3xUk6CQRyy274ixuMWwEu1ZdCanbbGWA9pWe/QMmXlL6OYWotxeqUwll07n1J5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355821; c=relaxed/simple;
	bh=iSBI92xbcFb8YtIaxCAj8/dQGVMdfEd5o75QnLCPRQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=msCbMdPCseYu8CSU0s7MpdJX2gJ15Jkz7HRgwdpMdl04b/cMkY5021D99yF2/ry2btdASFxJCcUgKCCkpFYE+YCWfewvRMYuj3J2pxOlmTQFDjb4lhOkTwftXGOxz7AOYqMZtFqFP7p5EB7yUWaTWBKsLQhnR+r0jztYPj7Q6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFGrOB0d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fzw0s8q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708355817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Q50iBSV6AQDahVw2RIwxtLrTecKxoffvk3tSJzt6UA=;
	b=qFGrOB0dXNjLITtaPHezRASS08WCvYV8XqwrJ/AbG5iNBmN+V+aV63RY6K4//AZvNEVVjV
	fqde0O8jlaeRpTeR5YQWD9uuwrHLEi/7SfAvbZH4y1uLqywpmSpgGTELgsOmYcjRvupXu9
	j//sSNQCW3/27U503HEP0ixehGdDGEHyeTabYftNxf8B/n+nOgSQqUqAjIdNXrPz/DLud9
	eRbw7qgKCW2zJ3WkaqlTMZh8LTwPPxpni1WepDtNcoWx4pvaQjeRoKKtQOzh/SzwkcHrBe
	4iIMjA3X7n7oor14TvSTsBK3/WNbIF/wUletmywVqalIxAjV81zmL0YaI9xt9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708355817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Q50iBSV6AQDahVw2RIwxtLrTecKxoffvk3tSJzt6UA=;
	b=2fzw0s8qwDXIrwZjpi8r4pchY0RxA0Q4KA9AWiBvpQv8XNlFU8gRH/kOvAuspKniRp3oQo
	4GM4lJ/Mrq6RftBg==
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
Subject: Re: [PATCH 02/30] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
In-Reply-To: <20240213055554.1802415-3-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-3-ankur.a.arora@oracle.com>
Date: Mon, 19 Feb 2024 16:16:57 +0100
Message-ID: <871q98a3h2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
>  
> +#define TIF_NEED_RESCHED_LAZY_OFFSET (TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
> +
> +typedef enum {
> +	NR_now = 0,
> +	NR_lazy = 1,

Just a nitpick. Please don't camel case the constant. Can you please
write out NEED_RESCHED_* as NR is generally associated with number?

Thanks,

        tglx

