Return-Path: <linux-kernel+bounces-101481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C887A7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82DB1C21A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB5C15D1;
	Wed, 13 Mar 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="tq9+w0ms"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE18184E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333547; cv=none; b=JPSV0nQ6c+Izu3BaWp7VX9nWhLduvNYiS/ODzpbRZ/8YB+wuPCM1bs0G8CIM27nMsqBE3WHfHFoIbjAsG2//HZrMFxDj6vH7tH9LzlvOMIJAd6XQphWbGw4BQhoYdS2Jk78HKA4eX8CWFjS8QvDRdUl9ssuN/BLrkAcK7JGq520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333547; c=relaxed/simple;
	bh=ngUuaRo2pmFu+8jYoRTurrk1cfzCRQG5Duy0aSlL/Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DreJbtCtASKJ5GRVQziCLwdRDQGDq3K7VkVixCCc4vlkom5iSDi4s2nns1fPcfXSZBEefVoIIzxlx2Gp2A/Vmu49tKU4h8Sorlly5zT5XsxzwbbGpAP7j/uvhRkuC4LsUH2s7sfQsI/iFNNKx+OolAw69936DaOBlFS9gzJwgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=tq9+w0ms; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd97fd66cdso26979485ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710333544; x=1710938344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=njgblKV6yYKUHhKiUWdh6CmtTll/pgdv/COytyS4OoQ=;
        b=tq9+w0msKHjxtMQoIlBBbTbb+PvYfX2app/nd6lESvQ+ki815ICvs/USGYYycHGixT
         hECfn6pttVvKP95cMsQzWgqRHPmw4vfdoduEeVBLVhUZkq5AT8vqGk9fOYIKxnHDC1zu
         VcID6s64JJS3S5RDYnU99eflaufhFAACNN7OOyu9WhqFjjvuDuNFu/f1B9vq6E8LFnXJ
         dAOvT7fXMbuKSdCLFEfuUjvnP2dYXVmTwl8DswJivyeC9NggVVu7JEvlBWUBYNGgq1gW
         nuuX0iKvo4xJfnMM42W9dxbQOYPikrtYPF9Gwwic2QMSAoc7dfs7j7bFhPy/xiue/zMZ
         +QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710333544; x=1710938344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njgblKV6yYKUHhKiUWdh6CmtTll/pgdv/COytyS4OoQ=;
        b=WCh2FX9NhgPrLzGLgQiK9Q0LWLjblT1dwlKLWnaWATMxEzcJSQfOeENQsZ/4uomnKs
         /RUDCPO4ptd4H5otKzld0g8LC90VnYwSe1LRdKgTfUfeG8RoDLh/MH0FSrf1DvxkmSIr
         7VeFleAT2tNjRQhNgRD773+OEOu3zhbwhTBKlnhwddQehUMRhgOmZnT22TcZmmrN4BwT
         0Kib0ML5iCpjI3R91c7Irp1KJ5dH6/t3rWQ7mDKLq4qBDFlSf0s5sVeP3u9juUcI7kGV
         fv0d0wl/p/fkPxDmVVQrVnCLC9fk9zwAlAkN4KiNusPSBVtja9PPqSFXc0RbKkeXqdLy
         5icA==
X-Forwarded-Encrypted: i=1; AJvYcCVWndifeDegojPmNYK24emC5ZSk8N8N4BzJWanBoTIn2LoJyGU8cYwFJ4Lgq1cU1NBKSn1j45e2PRyx1cmr/1Xyj+QNX4yyRBFZ3n5g
X-Gm-Message-State: AOJu0YxL3dtfU1pVKWGR9BRpt7wYybNAqKBxzcRbJgkziN0i3eXcSqA9
	Fv3kXFK/hbJALNtLwsFAOQtBrYY0nVhoinMhBPo0/vz7RJLBD+gW6lZKZjVA8Rs=
X-Google-Smtp-Source: AGHT+IHKm9fQknaASl+M5IgBaTKOQc2BRZdUNRsjnyNo9DIcyVNGt2YqwrfAc1sLBtlVoHNA+bY81Q==
X-Received: by 2002:a17:903:2303:b0:1dd:c1ba:d46c with SMTP id d3-20020a170903230300b001ddc1bad46cmr4672301plh.61.1710333543851;
        Wed, 13 Mar 2024 05:39:03 -0700 (PDT)
Received: from localhost.localdomain.cc ([2407:cdc0:ab48:2284:ee43:5c89:b26a:f291])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001dd95b5dd0fsm6440696plg.69.2024.03.13.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 05:39:03 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Anton.Gavriliuk@hpe.ua,
	Li Feng <fengli@smartx.com>
Subject: [PATCH v2 1/2] nvme-tcp: Export the nvme_tcp_wq to sysfs
Date: Wed, 13 Mar 2024 20:38:09 +0800
Message-ID: <20240313123816.625115-1-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the workqueue userspace visible for easy viewing and configuration.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e05602..2ec1186db0a3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2800,7 +2800,7 @@ static int __init nvme_tcp_init_module(void)
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
 
 	nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
-			WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS, 0);
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
-- 
2.44.0


