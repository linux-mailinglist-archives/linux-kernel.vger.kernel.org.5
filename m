Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FC7BC524
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjJGGr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbjJGGry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:47:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFBDBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:47:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5855333fbadso1919985a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696661251; x=1697266051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa94tOMo0Ci6GaMj3teUTMvZG21PCOv5dzIlQFQsxBg=;
        b=S2VU4jWSdC4YUk6xRrWoXB/MHoNmTFCgxlyWBlauxaMLkOiIy4IwzuE55/lJaNOmha
         DQCozK9hdPR1koNe3mVAt9gDGwnVd/zaZzdlXCMk8HVH5k/TQRqJNVPO2aIAvB7vRmK6
         z0u4OhhXSVzPaP3C41BdJtw2G2Tae6cHibah56CUvgloxgjORX70VsZqRSPC75tM1joR
         zL0Au6yh/FEFe6h9fGE2UR/Y38rGN2tR7rajsAGp2xYcMSllyzLCbvKcO1flN4U6GOjK
         gRaMwRnDVn/x0q8CFQVvJwAo7F9x/uezUB55zwmwcdgs5W8Ru7o8Py3DTxL0vC33uKKJ
         gnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696661251; x=1697266051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qa94tOMo0Ci6GaMj3teUTMvZG21PCOv5dzIlQFQsxBg=;
        b=q0llKrlSozfdW1K+GeEDfbno0gkfKpA4yNjjgc2JE5D2RHCiW6X/9AsZ5fDnzrp9xy
         wstyM+Zh0rJzIxedxTCFDVAIW1ZNQeeBQSCnWRJq1Nh65RvBRL+lrIvpwV4gIIyodQgR
         b1rQFfOA1wOA2cp9/I5/x+M/mfTEu9FOeMBtluTKIP5Y+kQrUrd5ko+9U6xo5PMHyrp4
         1BBB6WKtaalsWyhujUw6BJaDkjU+EkRjjD55ALDk8UguzNXxts6gLMvTMD/EeT6pTQrB
         gAmbUIm9ogt8zlM57IcQ1g0V9oJoWqWYky9EsW+tOAhw3havDfcJxddrMX6iDucvyohE
         diUA==
X-Gm-Message-State: AOJu0YwtO3wPvSVD3LjPCku2WvHIzKI9ciYfEHLTRSRMK1+vCROzdjAk
        a3fdO3Pa5gXN28MFpZqowWQ/3A==
X-Google-Smtp-Source: AGHT+IEQ4g9qyeKgKL49JcIxxXTL1KHeA+mt6bBdARAbvmrI6TPdKgqMhVSkXm1HXQQj9tc4KA++AA==
X-Received: by 2002:a05:6a21:181:b0:15e:dca8:1224 with SMTP id le1-20020a056a21018100b0015edca81224mr11235444pzb.55.1696661250780;
        Fri, 06 Oct 2023 23:47:30 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b001bda42a216bsm5063523plg.100.2023.10.06.23.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 23:47:30 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mst@redhat.com, arei.gonglei@huawei.com
Cc:     linux-crypto@vger.kernel.org, jasowang@redhat.com,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH] virtio-crypto: handle config changed by work queue
Date:   Sat,  7 Oct 2023 14:43:09 +0800
Message-Id: <20231007064309.844889-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MST pointed out: config change callback is also handled incorrectly
in this driver, it takes a mutex from interrupt context.

Handle config changed by work queue instead.

Cc: Gonglei (Arei) <arei.gonglei@huawei.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_common.h |  3 +++
 drivers/crypto/virtio/virtio_crypto_core.c   | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 59a4c0259456..154590e1f764 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -35,6 +35,9 @@ struct virtio_crypto {
 	struct virtqueue *ctrl_vq;
 	struct data_queue *data_vq;
 
+	/* Work struct for config space updates */
+	struct work_struct config_work;
+
 	/* To protect the vq operations for the controlq */
 	spinlock_t ctrl_lock;
 
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 94849fa3bd74..43a0838d31ff 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -335,6 +335,14 @@ static void virtcrypto_del_vqs(struct virtio_crypto *vcrypto)
 	virtcrypto_free_queues(vcrypto);
 }
 
+static void vcrypto_config_changed_work(struct work_struct *work)
+{
+	struct virtio_crypto *vcrypto =
+		container_of(work, struct virtio_crypto, config_work);
+
+	virtcrypto_update_status(vcrypto);
+}
+
 static int virtcrypto_probe(struct virtio_device *vdev)
 {
 	int err = -EFAULT;
@@ -454,6 +462,8 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	if (err)
 		goto free_engines;
 
+	INIT_WORK(&vcrypto->config_work, vcrypto_config_changed_work);
+
 	return 0;
 
 free_engines:
@@ -490,6 +500,7 @@ static void virtcrypto_remove(struct virtio_device *vdev)
 
 	dev_info(&vdev->dev, "Start virtcrypto_remove.\n");
 
+	flush_work(&vcrypto->config_work);
 	if (virtcrypto_dev_started(vcrypto))
 		virtcrypto_dev_stop(vcrypto);
 	virtio_reset_device(vdev);
@@ -504,7 +515,7 @@ static void virtcrypto_config_changed(struct virtio_device *vdev)
 {
 	struct virtio_crypto *vcrypto = vdev->priv;
 
-	virtcrypto_update_status(vcrypto);
+	schedule_work(&vcrypto->config_work);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -512,6 +523,7 @@ static int virtcrypto_freeze(struct virtio_device *vdev)
 {
 	struct virtio_crypto *vcrypto = vdev->priv;
 
+	flush_work(&vcrypto->config_work);
 	virtio_reset_device(vdev);
 	virtcrypto_free_unused_reqs(vcrypto);
 	if (virtcrypto_dev_started(vcrypto))
-- 
2.34.1

