Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23916771F47
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjHGLHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHGLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:07:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC3B83;
        Mon,  7 Aug 2023 04:07:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc4dc65aa7so5883055ad.0;
        Mon, 07 Aug 2023 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406469; x=1692011269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9OuBtIRd3TmVP55IsTuJa78bggwEoR7iVTgrkvRd/k=;
        b=Ct0Nla8VUY8ybYOsRxm5aDgm6jzAOjxj6XMVTgcCuiAC2A+CzL4xGxaGR7Gp4omn/U
         wnEQ7GzfmRBBtoppvtsQqT7OBM+vOCD0nftNLtbJ4GhbUHo+UgKh8NGarM1EeW+tbJj8
         uF9tOJu8w/hAbb5fUxP7dMYiweA3LPOfKHHvVOivmSR5NDDQ+gsAoT9ka+zl4NevmGcb
         5k75EQ64uWLiHn/c9fYf63atsflMYKsrjbiX0k+WEtPQn13yfpcjYWQDRXsAbLUSOGs0
         VEoszIUnkZ4TnloPndIe+6oW5bu6dFL4Bss5eDePuj7TcbwSAMum0+LmT2M/79mlN3bh
         zWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406469; x=1692011269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9OuBtIRd3TmVP55IsTuJa78bggwEoR7iVTgrkvRd/k=;
        b=UBgTHNbclDw8CTFfWAyjmJrjYrB6BIY+gwSob32NBZp7z2qdOZTKZorQKUvBfJtVh5
         9TpeOZFYOpbMsG2RURrhr93L7/m5yB4aZkLxzanv6MTCcAn9ZnaSBO4g4z2TsOqx2/eM
         dUL2Xk+oP4aSR07zLBvihPMB17JNmbfZFcLwybRkLpaVYkNH7M6KqmMUcErXl4bw0hPU
         kRJBul52fIaj+fTkgqzpGgorML9LxFUqTSOWggdMk6kL1yvtvquZyPCbghDl/x4X6+SZ
         sKp8qM2or2O1j0ew0R2HJZuLNW1vVtHEkT8BKrJIGbpnmHnj/JVqfTZtw3xeMfCQGltR
         EOCQ==
X-Gm-Message-State: ABy/qLYRpBnZL4N2a/bxT6sYUC0Bdqop7KXpxYcn5tTApnsYcD/mwqyE
        TTjYVan5uBEKr5Gk6lafTddsb9crdpRhmg==
X-Google-Smtp-Source: APBJJlHIKrHkeRxQvdKkND5ibuxu3DylP1Q9CVX/BYjyp1AOyRKSEwcYUEsAP/kDNY/3u8oRWywtag==
X-Received: by 2002:a17:903:1c7:b0:1b8:b55d:4cff with SMTP id e7-20020a17090301c700b001b8b55d4cffmr32901861plh.2.1691406469500;
        Mon, 07 Aug 2023 04:07:49 -0700 (PDT)
Received: from ubuntu.localdomain ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709026b8900b001b9da8b4eb7sm6603524plk.35.2023.08.07.04.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:07:49 -0700 (PDT)
From:   Min Li <lm0963hack@gmail.com>
To:     luiz.dentz@gmail.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix potential use-after-free when clear keys
Date:   Mon,  7 Aug 2023 19:07:41 +0800
Message-Id: <20230807110741.85859-1-lm0963hack@gmail.com>
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

Similar to commit c5d2b6fa26b5 ("Bluetooth: Fix use-after-free in
hci_remove_ltk/hci_remove_irk"). We can not access k after kfree_rcu()
call.

Fixes: d7d41682efc2 ("Bluetooth: Fix Suspicious RCU usage warnings")
Signed-off-by: Min Li <lm0963hack@gmail.com>
---
 net/bluetooth/hci_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a856b1051d35..bae8a9919dbe 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1074,9 +1074,9 @@ void hci_uuids_clear(struct hci_dev *hdev)
 
 void hci_link_keys_clear(struct hci_dev *hdev)
 {
-	struct link_key *key;
+	struct link_key *key, *tmp;
 
-	list_for_each_entry(key, &hdev->link_keys, list) {
+	list_for_each_entry_safe(key, tmp, &hdev->link_keys, list) {
 		list_del_rcu(&key->list);
 		kfree_rcu(key, rcu);
 	}
@@ -1084,9 +1084,9 @@ void hci_link_keys_clear(struct hci_dev *hdev)
 
 void hci_smp_ltks_clear(struct hci_dev *hdev)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -1094,9 +1094,9 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
 
 void hci_smp_irks_clear(struct hci_dev *hdev)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -1104,9 +1104,9 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
 
 void hci_blocked_keys_clear(struct hci_dev *hdev)
 {
-	struct blocked_key *b;
+	struct blocked_key *b, *tmp;
 
-	list_for_each_entry(b, &hdev->blocked_keys, list) {
+	list_for_each_entry_safe(b, tmp, &hdev->blocked_keys, list) {
 		list_del_rcu(&b->list);
 		kfree_rcu(b, rcu);
 	}
-- 
2.34.1

