Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB7E7FC8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376531AbjK1VNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346729AbjK1VMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:12:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01E93596
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C88C43395;
        Tue, 28 Nov 2023 21:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205645;
        bh=q4zuJqnRTMKFKpaQD3b9M8K0vV9uChLcAW1eHYiIYr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gp1b/mMHfw4pShS6Zc5WQlygErjHMMwmTADMvGhP8GD0hhtz0ZOSbllcwKMF+EyvW
         WWH/gR0nEpTazByZExORqhU4bxsEULpshdJJmXPo+8M4OchMyRX7reDbdbWUCOBGdk
         s6nmsz+XJGa5E2a4+IA3OreKsqc7o5ynI17kk5X3L9BgSKBqqNZP7X5EkRrTILJ7Ca
         KM4OhIpf44wLHWvAwdvDsR1uEiLRfgTT7uV388KdP6JQxPkXR9jFaAP4xxGl6Wnt1S
         8JYV2Hy3QxvrjbWbu7xM4f3PzaiHvoDS2qZL35HJx5WImKWelhHJMILAMwnji1Jn56
         y+MY5tFFV70Dw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, bongsu.jeon@samsung.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 32/40] nfc: virtual_ncidev: Add variable to check if ndev is running
Date:   Tue, 28 Nov 2023 16:05:38 -0500
Message-ID: <20231128210615.875085-32-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nguyen Dinh Phi <phind.uet@gmail.com>

[ Upstream commit 84d2db91f14a32dc856a5972e3f0907089093c7a ]

syzbot reported an memory leak that happens when an skb is add to
send_buff after virtual nci closed.
This patch adds a variable to track if the ndev is running before
handling new skb in send function.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
Reviewed-by: Bongsu Jeon
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/virtual_ncidev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index b027be0b0b6ff..590b038e449e5 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -26,10 +26,14 @@ struct virtual_nci_dev {
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
 
@@ -40,6 +44,7 @@ static int virtual_nci_close(struct nci_dev *ndev)
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
2.42.0

