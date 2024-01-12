Return-Path: <linux-kernel+bounces-24673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915F882C055
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADBB2861F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6766BB3E;
	Fri, 12 Jan 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b4z0gnfg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0SpkV9u1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6F5EE94;
	Fri, 12 Jan 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705064519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TS9YhPDldTTjGIAAyOKez0LHmI8RD+x8kd63E/fDUqw=;
	b=b4z0gnfg3rYIPjuHC/+CGOngTgmZ9G/DZXjxT14EEbShfFMUK5PKsI8npORtSBvthF7rtJ
	yqzfmZbzTNHjv0fFq5/IvHsyrxeiO3i+YC/JJzf7SvmTgwNFUU58WzXM85C+kxC09cd8D7
	nIrsR0z079jwaHZGWj5G9Kj8KdHaC0206jHSUouGA2o6I3klx9munEuxSfN3kqugkCipvS
	qi5EE5vehBmE8QuXy5PPASCrHq5b0gOE4sC1g2oC/sb6ycHA3oFVVgLFABk6+glZ1Ff5Gn
	tglPiZYslYqXiVLwophieMD7GSGxgzKfUGwS44yoTaYFA1/lDveIJDvEse9TZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705064519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TS9YhPDldTTjGIAAyOKez0LHmI8RD+x8kd63E/fDUqw=;
	b=0SpkV9u11zaLX55bOD86IHPv7DtnCwvpuus8BBQZWxykzJqS/dBPPl80+NnP/wnrpIrI+c
	tBdvUUSr/sYzSyBA==
To: Dave Chinner <david@fromorbit.com>, Jian Wen <wenjianhn@gmail.com>
Cc: linux-xfs@vger.kernel.org, djwong@kernel.org, hch@lst.de,
 dchinner@redhat.com, Jian Wen <wenjian1@xiaomi.com>,
 linux-kernel@vger.kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH] xfs: explicitly call cond_resched in
 xfs_itruncate_extents_flags
In-Reply-To: <ZaBPM14r5vGrQ9mc@dread.disaster.area>
References: <20240110071347.3711925-1-wenjian1@xiaomi.com>
 <ZZ8OaNnp6b/PJzsb@dread.disaster.area>
 <CAMXzGWJU+a2s-tbpzdmPTCg9Et7UpDdpdBEjkiUUvAV5kxTjig@mail.gmail.com>
 <ZaBPM14r5vGrQ9mc@dread.disaster.area>
Date: Fri, 12 Jan 2024 14:01:59 +0100
Message-ID: <87v87yiu2g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12 2024 at 07:27, Dave Chinner wrote:

Cc: Ankur

> On Thu, Jan 11, 2024 at 08:52:22PM +0800, Jian Wen wrote:
>> On Thu, Jan 11, 2024 at 5:38=E2=80=AFAM Dave Chinner <david@fromorbit.co=
m> wrote:
>> > IOWs, this is no longer considered an acceptible solution by core
>> > kernel maintainers.
>> Understood. I will only build a hotfix for our production kernel then.
>
> Yeah, that may be your best short term fix. We'll need to clarify
> what the current policy is on adding cond_resched points before we
> go any further in this direction.

Well, right now until the scheduler situation is sorted there is no
other solution than to add the cond_resched() muck.

> Thomas, any update on what is happening with cond_resched() - is
> there an ETA on it going away/being unnecessary?

Ankur is working on that...

