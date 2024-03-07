Return-Path: <linux-kernel+bounces-95376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD11C874CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04B0B21070
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A11272D0;
	Thu,  7 Mar 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT4WP146"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4D125DC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809619; cv=none; b=tRhZGwD5OKao4kpMrRGOjXT6PhQGEelKrxSNmGol1Z4GFe3MC42TGfP8o1DMZp2tWGLz346yq/0FTqiTwYXk3ob7h3Vn4kqLpHEp3ijC2RAUy65ssRh3JhQc9/PU1mGs1TnVbJ/ClfhVJEjuNKQ72jJ5o1gA5veetuOs8CX/LcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809619; c=relaxed/simple;
	bh=HRa+h+MVx6vcYH6oqnodWxGJ0wsjKUsI21FSsxtAoS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocRbciopHZ5E0XTrxFcaG6bCaY9PqVh3Z1bKoUOFlmce+AiuPC3OaKkkIDGeIDD2EWQ4+TdRQp17b1O6ao0216uVpBdeZebcvo6OENb4JI3UxKP9ZFBjssMGC3YPnc/EUCqnl2vjDQnozDzG1aZLXWHTwuinF92Tkaw6Jn8oa1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT4WP146; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so590683b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709809618; x=1710414418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uR2n9vqmHYDmRi4Mo+EM5BpT0JuFoc+JmwQnzy9M4Yk=;
        b=XT4WP146CDHoot7Q1VRl/DqsR+f7PurZtFiuF5Bh2lTQCwhKIb9nanur5J97g1IvLR
         9KPRk95rAA8TIowGeuPDZua7cwuaJfOcyp08C201knDHab+qDo1nRClw/bx5jV4FVJcf
         TOficlIZ3W4BmJviCoiugsEW7ECaqoez1tiHt7BGSvgg90AxIkGgWVeW8ms7HAJv6pJK
         TM4lnaTJyr6LzIvg/EFj5k3RW64p9KDxnpnmM+Jkjq66sgWjovBg4SqJ4mfEhX/o8ons
         TFMWXflyikmwOTB/uQ7LmCKuXxJqRSLnr2cpX0BO44tT8yMjMuMT4iZ0QhMLAoIzTxEs
         hW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809618; x=1710414418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR2n9vqmHYDmRi4Mo+EM5BpT0JuFoc+JmwQnzy9M4Yk=;
        b=FgRZmmqwO/I0ReO9YOT9CuRQqAeiuS1zdty8blvtSLbVZhkCc3RR62bGYqk1OQh4ZD
         5G4L0LxgrAhZXgE90CHNLKXuXi5Z7cRLfIvFEmMbV2sFJ8/rCo1r4HdR2WDIkoh4mIfu
         bsgurmzwc8SJgKAu0X/hn93OhMnCBOJasa/03zFCuIy3ZzLKOV/0dcmoxJmc3xH+zvce
         XT0xmMZLMAOS1H84qqW7xaSDs9SjmoIEh4fGt1EX7Fu2nvnKUWAPueb2zpQgvddR87KS
         FjB4kyNhp7HyMQMAirrL9Jh9FvlFKc16Wp+n5vAXnQDZ4B21jFiGAvU0yJ/AhFgKyjWs
         nVcw==
X-Forwarded-Encrypted: i=1; AJvYcCVMTftbuxU2iqv160rEeHISOoIZKawf0B2rX0ttdmwbNLjKHlM7bZjKEWNaKbnSJ1bZ7hM2ioxoOu/HGX4CL4nQc4s8jGVa3Qwb9cic
X-Gm-Message-State: AOJu0YxbQvI+e679ZXNQ89rW0uo84uogTgFsujIYVK8jqa5dA0oM7ydu
	FoRKWy9g1zstFVt1IyS914gTGFc8XK8m1W+REFyvSKVcJVMHrXBp
X-Google-Smtp-Source: AGHT+IEaTzs45VumZZImiBx+kdUqEeJkyq0RDS0XcfTiQIBbtVQ0nQpC27vWSszWIKYpSdti4zlvyg==
X-Received: by 2002:a05:6a20:3114:b0:1a0:a06e:41cf with SMTP id 20-20020a056a20311400b001a0a06e41cfmr5752759pzf.32.1709809617767;
        Thu, 07 Mar 2024 03:06:57 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id n17-20020aa78a51000000b006e56bf07483sm12297854pfa.77.2024.03.07.03.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:06:57 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme: fix reconnection fail due to reserved tag allocation
Date: Thu,  7 Mar 2024 19:06:57 +0800
Message-Id: <20240307110657.252120-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

We found a issue on production environment while using NVMe
over RDMA, admin_q reconnect failed forever while remote
target and network is ok. After dig into it, we found it
may caused by a ABBA deadlock due to tag allocation. In my
case, the tag was hold by a keep alive request waiting
inside admin_q, as we quiesced admin_q while reset ctrl,
so the request maked as idle and will not process before
reset success. As fabric_q shares tagset with admin_q,
while reconnect remote target, we need a tag for connect
command, but the only one reserved tag was held by keep
alive command which waiting inside admin_q. As a result,
we failed to reconnect admin_q forever. In order to fix
this issue, I think we should keep two reserved tags for
admin queue.

Fixes: ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
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


