Return-Path: <linux-kernel+bounces-112009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36088741A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D489B21F50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7B7F490;
	Fri, 22 Mar 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p86UHy59";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mf2GQc6o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E067A702;
	Fri, 22 Mar 2024 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711138033; cv=none; b=g5LDyg1ta8XemldQKr475+OcupeOTgXtxpMsQwbk6Y9cj84eVPIv4UUedD34vhLpsSuZEC37nhmC6t7mTf7HSDpCWfeZdtyxB5l5Ug0SEQ8gj4+ieuMLYGuePDcJWQr0SvjshjPxVlESWQXwg0pNdwKwmLByIDqTI1PGOwgSpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711138033; c=relaxed/simple;
	bh=Vvp33QqtqJ8Tn5uFYVU4oVtsQ5/b4IC2R0vLU+XGt9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U4rWuwb3kytZXOptqW4+cTZGz6/wlVu5DpEhjcAA4sykWrBuQxk4WvEjp071KB2GfQSiCifKLG6NmPCkocOMLiv6tiRA7iy8ZY/O29hRC00zC/Z/7jNtgeFJE6w50Ec0g0FJcN0oKlD6NpsuDWIMlW7v5BBxxKFIsFVY+fcrRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p86UHy59; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mf2GQc6o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711138030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/I7GIcd1orvJ1YDttKy3zNKHrkJSEPzRDkmOWSa/qAA=;
	b=p86UHy59deAJphoKo4e8ExAKwzLzqZuVoRo7Wgw263tq7c4FV2x2A+nvGw13hy6emlETfC
	F8iFd8vUPMCjmV/vzx9z3V+020ZdR42dvAg/vSElJgpiwAJlgVsm8EhGPWKAcbtBXSMxEM
	xYJt8ap/U8b+cMT5J5i/U+6d7FmMK3YI1BpmBn0F++5o64BbUXM5U0LTkE7zkB5FppFCfH
	V+pjfo/XuO2tMea9a35qQ/u0o/O5OKnfjVaLRsenaH9ULHINw3tO0upwBEXQvPPnwQSara
	CaxuuBlYlywBQmS6vnXe3iCpNC18oheuKWmw3ExWetWLiYmg5IKxlgvNHnHVGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711138030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/I7GIcd1orvJ1YDttKy3zNKHrkJSEPzRDkmOWSa/qAA=;
	b=mf2GQc6o+t6tJaFsnRrk8n3ofsR6kPIvtr2gJke6DlSEAn7zHOx9dPqj/celfpP/MG1yAS
	SZDd6tyCO0kyOoAQ==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Francisco Ayala Le Brun
 <francisco@videowindow.eu>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, Linux ACPI <linux-acpi@vger.kernel.org>, Mario
 Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
In-Reply-To: <CAJZ5v0hgWGWneAgqCxZ2L85nrM_7J7H1g042sA5tzz234BNUGw@mail.gmail.com>
References: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
 <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com>
 <5767438.DvuYhMxLoT@kreacher> <5770245.DvuYhMxLoT@kreacher>
 <CACRpkdby5dY7j9=r_dq+at_sqFduJWo15zt4tj4fvhY-KgCUYg@mail.gmail.com>
 <CAJZ5v0hgWGWneAgqCxZ2L85nrM_7J7H1g042sA5tzz234BNUGw@mail.gmail.com>
Date: Fri, 22 Mar 2024 21:07:09 +0100
Message-ID: <87frwighea.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22 2024 at 15:49, Rafael J. Wysocki wrote:
> On Fri, Mar 22, 2024 at 3:28=E2=80=AFPM Linus Walleij <linus.walleij@lina=
roorg> wrote:
>> Uhhh I rather not, the other approach will cover the invariably recurring
>> instances of this, it will not be the last time we see something like th=
is.
>
> I'm not actually sure how likely this is.
>
> The ACPI SCI is generally heavy-wieght, so it is not shared very often
> (and I believe that there is a particular reason for sharing it with a
> GPIO chip) and this very well may be an exception.
>
>> We need tglx input on this, I could merge the patch below with some
>> big TODO to fix it properly if the discussion about the proper solution
>> takes too much time.
>>
>> But I rather not hack around with IRQs without tglx (or marcz, but he
>> got overloaded) input.
>
> Fair enough.
>
> I guess I'll post the first patch with a proper changelog next week
> and we'll see.

Yes please. The COND flag makes a lot of sense. Hacking around it in the
driver is just a bandaid.

Thanks,

        tglx



