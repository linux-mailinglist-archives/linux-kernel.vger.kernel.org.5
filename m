Return-Path: <linux-kernel+bounces-113522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A5888501
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CECE28485A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2234213DDBF;
	Sun, 24 Mar 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay26U6aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05013DDA5;
	Sun, 24 Mar 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320324; cv=none; b=n8QQMMJwV7VZX+xExvcqwYg1XYF+b8rOAk3afPcR1zIlFxDGrPHDcPJ1KChfuQhQBjmVJL19mkwHWbnK7PUcfyfZrZO7El2oCUCck8IdzkpdfttO6BjGL3vCBe50ludaZQ1uswRlqmcQhC0hY+Z8A0HXrR9eGNy69y4uYQLgv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320324; c=relaxed/simple;
	bh=EMIauOwNZpp1rnml5K+5PBZu7xOF1ZXp6XWVN1UwmcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw6jej9ZzhrzHnjcknsx/NQCZlO/vYM48CTpvUPHFhvOcGknnPUjsEm+gU6cGVEluaTSDES+gZdVywlXGf+/THeo7GnInzZUkM9nhz1/7dvB1J6h4B3qf8FRZapH292sZbErem0swZYeWf/fN5uPxhUwyPd9Qf9ABuisVltGyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay26U6aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4883BC433F1;
	Sun, 24 Mar 2024 22:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320324;
	bh=EMIauOwNZpp1rnml5K+5PBZu7xOF1ZXp6XWVN1UwmcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ay26U6aj3OlyjI/P3sVQV079KL38UxJLGoXOpHdR3fzPjJZizJAgohgZZnyqpgWaH
	 kd7GDWU9/IjnKkPHjljpEIbMRUd3hopFPFX+UL8F68WKQ40iSF0DIhYZ+DswfEEezY
	 xT1/n7jSfqeu3R78TstlwIz8cWDyL6s5nikL33YW1FpCJSlTIwqzPYAtSqS76FSLdo
	 ketkVanliofoSra1pXn+BnRMPGq1u94TXMMSGbV9hRM6N8uesNiNZZmU2awzXE+AgR
	 UGwacFbuu7EHs2rtnL5GCdSgS22NTBBUb5xdJAXUMbsQ0SFWGIT9MqShGfK8hlP7od
	 tK2CH2ZI4sbVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 631/715] mei: vsc: Call wake_up() in the threaded IRQ handler
Date: Sun, 24 Mar 2024 18:33:30 -0400
Message-ID: <20240324223455.1342824-632-sashal@kernel.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 058a38acba15fd8e7b262ec6e17c4204cb15f984 ]

The hard IRQ handler vsc_tp_irq() is called with a raw spinlock taken.
wake_up() acquires a spinlock, a sleeping lock on PREEMPT_RT. This leads
to sleeping in atomic context.

Move the wake_up() call to the threaded IRQ handler vsc_tp_thread_isr()
where it can be safely called.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-and-Reviewed-by: Wentong Wu <wentong.wu@intel.com>
Link: https://lore.kernel.org/r/20240219195807.517742-2-sakari.ailus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/vsc-tp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 55f7db490d3bb..0e623700c3b0e 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -416,8 +416,6 @@ static irqreturn_t vsc_tp_isr(int irq, void *data)
 
 	atomic_inc(&tp->assert_cnt);
 
-	wake_up(&tp->xfer_wait);
-
 	return IRQ_WAKE_THREAD;
 }
 
@@ -425,6 +423,8 @@ static irqreturn_t vsc_tp_thread_isr(int irq, void *data)
 {
 	struct vsc_tp *tp = data;
 
+	wake_up(&tp->xfer_wait);
+
 	if (tp->event_notify)
 		tp->event_notify(tp->event_notify_context);
 
-- 
2.43.0


