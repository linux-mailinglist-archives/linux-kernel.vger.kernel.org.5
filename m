Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E77A9049
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjIUA5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjIUA5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:57:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31CBD3;
        Wed, 20 Sep 2023 17:56:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso353944b3a.0;
        Wed, 20 Sep 2023 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695257814; x=1695862614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bagVEl6M2d5FIlSzY0anx8WgPT2rmaHrI3Hcd6Q8CcI=;
        b=ZiVcYiXEdK/8EZhVniQPvOwzRDp3H46UM40v2C1HRFmAGB2iRiLF+WlTJsAW7RfPF9
         z5ZxyBmsL0B8/AiykZbffZ6C2IXkv4GHovXLUIhmqxZw+ZgAjpig/aTvFHgiAjELV2zE
         B+HQw7hJs+aMisnQfN1ydMK1Bstq8HceK0NzvLzLVg/UKSyQBIuZPI5uXDJ35k6nf+4O
         cq1hyOjvlJss/sBYqItJTWcE+vbbtbOSfe4jIFu4VDEVO5XqzbGXkvB7Omm/iS8R2yHB
         3jIoCfG0GAKkfPPp/T3W2nJyU36HcY5lqF5tosy0plJTjqXUgjo+yWXhmtDpHkfpQ1Cx
         qSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695257814; x=1695862614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bagVEl6M2d5FIlSzY0anx8WgPT2rmaHrI3Hcd6Q8CcI=;
        b=B1kQWN7t6wnZm1OePVqDOSWv7kC6WyS40j18O+t8fAWdnWLnhl+JIF//w+ureXL9Vc
         /qKb3DLZtv53gotdNVxtny9U2VrNJ0jdtkmusG0bZ/8Qo5klXJDewDg6Mm5ppGywzc0d
         65mSPrBBRllQBBQNk/JqPQa8jWqLOayhdRaF5nECqshRfBq4zYOhmudvW29gyI3DH658
         5Eu1kJI1WrkakFZQ6ZO08SsFJt32D7Kp0clf1tEG8qcwnykgNoOG6AsYGuE2JZgm+9LD
         0Nm++x4C0//J97b2af3y1dk//RWCTxEdqfp1iNkmYKsGIr+QCFRMfrCA+cVchJhkrHZ2
         mYiQ==
X-Gm-Message-State: AOJu0YxO3ni4ICkTlVVydtJs24G+9SVbWfH0W40KAQInl4S7Z10r4Aal
        HbWYZjw3Zjaz29PTlJMXNG8=
X-Google-Smtp-Source: AGHT+IFUcPFST8m/McJD1VU6r71vUMY0Tmsem/TpC8OsulBLO3kYTcnPgQvWIbb0N1edCoMuvFgXwg==
X-Received: by 2002:a05:6a21:78a7:b0:136:e26b:6401 with SMTP id bf39-20020a056a2178a700b00136e26b6401mr4781000pzc.16.1695257814004;
        Wed, 20 Sep 2023 17:56:54 -0700 (PDT)
Received: from localhost.localdomain ([104.28.226.90])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78e51000000b00688c733fe92sm123696pfr.215.2023.09.20.17.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 17:56:53 -0700 (PDT)
From:   Sieng-Piaw Liew <liew.s.piaw@gmail.com>
To:     chris.snook@gmail.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Subject: [PATCH net-next] net: atl1c: switch to napi_consume_skb()
Date:   Thu, 21 Sep 2023 08:56:23 +0800
Message-Id: <20230921005623.3768-1-liew.s.piaw@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to napi_consume_skb() to take advantage of bulk free, and skb
reuse through skb cache in conjunction with napi_build_skb().

When parameter 'budget' = 0, indicating non-NAPI context,
dev_consume_skb_any() is called internally.

Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 74b78164cf74..46cdc32b4e31 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -842,7 +842,8 @@ static int atl1c_sw_init(struct atl1c_adapter *adapter)
 }
 
 static inline void atl1c_clean_buffer(struct pci_dev *pdev,
-				struct atl1c_buffer *buffer_info)
+				      struct atl1c_buffer *buffer_info,
+				      int budget)
 {
 	u16 pci_driection;
 	if (buffer_info->flags & ATL1C_BUFFER_FREE)
@@ -861,7 +862,7 @@ static inline void atl1c_clean_buffer(struct pci_dev *pdev,
 				       buffer_info->length, pci_driection);
 	}
 	if (buffer_info->skb)
-		dev_consume_skb_any(buffer_info->skb);
+		napi_consume_skb(buffer_info->skb, budget);
 	buffer_info->dma = 0;
 	buffer_info->skb = NULL;
 	ATL1C_SET_BUFFER_STATE(buffer_info, ATL1C_BUFFER_FREE);
@@ -882,7 +883,7 @@ static void atl1c_clean_tx_ring(struct atl1c_adapter *adapter,
 	ring_count = tpd_ring->count;
 	for (index = 0; index < ring_count; index++) {
 		buffer_info = &tpd_ring->buffer_info[index];
-		atl1c_clean_buffer(pdev, buffer_info);
+		atl1c_clean_buffer(pdev, buffer_info, 0);
 	}
 
 	netdev_tx_reset_queue(netdev_get_tx_queue(adapter->netdev, queue));
@@ -909,7 +910,7 @@ static void atl1c_clean_rx_ring(struct atl1c_adapter *adapter, u32 queue)
 
 	for (j = 0; j < rfd_ring->count; j++) {
 		buffer_info = &rfd_ring->buffer_info[j];
-		atl1c_clean_buffer(pdev, buffer_info);
+		atl1c_clean_buffer(pdev, buffer_info, 0);
 	}
 	/* zero out the descriptor ring */
 	memset(rfd_ring->desc, 0, rfd_ring->size);
@@ -1607,7 +1608,7 @@ static int atl1c_clean_tx(struct napi_struct *napi, int budget)
 			total_bytes += buffer_info->skb->len;
 			total_packets++;
 		}
-		atl1c_clean_buffer(pdev, buffer_info);
+		atl1c_clean_buffer(pdev, buffer_info, budget);
 		if (++next_to_clean == tpd_ring->count)
 			next_to_clean = 0;
 		atomic_set(&tpd_ring->next_to_clean, next_to_clean);
@@ -2151,7 +2152,7 @@ static void atl1c_tx_rollback(struct atl1c_adapter *adpt,
 	while (index != tpd_ring->next_to_use) {
 		tpd = ATL1C_TPD_DESC(tpd_ring, index);
 		buffer_info = &tpd_ring->buffer_info[index];
-		atl1c_clean_buffer(adpt->pdev, buffer_info);
+		atl1c_clean_buffer(adpt->pdev, buffer_info, 0);
 		memset(tpd, 0, sizeof(struct atl1c_tpd_desc));
 		if (++index == tpd_ring->count)
 			index = 0;
-- 
2.34.1

