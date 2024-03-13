Return-Path: <linux-kernel+bounces-101231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93FE87A451
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AAF2829FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83A1B267;
	Wed, 13 Mar 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="rMzcvAdN"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00B19452
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320168; cv=none; b=sdu4B51AJFDutglE1DZZjFO6jlGF+dxitWOx5S+G2gjQ92BcjJXz42MuTlLhJ9AMmfZ/1U5pg4MjZy6UHc3zZtjKVgRPtvP0AheZ0akH/thx9/9gfFLYjthUWXT/XBMm2z30fwU4wULGGcTQETyDcryDPsjsdfmcn8v1nrKS6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320168; c=relaxed/simple;
	bh=AN/agWW3HoQxK3M61OPsqagSCr9q3SqrjjZVpXonF4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+zq88MP1Ha3c8pzsAcbbMlhM6AlM+PV5x9OuKd16aJx2GHUpFHf+zIpnJBx58xAwR4Yvo9BjCZfGKU417ivp6evxOsHCjWYyrFWhIufRsARwZ1OPzDwULic7fO4qvVlISk+mka1CihwoiuQKDUt0e53WZx7hQKnn/8XU6xbXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=rMzcvAdN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so4159265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710320165; x=1710924965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm85BXuVczHuF7thZskvHACa56yT/MJpoY/H4BB3y8Y=;
        b=rMzcvAdNd3HPhHSa6LpnYZRdUn8r0eqUzXA0590UgJR1dALYdPnJ7SgVYhN0TjZwuk
         1uFPmc92VJh8ZV8h7SMijDJ8oOM+S+/Uz1beM1eWlara5mmufnXkCgEDSEeMq5gw2uUv
         F1QrB91/PJT7ctRk/vs/CMVDTCnIDrcaIXpfjn58Mzko/N/rt1lJlYFJ3X9QPAtYCsxh
         cXK8cjqhVynLt6TYUMXDYL1cofqpkGOV/mqFy/ejq5UJAjMF3AZxhej60xu52m5BuBg6
         EQqpQDoluMdfY8K1ElfwfC7OGrujebBQlFD/zmigGLJG04STg0SZlzvnYD9FYGiJi9W3
         64NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320165; x=1710924965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm85BXuVczHuF7thZskvHACa56yT/MJpoY/H4BB3y8Y=;
        b=uzj4SohTmDfiYjSEekgTMXnjnAFBeBWo43BiWPIGRSoJzavawopzeieTOjw20nqFbW
         oP1kIfE91aAeawyVaDXupuSbgWurGVz+/ggUW8JGaGssPQjsyRaCpQcRwa3eaQIKQOgE
         jmzM/ktMY0DuSZBHHfiaTBsgdkGJ6M3Mvcd590H8CWtrEx0LHxeR7dLoqYlPsKR2aTBs
         x2YNV/ZsNIi+BHgqyP4aOP2QOFcpvgMKQsZRxbUjf9wr5ocg9kxE7fU/XVppDrN3l6Cr
         cNMiL+N38fezAIwF84TLMqySyz266rWZTn+N2Fge+3WmqyGr5Jiw7gvrrVxg+B5k7cY7
         Q3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXFGfdJ6xt/LrcdXatkLpfRaC/EJd2wQHkRAUlHerlU7PGBsNZR6JqHyI2qTPAYhpIjISDzsPqBU2g0bKSszQ2i/2SH/W9tF2Y6cZQk
X-Gm-Message-State: AOJu0YyzAzKk39hHRmU5CfqWMYw3kTyiSszMA4Gi1+brf3i8T1bNIRsu
	uMCgNfj6bhQ2EVjjp+NVruKOE5Y7LhyUHfUFFd0j4jkjt+EowfP/gOkYMwtWoemFDo9cBMf8cVF
	ugyYE6A==
X-Google-Smtp-Source: AGHT+IHj9sWvnrNbgEbJTmkO0mdVRd3JkV/BMSjseGuZwRkFHTRCBZuuBBAWm3G3tmwBHnuUO6m/Dw==
X-Received: by 2002:a17:903:947:b0:1dd:a616:8205 with SMTP id ma7-20020a170903094700b001dda6168205mr2047210plb.34.1710320164517;
        Wed, 13 Mar 2024 01:56:04 -0700 (PDT)
Received: from localhost.localdomain.cc ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001dc6b99af70sm8022794plg.108.2024.03.13.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:56:03 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Anton.Gavriliuk@hpe.ua,
	Li Feng <fengli@smartx.com>
Subject: [PATCH] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Date: Wed, 13 Mar 2024 16:55:17 +0800
Message-ID: <20240313085531.617633-1-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default nvme_tcp_wq will use all CPUs to process tasks. Sometimes it is
necessary to set CPU affinity to improve performance.

A new module parameter wq_unbound is added here. If set to true, users can
configure cpu affinity through
/sys/devices/virtual/workqueue/nvme_tcp_wq/cpumask.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..5eaa275f436f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -36,6 +36,14 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+/*
+ * Use the unbound workqueue for nvme_tcp_wq, then we can set the cpu affinity
+ * from sysfs.
+ */
+static bool wq_unbound;
+module_param(wq_unbound, bool, 0644);
+MODULE_PARM_DESC(wq_unbound, "set unbound flag for nvme tcp work queue");
+
 /*
  * TLS handshake timeout
  */
@@ -1551,7 +1559,10 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	else if (nvme_tcp_poll_queue(queue))
 		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
 				ctrl->io_queues[HCTX_TYPE_READ] - 1;
-	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+	if (wq_unbound)
+		queue->io_cpu = WORK_CPU_UNBOUND;
+	else
+		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -2790,6 +2801,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -2799,8 +2812,10 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
-	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	if (wq_unbound)
+		wq_flags |= WQ_UNBOUND | WQ_SYSFS;
+
+	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
-- 
2.44.0


