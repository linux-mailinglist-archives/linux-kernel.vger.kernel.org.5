Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ABA7AC6E5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 08:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjIXG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIXG6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:58:04 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40610B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 23:57:56 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id kJ3wqxINJLxWbkJ3wqOyHA; Sun, 24 Sep 2023 08:57:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695538674;
        bh=iGzNAoRtFRkqcxCkNp3FPfcx3BcBPyiwFBXbBlaScV0=;
        h=From:To:Cc:Subject:Date;
        b=V0YCvZ/4caGOUQtjOU3zWtUT88aXF7bmdwDxpABBjf4ve4CqKUlQ6Yc7U5SMm605b
         OWvAUZCTR38E+8gZfqXbtA/4TvjqLgJF+79sjdQkLWnwjt5GK4pNVSkI7xx5l2oy5p
         bj3nt36Oaxt6AYlfbOSV8/HPT0V1H9CuBVo8E+QnuKmwQdq1X/kgbT8vQu80vQH8h7
         hjlL5CZoKQGpQQFZP2sUszk2t36T+UGpHjNKWWMma6AZeQWr88lWf+kJOEhvYa8uex
         X6VePt6pTff6/pC9IVrm9TxvRStQV6ldj4rb+gDZXcH4bmiGtc44RzLdrIlFb+cPSt
         xxo4w/8Ie3Viw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Sep 2023 08:57:54 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kalle Valo <kvalo@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kalle Valo <quic_kvalo@quicinc.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH wireless 1/2] ath: dfs_pattern_detector: Fix a memory initialization issue
Date:   Sun, 24 Sep 2023 08:57:49 +0200
Message-Id: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs and channel_detector_exit() is called, it relies on
entries of the 'detectors' array to be NULL.
Otherwise, it may access to un-initialized memory.

Fix it and initialize the memory, as what was done before the commit in
Fixes.

Fixes: a063b650ce5d ("ath: dfs_pattern_detector: Avoid open coded arithmetic in memory allocation")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Patch #1/2 is a fix, for for wireless.
Patch #2/2 is for wireless-next I guess, but depnds on #1

Not sure if we can mix different target in the same serie. Let me know.

BTW, sorry for messing up things with a063b650ce5d :(
---
 drivers/net/wireless/ath/dfs_pattern_detector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/dfs_pattern_detector.c b/drivers/net/wireless/ath/dfs_pattern_detector.c
index 27f4d74a41c8..2788a1b06c17 100644
--- a/drivers/net/wireless/ath/dfs_pattern_detector.c
+++ b/drivers/net/wireless/ath/dfs_pattern_detector.c
@@ -206,7 +206,7 @@ channel_detector_create(struct dfs_pattern_detector *dpd, u16 freq)
 
 	INIT_LIST_HEAD(&cd->head);
 	cd->freq = freq;
-	cd->detectors = kmalloc_array(dpd->num_radar_types,
+	cd->detectors = kcalloc(dpd->num_radar_types,
 				      sizeof(*cd->detectors), GFP_ATOMIC);
 	if (cd->detectors == NULL)
 		goto fail;
-- 
2.34.1

