Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BB79B1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356280AbjIKWDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbjIKTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:51:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8A1A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:51:05 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id fmvuqjtZmmTYjfmvuqYQl7; Mon, 11 Sep 2023 21:50:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694461858;
        bh=ZamjEVZ18uTTJvONVpJjngq/DbdaPZNJa1qgQbQpoRw=;
        h=From:To:Cc:Subject:Date;
        b=K9obfdGdVxHS2CYE7BBNg4g3et6obL90MC7iMj/0IaUB/W1GHPqeBy0547TCtk0Iw
         g5LmkU8HegOrtKi97dK0zjIG9bSiHQWs8hIPYY6463Wr7wTTzGdtM5CGN5pTErkKCi
         sSU1I8z/XVqwSJQvVZ32XUEWF+EG/3+5YkKkT/F3/s2KUYc0qpSr6DDwwnqZOe7Au0
         baUiJYEtIre5X/neoTE++KjllhD7DVruxTVCUYmzdRurnS0pdY3MC1BYmQ8IJfmS5W
         HZ7dDI5LChMHgZnfld0y35Y6zsXM0JA1ZhUrEtpEH2MEneNJN/hP6F14EHSm32bFYw
         QwF6I7ZXfBUQQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Sep 2023 21:50:58 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org
Subject: [PATCH net-next] net: hinic: Use devm_kasprintf()
Date:   Mon, 11 Sep 2023 21:50:52 +0200
Message-Id: <198375f3b77b4a6bae4fdaefff7630414c0c89fe.1694461804.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kasprintf() instead of hand writing it.
This is less verbose and less error prone.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index ad47ac51a139..9b60966736db 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -861,7 +861,7 @@ int hinic_init_txq(struct hinic_txq *txq, struct hinic_sq *sq,
 	struct hinic_qp *qp = container_of(sq, struct hinic_qp, sq);
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	int err, irqname_len;
+	int err;
 
 	txq->netdev = netdev;
 	txq->sq = sq;
@@ -882,15 +882,13 @@ int hinic_init_txq(struct hinic_txq *txq, struct hinic_sq *sq,
 		goto err_alloc_free_sges;
 	}
 
-	irqname_len = snprintf(NULL, 0, "%s_txq%d", netdev->name, qp->q_id) + 1;
-	txq->irq_name = devm_kzalloc(&netdev->dev, irqname_len, GFP_KERNEL);
+	txq->irq_name = devm_kasprintf(&netdev->dev, GFP_KERNEL, "%s_txq%d",
+				       netdev->name, qp->q_id);
 	if (!txq->irq_name) {
 		err = -ENOMEM;
 		goto err_alloc_irqname;
 	}
 
-	sprintf(txq->irq_name, "%s_txq%d", netdev->name, qp->q_id);
-
 	err = hinic_hwdev_hw_ci_addr_set(hwdev, sq, CI_UPDATE_NO_PENDING,
 					 CI_UPDATE_NO_COALESC);
 	if (err)
-- 
2.34.1

