Return-Path: <linux-kernel+bounces-112889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0E5887F84
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA401C210ED
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C603F9ED;
	Sun, 24 Mar 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+fv2vo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6E3A8D0;
	Sun, 24 Mar 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319700; cv=none; b=SRdHSX3JVdSJFqxEE+ODxSrvndFtljLw2CBefzdYTV/nTQxge+QYjSWyAEUH0oIrOk1A+wVPZs/NEVmEDXHbK+tszCEEDXPcEdFxlrB0+6TY3T/HlBr8pbezmN2Ki9fCAdrA1E/XjKwoiaHdw4vbsQZ3ZxFylYZPgiC6X2JTW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319700; c=relaxed/simple;
	bh=AxbecBUzgHvzbWy2ha2okK9NoJE92B4IW4YBsUFXS1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvcDrcawN2Z+nTClyEmdZK5Ig0GUQPUXxg1ZAJ6OIi04BTwFwdutsjFO700QaE5tl627n9s1l9xfyM0jlZuGsGpC+3kDu5WdSl2luH7UkBEDduttOZZQwcmkympFrld/iIPhKSrg634QNLOWmP3BnMxcSpja4vUl6ccnQV77gX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+fv2vo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D200C433B2;
	Sun, 24 Mar 2024 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319700;
	bh=AxbecBUzgHvzbWy2ha2okK9NoJE92B4IW4YBsUFXS1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+fv2vo5Ny3emiQ3AfxrnqgSWwFhfAT0LgUKG7QDHFTAoaeGSQR18ZP3+gz44tEEe
	 ihYGPaTMwX+x2M4G7RpD6Dv2gmog3fq+CzQafJUkv7oJWrIB3PvSue5+sOP2S9fgw/
	 dk+m9rJ2TR5/rIBTxKhXmRdLQlZoYra+VyQs8vqI5vepaIFsxUiMbHmsTIuiqK233D
	 YoMNCObEJhz8//FsxICUpc8y+0h2tuZ7n9gxgDpk4SXsSiS9yOIGbpv0cK6TZ9nQXt
	 bWPA6p910matlKH1BSwmwIWrYdlVTEZwkaiY6Oo8JKtbfzqzRfhq3pxY0eSgGycMKF
	 b/lg7zEOm52XA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Audra Mitchell <audra@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 002/715] workqueue.c: Increase workqueue name length
Date: Sun, 24 Mar 2024 18:23:01 -0400
Message-ID: <20240324223455.1342824-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Audra Mitchell <audra@redhat.com>

[ Upstream commit 31c89007285d365aa36f71d8fb0701581c770a27 ]

Currently we limit the size of the workqueue name to 24 characters due to
commit ecf6881ff349 ("workqueue: make workqueue->name[] fixed len")
Increase the size to 32 characters and print a warning in the event
the requested name is larger than the limit of 32 characters.

Signed-off-by: Audra Mitchell <audra@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d7419..8a06fddb23e66 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -108,7 +108,7 @@ enum {
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
 
-	WQ_NAME_LEN		= 24,
+	WQ_NAME_LEN		= 32,
 };
 
 /*
@@ -4666,6 +4666,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	va_list args;
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
+	int len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4692,9 +4693,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	}
 
 	va_start(args, max_active);
-	vsnprintf(wq->name, sizeof(wq->name), fmt, args);
+	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
+	if (len >= WQ_NAME_LEN)
+		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
+
 	max_active = max_active ?: WQ_DFL_ACTIVE;
 	max_active = wq_clamp_max_active(max_active, flags, wq->name);
 
-- 
2.43.0


