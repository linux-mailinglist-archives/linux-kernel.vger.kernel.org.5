Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74D7AF1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjIZRWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIZRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:22:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F05116
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:22:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690ba63891dso6923595b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695748956; x=1696353756; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eK09SY9XnKtYYEeKZnb21txziNbHU1j+5dHVgQL9+WE=;
        b=EzNqOJcWhoQu55QHV5ATgucEkI8yC9eG01YtNr77TYEo3WAlc8EknHgCJOeE/fmQJZ
         s0JpAZAirENnb5UvSDEZ7IHhnpZC7+SVGseond3/6k3k1Q1+NMJa9fe9EGiGb45dhTom
         ImsDC+dGNOWkqCgfowCRSyjO7BHyZnlndo3iYJb7UQ5Fb8CCD8hQdjvMateNIR3ADBMo
         +fK2rICM+amkrpYP/oYYaq6eNJGRWCEfcUWSuE+0OHETBKqGPoCAUcN4P5DxWoHG82C/
         YIpVCoDdivWQMH2BanUDwzekStOSSVXT2P7GeSYclhCrtspEXyMzmFY3eg+H1ybzg7cJ
         2yDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695748956; x=1696353756;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eK09SY9XnKtYYEeKZnb21txziNbHU1j+5dHVgQL9+WE=;
        b=X5SoG1Ikjov95OC7FbMf1yXl8vJ560ZkAogUzpppNXtIzpr3+ArXXPd1LDVaOdlD8w
         sFpg4JZzvsrimyRXVZhn+zAQfEQ2p5n87BE7FMozAR1AfhkjVsR/lTFQXwMUk/bkir4s
         FVvlh7b2eyZJg/JmhZ4AWccWCoB8USRgYUShzUZvDluxkYmcmDofKNQaT6xMTpZyu++X
         MG5qAGORjfPlaIjsBnVBw298aHgQaOFyxDK7m/fuJHR/p9z146QyHWirhnvy0lzv/2bH
         +LzHOgCjpsVxJzPzRIgqaMSpvG5/U+pdlr7HcmLT0xH2mDUeX5Ua8LTqQgLqlmOEXLJC
         x5PQ==
X-Gm-Message-State: AOJu0YwERcuctTBP8h63GrRrBLoHwZ957r7wWWq4wrd6P+zE5DdcF8sn
        IOPaxIn8KvhC5uvg2nNclvU=
X-Google-Smtp-Source: AGHT+IEyc2uv0p8+Qf+SIjOHIOliLqbPagqqIfNSHAsdtOegXTnGbScLJOuA2pDRhbgeHoPJH3rflA==
X-Received: by 2002:a05:6a20:139a:b0:154:e7e6:85bd with SMTP id hn26-20020a056a20139a00b00154e7e685bdmr7271605pzc.20.1695748956241;
        Tue, 26 Sep 2023 10:22:36 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7908f000000b006661562429fsm10510857pfa.97.2023.09.26.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 10:22:35 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] nvmet-rdma: use spin_lock_bh() on rsp_wr_wait_lock
Date:   Tue, 26 Sep 2023 17:22:08 +0000
Message-Id: <20230926172208.55478-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to me that read_cqe.done could be executed under softirq
context, as done callbacks always do, and it acquires rsp_wr_wait_lock
along the following call chain.

   nvmet_rdma_read_data_done()
   --> nvmet_rdma_release_rsp()
   --> spin_lock(&queue->rsp_wr_wait_lock)

So it seems more reasonable to use spin_lock_bh() on it, otherwise
there could be following potential deadlocks.

nvmet_rdma_queue_response()
--> nvmet_rdma_release_rsp()
--> spin_lock(&queue->rsp_wr_wait_lock)
<interrupt>
   --> nvmet_rdma_read_data_done()
   --> nvmet_rdma_release_rsp()
   --> spin_lock(&queue->rsp_wr_wait_lock)

nvmet_rdma_cm_handler()
--> nvmet_rdma_handle_command()
--> spin_lock(&queue->rsp_wr_wait_lock)
<interrupt>
   --> nvmet_rdma_read_data_done()
   --> nvmet_rdma_release_rsp()
   --> spin_lock(&queue->rsp_wr_wait_lock)

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/nvme/target/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..a01ed29fbd8a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -520,7 +520,7 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 
 static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 {
-	spin_lock(&queue->rsp_wr_wait_lock);
+	spin_lock_bh(&queue->rsp_wr_wait_lock);
 	while (!list_empty(&queue->rsp_wr_wait_list)) {
 		struct nvmet_rdma_rsp *rsp;
 		bool ret;
@@ -529,16 +529,16 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 				struct nvmet_rdma_rsp, wait_list);
 		list_del(&rsp->wait_list);
 
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_bh(&queue->rsp_wr_wait_lock);
 		ret = nvmet_rdma_execute_command(rsp);
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_bh(&queue->rsp_wr_wait_lock);
 
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
 			break;
 		}
 	}
-	spin_unlock(&queue->rsp_wr_wait_lock);
+	spin_unlock_bh(&queue->rsp_wr_wait_lock);
 }
 
 static u16 nvmet_rdma_check_pi_status(struct ib_mr *sig_mr)
@@ -994,9 +994,9 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		goto out_err;
 
 	if (unlikely(!nvmet_rdma_execute_command(cmd))) {
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_bh(&queue->rsp_wr_wait_lock);
 		list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_bh(&queue->rsp_wr_wait_lock);
 	}
 
 	return;
-- 
2.17.1

