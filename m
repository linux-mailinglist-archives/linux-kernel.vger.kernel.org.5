Return-Path: <linux-kernel+bounces-102597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8898287B462
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346CA2869AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D925B217;
	Wed, 13 Mar 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="QX+p9dx5"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82D159B56
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369048; cv=none; b=HUsTrf9cjHd1dlMYJt+4+1cHH+Fmbrurzcy28I17A9H4pMdMS+OSmUd0VIu6or8QyVN46oBuR8PxXVEBUJ90XmSnoESNgJHmtOdM1zl9OPNkCz8ikKXn0bWDbbJGyVZvgAdf4YX/bHnMkzFudAt90OLQU+q2+1IT0fWrEVccZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369048; c=relaxed/simple;
	bh=1KgnKb3sBR6cbRrupoKHTHuK+ZNmuPGzeKCeruiGaoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elp0KepMdC+eIFxu/oY753fzjZpCJEtquqfLE5r1Vhj+8AHVWhXzgADJsUJZlx/bjRjM+AomvQWYV9IDpny//tB+ZiCAprru7oPH2God17EDGOxe2R1z5PvO9Vb9XNdr4EA82bRun0CJYY/M5Y9Pk2kAqhI8/F8BKorVfRHxpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=QX+p9dx5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e899ce9e3so212162f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1710369045; x=1710973845; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1KgnKb3sBR6cbRrupoKHTHuK+ZNmuPGzeKCeruiGaoQ=;
        b=QX+p9dx5uY1Nl5DQ6aNA4ddZxztlwICqeyGylGMwaageC/DpQJCpQU1suokC46CepZ
         hsjaJ5VnHwUXp8xAyxikYEUwcZH6hKDuxxsSeZHP/BF7iQAssGY21Eqs3jY4c/j7t+Nl
         euPeOT6uqDTcxG50EQYU/cVcusAMNsO70rsUelLU2wiEw9JBqcYT/fJVdfCg/4gwTfbo
         8w2l2RJL37NfV+eM7E74zhPHgQivTV3Gr3HQQCzVxtBZ97X/9TKwamkN37OLZ5fG0FQj
         LNrgb/6goGTVYfdiQsUOKeneZhj3IAtmOC8Gx4u+iYFkpLDZFg/fBHSmLYSAstOzVM7D
         Lm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369045; x=1710973845;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KgnKb3sBR6cbRrupoKHTHuK+ZNmuPGzeKCeruiGaoQ=;
        b=YH0Ax/BIzBeAqvwkccC2SVhGkOJwPz76BOCRB0HkEEMBaOrw5Ph4yOEAru2D9iwqYj
         VMcMBvcmbq7pSpa6yYVvqlGP2XkwMemfd6/ieE9uTeLsK3JWNT9p3g3l1N6Bjyy168qv
         Xjp+axNcX1jb8yTL5SVu+DOq2dy1SKA26vhOKIMVXeliqg4KXXYpbQ8n9NI4axZQLvkv
         MOpwa7RHQLsOAINpto2op9wrNlJDpeIsqDTwjuslNomvWRFP4/CRuyB2Ck7lViJ7OEtJ
         Xki9WAYFPCipc5kT/40Ce57mu2DdOOzte1dLKaK6+ExWYWmmBekLsCLwHaxRa/7oHjm1
         LEXQ==
X-Gm-Message-State: AOJu0YyKRP40CJf+swYi+EyMHUKCL1Gn+7vYaZwuOgIPmwDvBTFGfAMv
	UBT1qQmtylK3B1CcbymLzMrCTY0mGPWOx0Vu4LPKkn0LP/5+F/dgW9wAM/yXIQqaJj7R/ZoVPaU
	AWBJAT+4NsAGUhB4oFhgHAuLZmdJRLP+irVl1P8zKG7ug4AboU7O0urhLjbpn5YCulp6y+4PQ+W
	JU/kqes+RFlZMIQ2IEvnJb3lwLPAhDAt2bssXd7Mo2sN17fYY1Wiur2WDGs6CyoNhtjm5zQOh4J
	6V3R23eJyWgYnRnRZMS67HzGjy3StV06GJ0dH4TP/xO5zJNYs0K7RUC/zXusc1MO56VDeX/1MCF
	dmAdUbFMUDahN+kmgpE+ILntYVgwu2aAwVPEUxImpj2sKgyRrL2HUwRaLJ4=
