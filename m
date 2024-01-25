Return-Path: <linux-kernel+bounces-38191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1692383BC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4967F1C25D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D021B950;
	Thu, 25 Jan 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RTux1+pR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pt+4Up3Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB691B94B;
	Thu, 25 Jan 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172318; cv=none; b=RAriFCyHrPp8tF7Xy5phOCRFwp0WNFRGOhzPDgVO/6b+IwP8MNttclmXyPVTOgr9/RGiemBTAw5criUfKm8auK4IXQcq1cWliyWP0WMhXVZRs96c1syusB+C/mlSs+G9u5XAxel4C+pj4d5m+7vvxrJMCkQn0JnSNhZFoq3mlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172318; c=relaxed/simple;
	bh=8/N8nHgaQvKTBhfxwCmzbJX3QzXCprpMyk/c3leHg08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7eHy4Vf7oRZlVpJ26P4QBLxov/Qhq8w2IOdc4agdmbM/Z1p5vtg0TqTTt+o1AeMTH0bU3ikXESB0rdv86qyf0q+s1OY3eAhR9QsuTn/fFL+Pggexe8BOkEe6YTAyZx7Be+tLR/foLH9awfPuv9Pk3GFvp+ayyYR+4Ng4Q96ixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RTux1+pR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pt+4Up3Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706172309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/N8nHgaQvKTBhfxwCmzbJX3QzXCprpMyk/c3leHg08=;
	b=RTux1+pRR18Wian+HDI6adTZ/YAeMMLdG1s7PChn0t52OXX4/qt1+s6W+rlN5lGv8l1mAm
	uDImkHQhEwoMUSu27Qysj0N35xLmWQnLiminAaNU+kFEJYGBYkGERzGS8keWE2sIdnnhGL
	ReSi69T5FCAck/QCeHqxcqRVqPBTJ+Ux0ZYOh6zw4q7L2J0gnFRg7lq+4ZQBLOWReboZ6T
	Fhr2dClqzHYA1P28jSMsbKJ7gVOntd5+GRm1fM0KvmNsMB3Be69/s0XNhIIy2r9Lv8nhS1
	K1IBGeJjkL/2y3s9NDfUupCpnv4CD1RPMvwhccE6mGIZ8mQ4/MAyUpVYf5tv9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706172309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/N8nHgaQvKTBhfxwCmzbJX3QzXCprpMyk/c3leHg08=;
	b=Pt+4Up3ZcUmLAxp2euhrRzuCu/V0OYU0xtyo6emPV1pORKWrqQqO7cbfKlPUiwy7H4DMKK
	UGaqX01fpuOb+RCQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Heiko Carstens
 <hca@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] tick-sched: Preserve number of idle sleeps across CPU
 hotplug events
In-Reply-To: <ZbFvDbFm1_EfajFf@pavilion.home>
References: <20240122233534.3094238-1-tim.c.chen@linux.intel.com>
 <87v87ijzqj.ffs@tglx> <ZbFvDbFm1_EfajFf@pavilion.home>
Date: Thu, 25 Jan 2024 09:45:09 +0100
Message-ID: <87jznxkdii.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24 2024 at 21:11, Frederic Weisbecker wrote:

> Le Wed, Jan 24, 2024 at 08:30:28PM +0100, Thomas Gleixner a =C3=A9crit :
>> On Mon, Jan 22 2024 at 15:35, Tim Chen wrote:
>>=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D71fee48fb772ac4f6cfa63dbebc5629de8b4cc09
>>=20
>
> It's a different patch :-)

I clearly can't read ....

