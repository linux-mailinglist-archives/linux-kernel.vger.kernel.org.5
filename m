Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA187DA4EC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjJ1DCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjJ1DCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:02:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292B10A;
        Fri, 27 Oct 2023 20:02:38 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SHPPF4DbhzVkgh;
        Sat, 28 Oct 2023 10:58:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 11:02:36 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/7] net: hns3: fix add VLAN fail issue
Date:   Sat, 28 Oct 2023 10:59:11 +0800
Message-ID: <20231028025917.314305-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231028025917.314305-1-shaojijie@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

The hclge_sync_vlan_filter is called in periodic task,
trying to remove VLAN from vlan_del_fail_bmap. It can
be concurrence with VLAN adding operation from user.
So once user failed to delete a VLAN id, and add it
again soon, it may be removed by the periodic task,
which may cause the software configuration being
inconsistent with hardware. So add mutex handling
to avoid this.

     user                        hns3 driver

                                           periodic task
                                                │
  add vlan 10 ───── hns3_vlan_rx_add_vid        │
       │             (suppose success)          │
       │                                        │
  del vlan 10 ─────  hns3_vlan_rx_kill_vid      │
       │           (suppose fail,add to         │
       │             vlan_del_fail_bmap)        │
       │                                        │
  add vlan 10 ───── hns3_vlan_rx_add_vid        │
                     (suppose success)          │
                                       foreach vlan_del_fail_bmp
                                            del vlan 10

Fixes: fe4144d47eef ("net: hns3: sync VLAN filter entries when kill VLAN ID failed")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 21 +++++++++++++------
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      | 11 ++++++++--
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c42574e29747..a3230ac928a9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10026,8 +10026,6 @@ static void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
 	struct hclge_vport_vlan_cfg *vlan, *tmp;
 	struct hclge_dev *hdev = vport->back;
 
-	mutex_lock(&hdev->vport_lock);
-
 	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
 		if (vlan->vlan_id == vlan_id) {
 			if (is_write_tbl && vlan->hd_tbl_status)
@@ -10042,8 +10040,6 @@ static void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
 			break;
 		}
 	}
-
-	mutex_unlock(&hdev->vport_lock);
 }
 
 void hclge_rm_vport_all_vlan_table(struct hclge_vport *vport, bool is_del_list)
@@ -10452,11 +10448,16 @@ int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
 	 * handle mailbox. Just record the vlan id, and remove it after
 	 * reset finished.
 	 */
+	mutex_lock(&hdev->vport_lock);
 	if ((test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
 	     test_bit(HCLGE_STATE_RST_FAIL, &hdev->state)) && is_kill) {
 		set_bit(vlan_id, vport->vlan_del_fail_bmap);
+		mutex_unlock(&hdev->vport_lock);
 		return -EBUSY;
+	} else if (!is_kill && test_bit(vlan_id, vport->vlan_del_fail_bmap)) {
+		clear_bit(vlan_id, vport->vlan_del_fail_bmap);
 	}
+	mutex_unlock(&hdev->vport_lock);
 
 	/* when port base vlan enabled, we use port base vlan as the vlan
 	 * filter entry. In this case, we don't update vlan filter table
@@ -10481,7 +10482,9 @@ int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
 		 * and try to remove it from hw later, to be consistence
 		 * with stack
 		 */
+		mutex_lock(&hdev->vport_lock);
 		set_bit(vlan_id, vport->vlan_del_fail_bmap);
+		mutex_unlock(&hdev->vport_lock);
 	}
 
 	hclge_set_vport_vlan_fltr_change(vport);
@@ -10521,6 +10524,7 @@ static void hclge_sync_vlan_filter(struct hclge_dev *hdev)
 	int i, ret, sync_cnt = 0;
 	u16 vlan_id;
 
+	mutex_lock(&hdev->vport_lock);
 	/* start from vport 1 for PF is always alive */
 	for (i = 0; i < hdev->num_alloc_vport; i++) {
 		struct hclge_vport *vport = &hdev->vport[i];
@@ -10531,21 +10535,26 @@ static void hclge_sync_vlan_filter(struct hclge_dev *hdev)
 			ret = hclge_set_vlan_filter_hw(hdev, htons(ETH_P_8021Q),
 						       vport->vport_id, vlan_id,
 						       true);
-			if (ret && ret != -EINVAL)
+			if (ret && ret != -EINVAL) {
+				mutex_unlock(&hdev->vport_lock);
 				return;
+			}
 
 			clear_bit(vlan_id, vport->vlan_del_fail_bmap);
 			hclge_rm_vport_vlan_table(vport, vlan_id, false);
 			hclge_set_vport_vlan_fltr_change(vport);
 
 			sync_cnt++;
-			if (sync_cnt >= HCLGE_MAX_SYNC_COUNT)
+			if (sync_cnt >= HCLGE_MAX_SYNC_COUNT) {
+				mutex_unlock(&hdev->vport_lock);
 				return;
+			}
 
 			vlan_id = find_first_bit(vport->vlan_del_fail_bmap,
 						 VLAN_N_VID);
 		}
 	}
+	mutex_unlock(&hdev->vport_lock);
 
 	hclge_sync_vlan_fltr_state(hdev);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index a4d68fb216fb..1c62e58ff6d8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1206,6 +1206,8 @@ static int hclgevf_set_vlan_filter(struct hnae3_handle *handle,
 	     test_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state)) && is_kill) {
 		set_bit(vlan_id, hdev->vlan_del_fail_bmap);
 		return -EBUSY;
+	} else if (!is_kill && test_bit(vlan_id, hdev->vlan_del_fail_bmap)) {
+		clear_bit(vlan_id, hdev->vlan_del_fail_bmap);
 	}
 
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
@@ -1233,20 +1235,25 @@ static void hclgevf_sync_vlan_filter(struct hclgevf_dev *hdev)
 	int ret, sync_cnt = 0;
 	u16 vlan_id;
 
+	if (bitmap_empty(hdev->vlan_del_fail_bmap, VLAN_N_VID))
+		return;
+
+	rtnl_lock();
 	vlan_id = find_first_bit(hdev->vlan_del_fail_bmap, VLAN_N_VID);
 	while (vlan_id != VLAN_N_VID) {
 		ret = hclgevf_set_vlan_filter(handle, htons(ETH_P_8021Q),
 					      vlan_id, true);
 		if (ret)
-			return;
+			break;
 
 		clear_bit(vlan_id, hdev->vlan_del_fail_bmap);
 		sync_cnt++;
 		if (sync_cnt >= HCLGEVF_MAX_SYNC_COUNT)
-			return;
+			break;
 
 		vlan_id = find_first_bit(hdev->vlan_del_fail_bmap, VLAN_N_VID);
 	}
+	rtnl_unlock();
 }
 
 static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
-- 
2.30.0

