Return-Path: <linux-kernel+bounces-119908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ADC88CEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCAA32811C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCC313D534;
	Tue, 26 Mar 2024 20:26:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374F13D50C;
	Tue, 26 Mar 2024 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484761; cv=none; b=AoijNudTy9rZsP0zbATLSPzXzVnCvPL5rp99TK8EsAaiFux7Fq9AGWZKpdjIOdxFc18N6hEquTfhlwyWsbdEOgxvpHFy5H7Nq0acIRFuG0NElp5Ba+Dglnw3MqJgJmCn1RTqzBo+g2rxJrw3RXAW2fT1jX1hqBQaCCf471h0Zpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484761; c=relaxed/simple;
	bh=igWGdcldAz0/c8YIfnVQ/TAEd2nFNJDirYyjzqHgGRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPqmV6J0yUqzhTM/zCbgVgRDjDw6Ur/kDROTx+0rsf4fmLVAvsmMuty4urcOHk1HOrS1+or9hFp+4YTpXAdkvXEYQLqKi5mi98ohgFRZJ6LZTIblzWzpU/Wn2tZsZGyXe1kvHs8L2imcfgz1sS8eNQH+YwwTO1QyRGAyObrLsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A2CC433F1;
	Tue, 26 Mar 2024 20:25:59 +0000 (UTC)
Date: Tue, 26 Mar 2024 16:28:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] rcu-tasks: Update show_rcu_tasks_trace_gp_kthread
 buffer size
Message-ID: <20240326162838.14da4a7c@gandalf.local.home>
In-Reply-To: <4b3e239d-ab87-4a37-ac1d-af49e1f8f3ee@ancud.ru>
References: <20240326174839.487582-1-kiryushin@ancud.ru>
	<20240326152230.3e692d83@gandalf.local.home>
	<4b3e239d-ab87-4a37-ac1d-af49e1f8f3ee@ancud.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024 22:55:29 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> On 3/26/24 22:22, Steven Rostedt wrote:
> > Why 87? as it's not even word size, and this is on the stack.
> > =20
> Got 87 as maximal used buffer length (result of
> sprintf(buf, "N%lu h:%lu/%lu/%lu",
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long int) -1,
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long int) -1,
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long int) -1,
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long int) -1);
> +1 for terminator.
>=20
> Is word-size alignment a thing in this case? I thought that char buffers
> are ok to be aligned by 1?

Because it's on the stack, which will likely reserve data in word size.

Thus, buf[87] reserves as much data on the stack as buf[88].


> > Better yet, why not just use snprintf()?
> > =20
> Seems like a better idea indeed, as if fixes overflows for unpractical ca=
ses,
> without added overhead to common cases. The only concern is possible trun=
cation
> of data, that may break some automation (if output is parsed by someone,
> without accounting on it being cut, who knows). But again, it is for pret=
ty unpractical
> values.
>=20
> Will make a v2 patch with snprintf() with buffer length.
>=20
> Genuinely look forward to being educated about aspects of aligning array =
sizes, as
> I do not really understand the limitations.

It's because it's on the stack, but it's always good to align. For
instance, kmalloc() will allocate things in 32 byte chunks.

-- Steve

