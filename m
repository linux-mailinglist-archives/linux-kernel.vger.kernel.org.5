Return-Path: <linux-kernel+bounces-132877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F71899B87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7EA1C22AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E316C42B;
	Fri,  5 Apr 2024 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bnl7+oNJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB816ABFD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315045; cv=none; b=YhAKUPVQyeiV4YtfHHSlQvkNF8DLdKTeA4jGKAGgvoWCLHpiT9eqIuzALkqX3ngQGjaJd8OIzb8SVfz4m/TgwykTWgJ2sG1Ypja62Z0kEljzW4J4EQyvpfahjNrlky0KrAMNRx829KzAMMxe49DkvUzewTfLOKYKoe0D0r9nk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315045; c=relaxed/simple;
	bh=vjHoXtu1Dr7ssLbAC37qswiXh7DpIvczSEIMZRk40yI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H0OvI/dbCYJ7xgZdbHnGerMQPfulu2RJG9NTmHbV3dVMTeQ1P7qKayeit+BF2xBwbO1tyuaegezVEcxe9inLgFftcdfcpfqt/r9h7fubBgm4tQp88n1GPD/KdqOLdLYYkhlo72xnp/AG6G7MfgM2ruOEN67arq+Lb/3Q12eWlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bnl7+oNJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=AtyXK0mDyRpLR40IzL1aJmLNNAhRc7sK+9ltbHhK2LU=; b=Bnl7+oNJ4WP3AlWOf7jW5RLjm4
	jXiHm7J07CLpi1otmcSoQewQa7PsWtvOzX2UQUaaIRm9irUHUaK0o9cxOB0L4Lfe2NSjFQddFOUML
	tCKcyQWs3Tyd4SYUSFnIwkQzHOEmsOYF8drWDFzQ+h/8HH5xIy0upvfoHfZWfsErsnuTzYimzRKTC
	oDxYOzyC2WjvXldyEDgKjNwHsZUH2L6V284fbPv9VQ84nRLybt1t/4xXKLxpSESyxOkSnKhFq5ifk
	MPIxaucEnKVrfLWHJDy/EEhc2XYJc7fim36691VmjFDxbm9sgvE1/tLzLreH+UcnHalQNPBlOMW1R
	XvkSkrsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMG-00000005Z8h-3cRc;
	Fri, 05 Apr 2024 11:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 7D5C9301202; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110009.810420660@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:27:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 01/10] sched/eevdf: Add feature comments
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/features.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -5,7 +5,14 @@
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
 SCHED_FEAT(PLACE_LAG, true)
+/*
+ * Give new tasks half a slice to ease into the competition.
+ */
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+/*
+ * Inhibit (wakeup) preemption until the current task has either matched the
+ * 0-lag point or until is has exhausted it's slice.
+ */
 SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*



