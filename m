Return-Path: <linux-kernel+bounces-98413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DD78779BF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73572811A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A9EDB;
	Mon, 11 Mar 2024 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5x3grYn"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DC812
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710122971; cv=none; b=J8reQrhc6bcpjlVtomcYAhEC72X4EPQgIlDB2fH937V3PFX4shcsYhTLchex6gD6GCNm+1irn8J/LNBfHMeuNYY0QgsX3iT7NnBxKQhSTThF8RXAJXP94gq+7R3duAJg6o2YpLQX9tZurviTczCcrnTMV7fk2C0OXljEN6Z9jFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710122971; c=relaxed/simple;
	bh=UpmFp74ay0Ol8HpjLX2V80TYaJW2nnT+dSTPHakkRl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZU1kFlRAn4106/zs0QcIxxgrpBWu9U9Lxl2RrHavQY/KBOAuOy+5NsBFCf2+SfwLsmmTnwYPPeCxExGO914JPDTNYqlujqkOa8VcBj2HXc6vgvAO/uhmRcPBb3bmadf7QMfGghcx4d7gD6jErnq6mEfN9Vz4JOB5kBm7SeTwgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5x3grYn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3353701a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710122969; x=1710727769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4ztNqq1FwMuKzBeQUi/UacN3w/fjsndHTJlWkBGBT0=;
        b=V5x3grYnlf39ATi2x5gJ+tx+fJA6t9oqTTyW8HjdObH38dm/KO9zejrWSjyOUbo1P0
         pLJFFu4AWQD8lwtA3WYSPO/7uA610YS8B5EnGcHngvfH1nz8SJpdDQZMOKnD42CBaKx9
         uIPjw0+t4vEZ9w0vfp/JQFhjQ3SPC3ghwicBIPjz/QB9Pu7936N6lifaiK5DkiMoiIns
         SwrSJNy+bUQPlXRjQEn6tVLLH9oOdLpdZQ3rpqFiF/MKBuB/ssqwNEdhrQf32t1iY8sy
         M2xU0VExBtUc0piW+pYiGB3tUqobV8iQcYPyIhmmPoED8AWe9GIepabFFZBtvUCwlHmq
         YSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710122969; x=1710727769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4ztNqq1FwMuKzBeQUi/UacN3w/fjsndHTJlWkBGBT0=;
        b=xTmtsrJcZrntH/MLLH5txUjmWX0Cg6ys3Q4U1H20t5dpLveFJw4xaGQUT1BUK8ZSR1
         ZkSkxEvw+V+VemtnBM64cfjeH6HyNWRQHjkHc9HpG23Z8w2CBVSuqzR92CE9HIUsPQPo
         3pXZR80ifQlqKrhlCGszxTeXL2z58Kg3XxG2u01ZDlW/zZIcs7iBPm/fAYWH7GP/5Mly
         CKV/UG+1zizy4miXBYKOeGlRSkgrk9ATS78kcIewm5OMsxIrsZVwZFQG2lh7jSltkQB/
         aorfj3NDU80WNmcsNOK+ENlyMlKlIH6dhO5SAyFiI1Ng9h8Qh7IPxTLrEgNWkd81ZEa8
         iECQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlDZl+YKktf+h5ggoAvqZgLRJCSQwZekQL84/mQTXiOwn6QEzqOpZ8rr3HWvxk98hYHE/0BYTRxT3HtSS4c7XFpdjst3YU6uQKZRS0
X-Gm-Message-State: AOJu0YzD3NR/byt3KXX1XpKxg+MJdZtBHrnZO/oxhiWYqmjQ11a55b15
	vK4mQdnAeWmXwaWfqNHKYA1olZQf2NasYr5byQzmaTYMgP/IgBqFrO4ejsJ5
X-Google-Smtp-Source: AGHT+IHqBF6JL0jv4YkL9dvpzWH5MTZk1eBoCcUG7fuhmwb1A35fre/o9bnKED1G3FfFT131dmX8eQ==
X-Received: by 2002:a05:6a20:258f:b0:1a0:f5b9:bd88 with SMTP id k15-20020a056a20258f00b001a0f5b9bd88mr7832457pzd.55.1710122968903;
        Sun, 10 Mar 2024 19:09:28 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170902f98e00b001dd61bc14f2sm3387888plb.8.2024.03.10.19.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:09:28 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvme: fix reconnection fail due to reserved tag allocation
Date: Mon, 11 Mar 2024 10:09:27 +0800
Message-Id: <20240311020927.85482-1-brookxu.cn@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4: move init value and the comments to the real users
v3: rearrange commit log, no code change
v2: keep two reserved tags for admin_q instead of drop keep alive request

drivers/nvme/host/core.c    | 6 ++++--
 drivers/nvme/host/fabrics.h | 7 -------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..fe3627c5bdc9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4359,7 +4359,8 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect and keep alive */
+		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4428,7 +4429,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
 	else if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect */
+		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..37c974c38dcb 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,13 +18,6 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
-
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
  * allow the override it when creating controllers.  This is both to provide
-- 
2.25.1


