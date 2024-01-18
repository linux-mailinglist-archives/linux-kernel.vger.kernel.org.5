Return-Path: <linux-kernel+bounces-30567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BA8320AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74D1284291
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B129B2E859;
	Thu, 18 Jan 2024 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToZ1V4ys"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886852E84E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611798; cv=none; b=UkI7fKMEPxd7H3tFJ8udMguvWm+K9C2THd8yBiMG8LhR6k9zJtq+dl3O/CoysgQai+S3905508MdF83oJ3e1x6OdZ38XuNjBiv+zrxyKTp/I6eD3hdZVOvU+pPnMnTghjfPla9V7GqYN0HBzZflLuBTH3QNws0w3HQGsLRk+cnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611798; c=relaxed/simple;
	bh=6SMKOxcf+4Apt7o+Be8igJKCg+nalrh+TLWLD1u7S5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oz+nzy0N4bQNvqflrvCKpYCc3SO040LwxBZEW8ZIyEH+Y6f2FkQgHy/oZiF5vwGPP/U3qkeweeSglw2XRg/t7yHyvpxJVkHM1/c/tUNSK8pc9D5RAOZzQ6LDRRm8icmiefcCyE1+UN5tNkIu+WUZd2fcgJsH/3jL9LMyqSFwD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToZ1V4ys; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ddf26eba3cso56162a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705611794; x=1706216594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZuonEw3eedxFWRIJ3FPhNOWVoihKIZ04zTqPK6ckUU=;
        b=ToZ1V4ys6wOgODSnd4v/Rc8Tb7q16I5UymsPrQVAXekZIBm27aoisds+sdDc2sJz3V
         X3qP7tB83plaeyomeMkSRwdTYo1mPXmix+qov2iq0BlyA1CHyQQk2T3D8EQnnYWWO3e+
         Ou3bortXk/EVDbshDERQUC/sT0YPuULfblVX3Wl+fsCMXqCZSRtI0N+nswM9BF4SM2t2
         jLRwDWyZz1xhIY2QKjflxgsfBjmZak1bnvBVrZ3q6676OaFH2aqbZDB/NMIBamgIiyYY
         3YZdcQlHsuTshzJnrSTwCNfMbXArvvAfwlhwhoeFoMLK0JDPJ/aXfYQzReRDJwfjLW9V
         rzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705611794; x=1706216594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZuonEw3eedxFWRIJ3FPhNOWVoihKIZ04zTqPK6ckUU=;
        b=RjxCrtL35SClGd6ANHj68dDMI8kwAByhpd/d0HftldHRkq99MBFCr6Rild0rqnAGw8
         DvPJaGj+VD7UwzrJmeYdAyWL2/yVkz9FOkPWa2LxoZGHNKOe+vydJifqNyxUFSgYx2ve
         cdXU1yMfyv4imv5SzhLFVonD+NBL6Jjs7QWhDeh5TRRVfnu3ia8q1YAugvslFB9fUQj0
         g7AjybVZ50g9TBSl/dVHLsLf4dOTU8chAaAJZm8o8n75ZQsQz8o2Kdm3ql92BN6LFjTV
         /Hjx/zGP/0KWZnB/rGRpsFuTZ6EHuvkTBLl9tOTFuGa7eduHPspZrBo9SZVX7+mlxhji
         pHvQ==
X-Gm-Message-State: AOJu0Yxj8tGYA6NzhckR/lRQoBV0Wdk853B+N0AFd05MPKv0PsroHqJR
	6aQe+KV84hwhwWoONOZeqUZE9F5qmKvY9dTCmeycnry5TBxus0+U7ZF/GRkx
X-Google-Smtp-Source: AGHT+IGVklt9g4h7KihbkN8RM4qlKc68kUyLYgwQyhhb0nsrUkqiwhDB8iyrlbOXVNVP2f27h7ty3Q==
X-Received: by 2002:a05:6870:7099:b0:210:aec0:e8ed with SMTP id v25-20020a056870709900b00210aec0e8edmr1429121oae.73.1705611794473;
        Thu, 18 Jan 2024 13:03:14 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id gu27-20020a056870ab1b00b00206516474f3sm561572oab.38.2024.01.18.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:03:14 -0800 (PST)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2] nvme_core: scan namespaces asynchronously
