Return-Path: <linux-kernel+bounces-64922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E6E8544B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2374E1C271B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858AA125D8;
	Wed, 14 Feb 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uWirW6dh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bhu0XwN/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEB125AD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901825; cv=none; b=hzYyi7acgrK+bTI+mFzozZaResPhzs3gTCX4fkWy7VjUNNDq133+iaNdpgxhGOzkzFj8RaQ0z5w/y+ktcLL5ax0DjEt5tMOaX7n/hmlhGQZXS8iOh3kNoxO3tDyLCHKn7aIJGI7pHx7wZOOkSg/Dp/S4aHjKoLs8FKxVx6Hqvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901825; c=relaxed/simple;
	bh=Ease4Xu94MyjAUTYGM7mSWYyxjSVPzGp2GcQugAQU8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLtakF18ohDFo+ksNX9Cejny3PhdDnEplFcRo93L70vQwyGL9MpZBQp9Kn5rso3GVVMlh6Jxz7nBAgnqpJ4JtEBEqT4PdK4wDUOO64l1mUJPQhoecRtZMv8tngu5U4lSl+D1VYh9HOzLrS2u3HIPQgOFchb4NhnolBqTzNlVsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uWirW6dh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bhu0XwN/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707901815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTUMmecBgx1xoeb/xr61S/VEq01TOImizufZhL6jM+E=;
	b=uWirW6dhxkIDY8J4k4iuH9+MSks+NlO9QzKr+rG6TzjFn+xQH9+c18WCOSmmSrq5ydSeqY
	jYR9M+aWr2YKSQROluxM0iK29s5BuEj0ZOt3T/z+WjwVd47A484lmuNd9aD9XtLcX80QNh
	Ma2OECoJJoUKtJBiHIpqzz8SRx2iZWMHOBcejNlF+rcklbKxzj/sKg2SIURTp96ZNh46Zc
	z9bowKn5LwTvSwTqTvQ05j6ghReHjuTz3/zBFfxLHnBxfc8oZvAYq4dfLanlI/3LQtVZVn
	Cp17g04dx6RsOXU2U+qcmMtrzVpLoQsicROXyTmOiIEkpdas+LIm/e3g3h5Z7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707901815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sTUMmecBgx1xoeb/xr61S/VEq01TOImizufZhL6jM+E=;
	b=Bhu0XwN/3M5qBlhhMIoKyKtGqNbR5+CLMgsf+ElYb1JhPJ5ioZIwbYVOtXLfuSxA1bwQCs
	9z+fagkc2Jh2EUBg==
To: Costa Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>, Waiman Long
 <longman@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] hrtimer: select housekeeping CPU during migration
In-Reply-To: <20240213164650.2935909-3-costa.shul@redhat.com>
References: <20240211135213.2518068-1-costa.shul@redhat.com>
 <20240213164650.2935909-3-costa.shul@redhat.com>
Date: Wed, 14 Feb 2024 10:10:14 +0100
Message-ID: <87sf1vfm2x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13 2024 at 18:46, Costa Shulyupin wrote:
> @@ -2224,7 +2224,7 @@ static void migrate_hrtimer_list(struct hrtimer_clo=
ck_base *old_base,
>  int hrtimers_cpu_dying(unsigned int dying_cpu)
>  {
>  	struct hrtimer_cpu_base *old_base, *new_base;
> -	int i, ncpu =3D cpumask_first(cpu_active_mask);
> +	int i, ncpu =3D cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_T=
IMER));

kernel/time/hrtimer.c:2224:56: error: implicit declaration of function =E2=
=80=98housekeeping=E2=80=99 [-Werror=3Dimplicit-function-declaration]

Sigh,

