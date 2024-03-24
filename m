Return-Path: <linux-kernel+bounces-112730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3695F887D8A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6263F1C20A74
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03318AE0;
	Sun, 24 Mar 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CVvJRlco";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FHPOd3W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF518EA8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296936; cv=none; b=ko7/wZxIule8Gu9e+MVsw9C3EMM+a2+QU36B4+3x/mo5GuOIy6GTOumhbwvESqFTHJzTJwyGizqG2PLfVP62CsZzdy+cDBLLOPR8LxTDPYYIxt5Fsmf1FfXtrOb8Pld/rwKDcvuhkvshsFLPD7nhlywFOGDocSTucjC8idolUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296936; c=relaxed/simple;
	bh=aBEr+ve5f7+8NIfn+vO2L6z88R4K4Px3RaEuxYvrIVY=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=F3m4GSQKYZHJFGjUkjrr3iUQkUBdYqdmtFq4k7K8ZU4gSgNCEA4JSdsrqUULrhX5kkcElvSvZHk+5Gt1eGqlUFuMkMaU0pg7r118PClsK2v+2UvgIS1WYz9Bln2Whn8ZZco+LwKlwmLuZmmcjk6Yuk4mk+P+qQ6f/OwmbPL7TrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CVvJRlco; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FHPOd3W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711296932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y+jpGIuM3FKEo/0cgir1f/sSzLcDK46ZDYmC3534guc=;
	b=CVvJRlcofZ81quxDB299zd0uXfO8ETBgPFUAjX7o4fPkGqZu3l5nmAOYl+BjF2M1S5nP1S
	sFea+/YwCx1h/Zy1zG7et5JHKA371dVjC0ULtkmexQ36wbDnsQROjvXochBgxOQq/HnWnn
	36rjxGuMAGXXi0yI88GmEI4jZFSPBGvEMJweg22N/WzDKcP87wMidAfi1OI2d6vRncBIcL
	9VaOE/id5Emgn9Q/hPuWbtlp61oYoZdN94+wvx1OsGajx5vKDJpcPtmV6RXZMuXDvvm/D6
	G/i0Xglo6HiDGX9rAC7L79fKl9v7dBP62GP4aUSS1ypQA12ltKMBsEO8/54DTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711296932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y+jpGIuM3FKEo/0cgir1f/sSzLcDK46ZDYmC3534guc=;
	b=0FHPOd3WPtNQJ0rsIC0H47xL7Hr70F1job5bcUf/EbX+WSzlNFNf1Gjgwxb5zM3tDIXKTb
	erSloCLr1r3gk5Bg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v6.9-rc1
Message-ID: <171129691660.2804823.9714349244324963954.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Mar 2024 17:15:32 +0100 (CET)

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
4-03-24

up to:  a26979377bf3: sched/doc: Update documentation for base_slice_ns and C=
ONFIG_HZ relation

A single update for the documentation of the base_slice_ns tunable to
clarify that any value which is less than the tick slice has no effect
because the scheduler tick is not guaranteed to happen within the set time
slice.

Thanks,

	tglx

------------------>
Mukesh Kumar Chaurasiya (1):
      sched/doc: Update documentation for base_slice_ns and CONFIG_HZ relation


 Documentation/scheduler/sched-design-CFS.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/sch=
eduler/sched-design-CFS.rst
index 6cffffe26500..e030876fbd68 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -100,6 +100,9 @@ which can be used to tune the scheduler from "desktop" (i=
e., low latencies) to
 "server" (i.e., good batching) workloads.  It defaults to a setting suitable
 for desktop workloads.  SCHED_BATCH is handled by the CFS scheduler module t=
oo.
=20
+In case CONFIG_HZ results in base_slice_ns < TICK_NSEC, the value of
+base_slice_ns will have little to no impact on the workloads.
+
 Due to its design, the CFS scheduler is not prone to any of the "attacks" th=
at
 exist today against the heuristics of the stock scheduler: fiftyp.c, thud.c,
 chew.c, ring-test.c, massive_intr.c all work fine and do not impact