Date: Thu, 18 Jan 2024 15:03:03 -0600
Message-Id: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use async function calls to make namespace scanning happen in parallel.

Without the patch, NVME namespaces are scanned serially, so it can take a
long time for all of a controller's namespaces to become available,
especially with a slower (TCP) interface with large number of namespaces.

The time it took for all namespaces to show up after connecting (via TCP)
to a controller with 1002 namespaces was measured:

network latency   without patch   with patch
     0                 6s            1s
    50ms             210s           10s
   100ms             417s           18s

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

--
V2: remove module param to enable/disable async scanning
    add scan time measurements to commit message

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0af612387083..069350f85b83 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -3812,12 +3813,38 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 		nvme_ns_remove(ns);
 }
 
-static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+/*
+ * struct nvme_scan_state - keeps track of controller & NSIDs to scan
+ * @ctrl:	Controller on which namespaces are being scanned
+ * @count:	Next NSID to scan (for sequential scan), or
+ *		Index of next NSID to scan in ns_list (for list scan)
+ * @ns_list:	pointer to list of NSIDs to scan (NULL if sequential scan)
+ */
+struct nvme_scan_state {
+	struct nvme_ctrl *ctrl;
+	atomic_t count;
+	__le32 *ns_list;
+};
+
+static void nvme_scan_ns(void *data, async_cookie_t cookie)
 {
-	struct nvme_ns_info info = { .nsid = nsid };
+	struct nvme_ns_info info = {};
+	struct nvme_scan_state *scan_state;
+	struct nvme_ctrl *ctrl;
+	u32 nsid;
 	struct nvme_ns *ns;
 	int ret;
 
+	scan_state = data;
+	ctrl = scan_state->ctrl;
+	nsid = (u32)atomic_fetch_add(1, &scan_state->count);
+	/*
+	 * get NSID from list (if scanning from a list, not sequentially)
+	 */
+	if (scan_state->ns_list)
+		nsid = le32_to_cpu(scan_state->ns_list[nsid]);
+
+	info.nsid = nsid;
 	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
 
@@ -3881,11 +3908,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	__le32 *ns_list;
 	u32 prev = 0;
 	int ret = 0, i;
+	ASYNC_DOMAIN(domain);
+	struct nvme_scan_state scan_state;
 
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
+	scan_state.ctrl = ctrl;
+	scan_state.ns_list = ns_list;
 	for (;;) {
 		struct nvme_command cmd = {
 			.identify.opcode	= nvme_admin_identify,
@@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			goto free;
 		}
 
+		/*
+		 * scan list starting at list offset 0
+		 */
+		atomic_set(&scan_state.count, 0);
 		for (i = 0; i < nr_entries; i++) {
 			u32 nsid = le32_to_cpu(ns_list[i]);
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_scan_ns(ctrl, nsid);
+			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
+		async_synchronize_full_domain(&domain);
 	}
  out:
 	nvme_remove_invalid_namespaces(ctrl, prev);
  free:
+	async_synchronize_full_domain(&domain);
 	kfree(ns_list);
 	return ret;
 }
@@ -3922,14 +3959,23 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
 	u32 nn, i;
+	ASYNC_DOMAIN(domain);
+	struct nvme_scan_state scan_state;
 
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 	nn = le32_to_cpu(id->nn);
 	kfree(id);
 
+	scan_state.ctrl = ctrl;
+	/*
+	 * scan sequentially starting at NSID 1
+	 */
+	atomic_set(&scan_state.count, 1);
+	scan_state.ns_list = NULL;
 	for (i = 1; i <= nn; i++)
-		nvme_scan_ns(ctrl, i);
+		async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
+	async_synchronize_full_domain(&domain);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
-- 
2.39.3


