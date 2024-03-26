Return-Path: <linux-kernel+bounces-120140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5D88D2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512661C2CE39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF8A13E040;
	Tue, 26 Mar 2024 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SnCHX0g1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="od8qGGCE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1E13E03F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496221; cv=none; b=e/1Lj/R8hvKBftb93ubgR61af9Nm1W1aChxPjTt2JF38DUfm1plWd1wWGLni2Bq9qisCQz/iniOLoAP2m3mkK75Qv1NDq/ivyTidgCw3FEH1+QZGCluN9r7N1U7K5amESovsPl/zTj6z00VvMe8hHXVRDk6IxnA/C+IQuVvey0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496221; c=relaxed/simple;
	bh=oahTA6dTYSWMdCkR8OHLK2ha2hSU4kUfoocggeRJGJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kNCiA7kYMbkImteBm635gPnlNafQmRR44DobdI/MMcuOBkNEc8ctUtz/LaeApnDgnYGAZ9M4SwgdrvLJ8xWj6MC6SmMm2GraHT9cHAltQCu1MToJfkxj73UQTv0DMG21o/ezAthlwR9IdwoxoW9KhomxDas5UUTevluuwfpf7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SnCHX0g1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=od8qGGCE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711496217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVoO2SchxdEz7fwpw07CFpmgAKOUXncfAlsQ/m8G3/w=;
	b=SnCHX0g1f6/dQ9Gm+zOYX3OywxBLcwYq+1b2na9SUxhs1MmdsK0HskY4tzlfR2eC5LerOa
	WF6HiGD9OVCvlaKGz4dJFycGpAOzU3rEpjhqtJzZbb2PgkV9FrS3hiBWDYIEA5o1QDy+7t
	8SXo9lcEZhnuEudzc4IbEgGUoN4WPzYysXK/JKPPI01dDGUSs0PLmnUXsqwcDZ0grsTCSq
	TkTkA5TOwPVY9j0ncY1Lpog+6CnuEhojESsqVJUSAR/V4+W9dwx8ObOEhVmCGguCBwKLif
	N5BLSKieSjCTYaY1nKhrcOGRpE5Y0HlE5elOUPv3QCGvYS7vluT3utLrLowE1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711496217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVoO2SchxdEz7fwpw07CFpmgAKOUXncfAlsQ/m8G3/w=;
	b=od8qGGCE60/d4xA8vQjxF6rPawNJBjmpfMH52NvmH8q+kcTQc8xaXQ9HTSQsffCwkIqZVh
	3QoMyVAQBHaOe4Cg==
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jiwei Sun <sunjw10@lenovo.com>, Adrian
 Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] genirq/proc: Try to jump over the unallocated irq
 hole whenever possible
In-Reply-To: <CAHKZfL1xq-pemEMo7m8DctEVxSG_ASQWxCC_HsN=-92UAjP_Mw@mail.gmail.com>
References: <20240325035102.15245-1-adrianhuang0701@gmail.com>
 <874jcueydh.ffs@tglx>
 <CAHKZfL1xq-pemEMo7m8DctEVxSG_ASQWxCC_HsN=-92UAjP_Mw@mail.gmail.com>
Date: Wed, 27 Mar 2024 00:36:57 +0100
Message-ID: <87h6gsefae.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26 2024 at 21:35, Huang Adrian wrote:
> On Tue, Mar 26, 2024 at 6:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
> The reason I made the changes in show_interrupts() is to minimize the
> traversal times of the 'sparse_irqs' maple tree since irq_to_desc() is
> invoked in show_interrupts().

They are not really relevant. The cache line is hot after the
irq_get_next_irq() lookup and maple tree is a highly optimized data
structure.

I'm not saying that it is free, but if you want to avoid that in the
first place then you need to do a lookup of the next descriptor and hand
it into show_interrupts() right away and not just hack some completely
obscure optimization into show_interrupts().

> @@ -19,6 +19,10 @@ static void *int_seq_next(struct seq_file *f, void
> *v, loff_t *pos)
[ 3 more citation lines. Click/Enter to show. ]
>         (*pos)++;
>         if (*pos > nr_irqs)
>                 return NULL;
> +
> +       if (!irq_to_desc(*pos))
> +               *pos =3D irq_get_next_irq(*pos);

How is irq_get_next_irq() valid without either holding the sparse irq
lock or RCU read lock?

Testing this with full debug enabled might give you the answer to that
question.

But that aside you are missing a massive performance problem in the
generic show_interrupts() code:

	if (desc->kstat_irqs) {
		for_each_online_cpu(j)
			any_count |=3D data_race(*per_cpu_ptr(desc->kstat_irqs, j));
	}

	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
		goto outsparse;

There are two obvious problems with that, no?

Thanks,

	tglx

