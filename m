Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886DA7F07A5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjKSQrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:47:14 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7D1F9;
        Sun, 19 Nov 2023 08:47:11 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce322b62aeso2040037a34.3;
        Sun, 19 Nov 2023 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700412430; x=1701017230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l/ttRIHKXMZ13uQ7+QQurcFDXbvyi0K7tHJbOIbLlt0=;
        b=iuAt1wQiZHwWJ/QU32Pq8k3wMjoQI6C4nmSLDYnCEiz3erLad7CDafoWfB9FggfZLS
         idlczmX2ynU9710DQyi/25tid9tITNfD8AxOfNnA9Oh6KSDlQl0Jq1Eg15V+x/tfGCCE
         eZvaEtZB1a/LQO6BR5BXT2njXz8jCcMWbO1oWija7rKpU76yHwFv2i5JLgW0iHLxuCQq
         VxgNPbelsvRESBs4zdToJPzBr7rody+LDTsJZneEXYqp8OHppf0iHUfbQKFtv0ishK1u
         tmvfAtgAesHAIU/Ny5WNKONcxktVnSzepNYabvcpuNcg5qTdgINEpRKN5+989JNHLxfF
         EipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700412430; x=1701017230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/ttRIHKXMZ13uQ7+QQurcFDXbvyi0K7tHJbOIbLlt0=;
        b=ZArgaBfWK4RAIkqCfeDXictQxK/a+lUiC3yCJp2VkvblysEsmUc+Kt9BQdwTn6GpBg
         ph+5Ue09fxnB68Fu1flZg847PucICmcGLgLg0nS7zMgEsMALvcLu40uMR+BiXTcPd2vD
         UVjBPLwWao8dh5/5KsZNqXep21Yh0OQ2h4A7bva0cf3ri2O+x20wRWjsKSQ8o03ifCfD
         0J8UNOzOxzjIaj6s0jcIfBZoeN8+4wpCk5nQB5kMmrLK6ytNBBUARPDU0n2x+iN8Uvhx
         96kvtQYaawZCbpeD27PHqKjD+QNH1jLRU1Iicjbe1YuaL7KjzgBk2RQedLstd1So6mmk
         HvvA==
X-Gm-Message-State: AOJu0Yxp93ltDT+ueKaPrqRl7Yya3f+HmhzWlIhg6J0n9o8W1V5oN4C3
        qK2VPlu2jHNi4RIB32lagcw=
X-Google-Smtp-Source: AGHT+IGJf73OXrm2X3fSleXtAO73g8oopu056A8xbRn6X/3Q9OtFJGewP5EZTZjTMactNrEvXv3/2g==
X-Received: by 2002:a05:6871:152:b0:1f4:ae6e:a4e1 with SMTP id z18-20020a056871015200b001f4ae6ea4e1mr6674088oab.56.1700412430539;
        Sun, 19 Nov 2023 08:47:10 -0800 (PST)
Received: from phi.. (bb220-255-254-193.singnet.com.sg. [220.255.254.193])
        by smtp.gmail.com with ESMTPSA id x4-20020aa79184000000b0068790c41ca2sm4519398pfa.27.2023.11.19.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:47:10 -0800 (PST)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nguyen Dinh Phi <phind.uet@gmail.com>,
        syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
Subject: [PATCH] nfc: virtual_ncidev: Add variable to check if ndev is running
Date:   Mon, 20 Nov 2023 00:47:05 +0800
Message-Id: <20231119164705.1991375-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.34.1
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

syzbot reported an memory leak that happens when an skb is add to
send_buff after virtual nci closed.
This patch adds a variable to track if the ndev is running before
handling new skb in send function.

Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 drivers/nfc/virtual_ncidev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index b027be0b0b6f..ac8226db54e2 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -20,26 +20,31 @@
 				 NFC_PROTO_ISO14443_MASK | \
 				 NFC_PROTO_ISO14443_B_MASK | \
 				 NFC_PROTO_ISO15693_MASK)
+#define NCIDEV_RUNNING 0
 
 struct virtual_nci_dev {
 	struct nci_dev *ndev;
 	struct mutex mtx;
 	struct sk_buff *send_buff;
 	struct wait_queue_head wq;
+	bool running;
 };
 
 static int virtual_nci_open(struct nci_dev *ndev)
 {
+	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
+
+	vdev->running = true;
 	return 0;
 }
 
 static int virtual_nci_close(struct nci_dev *ndev)
 {
 	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
-
 	mutex_lock(&vdev->mtx);
 	kfree_skb(vdev->send_buff);
 	vdev->send_buff = NULL;
+	vdev->running = false;
 	mutex_unlock(&vdev->mtx);
 
 	return 0;
@@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
 
 	mutex_lock(&vdev->mtx);
-	if (vdev->send_buff) {
+	if (vdev->send_buff || !vdev->running) {
 		mutex_unlock(&vdev->mtx);
 		kfree_skb(skb);
 		return -1;
-- 
2.34.1

