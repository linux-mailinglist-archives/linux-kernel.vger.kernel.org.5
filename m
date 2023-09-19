Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6907A5ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjISH1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjISH06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:26:58 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E3212C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JLRiv
        irvLdhDAeXVgmYFc+hQLslyGrE4IatkdcfmFZc=; b=Isuvg5liS42MLoH9y9qmP
        U5P8UDVhc9Fg+bbVIpw691F+1wsVWqiN5+WGZESLeJ5c0a6fovbgUYX33QFSP41t
        6K46hUDM/NyitjgO8pYbmiOp3U0fYoZmLU93DLzh3B6jBAtlitqT2GUIeFWmqoPv
        MdhjPI4Q1WBzhg5JfeyY+E=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wC3xzwLTQll56jiCQ--.2751S4;
        Tue, 19 Sep 2023 15:26:11 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, kuba@kernel.org,
        bvanassche@acm.org, razor@blackwall.org, edumazet@google.com,
        make_ruc2021@163.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: iscsi: fix reference count leak in cxgbi_check_route()
Date:   Tue, 19 Sep 2023 15:26:01 +0800
Message-Id: <20230919072601.3498866-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3xzwLTQll56jiCQ--.2751S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrur47tw48tFy7uFWDCw1xZrb_yoW3trc_G3
        929FW7Ar4qgrZ7Gw47Wan3XF9FvF9rZFy8uF4xtr9akr45XFWxGrykAFn8Z345Xw4DWFy5
        Aw17Wr13CFnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpBTDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyAPuC1p7LzUeiAABsC
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cxgbi_check_route() dont release the reference acquired by ip_dev_find()
which introducing a reference count leak. We could remedy this by
insuring the reference is released.ip_dev_find().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/scsi/cxgbi/libcxgbi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index abde60a50cf7..435056b27cba 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -670,6 +670,7 @@ cxgbi_check_route(struct sockaddr *dst_addr, int ifindex)
 		"route to %pI4 :%u, ndev p#%d,%s, cdev 0x%p.\n",
 		&daddr->sin_addr.s_addr, ntohs(daddr->sin_port),
 			   port, ndev->name, cdev);
+	dev_put(ndev);
 
 	csk = cxgbi_sock_create(cdev);
 	if (!csk) {
-- 
2.37.2

