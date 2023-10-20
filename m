Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF56F7D0BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376763AbjJTJex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376770AbjJTJep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:34:45 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 434F0D5B;
        Fri, 20 Oct 2023 02:34:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 8621A60583963;
        Fri, 20 Oct 2023 17:34:40 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     kvalo@kernel.org
Cc:     Wu Yunchuan <yunchuan@nfschina.com>, dzm91@hust.edu.cn,
        christophe.jaillet@wanadoo.fr, horms@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH wireless-next 1/2] wifi: ray_cs: Remove unnecessary (void*) conversions
Date:   Fri, 20 Oct 2023 17:34:31 +0800
Message-Id: <20231020093432.214001-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need cast (void *) to (struct net_device *).

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 8ace797ce951..c95a79e01cd0 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -348,7 +348,7 @@ static int ray_config(struct pcmcia_device *link)
 {
 	int ret = 0;
 	int i;
-	struct net_device *dev = (struct net_device *)link->priv;
+	struct net_device *dev = link->priv;
 	ray_dev_t *local = netdev_priv(dev);
 
 	dev_dbg(&link->dev, "ray_config\n");
@@ -1830,7 +1830,7 @@ static void set_multicast_list(struct net_device *dev)
 =============================================================================*/
 static irqreturn_t ray_interrupt(int irq, void *dev_id)
 {
-	struct net_device *dev = (struct net_device *)dev_id;
+	struct net_device *dev = dev_id;
 	struct pcmcia_device *link;
 	ray_dev_t *local;
 	struct ccs __iomem *pccs;
@@ -2567,7 +2567,7 @@ static int ray_cs_proc_show(struct seq_file *m, void *v)
 	link = this_device;
 	if (!link)
 		return 0;
-	dev = (struct net_device *)link->priv;
+	dev = link->priv;
 	if (!dev)
 		return 0;
 	local = netdev_priv(dev);
-- 
2.30.2

