Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4046B7E9653
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjKMEly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKMElw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:41:52 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5A10CFA;
        Sun, 12 Nov 2023 20:41:47 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 4C935604A87FE;
        Mon, 13 Nov 2023 12:41:31 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     kvalo@kernel.org
Cc:     Su Hui <suhui@nfschina.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next] wlcore: debugfs: add an error code check in beacon_filtering_write
Date:   Mon, 13 Nov 2023 12:41:14 +0800
Message-Id: <20231113044113.74732-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wl1271_acx_beacon_filter_opt() return error code if failed, add a check
for this is better and safer.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/ti/wlcore/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/debugfs.c b/drivers/net/wireless/ti/wlcore/debugfs.c
index eb3d3f0e0b4d..d4071291a8cd 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.c
+++ b/drivers/net/wireless/ti/wlcore/debugfs.c
@@ -932,13 +932,15 @@ static ssize_t beacon_filtering_write(struct file *file,
 
 	wl12xx_for_each_wlvif(wl, wlvif) {
 		ret = wl1271_acx_beacon_filter_opt(wl, wlvif, !!value);
+		if (ret < 0)
+			break;
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
-	return count;
+	return ret < 0 ? ret : count;
 }
 
 static const struct file_operations beacon_filtering_ops = {
-- 
2.30.2

