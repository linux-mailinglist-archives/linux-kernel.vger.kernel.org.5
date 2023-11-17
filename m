Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50DD7EF7D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjKQT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjKQT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:29:49 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F9CB6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:43 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6baaa9c0ba5so2796892b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700249383; x=1700854183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ZtpR5VBZnnk4soDSw6IwamiHkMHtshmq2RkQ7zs14Y=;
        b=PEG1Ry6bk3xe23gXUeibAY60PYqMqIFQf5RkDsat2en1DIbkh8m+ExE0T7nNCW/4EE
         ZtoQPu/C4Lr8jLphqOa2txNnNCcBLZiTb5a/hy7W/1mMc7K+6TfVMtrRm9oOhtb4rh/W
         BA+vmEo9J4FkbYXB39b4Ookem5y3SoNnl3ANXMRt4YeH7WTW/tXp2/0s4lBiNehtqYoX
         XAsTVliTDHixJb05WFDWVWyp7CwBKo/Fuf2MNU9GC/ClnI9WeYcNpkDOYuWmWJVyep06
         7ioEMhSJ2br8iHgdkNLbBBlBX4CACOEUo8RjNwPsz6VOlMKlrPTrIQhkUOT34g51crBk
         Jvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249383; x=1700854183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZtpR5VBZnnk4soDSw6IwamiHkMHtshmq2RkQ7zs14Y=;
        b=JrDJKDk3RENCyvqKQ0C2Qn775KQ3aB6zaBOrCXsdS9oildSYNs+fYFBMXYYcWnaM9C
         z09RGdTrQcjRsn41qGTSD/Mk6Kv/KneQ5EYrc7DCSGJeEyT9iYpxUZQ19chGnsHfn3wr
         HkdWUjkame0wT6X5TdjaGscwJIMZS9ruUwv1fzm/776+XcDKUXZEPfIODGiplvEEfO8d
         vc3ki3RvZwM95O4Tbc8jMiuy9Wv6grXq2fcl6v0KM0loJb20eHsMisgrCJvpLfeykHV6
         ehw58Px7jZPYcxImgTBl1/554eT97sS32fWms6AvnysHiIyij6/C226efseTjPhsbr/3
         6+wQ==
X-Gm-Message-State: AOJu0YyjKO/fnL0aXNlDScyFAFnzuRD300nzeg4WqH82/7ufjGi1YJWL
        AA5uhz67cTBbTMeFgG/LSBT43RGZUSw56w==
X-Google-Smtp-Source: AGHT+IFslrvPLsq4BT5PcXEkzGg0ZUVP85qVwKubrphQcon4Mwiuor6/RqEk3QS/vc3/a5OeGoXksoaO5xM7Cw==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a05:6a00:8d93:b0:6c6:b762:ad83 with SMTP
 id im19-20020a056a008d9300b006c6b762ad83mr112843pfb.0.1700249382992; Fri, 17
 Nov 2023 11:29:42 -0800 (PST)
Date:   Fri, 17 Nov 2023 11:28:33 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Subject: [PATCH v2 1/2] Bluetooth: btusb: Return when coredump trigger cmd fails
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid freeing NULL skb when hci command fails.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")

Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

Changes in v2:
- Fixed a typo in error log in btusb_coredump_qca()

 drivers/bluetooth/btusb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b8e9de887b5d..35a26440cabd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3463,8 +3463,11 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
-		bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__, PTR_ERR(skb));
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "%s: trigger crash failed (%ld)", __func__, PTR_ERR(skb));
+		return;
+	}
+
 	kfree_skb(skb);
 }
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

