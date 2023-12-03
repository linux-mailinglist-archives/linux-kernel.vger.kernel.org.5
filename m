Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A1E80270D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjLCThI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjLCTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:36:39 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B019B;
        Sun,  3 Dec 2023 11:33:49 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so1567023276.2;
        Sun, 03 Dec 2023 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632026; x=1702236826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbCVZUZWRPuqODDp3Z8qmjnrbZPazZZzGPA5ZDraoqY=;
        b=GODEmAySZbn4+6NIc45hfyCky5+WU1lOhnwh+FrBR9QS0IHEVYfxhI8fPUvMUtDcvf
         GDJQigsAR2yc45hpGZnVHUiM/zJv78OS5hpPKDM3G/v3QDwEclGqIjHBUGOY9dvAI9JS
         iXpBjcDxYdQsc93EVJFEuFvBUHZdZNomajmTF4HfleZlIK2ajIAeWMZndNLdGssxhnbR
         aIOIdStmeGyiFk/H+/2GN57gOhbhPcF4qwP2JX0gWQkZYIKB6nnm0FeTxhIFHGvVAjjx
         LZxKuWnueRRKhv82EI5oZQYSkOLSgf/qJZY6SHyh/W0PxtEJBjukViVzVw8KWlZepJ9E
         CZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632026; x=1702236826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbCVZUZWRPuqODDp3Z8qmjnrbZPazZZzGPA5ZDraoqY=;
        b=h4z0gDRL3bUNtp9m/8Tq8EH9dBdJMHUAdVhYypBSKqDel4x9aClv/BgRJQ2sBPVzin
         dHpDMH/xxcV/H6MVWvfmfF9nTNdFyEeo7LC9xCu6NUFrwbu+NYi5GbIc7hkJmg8qU3Fu
         zmYW33bugsWAQ/iLzK0wjvzniZRVwDe37HlLBko06utN6FPLP5+png4wCGIjaU7n9r5Y
         ZmX0+3Spocibq2KTk+7jNtyfDRN8G9Xt14orZllNyYEatHu2fIdlxMGOmkYNQ+jfidLf
         RZyFtJJjxvkdN8ZJIiW49GhB6GC84gKwdPhctOwBkOIRjjGnQWAap/IS1YWMLpFVfz9L
         aRWg==
X-Gm-Message-State: AOJu0YyHQ6HGeWKFYAT2Y2zAOJNa2kX8QkTF0w6dd9w0wlR4/BgDVCJd
        aL9A83XvYT1/xDmKhzKZ+gFHHg+AsunefA==
X-Google-Smtp-Source: AGHT+IGu0APP9u8wu69W2xKOsAN5cuKpTM7AUbqner4I5ZDEE4Zj4TzmSznLt47vQLMdxzliHcTAdQ==
X-Received: by 2002:a25:bc90:0:b0:db5:4b47:24ec with SMTP id e16-20020a25bc90000000b00db54b4724ecmr1236954ybk.36.1701632026299;
        Sun, 03 Dec 2023 11:33:46 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id g188-20020a0df6c5000000b005a7daa09f43sm2758328ywf.125.2023.12.03.11.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:45 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>, netdev@vger.kernel.org,
        linux-net-drivers@amd.com
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 21/35] sfc: switch to using atomic find_bit() API where appropriate
Date:   Sun,  3 Dec 2023 11:32:53 -0800
Message-Id: <20231203193307.542794-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SFC code traverses rps_slot_map and rxq_retry_mask bit by bit. We can do
it better by using dedicated atomic find_bit() functions, because they
skip already clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/rx_common.c         |  4 +---
 drivers/net/ethernet/sfc/siena/rx_common.c   |  4 +---
 drivers/net/ethernet/sfc/siena/siena_sriov.c | 14 ++++++--------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index d2f35ee15eff..0112968b3fe7 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -950,9 +950,7 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	int rc;
 
 	/* find a free slot */
-	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
-		if (!test_and_set_bit(slot_idx, &efx->rps_slot_map))
-			break;
+	slot_idx = find_and_set_bit(&efx->rps_slot_map, EFX_RPS_MAX_IN_FLIGHT);
 	if (slot_idx >= EFX_RPS_MAX_IN_FLIGHT)
 		return -EBUSY;
 
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 4579f43484c3..160b16aa7486 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -958,9 +958,7 @@ int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	int rc;
 
 	/* find a free slot */
-	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
-		if (!test_and_set_bit(slot_idx, &efx->rps_slot_map))
-			break;
+	slot_idx = find_and_set_bit(&efx->rps_slot_map, EFX_RPS_MAX_IN_FLIGHT);
 	if (slot_idx >= EFX_RPS_MAX_IN_FLIGHT)
 		return -EBUSY;
 
diff --git a/drivers/net/ethernet/sfc/siena/siena_sriov.c b/drivers/net/ethernet/sfc/siena/siena_sriov.c
index 8353c15dc233..554b799288b8 100644
--- a/drivers/net/ethernet/sfc/siena/siena_sriov.c
+++ b/drivers/net/ethernet/sfc/siena/siena_sriov.c
@@ -722,14 +722,12 @@ static int efx_vfdi_fini_all_queues(struct siena_vf *vf)
 					     efx_vfdi_flush_wake(vf),
 					     timeout);
 		rxqs_count = 0;
-		for (index = 0; index < count; ++index) {
-			if (test_and_clear_bit(index, vf->rxq_retry_mask)) {
-				atomic_dec(&vf->rxq_retry_count);
-				MCDI_SET_ARRAY_DWORD(
-					inbuf, FLUSH_RX_QUEUES_IN_QID_OFST,
-					rxqs_count, vf_offset + index);
-				rxqs_count++;
-			}
+		for_each_test_and_clear_bit(index, vf->rxq_retry_mask, count) {
+			atomic_dec(&vf->rxq_retry_count);
+			MCDI_SET_ARRAY_DWORD(
+				inbuf, FLUSH_RX_QUEUES_IN_QID_OFST,
+				rxqs_count, vf_offset + index);
+			rxqs_count++;
 		}
 	}
 
-- 
2.40.1

