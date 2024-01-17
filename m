Return-Path: <linux-kernel+bounces-28674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1AF8301B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1F1F26560
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850731DFC6;
	Wed, 17 Jan 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQPro8+A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D31DDF8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481764; cv=none; b=gvcwi45TSDf8Ny7TrwsjpygYoSX5g28CEl9WcfnWxhF3pnEdggEJyWQM+IZIW3o6d2DhKd2nRbj1sZYFx8FoxCWvpivg+nXoqxffmQmDKzMmukwTiynGPvTr+Q4wQGJVdYjIBjdTUIk/ifuAbUKGR4Zhf2pwiVB9hRdsKyq5FCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481764; c=relaxed/simple;
	bh=BpcqVNZ8ffNdT1y7g2xcioG/6BH0/8tEnBf+zOJis+8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=B8E7sQbBSedzYdkcI7Wn10F/wE/8ImPJgF6TdzIK2cmVK772XxhQSU8pySyfuPg2l2FQ+z+dLhCegjwUyC9bg0DF4KjdhucRTo8A9PLQRX5QP0u/Dut2Km13qaIRy+tRRTsKW39wpgnQ4j+iZJlwjKj1+lr7UoPwqD9nBipbmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQPro8+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0592C433F1;
	Wed, 17 Jan 2024 08:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705481764;
	bh=BpcqVNZ8ffNdT1y7g2xcioG/6BH0/8tEnBf+zOJis+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQPro8+AjYJWrqOdEO26JABPCXwg16DvQHdwmltEa6jJBIPVOdIeT+LwdRMd6odez
	 BaX8yFA7cjBL28uQn0JIi5szxOAF0kL86Pqsm7/NgKajVvXZdtZ8hUGxU29TU5jSd0
	 GNcVpEyi5ZY6j1H+wj9LVjw9tRphXGgx51LOcf5gOQylT+PaaTMCjqm70EQOBW2Vwe
	 J6ytRN/f9u8HPMvLL6vgQoHWHF+WLzbNsshcm/FET950r4Fem/AdhGcZq00m63vslG
	 vWDT7+GUAfdWg3CL/1qjxDo+TyWn65tM4QepS28vldl+AHBuIFzam790YyDhW/EUE2
	 vDwAWvyzvjIUQ==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 3/5] sched/fair: cleanup sched_use_asym_prio
Date: Wed, 17 Jan 2024 16:57:13 +0800
Message-ID: <20240117085715.2614671-3-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117085715.2614671-1-alexs@kernel.org>
References: <20240117085715.2614671-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

And simplify the one line code. No function change.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d70417f5125..ebd659af2d78 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9741,10 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
-	if (!sched_smt_active())
-		return true;
-
-	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
+	return (!sched_smt_active()) ||
+		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
 }
 
 /**
-- 
2.43.0


