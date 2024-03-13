Return-Path: <linux-kernel+bounces-101482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA087A7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63781F23FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62C3FB88;
	Wed, 13 Mar 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="XyMHnB6V"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AA28F3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333549; cv=none; b=IiAu6P3u87P0MeXuxa3ab3pMz4TRK3CUZKjFNtT3CDA8rXuEPuSaKLZTNC8e0UrH2BRJRlMiQC+pfRNJ7d0U2LVWi6evCwES/g5AXRno8OPOKtnYi/ghAjCM/J4Ku4TmhLS5TSAQTNlpzyITdioaAbExoAhwasDM7MXadLM8xnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333549; c=relaxed/simple;
	bh=VxnYqFpMNrkrvkCd/Uk+38u8KTxd2R1sXfsxtDeMJDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjfJeNOTAG0kMkd3HdR8E0R1P4AR3M3kswIUE9zZ6NiNExasiBaMbOsZkEg/E0HOipT9SgbodltPxAYmhQdLemFgTh3gvLnLzwOMGJtMAeI2+OyWSXm29TMFg5EQIcUTQktrq/Inebs0CZf0eOBKeDeaYY/jCzRt8qN/THTysJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=XyMHnB6V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd10a37d68so8913685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710333546; x=1710938346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p793P1BTk7k277weTIdJuZGu4hnig42k4ieb9wGqdXY=;
        b=XyMHnB6Vrl6qGN6n7LSzkQfSJYz0SaaLQI8oIbNdGuHUKaYirpCyc6nZCUjjNN3Zvg
         yqh6vTQaH5qKTfwe0RAfWF7IGf/ga4rPyg+KFeP9XReVNHV99RHFymJ5aAGw+Qw5PRiB
         G/LZTOJGJxx57Tkhre669B2181N78ENk+4im8uD5JF3ch+sKZ9zSbSlOmI+v0/3tv+Xr
         Zq7M/PB1VjdpsYhhoUL9vhk2fq4FL+jPdN3wFmocREsul/4ZBSvFOnlM1yeYVy2m1fin
         bkZ4Mr9Ebmgud2Ku8uDD3OHUQKHVmKOmvHw9Y88L1mmXf7zs11z+vkW0oEUKC2qOnhhF
         r7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333546; x=1710938346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p793P1BTk7k277weTIdJuZGu4hnig42k4ieb9wGqdXY=;
        b=SPy4EQhknz6zs6mcY65PCkk1WbUdQFaJPmehOTenqn2GlQ+In0UGr8ZbSTJjJFiuCQ
         bSXJah30FzbgoajSBTIVd5XgFLonHDj6ia7XWjibI1dFVJvtiP49tlGaUA9ZOJciV+dA
         6DxwRGJT2A7/3KyXuXdawZQtDZTQlVseJVLHhkemVpIyJYduNTbsHTor98TwbKGENXEe
         GcmB9jupW36RnWpafzDMAFhumby9uJxiVCQT08CHkRfsKJyHV8TUIyex2eriqSAGuXT9
         e55M4fpJiY4y++fSq/mpgGvDlFEfciqRFc5wPiaUeAdrIYMFhezvyEtT7U231+mqc04m
         JG/w==
X-Forwarded-Encrypted: i=1; AJvYcCUTMNvDQjemZ0no/Rr5V/8qt7cHP09vuG87u34EWhcbQTsWVlMGdg1T2t/JWkDvcV99fms39CpOUJBuq0JxidJYez81M8YptKvinCtd
X-Gm-Message-State: AOJu0Yy6/4d8/J6Yyzjb55I8jSZjmRklpoaDPVoaY/Fl65seVdQxMksA
	MuxaXolIOv/mLCfm5fI3K7w9502ZrcZLqJyhPRQmYz0r6opbf0dlz3RMjagGb6A=
X-Google-Smtp-Source: AGHT+IHSR4NZqEKpPRGEz1h9gCqyf3I7QrJuUdWoD2pI+Gb4mE8YekSGojr4q+MbQUi3dR12PXz0YQ==
X-Received: by 2002:a17:903:22c8:b0:1dd:72cd:9442 with SMTP id y8-20020a17090322c800b001dd72cd9442mr3612081plg.30.1710333546263;
        Wed, 13 Mar 2024 05:39:06 -0700 (PDT)
Received: from localhost.localdomain.cc ([2407:cdc0:ab48:2284:ee43:5c89:b26a:f291])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001dd95b5dd0fsm6440696plg.69.2024.03.13.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:39:05 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Anton.Gavriliuk@hpe.ua,
	Li Feng <fengli@smartx.com>
Subject: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Date: Wed, 13 Mar 2024 20:38:10 +0800
Message-ID: <20240313123816.625115-2-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313123816.625115-1-fengli@smartx.com>
References: <20240313123816.625115-1-fengli@smartx.com>
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
index 2ec1186db0a3..34a882b2ec53 100644
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
+MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
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
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
@@ -2799,8 +2812,10 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
-	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS, 0);
+	if (wq_unbound)
+		wq_flags |= WQ_UNBOUND;
+
+	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq", wq_flags, 0);
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
-- 
2.44.0


