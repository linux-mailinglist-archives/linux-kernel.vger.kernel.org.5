Return-Path: <linux-kernel+bounces-114451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7B888ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D006CB234E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC217A367;
	Sun, 24 Mar 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3M5xjxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847E1F10D9;
	Sun, 24 Mar 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321871; cv=none; b=hEGCs8gKfhSKjJdL6aIbY8Jn2PgXE70ZZDF6dZvvwkpbH68CO6DFW9WuvLmBQl3iio3rXfIrHfO9ijBCqu7egwTjwcWQnaOyDVOdQszOH4kBcy38JnB7gqv3dhqY2SvZKx11NiCPFO+mN/tUytUSsK0l1BEQPkeYIBjnldecPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321871; c=relaxed/simple;
	bh=HF7/g01MyF5usS4jtmaXCrXMB/637THnKn0KAttJEFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taveYn8xUjhDT2cxpzShyN5Zrek0iIA756BWbP2oW5jbgxGFOvecifUUK/psMXyxUuH/4bUbqjY4vy0EJB3dAH08INV2TbUw1/3UmpaU9TQ2HGefe5FU5sJ5+lPIhZgBu9eZBWSpTO0ZtrJWWpYL+YKsHndpw0GO6nRIN4OcGR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3M5xjxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309BBC433C7;
	Sun, 24 Mar 2024 23:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321869;
	bh=HF7/g01MyF5usS4jtmaXCrXMB/637THnKn0KAttJEFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3M5xjxk190ydVUUHx2XzsGiCM3Du8sOGkwORMiXWX5ikubqQQgla3czgj4gRdPNx
	 fXErHd7Aj+oz5Se7nMMhtn6bYR1eK8dJYU9y1LcjaUir2t4RAoECYLhLmSx36I38vI
	 ufe8zxGsUUDM/aEnnLfdAeH0DKmoMhSpKJOPHnQhjqn6pxn0BKCSx331IDAbk0tYbS
	 CfMI4j1IwdhE2pdDxXZW8rjr/xUoQcc5MhBoqmL/KpCbBYYnYb6b8FNciQaXXQx0y+
	 4Eshmn5s7rdl2oBT1N08iv4iY+a6M1AHL1O+chyXvRAQ35IGQwF58dVpNFe8Kd0gH7
	 3E6FgnW5YKhJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Demi Marie Obenour <demi@invisiblethingslab.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 598/638] xen/evtchn: avoid WARN() when unbinding an event channel
Date: Sun, 24 Mar 2024 19:00:35 -0400
Message-ID: <20240324230116.1348576-599-sashal@kernel.org>
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


