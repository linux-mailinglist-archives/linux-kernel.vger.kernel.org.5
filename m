Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFA768A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjGaCqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGaCqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:46:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F96E45;
        Sun, 30 Jul 2023 19:46:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9defb36a2so3687555a34.2;
        Sun, 30 Jul 2023 19:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690771563; x=1691376363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLnxhTOK8CR7EOKXVMtGvf6ZSiJOcPXDQqy3TBSI8eI=;
        b=fBWuJ/VArlePTzAu+Lv1gqnlPm1ITSafKrNAnGpysA0wqm5h+7D28oOsXmzHfQteCo
         O3gq/1b1LaWqVu0Iq8Z1hBFo97dQQkyf8rPeoYBwT9pCQ+9LSFSCGzTxcIHXmwawqLZ6
         2jMnKnKGwWltp0uBK1kBYf5TUMDex7bpwzMF9OkbcWZoU4UOHGayozhDgvub93GChaf9
         2Bc/NesvHzpTquzJev3zGxoYOfP7nrE2w1N+dcFAflHCEDqmxpC9VUc7poptzT9m/2v8
         +DEnp9f6nM/mZrzjFYzERwxXXJV9WOd1FWxZ5vutlN/TtOTA1O3ofTMYDyILNdEm2/rr
         OUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690771563; x=1691376363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLnxhTOK8CR7EOKXVMtGvf6ZSiJOcPXDQqy3TBSI8eI=;
        b=lLq5KnW9eW5Exem717fG0vtMM9zm0u0vfo3wj4ahCN6C1f/imlsH7fzRIlT6/zOmYU
         VApn/aghctzIQ2OnfzTRaBggMPtjzUl3qmE3M/shRK+EA0HcIxYRAasQZM7IkBbC6rBI
         wl7ML3ijJ1KGr5HQTbOUqOEfkLcDTehfvCBqNHCyJtcDwJpCaTJ3gpB6+nLAI3RIoKdx
         AOe3yfZXyuvz+vQfAf6DPkkzZJNbphIT6SiP0VMr/ZXF4ZpsUXMBSbHRJ8gyRnDFq+C2
         df8sZY/u4huU3Ut0AM7R9b9Hn38OS7g0vr88EYlhmkFBwbCOT3HcWHLV76RuyO9wkZWd
         j9Bw==
X-Gm-Message-State: ABy/qLZsov7pHgCd+blEcDVPSjDfz0LTfsl4Bc91gqmfwkKOi7N4wIpS
        Gd4GNyu2V8Vd2zq1VFagCVaXws2NyrS57hOm
X-Google-Smtp-Source: APBJJlGX6gf6keMnZy5xVRbtRtp1qIpjbNHpcHhZQJEad9kWQQ8T7vWppcBE7i3cScDh4yAuD2TZIQ==
X-Received: by 2002:a05:6358:249f:b0:135:515c:38ee with SMTP id m31-20020a056358249f00b00135515c38eemr9782752rwc.25.1690771563460;
        Sun, 30 Jul 2023 19:46:03 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:f50b:8f24:acc4:e5c])
        by smtp.gmail.com with ESMTPSA id q1-20020a63d601000000b0055be951145csm7045301pgg.36.2023.07.30.19.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 19:46:03 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] ath6kl: Fix debugfs_create_dir error checking
Date:   Sun, 30 Jul 2023 19:45:42 -0700
Message-Id: <20230731024542.27248-1-rauji.raut@gmail.com>
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

The debugfs_create_dir function returns ERR_PTR
in case of error and the correct way to check an
error is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR

This issue was found with the help of Coccinelle.
./drivers/net/wireless/ath/ath6kl/debug.c:1796:6-21: Wrong debugfs call error processing on line 1796

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/debug.c b/drivers/net/wireless/ath/ath6kl/debug.c
index 433a047f3747..505af195e299 100644
--- a/drivers/net/wireless/ath/ath6kl/debug.c
+++ b/drivers/net/wireless/ath/ath6kl/debug.c
@@ -1793,7 +1793,7 @@ int ath6kl_debug_init_fs(struct ath6kl *ar)
 {
 	ar->debugfs_phy = debugfs_create_dir("ath6kl",
 					     ar->wiphy->debugfsdir);
-	if (!ar->debugfs_phy)
+	if (IS_ERR(ar->debugfs_phy))
 		return -ENOMEM;
 
 	debugfs_create_file("tgt_stats", 0400, ar->debugfs_phy, ar,
-- 
2.34.1

