Return-Path: <linux-kernel+bounces-155275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6798AE7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62890B280C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867A86247;
	Tue, 23 Apr 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5nUE72S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oic7S4hd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8DA6A03F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878574; cv=none; b=A6UePOy4isxdsa1TNzyqG3sqjkW1LyXPjxvaSFW2a5JDx8aPVFihQZPxmGMRUzGZxVta58n71nbabI3hqhDKIdDJakYVVfP87XsyqUYtDnULbLlt5+Yph+dvN3/qXxCh3mAIv7MIWZPlQWJmmtwgAdmvWtDDb24G1IabuniX5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878574; c=relaxed/simple;
	bh=KmATSqFrHq4RRAc6IwEhkR3mz+o6wTqAp3XvoRfn0oc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j4mYFqduTKGtAr3SltGBQpSs8AqBFznJ/quOgP6wcLDGZEZ9uLLEveqgrOzArkJo7Wp0uV7Ye9V5+LoWYdUI822EgXrsQisXQrm/2xCOW6Ez4nsA7ISalXadmYFEYZoUVHMvCzFwOeCwNZyztxFyGhSLNuRZdJXwzcLtynnk8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5nUE72S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oic7S4hd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713878572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmATSqFrHq4RRAc6IwEhkR3mz+o6wTqAp3XvoRfn0oc=;
	b=X5nUE72SKXF3BgB7eT7SUPtVgJdwKEsG8Lj7wGvL56esc9cMuXwPssWGFB05wbYb355OW7
	+okrksre32uxY6qBXuBIE4XiKO6/ZSAtOJ+gveu3Ni+6em1i/3lGdHfQ7E7EHV4B2gmMz+
	jUxYwGsnvnu/C3vckaZlvoql8RICulbuN9CVyJX1gTQ6G1yHo9DVpKsWhpWJfi2xcteXkE
	sAz1InqOHrcbWSAuf7OUq98lfZycCpIcnESTCQ18QkX3sM6O3NGdyOVlAZSsSomZgAXEwH
	lWuLRlY0y3/e7gsbGtcQ9OqOD7BQH3sMvMe9SbahJYQBmTHhtR+82+S8MjFlmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713878572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmATSqFrHq4RRAc6IwEhkR3mz+o6wTqAp3XvoRfn0oc=;
	b=Oic7S4hdnZ6OUXIkaDxZIkzFpncPgPMu6slmIXkVD5Qd4rYBMR5dXNWd+4g+soeqrGSj+l
	vRYh7/J3N+OZIpCg==
To: David Stevens <stevensd@chromium.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: Disable suspended irqs when restoring affinity
In-Reply-To: <CAD=HUj7cmO5x4aunD_sJoQ6BQxejiwqa8tMbORnGjB3gADiLxg@mail.gmail.com>
References: <20240418074652.126355-1-stevensd@chromium.org>
 <87wmopuobi.ffs@tglx>
 <CAD=HUj7cmO5x4aunD_sJoQ6BQxejiwqa8tMbORnGjB3gADiLxg@mail.gmail.com>
Date: Tue, 23 Apr 2024 15:22:48 +0200
Message-ID: <8734rcusbb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23 2024 at 11:06, David Stevens wrote:
> On Tue, Apr 23, 2024 at 5:36=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> Makes sense. But I rather avoid the whole startup/disable dance in this
>> case and let resume_device_irqs() deal with it.
>
> Thanks for taking a look at my patch. Should I send a v2 with your
> suggestions, or will you create a patch for your tree yourself?

Please send a V2.

