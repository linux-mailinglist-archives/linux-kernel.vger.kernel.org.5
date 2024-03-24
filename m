Return-Path: <linux-kernel+bounces-115600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0F889CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DD61F363F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F132530D2;
	Mon, 25 Mar 2024 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUH/NSS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353D14F11B;
	Sun, 24 Mar 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321345; cv=none; b=ZPQyGcQ1ltS1P2+bhz92cZLJGdksSZ2vJ3B4qWnCcMEmvO5PezpBlJ6o9Eq3XF4RlNw54oBx0oB7EaoF1M7MnrnMhH8ZwUp/0UHa/3YE7EMcBQXOhH3KKUtn6JdKW+WoQHffi/Yscy8XUHgOQzeOVslaemDvXGq7SPWOUaROSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321345; c=relaxed/simple;
	bh=4HzUgQJ1cTA7sevheQM8td4jHmu+l+Xbddni5/4LvTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVs0iIhoF465s/tgcIG9S+YyD81oe+QphXNNdYL26N0nxgiYEwACrEmBP5z1DoQUkNYz4anO33lYbwXw6Cd/4x538z/fBnHyeg6AfNtUZiQR7w+Pzlao8jtgJrp9HVsRn4jaXfebqNfdQ/HIv7or4Au6XxZC/x41TigeV1irw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUH/NSS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1881C43399;
	Sun, 24 Mar 2024 23:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321344;
	bh=4HzUgQJ1cTA7sevheQM8td4jHmu+l+Xbddni5/4LvTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUH/NSS/J7M1j6wpT738vrmCCsbt+PGS6WclrGPeq2R/zWVvll4VTOoTvO1rP9QA2
	 yalpHsx8yuICilS8mxkJFoCATnYgj22hXQ7n3UxV0QajcKvCdy+ARjjiDX49FtYEK6
	 zcgWxGweSx9AREG7l3/FisNrRTPjM87UxNmveh2yDuplcm3doBxddVLXpkKyFaHCXL
	 nSvtWc+uHPKFM542rCrZtve6vRQhxEbfhoz9Ex4vxZI2wxhvCjQcxm6iAumn6EomZ5
	 UdxwG0lRo3i6hWLwryYFbPZPAyP2oEw0cG8uj8o1g+6N3wYaGxg0IVcI8pN1wR/o5q
	 K6sR3bMStGpCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Audra Mitchell <audra@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 068/638] workqueue.c: Increase workqueue name length
Date: Sun, 24 Mar 2024 18:51:45 -0400
Message-ID: <20240324230116.1348576-69-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index fd7b84b06d926..e004e65ae987e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -108,7 +108,7 @@ enum {
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
 
-	WQ_NAME_LEN		= 24,
+	WQ_NAME_LEN		= 32,
 };
 
 /*
@@ -4673,6 +4673,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	va_list args;
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
+	int len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4699,9 +4700,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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


