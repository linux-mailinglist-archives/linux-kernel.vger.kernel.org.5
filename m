Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503747E40FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbjKGNsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjKGNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:48:16 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632D2D54
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:46:34 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc391ca417so45633365ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699364794; x=1699969594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KRZW8kevjh4aZ31PiUOxCku+9NRp8iX+bdfbv+Qzu7I=;
        b=sH2Vbork7s2X3eU4RjIVBjkHEe2qAJzOOE4K7IfELcpA+Aztp4NvlROoZxxRJcMPY3
         t7NeMlc0VsvkyguWQGhyZcB82XXNFRkptKeVSk4WulLmVQd5/ek6AfmNABDENsEeyTVo
         rceYCWcO0Sz96gPc877UZ5cOoMPCyqClLiQEggSj/xwOPVA1SYWqhH+HVSGmzCWSCt2R
         TM7ntVhjMgj6g9hD0Q2y6dG8dMvRGg6eqyYYMcvoa4nP0BnBZjvK9eU4EEqlsb7DJzoP
         1NkZpHqfTCEcwiqWgMtKgEpwk0TB5Kzlx96RzmFbpUZzclQ2tXV8jFBBHSP5X65xmN5u
         79Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699364794; x=1699969594;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRZW8kevjh4aZ31PiUOxCku+9NRp8iX+bdfbv+Qzu7I=;
        b=OyPFAKRG2ljpciGR//HqXtu+0ydEvGZEdYaBLcj4Kojj8S4MrnG3iSaqAXmTKkvi6I
         5vMKB2/0VWDTmxyxELOTt246M4YaPUwDTe+7qwpmqT/wB2lHBWIue2N/gJd7OQytUfO/
         LFs2QC/kzi+TM1ixHvdp31IX7S8CnDPumHrw4jj1aI/amyl/brFGlAjw7oN0JHWkT7p8
         t8FPZtPuZdJOXy93FTLnXmwKZcyyBSOCYzluyF0s5SH8Tl2gVu8l/4UhByEVb/gh8Z8y
         3JZgC7U3ISSvLG+d28nqx2gT1Th7lBLht8SJzHPcYc5EZ7N8YqXpO6TAITL0vdfnTWWd
         z9mw==
X-Gm-Message-State: AOJu0YyoJyHndN8KZtpanIEjGK2oCCJel/jeKc6DPh4jUqwSONnl6mAf
        MtibnfiA9Rd1AYlN8Wk77BUsFi3aapsKGQ==
X-Google-Smtp-Source: AGHT+IEwFapbdsh5pEB9VSu6Xx0POX8X14oXwHK2HqW/z8ziL+svc7eapTp7HYjscOU8GhqJ+Pj+oCpEClThjg==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:903:2591:b0:1cc:bb7f:bd5a with SMTP
 id jb17-20020a170903259100b001ccbb7fbd5amr144886plb.6.1699364793747; Tue, 07
 Nov 2023 05:46:33 -0800 (PST)
Date:   Tue,  7 Nov 2023 05:46:10 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107054609.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Subject: [PATCH] Bluetooth: btusb: Return when coredump trigger cmd fails
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Tim Jiang <quic_tjiang@quicinc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid freeing NULL skb when hci command fails.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..a0359702c0a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3463,8 +3463,11 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
+	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));
+		return;
+	}
+
 	kfree_skb(skb);
 }
 
-- 
2.42.0.869.gea05f2083d-goog

