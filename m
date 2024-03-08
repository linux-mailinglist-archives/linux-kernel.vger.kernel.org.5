Return-Path: <linux-kernel+bounces-96440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B03D875C25
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D41F21DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C322EED;
	Fri,  8 Mar 2024 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZM+jfiG"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FB224CC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862878; cv=none; b=adiT1gJc8hKKU7wKvMb+RnMMqGxQKCZdbFobDI0rk/2Upr/CtSdQ2jSj9ReW7iTHxP/rDKUUfrpzTizvGZpxH+5exvjGFmA1sdRSsow0l8I8VNj0IC+zz1YszsnbYSODSk73cexfqh/dx2m6BATAnp1JmCNn39MsNmoXR59sMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862878; c=relaxed/simple;
	bh=AWB34K9JSaG+L3McdXe1VruUf5eMJo4RqUBRvbb90AY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tTsOjAl+4f83qUEkqhYHJdTYran6mAOpke4MbVmhjxHFfXgjY4IsHDREyxaHdPPVVf2pvk9AdtsxuHtR9M+rF6ls5n2q/zranJ93wIfXIFi0wm+5TFOe3XqlSJO2uQ685K9y4L1QpZ2xiARpOca0tI5n9XdaIhfwaCnSRrT4+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZM+jfiG; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so1139883a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 17:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709862876; x=1710467676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T0VmI7cjh01bWA9ccp2UxVbT9UK8V+NJKMSbB8EgOiM=;
        b=eZM+jfiGWDbbzoukv767tItVRAPlNaLlrP/xIXfvFH7q/GDVMvfIyzeA2PeUzY9xVy
         c4TtVAAMxnfOEcAx+266jzygMtpawUoGsGTcw92PP7aJ+n9l7KleK6PRN0OxYq0IkTja
         SNRAERf4RMfXZ87tYnsxlJSiuIl+AMnpg3vd/xEchBFMKdCXCHCC/934WZCaN+EObyO3
         SM6EZUj7ARyENap80C/W8HcPtXcnRVC7n6017STka2oPT4NOnBMvRmAcHVEWMI7o7R6g
         vZ+cQRQxlQPvNZy/qlxM3PeD7C2HixX3aBRIRR2WspwF6YJlaD+WPrCgGI6DYHaxjSS+
         1Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709862876; x=1710467676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0VmI7cjh01bWA9ccp2UxVbT9UK8V+NJKMSbB8EgOiM=;
        b=RmjrPsUHTnjStA5PEonWtDvVSEiumiClKPtUjcNbkNjUQfuw1zy3Z8kwefr4pgoXQ/
         /wLEGbGIdy1ojoHRyXA9bjjDcWi54RgEuHVYv9cZ2Y2aDDlVtNOw3pu/Ow9db4cjfRlJ
         jaP5IPR7QPo4XBCAQtEgywggDYO1sM3k+e9V08O0s1i1156orj2fV0r8KBCIL9+AUvtZ
         nxX22X2GATLRhP6kHygYjrig0Fmu0GmZgQ8WOhTXCSYYy6Xj6vavdNbcuiXufQiSMCnS
         PzwtCdqLKPGD+J0NBmTDzVa734f8KuR4IQMfieKJV3c0DtIGeqKve8A3nr2f3Y+fT9vd
         v7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlfwZlvG2Tut9HeOHuB9aw18xC9DzC3XHzalpTJS+KMTzARrWb4SUUOexg+rzWnAjCBJFj9SKfBBc5xz+vEnTJBNOHFGmjCxt0EL9W
X-Gm-Message-State: AOJu0Yy6M9YvAgVHJS2HCiFmXblZoLpwIuHMNxo2lvT8MPm7avRscJfL
	mT2e5Eoz/0t0HIt4IgUWEIRJo6xQI8VoEgukKR3dLsA59xhNisMG
X-Google-Smtp-Source: AGHT+IG8Ki4U/HJqYPtsOy4+8fzlsGDeLJ+EjEnwZUwHoLxUKzC6D0RgqFcow4Z6uSVDQALjxcmYmQ==
X-Received: by 2002:a17:903:187:b0:1dd:6997:c96f with SMTP id z7-20020a170903018700b001dd6997c96fmr465916plg.18.1709862875858;
        Thu, 07 Mar 2024 17:54:35 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id lb12-20020a170902fa4c00b001dd675cb6fbsm317845plb.298.2024.03.07.17.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 17:54:35 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
Date: Fri,  8 Mar 2024 09:54:35 +0800
Message-Id: <20240308015435.100968-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

We found a issue on production environment while using NVMe over RDMA,
admin_q reconnect failed forever while remote target and network is ok.
After dig into it, we found it may caused by a ABBA deadlock due to tag
allocation. In my case, the tag was hold by a keep alive request
waiting inside admin_q, as we quiesced admin_q while reset ctrl, so the
request maked as idle and will not process before reset success. As
fabric_q shares tagset with admin_q, while reconnect remote target, we
need a tag for connect command, but the only one reserved tag was held
by keep alive command which waiting inside admin_q. As a result, we
failed to reconnect admin_q forever. In order to fix this issue, I
think we should keep two reserved tags for admin queue.

Fixes: ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v3: rearrange commit log, no code change
v2: keep two reserved tags for admin_q instead of drop keep alive request

 drivers/nvme/host/core.c    |  4 ++--
 drivers/nvme/host/fabrics.h | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..3d394a075d20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4359,7 +4359,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_ADMIN_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4428,7 +4428,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
 	else if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		set->reserved_tags = NVMF_IO_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..a4def76a182d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,12 +18,10 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
+/* Reserved for connect */
+#define NVMF_IO_RESERVED_TAGS		1
+/* Reserved for connect and keep alive */
+#define NVMF_ADMIN_RESERVED_TAGS	2
 
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
-- 
2.25.1


