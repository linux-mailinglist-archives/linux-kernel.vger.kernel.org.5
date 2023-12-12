Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8780E1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjLLC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjLLC2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:32 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1437114;
        Mon, 11 Dec 2023 18:28:25 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-dafe04717baso5072473276.1;
        Mon, 11 Dec 2023 18:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348104; x=1702952904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5dLrjk8RGdEFK2IC/mT3GdPdKaiYDerbdLTf1ASMu8=;
        b=div8NoT3hGC25kZssriOXiz4HMqfwc5EWDH2eeYR8CYshwy27Of7YnsHZsBHqUKGQD
         7q7xr2LP6cXJ9mRdl6Vb9yXDKlyUSU2rz2UH3Tms2aGmdhD6Kog8v5nXp46bvQTppxvM
         LCEQFPOWrhBHxMrxbEbEJ1uF78OU8zTR66idqST6Ir2M+b/JHjWTKfPcXReXp02k3zHS
         w6GKxQ5xTBJz6OTOjzHdE5wJwX99JFVpxBu5hyo7shKnc58KkCW45QxsiPmm5Gn42a/G
         fMkGy7cC1mMgwGBAfVf6tZK/Q9hVEddiOlyOdJzgjGQjSZWRs/+O5uM+ze1hh2EIGHO5
         nePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348104; x=1702952904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5dLrjk8RGdEFK2IC/mT3GdPdKaiYDerbdLTf1ASMu8=;
        b=aA0Cwq3xj+JSItZXSxBt16hCmfrAFKaDwEnwDai3rqOgBKuVaNw6k6QOmnZJMkOd8o
         d5vjPXBJhAG7OOYbO1KGytiguuUfJOoIFjUcow52ddn/IHcgE1m06LgpVukvq71b3Dxt
         s6ZhKY4dfGVH3bUuwZYpVEuaH6ddLcBQ7QQiMIU2eoc4vX7CdOuRtLsg3MFvKzUmBgHI
         5B4tumE0icbbLmp9O2fMGiB7Bit0tGUfLwX7v69QUXkKRGuPEoxLWNsLvrGFbDw7DE3Q
         NGCg6eVOY1VX05cD5OsUKpJ1O4Rixv1Sfd/f0cEljibRcSZxjXEk2P+b71CHwxrgbVY5
         XRBw==
X-Gm-Message-State: AOJu0YwUNdzjKEDCT1uXtbjHmN7y1vs+i2LLUyJwYTWSJivl9rHcOyLW
        nZAw/4O+QfjYmfrshiDW6vFt+uiLe8pLLw==
X-Google-Smtp-Source: AGHT+IHp1dJVq6AiSkWUXT6teibC9JRWOJxb+fMHX6K4A08kJLb31Z2LLH3UPUp5SLKf8329TyCHhA==
X-Received: by 2002:a05:690c:2c01:b0:5df:5d59:6d71 with SMTP id eo1-20020a05690c2c0100b005df5d596d71mr3494936ywb.21.1702348104547;
        Mon, 11 Dec 2023 18:28:24 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id j62-20020a0dc741000000b005da626a84a2sm3445778ywd.30.2023.12.11.18.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:24 -0800 (PST)
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
Subject: [PATCH v3 21/35] sfc: optimize the driver by using atomic find_bit() API
Date:   Mon, 11 Dec 2023 18:27:35 -0800
Message-Id: <20231212022749.625238-22-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

SFC code traverses rps_slot_map and rxq_retry_mask bit by bit. Simplify
it by using dedicated atomic find_bit() functions, as they skip already
clear bits.

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