X-Google-Smtp-Source: AGHT+IFWTDqmAKnxNbMvN1tvVrUrsJUBfbnhN00ItdbKhCgZV7me6wIEkibHvMXjnxNUT/IkJzesXA==
X-Received: by 2002:a05:600c:3d88:b0:413:e531:5a47 with SMTP id bi8-20020a05600c3d8800b00413e5315a47mr100917wmb.4.1710368609711;
        Wed, 13 Mar 2024 15:23:29 -0700 (PDT)
Received: from avi.scylladb.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id e10-20020a05600c4e4a00b0041316e91c99sm402607wmq.1.2024.03.13.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:23:29 -0700 (PDT)
Message-ID: <dca2d74b4078a0c2488cefd9beeaeb819a5c7fc9.camel@scylladb.com>
Subject: Re: [RFC PATCH 0/2] Introduce serialized smp_call_function APIs
From: Avi Kivity <avi@scylladb.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Oskolkov
	 <posk@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng
 <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,  Maged Michael
 <maged.michael@gmail.com>, gromer@google.com, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Thu, 14 Mar 2024 00:23:27 +0200
In-Reply-To: <6952b581-68d2-476b-9f7e-e9746c8c0473@efficios.com>
References: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
	 <7c1860d783e0f317160069bf77d8fafdf01a9f97.camel@scylladb.com>
	 <6952b581-68d2-476b-9f7e-e9746c8c0473@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Wed, 2024-03-13 at 18:06 -0400, Mathieu Desnoyers wrote:
> On 2024-03-13 17:14, Avi Kivity wrote:
> > On Wed, 2024-03-13 at 16:56 -0400, Mathieu Desnoyers wrote:
> > > commit 944d5fe50f3f ("sched/membarrier: reduce the ability to
> > > hammer=20
> > > on sys_membarrier")
> > > introduces a mutex over all membarrier operations to reduce its
> > > ability
> > > to slow down the rest of the system.
> > >=20
> > > This RFC series has two objectives:
> > >=20
> > > 1) Move this mutex to the smp_call_function APIs so other system
> > > calls
> > > =C2=A0=C2=A0 using smp_call_function IPIs are limited in the same way=
,
> > >=20
> > > 2) Restore scalability of MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
> > > with
> > > =C2=A0=C2=A0 MEMBARRIER_CMD_FLAG_CPU, which targets specific CPUs wit=
h
> > > IPIs.
> > > =C2=A0=C2=A0 This may or may not be useful, and I would welcome bench=
marks
> > > from
> > > =C2=A0=C2=A0 users of this feature to figure out if this is worth it.
> > >=20
> > > This series applies on top of v6.8.
> > >=20
> >=20
> >=20
> > I see this doesn't restore scaling of
> > MEMBARRIER_CMD_PRIVATE_EXPEDITED,=20
> > which I use (and wasn't aware was broken).
>=20
> It's mainly a mitigation for IPI Storming: CVE-2024-26602 disclosed


Very interesting.


> as part of [1].
>=20
> >=20
> > I don't have comments on the patches, but do have ideas on how to
> > work=20
> > around the problem in Seastar. So this was a useful heads-up for
> > me.
>=20
> Note that if you don't use membarrier private expedited too heavily,
> you should not notice any difference. But nevertheless I would be
> interested to hear about any regression on performance of real
> workloads resulting from commit 944d5fe50f3f.
>=20


In fact I did observe the original text of 944d5fe50f3f ("On some
systems, sys_membarrier can be very expensive, causing overall
slowdowns for everything") to be true [1]. So rather than causing
a regression, this commit made me fix a problem.

The smp_call_function_many_cond() in [1] is very likely due to
sys_membarrier, and it's slow since it's running on a virtual machine
without posted interrupt virtualization. Usually we detect virtual
machines and call membarrier() less frequently, but on that instance
(AWS d3en) the detection failed and triggered that IPI storm.

My fix is to just detect if there's a concurrent membarrier running and
fall back to doing something else, I don't think it's generally
applicable.

[1] https://github.com/scylladb/scylladb/issues/17207



