Return-Path: <linux-kernel+bounces-84749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA7786AB03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF881C2336B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267B36123;
	Wed, 28 Feb 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEfS2gy0"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC4339A8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111660; cv=none; b=INEdVJUMDSEQ1sQ/rkCYMWyajqasIlLoQC3nX+mdqLamADwu1ebtQjjbmFXPckL3dpFI34C5fd4b9qaSaVjjgHX5RKMsezFIBrUTCmtqMFXJ59xnoQjxbU9XwiPG72ELr6YzFEJfzOPrJL3nWZg08n+CMIWB5mRm5ZzkPHQEwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111660; c=relaxed/simple;
	bh=YqT3rosOO1z9LAP2EjAA3CdVKOOaWYbKMcl0gaenUQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1RSiHBRqIc2OQJ5YFew1PGhaVCVAJEPrh65Oyx93F15CA1AuJxA4XVZSDFNm3Q+dY+oqm8jYwE7m746KJyT15OzVLPqCDMw955VDLw5RnW6eV/ldCL4/v88mKTIYYXHJitvguXIrsZSOIULbK39x+gbdlpoMb+QBzLBkseinPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEfS2gy0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4591141a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709111658; x=1709716458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwNxh5KU/TPJqtrokiiKhDFcHYcJeUw5wnGYXiE+YAY=;
        b=PEfS2gy0B2owdT9rmCcyDnhlKjcXOlNGSKMLwKm0svZcdK4lmsv1CiisAw3uCB6dbx
         xr4lFfqk6WOum8ehF2JVGnAoKjNzhYgkCq2X8pesRs0wg5h8Cfcucl1njgcq9NxK8Xqn
         oS6hnLE1GYD8XX9DW2bPeqP5PaiMvreosYrWpCOrv/dUe/1PEivWV8tWhoGGw5AOpGzM
         R3oB58cVf2rZjR0q120+jRFxuaNPZ/lhuJmzvn3CKptrM2H+oLH2pPYdiNZ/4EHPgGft
         mVUfTCmOzeO7YdXizVPcQmU52Jbcg0Pl6R3k0eyRPDFZDLv1iXRGV7sQCy2FpUjBCU2T
         EG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111658; x=1709716458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwNxh5KU/TPJqtrokiiKhDFcHYcJeUw5wnGYXiE+YAY=;
        b=FhJrLGlF0Jn/FxEG+twF3vl1VcnXrrPVpvtffY2XZ3KXNDeeUgt9PH+HT81+vKfkxQ
         eW3wuSsgmPrnFADl07m2Ofm1kuGRqKyjJqFNIEtkb7zbj4oFUlQZhn7/dZJYVl2wcZRC
         o8cNBQrQisr8jCslUsixgGyvtBp2w10mQ0UHTboMRjQhIVmJoivtahwyCycNUV/4AC/Z
         Ejx8ckqGD3gbldCdKck/5yhuslc/gdDW3J91tFbgxJsTkr3iN5ORETeHWy5fKmBekHX6
         VuazHjMEpoeqdMT3SK6Hvsc4nD2dwVw2asSBhRnMV6rrIggAUb1I+uq5WZCmAn8J6SiR
         Z3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmU42fS3A3ZQSxo+7Velfm+dmghMaxI8M10Z73SaclPSgVsQSUIeTRvzL3XiE+d/ECOGAbN+/0xkXHo6NYjckiXIAXlEVZnyuswvEU
X-Gm-Message-State: AOJu0Yx0jgHbexZWUvDMK4uY0FRQY00hW0pCl4zcdPnQgwrZOSGzEI8c
	hSXOKVZGo6ZxCDy4J5EU+qqCdum8YWFrAo7O0pm46iPM6f60GFKs0drj5dDqv7o=
X-Google-Smtp-Source: AGHT+IH5NAXcMbuhJpH/Xq9dDpHTumyiizBHH977vYfxaCnejpVQkk9t9d+6zFC8dMykJv5VnZD7OA==
X-Received: by 2002:a05:6a20:c887:b0:1a0:f0a4:8206 with SMTP id hb7-20020a056a20c88700b001a0f0a48206mr5002676pzb.29.1709111658541;
        Wed, 28 Feb 2024 01:14:18 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id sx16-20020a17090b2cd000b00299b31de43esm1058722pjb.45.2024.02.28.01.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:14:17 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix reconnection fail due to reserved tag allocation
Date: Wed, 28 Feb 2024 17:14:17 +0800
Message-Id: <20240228091417.40110-1-brookxu.cn@gmail.com>
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
we failed to reconnect admin_q forever.

In order to workaround this issue, I think we should not
retry keep alive request while controller reconnecting,
as we have stopped keep alive while resetting controller,
and will start it again while init finish, so it maybe ok
to drop it.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..07ed2b6a75fb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -371,6 +371,8 @@ enum nvme_disposition {
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
@@ -382,6 +384,12 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+		if (nvme_req(req)->cmd->common.opcode ==
+		    nvme_admin_keep_alive)
+			return COMPLETE;
+	}
+
 	if (req->cmd_flags & REQ_NVME_MPATH) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
@@ -1296,8 +1304,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
-	if (ctrl->state == NVME_CTRL_LIVE ||
-	    ctrl->state == NVME_CTRL_CONNECTING)
+	if (ctrl->state == NVME_CTRL_LIVE)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-- 
2.25.1


