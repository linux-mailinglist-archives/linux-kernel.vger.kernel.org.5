Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CED7F00A0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjKRPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjKRPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:28 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5381728;
        Sat, 18 Nov 2023 07:51:29 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da0359751dbso2372606276.1;
        Sat, 18 Nov 2023 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322688; x=1700927488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7UbIoFa3HLA+YNouSNyxHd1ANvqTMMe1TaZ6Yb0imk=;
        b=KAi1o1Lp2NXwdu7Wp2qrYSU1kAU39h4nCxehYxl8oMXiayPkh0Q3w/J9ydhyMErtxH
         4qcESin55kISPjFb4nD6h7tm8Drs9yk9ITYtfYpqhRTc1ZLLV3Hxy3EzxlpoTAVcnFIF
         HrF+Cks34FmnTYFTG1GezpcK3MxWcW5vRrrZEiuLZo45H4OImCbrOS4s1vGq81zYoFFA
         MzPsW+2v3WUuNPg17AqgaNfFqIdsA7bK0GOIRKUkDzRwvtu63GfYqRvQ3XlsnBbMGOCA
         kuUhkDvJj/MXlAOEHpBRWsCGlE/nhsoGr5rfga4yWUDCOzXSywEmuG3FC2KCoaonDgIJ
         atxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322688; x=1700927488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7UbIoFa3HLA+YNouSNyxHd1ANvqTMMe1TaZ6Yb0imk=;
        b=tByGhZ5Qiz9yPFEuwaCgeDROxQEZA1QwOkU7blb+kM6cfMvG+M7LHn7V9RKwm+lZE9
         xKONKvwhXDiHhDAs75OwCbhabqiFqykPFvOiIwh/6ZwVg1IFRmPwkC9ceKGrbWGn5xnn
         lp03mxOPC1d47QbflBbrJeRfDwrB76dw6LDuYWSsM2Mapy8XZ3rjqTe1dqyadqKQto0o
         nW9GjbJrGkk4Lp85GypdWldfZg2mb5+2IABjwp1rc1RFwLChF4o6rKCU2fFimeTb4hAK
         CcYtJqwtuuQDVcSpJ1YQZroYSGkkGdr2saseBF6P8wI5f2GEzKOdtX48ZjBkLAyujQV4
         tKBg==
X-Gm-Message-State: AOJu0YzYzv4yYTGCKXFCN/v11vwMFj/gIIbxgs96Sz2acUt45KbXES62
        8bsaVeiCKoKsFuGrhC3mypDrVjfXGtsZXaVp
X-Google-Smtp-Source: AGHT+IG2fdzu87N53rGqJR9N9gQqCXQKJNf4sG4KZv9s0gbPje53w6L12nPkNTqg8pVr1QpQJBOnQg==
X-Received: by 2002:a25:ad4f:0:b0:daf:7702:fd60 with SMTP id l15-20020a25ad4f000000b00daf7702fd60mr1666371ybe.1.1700322688428;
        Sat, 18 Nov 2023 07:51:28 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id w4-20020a254904000000b00da3b52e3cf5sm1010714yba.10.2023.11.18.07.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:27 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Yury Norov <yury.norov@gmail.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 12/34] wifi: intel: use atomic find_bit() API where appropriate
Date:   Sat, 18 Nov 2023 07:50:43 -0800
Message-Id: <20231118155105.25678-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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

iwlegacy and iwlwifi code opencodes atomic bit allocation/traversing by
using loops. Switch it to use dedicated functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 .../net/wireless/intel/iwlegacy/4965-mac.c    |  7 ++-----
 drivers/net/wireless/intel/iwlegacy/common.c  |  8 ++------
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c  |  8 ++------
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   | 19 ++++++++-----------
 4 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 69276266ce6f..8fb738c95cb4 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -2089,12 +2089,9 @@ il4965_txq_ctx_stop(struct il_priv *il)
 static int
 il4965_txq_ctx_activate_free(struct il_priv *il)
 {
-	int txq_id;
+	int txq_id = find_and_set_bit(&il->txq_ctx_active_msk, il->hw_params.max_txq_num);
 
-	for (txq_id = 0; txq_id < il->hw_params.max_txq_num; txq_id++)
-		if (!test_and_set_bit(txq_id, &il->txq_ctx_active_msk))
-			return txq_id;
-	return -1;
+	return txq_id < il->hw_params.max_txq_num ? txq_id : -1;
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 054fef680aba..c6353e17be50 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -2303,13 +2303,9 @@ EXPORT_SYMBOL(il_restore_stations);
 int
 il_get_free_ucode_key_idx(struct il_priv *il)
 {
-	int i;
-
-	for (i = 0; i < il->sta_key_max_num; i++)
-		if (!test_and_set_bit(i, &il->ucode_key_table))
-			return i;
+	int i = find_and_set_bit(&il->ucode_key_table, il->sta_key_max_num);
 
-	return WEP_INVALID_OFFSET;
+	return i < il->sta_key_max_num ? i : WEP_INVALID_OFFSET;
 }
 EXPORT_SYMBOL(il_get_free_ucode_key_idx);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index 8b01ab986cb1..21e663d2bc44 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -719,13 +719,9 @@ void iwl_restore_stations(struct iwl_priv *priv, struct iwl_rxon_context *ctx)
 
 int iwl_get_free_ucode_key_offset(struct iwl_priv *priv)
 {
-	int i;
-
-	for (i = 0; i < priv->sta_key_max_num; i++)
-		if (!test_and_set_bit(i, &priv->ucode_key_table))
-			return i;
+	int i = find_and_set_bit(&priv->ucode_key_table, priv->sta_key_max_num);
 
-	return WEP_INVALID_OFFSET;
+	return i < priv->sta_key_max_num ? i : WEP_INVALID_OFFSET;
 }
 
 void iwl_dealloc_bcast_stations(struct iwl_priv *priv)
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 111ed1873006..1b3dc99b968c 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -460,17 +460,14 @@ int iwlagn_tx_skb(struct iwl_priv *priv,
 
 static int iwlagn_alloc_agg_txq(struct iwl_priv *priv, int mq)
 {
-	int q;
-
-	for (q = IWLAGN_FIRST_AMPDU_QUEUE;
-	     q < priv->trans->trans_cfg->base_params->num_of_queues; q++) {
-		if (!test_and_set_bit(q, priv->agg_q_alloc)) {
-			priv->queue_to_mac80211[q] = mq;
-			return q;
-		}
-	}
-
-	return -ENOSPC;
+	int q = find_and_set_next_bit(priv->agg_q_alloc,
+				      priv->trans->trans_cfg->base_params->num_of_queues,
+				      IWLAGN_FIRST_AMPDU_QUEUE);
+	if (q >= priv->trans->trans_cfg->base_params->num_of_queues)
+		return -ENOSPC;
+
+	priv->queue_to_mac80211[q] = mq;
+	return q;
 }
 
 static void iwlagn_dealloc_agg_txq(struct iwl_priv *priv, int q)
-- 
2.39.2

