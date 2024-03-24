Return-Path: <linux-kernel+bounces-113560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B988854D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CDD284E45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0DA1C5ACB;
	Sun, 24 Mar 2024 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoPsTdSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD721C5ABE;
	Sun, 24 Mar 2024 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320362; cv=none; b=jBJnTor2HxagB9BVJ0wfr002LUtt0CRhJUCWnV8iiTjeopFo5PdQmUKMZwSvQqwFM+5H66Mtm7FsCSIJR6Gixh0WTwsmr878d8fOhEZKVf07WwAJ4351JJKjpDLpSUa3qdJAUyoWHcqNtUg/8rMVQFguD5O/TATcj6IJ8f9wPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320362; c=relaxed/simple;
	bh=HF7/g01MyF5usS4jtmaXCrXMB/637THnKn0KAttJEFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkXxWtolMRI+oICOyD5xR718TCX+QA+Lyh3RYBkSQ6gmXdhAZGgB6V+j7G3lDmEvFqRJP+TxzRYyb8+E04vPoUcBkgkcBFsC5/zpxAIVDfKnhQMWm2ZlV1UaUtfNX1MM8/LFnvSy8Eni/f3EFH7gJuIsca8MuioRfxsAHFP81X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoPsTdSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2154C433A6;
	Sun, 24 Mar 2024 22:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320362;
	bh=HF7/g01MyF5usS4jtmaXCrXMB/637THnKn0KAttJEFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WoPsTdSGDp34Q/xZG7Z9UL33va0i+/nDc1cO+YFpwaKXKa18BdOMIkbH+6JQqsprY
	 IAmBK3m+9AVAGLlNL/4Wo/iAhRx0nVZq4AzBhSG44/diPUO57Q84LMuyrxZt/wN3wF
	 SiU0NRAGaAPYunxlMrk6YgCBJlcZzT9GE8OKSq3kWFXuZwLv5G58Jaaeg7Nr1+bX8+
	 48SeAjJHAKezet2Byoqhd7qIJ8e5Bpd+AwGNcBBSkHjMdPrUWOP/e7KVZlRJGv8BAU
	 vjjmHf3u2D8OEEGO+hA5WH9DOQwgY8cebutlb47+vHYbin+N1x8uBup+PU0CSZtZWH
	 NsIgXXIrxb73w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Demi Marie Obenour <demi@invisiblethingslab.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 669/715] xen/evtchn: avoid WARN() when unbinding an event channel
Date: Sun, 24 Mar 2024 18:34:08 -0400
Message-ID: <20240324223455.1342824-670-sashal@kernel.org>
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

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 51c23bd691c0f1fb95b29731c356c6fd69925d17 ]

When unbinding a user event channel, the related handler might be
called a last time in case the kernel was built with
CONFIG_DEBUG_SHIRQ. This might cause a WARN() in the handler.

Avoid that by adding an "unbinding" flag to struct user_event which
will short circuit the handler.

Fixes: 9e90e58c11b7 ("xen: evtchn: Allow shared registration of IRQ handers")
Reported-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Tested-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Link: https://lore.kernel.org/r/20240313071409.25913-2-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/evtchn.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index 59717628ca42b..f6a2216c2c870 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -85,6 +85,7 @@ struct user_evtchn {
 	struct per_user_data *user;
 	evtchn_port_t port;
 	bool enabled;
+	bool unbinding;
 };
 
 static void evtchn_free_ring(evtchn_port_t *ring)
@@ -164,6 +165,10 @@ static irqreturn_t evtchn_interrupt(int irq, void *data)
 	struct per_user_data *u = evtchn->user;
 	unsigned int prod, cons;
 
+	/* Handler might be called when tearing down the IRQ. */
+	if (evtchn->unbinding)
+		return IRQ_HANDLED;
+
 	WARN(!evtchn->enabled,
 	     "Interrupt for port %u, but apparently not enabled; per-user %p\n",
 	     evtchn->port, u);
@@ -421,6 +426,7 @@ static void evtchn_unbind_from_user(struct per_user_data *u,
 
 	BUG_ON(irq < 0);
 
+	evtchn->unbinding = true;
 	unbind_from_irqhandler(irq, evtchn);
 
 	del_evtchn(u, evtchn);
-- 
2.43.0


