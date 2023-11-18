Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71A27F00B0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjKRPxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjKRPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:48 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799F1BD4;
        Sat, 18 Nov 2023 07:51:39 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-da819902678so2850616276.1;
        Sat, 18 Nov 2023 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322698; x=1700927498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVDnPRtaRLazzNSQqeYFzsOLIVc3PVHkJ3Smdo81+fM=;
        b=fH6IUlnKl+XJ2/OuYFTx23RstVGtGSlGFQ/3+xlroLXDu1iCWEociJ0i4qjs+HhfEO
         aOtwuhCaKCn7N8R9ulrKmvt4zGkgL7KmefwSS7195RiI72CX5L4ijY+RYDxqavdqTV+p
         +QBshJ9+oMGQvxhCvauk98tZur/evaRPmpJsAoCYoZy2Tb5OKqqszoCNwuVCMnlNDyli
         qzi6MZ7EwJpElz7mSyM11yFwcUpU3M5Yju7pLfZz6aS11EsbRQG4Hq6lYFslYBY8w/Vx
         atEKoMayU0rr/A8RMw6MDDnGuHW/QKvL/5CqcjIqhRyTfjN8X/8v9tbPw+v3CbFo914V
         OpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322698; x=1700927498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVDnPRtaRLazzNSQqeYFzsOLIVc3PVHkJ3Smdo81+fM=;
        b=eUFVJ/I3c6HsTpn6yVhaxaa7ggfFTiZExzEdL7k7TgltVCHgxwh9Te/HU78iWKbNef
         mvYGpGLKhqbwhMW8N/QUQSlS7YtLLMXBK65rqTWi/lhcD4FwlV2DX5znt8tJK7fPMkTZ
         ZUE7Ts7WF5tDXSbLRy1rta/I9Bxi/wWkK7IGbvPwoZsFpSj6jchUjyk/TuxU6a1TIVgR
         ACu4e8F+lCT048CmIXf3gsEojWBWFOYtu9Z1Opoa2FP6E+ufNxZ/LAEwOMrRN2UyvhqA
         4fA7zV9ii6twWTk/e36KL4DlVVlw83h3NLHSFA06h6x/ap4/lXzEs96JkfnBfhld1M5e
         JZIQ==
X-Gm-Message-State: AOJu0Yzqtkc6PYBlKcP3kf941lOT5TJm9olg/hXHoEGSDc/VUGGDCHrU
        zMT0iZtmxUCJd8Iouv9yl57hLl6jOgbN8Ok7
X-Google-Smtp-Source: AGHT+IFtv4Y5M+sXZKP4hY/boWna7OBaMWOrVT2d9mWQ309PzUbuFpqsDSmyQwNUVJs/HTlum9QHAQ==
X-Received: by 2002:a5b:a12:0:b0:d9a:ba25:d1f9 with SMTP id k18-20020a5b0a12000000b00d9aba25d1f9mr2149118ybq.9.1700322697688;
        Sat, 18 Nov 2023 07:51:37 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id b79-20020a253452000000b00da076458395sm998958yba.43.2023.11.18.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:36 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 19/34] sfc: switch to using atomic find_bit() API where appropriate
Date:   Sat, 18 Nov 2023 07:50:50 -0800
Message-Id: <20231118155105.25678-20-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
2.39.2

