Return-Path: <linux-kernel+bounces-10326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3874281D2C5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 07:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9EC1F228B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBFB6AB6;
	Sat, 23 Dec 2023 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fq9ZAJdV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84C59440;
	Sat, 23 Dec 2023 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vOQW7
	eM1tXoOjk7SXdvzeBTeJxvvs01bGEkLMLHzGlM=; b=fq9ZAJdVBLs2TEdvyWkE0
	g0eWgruRMKOKe2oYEZaTWgRw1gVQ0Ei51CyupvPQDrcW9gRibFxRXJWK5W/eLVlw
	Hm7A8Mqp8RU4FjDVJIsa7McLmvVPy6ANlwq4vfkjavOLYMkNKztbKCfS7TZWubDC
	HTN1InDfPTHDN8ZdZ2DwMY=
Received: from localhost.localdomain (unknown [111.202.47.2])
	by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wD3n6RYg4ZlvWoXBA--.33533S2;
	Sat, 23 Dec 2023 14:51:04 +0800 (CST)
From: wangkeqi <wangkeqi_chris@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangkeqi <wangkeqiwang@didiglobal.com>
Subject: [PATCH] connector: Fix proc_event_num_listeners count not cleared
Date: Sat, 23 Dec 2023 14:50:32 +0800
Message-Id: <20231223065032.20498-1-wangkeqi_chris@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n6RYg4ZlvWoXBA--.33533S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFykGrWkAw4xKFyfJFWUurg_yoW8JrWfpF
	ZrurWjyF48XayxWwn8JF4j9FyrXaykXry2kF4xG3sxWrn8WrZ2qF4rtFZF9a43J348Kr1Y
	vw1qqF98uan8CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSjgxUUUUU=
X-CM-SenderInfo: 5zdqwy5htlsupkul2qqrwthudrp/1tbiQBxP3GVOAnnTogAAsu

From: wangkeqi <wangkeqiwang@didiglobal.com>

When we register a cn_proc listening event, the proc_event_num_listener
variable will be incremented by one, but if PROC_CN_MCAST_IGNORE is
not called, the count will not decrease.
This will cause the proc_*_connector function to take the wrong path.
It will reappear when the forkstat tool exits via ctrl + c.
We solve this problem by determining whether
there are still listeners to clear proc_event_num_listener.

Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>
---
 drivers/connector/cn_proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 44b19e696..3d5e6d705 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -108,8 +108,9 @@ static inline void send_msg(struct cn_msg *msg)
 		filter_data[1] = 0;
 	}
 
-	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data);
+	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+			     cn_filter, (void *)filter_data) == -ESRCH)
+		atomic_set(&proc_event_num_listeners, 0);
 
 	local_unlock(&local_event.lock);
 }
-- 
2.27.0


