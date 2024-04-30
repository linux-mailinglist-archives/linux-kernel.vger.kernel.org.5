Return-Path: <linux-kernel+bounces-163262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF18B67E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAB1C21F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DB18F70;
	Tue, 30 Apr 2024 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2FmP045"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F4633D5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443476; cv=none; b=JNUmeHRjZ9IMHYocIOTr2sFNJZ+7pDh8Hi09Gqrcpn3J7PRCWxZh7AsA8mPnjXFMNyzsPIQ4L0mE6901pbGL2VEu5o3seUPHpQki1CLMqFokjoHz9q7kKMRIYlDFpT192qsP6sMLOPlfm6mbhiFhD5sV186hEbhaPi3BzVzKsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443476; c=relaxed/simple;
	bh=A+pXMQ7LewpVRbo5DMWA5iHpn7olR3kQXZjLcapHorY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5JcjXpC0hC20eGCj3JWI2PBAbgnnIqtX6aUDxq/VfPdwBEglf6K88oDOh3PVG5fA6w4BqXqX24h03CLIqNvlZvus/TpjXQbt5FvqPxMlGJejVGbVJR5h6fKEUMqpn7iEZEATv2XH2YctX8s99L0Qpq6IqUb3+Y3MpmACVqdk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2FmP045; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so4128489a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714443474; x=1715048274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cchrfa8eIXWEq/fb8YAhdNX//HQqlhIwVZ6NSv/uTAM=;
        b=E2FmP045xwzRDtEtmolF3CqlTtAMs166KJlMSQCc277ZcGUVgOlen6EXfa8oRFnoFz
         xna9FMqjAjt8dSMqb15VKt8rZSTtOaigjubVKhorZ30PkTDntBGtWDsIqEiPe+5WtVTO
         VCQEDL6g+f6HaMiUvBqrVYpyVIQSLwgROiAubTDa7SzgChYEkHuS3SruXczG0CZb+C/T
         DBcBw4hv3fenJ/pe1DS3IgLBV09+HUUOoAcBQmQLH4v7UIAjOlhyezzWIM9ym+bFhjPi
         P5FnvLtdQpJ7o0CSMTyH+V+W53xxooDjDGbNve+EADQJ7fqAeXU2OuzoscEXCNIrSl73
         0Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714443474; x=1715048274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cchrfa8eIXWEq/fb8YAhdNX//HQqlhIwVZ6NSv/uTAM=;
        b=uvue6sBEqwuyzck07pmXlbnb614kx9eA+O4g796MSfg2optKow+8v+4IOr9wux5K6G
         EtGSE73SEfI/1xQzLrjyCEvqkUzMdmFuxJEDAb9+BAbbRKLBaG00ChW6VsGlRe/H5ZP4
         egmi6CdpYSq5MoBHIvauUXo4+oYf3ArvN+JlCHTCk/RIAAU1edZGz13HaROMP5CvYEVT
         A79oy1g6TCBY7BnQPmYv6nY2h0DrJS+rxjrOxH8JuJSX2dbjm0rDiFxt0CFITg/jH46u
         uSEZ5zJsnyLALjhemhYBaCS5YeQXML2BOplQg6s5wwgCQcTguMayC2rvpYreh7+t3aAU
         6Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCVXRaERLxHjh7evfKsu1P5ZFsC5HCg74NTXkaOm+kSH9oAxDK/Dlyxkcu5eCCzRnv+EUt6Naq7ZG51Mq9sDnEoofDyG58K1sVBWEFjx
X-Gm-Message-State: AOJu0YxTCmeC/DUyGeJXBhIAROc2yIZl3hcsFQM2GUBWKdt7H+4Xx1rR
	5NeWQQ7AbH7UVc+/zo+CcvFTuYBy1rBjWC/zawtq3Pej0713aydB
X-Google-Smtp-Source: AGHT+IEF3eO70FW3TItLtjRdAj6x49nr+2Kh7RJrVnC3sLWoPwJO4yfoQOluLguDyR+oKOT9sfZO6w==
X-Received: by 2002:a05:6a20:c70e:b0:1af:3857:e653 with SMTP id hi14-20020a056a20c70e00b001af3857e653mr8338836pzb.12.1714443474145;
        Mon, 29 Apr 2024 19:17:54 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902694600b001e20afa1038sm21154619plt.8.2024.04.29.19.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 19:17:53 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
Date: Tue, 30 Apr 2024 10:17:53 +0800
Message-Id: <20240430021753.385089-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

In some scenarios, if too many commands are issued by nvme command in
the same time by user tasks, this may exhaust all tags of admin_q. If
a reset (nvme reset or IO timeout) occurs before these commands finish,
reconnect routine may fail to update nvme regs due to insufficient tags,
which will cause kernel hang forever. In order to workaround this issue,
maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
tags. This maybe safe for nvmf:

1. For the disable ctrl path,  we will not issue connect command
2. For the enable ctrl / fw activate path, since connect and reg_xx()
   are called serially.

So the reserved tags may still be enough while reg_xx() use reserved tags.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22..f6416f8553f0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0);
+			NVME_QID_ANY, NVME_SUBMIT_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.25.1


