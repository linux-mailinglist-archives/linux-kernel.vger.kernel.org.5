Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A617AD882
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjIYNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjIYNB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:01:27 -0400
X-Greylist: delayed 83 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 06:01:17 PDT
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264CFC6;
        Mon, 25 Sep 2023 06:01:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
        by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id AAE4B607EA;
        Mon, 25 Sep 2023 15:59:45 +0300 (MSK)
Received: from den-plotnikov-n.yandex.net (unknown [2a02:6b8:0:419:f70:586b:6390:c6a4])
        by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id exNfIA0Op0U0-c2Sy2QAO;
        Mon, 25 Sep 2023 15:59:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
        s=default; t=1695646785;
        bh=2Q2xe2PpYwGaEzbFom0qcl1nTnSdaQt3gv9imQvhg5I=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=I8Nhee08CMvR7SkKDsjSwXR+73xCtH2NEzXcOTlkpwgSAzXFiCuc1pr4dJhYHjk2I
         Hy6yR1ihHDQOb4uAanvMysQv7nNJg5Dul5DDh0szDVTwdwXj2dEUU+PP6VXYxTG2sY
         rlLgmUC62Kcz2hkBFmbfyvElorvz7CUAO15FZMIM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Denis Plotnikov <den-plotnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     linux-raid@vger.kernel.org, song@kernel.org
Subject: [PATCH] md-cluster: check for timeout while a new disk adding
Date:   Mon, 25 Sep 2023 15:59:40 +0300
Message-Id: <20230925125940.1542506-1-den-plotnikov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new disk adding may end up with timeout and a new disk won't be added.
Add returning the error in that case.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Signed-off-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
---
 drivers/md/md-cluster.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index f0e64e76fd79..a5bb065835b7 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -501,7 +501,7 @@ static void process_suspend_info(struct mddev *mddev,
 	mddev->pers->quiesce(mddev, 0);
 }
 
-static void process_add_new_disk(struct mddev *mddev, struct cluster_msg *cmsg)
+static int process_add_new_disk(struct mddev *mddev, struct cluster_msg *cmsg)
 {
 	char disk_uuid[64];
 	struct md_cluster_info *cinfo = mddev->cluster_info;
@@ -509,6 +509,7 @@ static void process_add_new_disk(struct mddev *mddev, struct cluster_msg *cmsg)
 	char raid_slot[16];
 	char *envp[] = {event_name, disk_uuid, raid_slot, NULL};
 	int len;
+	int res = 0;
 
 	len = snprintf(disk_uuid, 64, "DEVICE_UUID=");
 	sprintf(disk_uuid + len, "%pU", cmsg->uuid);
@@ -517,9 +518,14 @@ static void process_add_new_disk(struct mddev *mddev, struct cluster_msg *cmsg)
 	init_completion(&cinfo->newdisk_completion);
 	set_bit(MD_CLUSTER_WAITING_FOR_NEWDISK, &cinfo->state);
 	kobject_uevent_env(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE, envp);
-	wait_for_completion_timeout(&cinfo->newdisk_completion,
-			NEW_DEV_TIMEOUT);
+	if (!wait_for_completion_timeout(&cinfo->newdisk_completion,
+					NEW_DEV_TIMEOUT)) {
+		pr_err("md-cluster(%s:%d): timeout on a new disk adding\n",
+			__func__, __LINE__);
+		res = -1;
+	}
 	clear_bit(MD_CLUSTER_WAITING_FOR_NEWDISK, &cinfo->state);
+	return res;
 }
 
 
@@ -591,7 +597,8 @@ static int process_recvd_msg(struct mddev *mddev, struct cluster_msg *msg)
 				     le64_to_cpu(msg->high));
 		break;
 	case NEWDISK:
-		process_add_new_disk(mddev, msg);
+		if (process_add_new_disk(mddev, msg))
+			ret = -1;
 		break;
 	case REMOVE:
 		process_remove_disk(mddev, msg);
-- 
2.34.1

