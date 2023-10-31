Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F117DC562
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjJaEdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjJaEdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:33:19 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6EA1A9;
        Mon, 30 Oct 2023 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+tVgY
        gLvSUt79F9deEr1RjBBDXQuJPY7Sdg5IY3CCU0=; b=CuhLN7408Ihy4Bi339UBp
        yNm84LT66jOyjchWRLhHij1/pQJTHn/+2dQubJ4VvrTz33QoymrRObooZoRzW1mT
        5GOp5S8Dz4bE/ws8vkd69kV73cjijE93MVOdtZMwxIDnnGG3GKOXAjPovpWmdcE1
        Gz8CvD5J9Li/8u1FfQD19k=
Received: from ubuntu.. (unknown [171.83.47.188])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wCHD1p5g0BlfEPABw--.59861S2;
        Tue, 31 Oct 2023 12:32:57 +0800 (CST)
From:   Charles Yi <be286@163.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charles Yi <be286@163.com>
Subject: [PATCH v2] HID: fix a crash in hid_debug_events_release
Date:   Tue, 31 Oct 2023 12:32:39 +0800
Message-Id: <20231031043239.157943-1-be286@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHD1p5g0BlfEPABw--.59861S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWDXr45Zr1kWw1kWr47CFg_yoW7ZFWxpr
        18tFZrCrW8Jrn7G34UCr4Dur9xK3W0ka4UuryxC3s3Wrn5WF98tFW8tFyY9rs5WrWkJFW3
        GFs5Xr48KFW8Xw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRn2-nUUUUU=
X-Originating-IP: [171.83.47.188]
X-CM-SenderInfo: dehsmli6rwjhhfrp/1tbiMhQa0lWB6W20IwAAsp
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hid_debug_events_release() access released memory by
hid_device_release(). This is fixed by the patch.

When hid_debug_events_release() was being called, in most case,
hid_device_release() finish already, the memory of list->hdev
freed by hid_device_release(), if list->hdev memory
reallocate by others, and it's modified, zeroed, then
list->hdev->debug_list_lock occasioned crash come out.

The crash:

[  120.728477][ T4396] kernel BUG at lib/list_debug.c:53!
[  120.728505][ T4396] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  120.739806][ T4396] Modules linked in: bcmdhd dhd_static_buf 8822cu pcie_mhi r8168
[  120.747386][ T4396] CPU: 1 PID: 4396 Comm: hidt_bridge Not tainted 5.10.110 #257
[  120.754771][ T4396] Hardware name: Rockchip RK3588 EVB4 LP4 V10 Board (DT)
[  120.761643][ T4396] pstate: 60400089 (nZCv daIf +PAN -UAO -TCO BTYPE=--)
[  120.768338][ T4396] pc : __list_del_entry_valid+0x98/0xac
[  120.773730][ T4396] lr : __list_del_entry_valid+0x98/0xac
[  120.779120][ T4396] sp : ffffffc01e62bb60
[  120.783126][ T4396] x29: ffffffc01e62bb60 x28: ffffff818ce3a200
[  120.789126][ T4396] x27: 0000000000000009 x26: 0000000000980000
[  120.795126][ T4396] x25: ffffffc012431000 x24: ffffff802c6d4e00
[  120.801125][ T4396] x23: ffffff8005c66f00 x22: ffffffc01183b5b8
[  120.807125][ T4396] x21: ffffff819df2f100 x20: 0000000000000000
[  120.813124][ T4396] x19: ffffff802c3f0700 x18: ffffffc01d2cd058
[  120.819124][ T4396] x17: 0000000000000000 x16: 0000000000000000
[  120.825124][ T4396] x15: 0000000000000004 x14: 0000000000003fff
[  120.831123][ T4396] x13: ffffffc012085588 x12: 0000000000000003
[  120.837123][ T4396] x11: 00000000ffffbfff x10: 0000000000000003
[  120.843123][ T4396] x9 : 455103d46b329300 x8 : 455103d46b329300
[  120.849124][ T4396] x7 : 74707572726f6320 x6 : ffffffc0124b8cb5
[  120.855124][ T4396] x5 : ffffffffffffffff x4 : 0000000000000000
[  120.861123][ T4396] x3 : ffffffc011cf4f90 x2 : ffffff81fee7b948
[  120.867122][ T4396] x1 : ffffffc011cf4f90 x0 : 0000000000000054
[  120.873122][ T4396] Call trace:
[  120.876259][ T4396]  __list_del_entry_valid+0x98/0xac
[  120.881304][ T4396]  hid_debug_events_release+0x48/0x12c
[  120.886617][ T4396]  full_proxy_release+0x50/0xbc
[  120.891323][ T4396]  __fput+0xdc/0x238
[  120.895075][ T4396]  ____fput+0x14/0x24
[  120.898911][ T4396]  task_work_run+0x90/0x148
[  120.903268][ T4396]  do_exit+0x1bc/0x8a4
[  120.907193][ T4396]  do_group_exit+0x8c/0xa4
[  120.911458][ T4396]  get_signal+0x468/0x744
[  120.915643][ T4396]  do_signal+0x84/0x280
[  120.919650][ T4396]  do_notify_resume+0xd0/0x218
[  120.924262][ T4396]  work_pending+0xc/0x3f0

Fixes: <cd667ce24796> (HID: use debugfs for events/reports dumping)

Signed-off-by: Charles Yi <be286@163.com>

---
Changes in V2:
- Add "Fixes:" tag and call trace to commit message.
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

