Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37E27D2E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjJWJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjJWJgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:36:10 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81D5B19AD;
        Mon, 23 Oct 2023 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=eR952
        nTK9QOHzSljh04R7YWcwf8JgCBhBkhmce4vaCg=; b=KXJWN37wv6TxZqLfCP7HQ
        cpxC0NmCfMvFkTPdMYxQc1ORwL5dML/F5mKELBplATRgutijuF1/9Eia8psrlbRL
        uIC/M56piQE9YM4BFjd799jp7Ycx3NaF87WhnPi83bfRQrA1xxvrLy1on0v/ZxV/
        ezqQtNTAceDYquPc+TbNjg=
Received: from ubuntu.. (unknown [171.83.44.150])
        by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wCXnwFXPjZllUYmBQ--.56200S2;
        Mon, 23 Oct 2023 17:35:19 +0800 (CST)
From:   Charles Yi <be286@163.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charles Yi <be286@163.com>
Subject: [PATCH] HID: fix a crash in hid_debug_events_release
Date:   Mon, 23 Oct 2023 17:35:00 +0800
Message-Id: <20231023093500.1391443-1-be286@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXnwFXPjZllUYmBQ--.56200S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw1kuFyUAry8Gr4fZFyxXwb_yoW5WF4UpF
        95Ja90krW0yr1xWw1DJr1kuFyYqa40k3s5uryxC34agFnYkFyYqF1Sya4j9rs8XrWkAF43
        Wr40qry8Ga1jyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRwvtXUUUUU=
X-Originating-IP: [171.83.44.150]
X-CM-SenderInfo: dehsmli6rwjhhfrp/1tbiMhkS0lWB6LTXYQAAsV
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hid_debug_events_release() access released memory by
hid_device_release(). This is fixed by the patch.

Signed-off-by: Charles Yi <be286@163.com>
---
 drivers/hid/hid-core.c  | 12 ++++++++++--
 drivers/hid/hid-debug.c |  3 +++
 include/linux/hid.h     |  3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8992e3c1e769..e0181218ad85 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -702,15 +702,22 @@ static void hid_close_report(struct hid_device *device)
  * Free a device structure, all reports, and all fields.
  */
 
-static void hid_device_release(struct device *dev)
+void hiddev_free(struct kref *ref)
 {
-	struct hid_device *hid = to_hid_device(dev);
+	struct hid_device *hid = container_of(ref, struct hid_device, ref);
 
 	hid_close_report(hid);
 	kfree(hid->dev_rdesc);
 	kfree(hid);
 }
 
+static void hid_device_release(struct device *dev)
+{
+	struct hid_device *hid = to_hid_device(dev);
+
+	kref_put(&hid->ref, hiddev_free);
+}
+
 /*
  * Fetch a report description item from the data stream. We support long
  * items, though they are not used yet.
@@ -2846,6 +2853,7 @@ struct hid_device *hid_allocate_device(void)
 	spin_lock_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_input_lock, 1);
 	mutex_init(&hdev->ll_open_lock);
+	kref_init(&hdev->ref);
 
 	hid_bpf_device_init(hdev);
 
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index e7ef1ea107c9..7dd83ec74f8a 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1135,6 +1135,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
+	kref_get(&list->hdev->ref);
 	file->private_data = list;
 	mutex_init(&list->read_mutex);
 
@@ -1227,6 +1228,8 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
 	kfifo_free(&list->hid_debug_fifo);
+
+	kref_put(&list->hdev->ref, hiddev_free);
 	kfree(list);
 
 	return 0;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 964ca1f15e3f..3b08a2957229 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -679,6 +679,7 @@ struct hid_device {							/* device report descriptor */
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
+	struct kref			ref;
 
 	unsigned int id;						/* system unique id */
 
@@ -687,6 +688,8 @@ struct hid_device {							/* device report descriptor */
 #endif /* CONFIG_BPF */
 };
 
+void hiddev_free(struct kref *ref);
+
 #define to_hid_device(pdev) \
 	container_of(pdev, struct hid_device, dev)
 
-- 
2.34.1

