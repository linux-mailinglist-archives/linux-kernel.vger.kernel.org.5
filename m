Return-Path: <linux-kernel+bounces-82013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06827867DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377FD1C21B35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E118A13472D;
	Mon, 26 Feb 2024 17:00:36 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868ED133429;
	Mon, 26 Feb 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966836; cv=none; b=hhlQRbgi9vqcTBihtF1YMM32PXXFQTv7FzAFQNHB98eJdPzTwXHzy8yq5diuU/lsHQ33WhtXKLhZq3iOH9UJI+oCzHUdLo66KLALvh7snEQevxFjjjLxnpcGkU4yFJvVNvi9GoTVRaSM812eIvb5zTwBcSM0Gf+McnJz0XZEjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966836; c=relaxed/simple;
	bh=TJQajcvykBMBxUEeqy/MVrgfkPcyDTbvbZrHw1dY2c0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAuNCR0gcAoHJ6QZnlAKHYlayDYYHesBlPlImpGgyQa7xYyqcHM3xWgbxYNRXwHhmL/SfN/GEI90IwgwUmt0KiG8lmfFMo5CrPEJpW3E1ACAP0bg1uCbFYdszuDr9iVkhitaUiApol8w3Vhp5eFdRjpJW5npu8rFYKyBM0+VrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett
	<josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	<linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, David Vernet <void@manifault.com>
Subject: [PATCH 5.10 1/1] rcutorture: Add missing return and use __func__ in warning
Date: Mon, 26 Feb 2024 20:00:11 +0300
Message-ID: <20240226170011.22798-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240226170011.22798-1-d.dulov@aladdin.ru>
References: <20240226170011.22798-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: David Vernet <void@manifault.com>

commit 80dcee695143255261f30c7cc2a041ba413717a4 upstream.

The rcutorture module has an rcu_torture_writer task that repeatedly
performs writes, synchronizations, and deletes. There is a corner-case
check in rcu_torture_writer() wherein if nsynctypes is 0, a warning is
issued and the task waits to be stopped via a call to
torture_kthread_stopping() rather than performing any work.

There should be a return statement following this call to
torture_kthread_stopping(), as the intention with issuing the call to
torture_kthread_stopping() in the first place is to avoid the
rcu_torture_writer task from performing any work. Some of the work may even
be dangerous to perform, such as potentially causing a #DE due to
nsynctypes being used in a modulo operator when querying for sync updates
to issue.

This patch adds the missing return call.  As a bonus, it also fixes a
checkpatch warning that was emitted due to the WARN_ONCE() call using the
name of the function rather than __func__.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6c1aea48a79a..69856904838c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1063,7 +1063,7 @@ rcu_torture_writer(void *arg)
 		pr_alert("%s: gp_sync without primitives.\n", __func__);
 	}
 	if (WARN_ONCE(nsynctypes == 0,
-		      "rcu_torture_writer: No update-side primitives.\n")) {
+		      "%s: No update-side primitives.\n", __func__)) {
 		/*
 		 * No updates primitives, so don't try updating.
 		 * The resulting test won't be testing much, hence the
@@ -1071,6 +1071,7 @@ rcu_torture_writer(void *arg)
 		 */
 		rcu_torture_writer_state = RTWS_STOPPING;
 		torture_kthread_stopping("rcu_torture_writer");
+		return 0;
 	}
 
 	do {
-- 
2.25.1


