Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17D17F76B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbjKXOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjKXOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:42:34 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EC41BC7;
        Fri, 24 Nov 2023 06:42:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vx1llv._1700836952;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vx1llv._1700836952)
          by smtp.aliyun-inc.com;
          Fri, 24 Nov 2023 22:42:33 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, raspl@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/7] net/smc: manage system EID in SMC stack instead of ISM driver
Date:   Fri, 24 Nov 2023 22:42:15 +0800
Message-Id: <1700836935-23819-8-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
References: <1700836935-23819-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System EID (SEID) is an internal EID that is used by the SMCv2
software stack that has a predefined and constant value representing
the s390 physical machine that the OS is executing on. So it should
be managed by SMC stack instead of ISM driver and be consistent for
all ISMv2 device (including virtual ISM devices) on s390 architecture.

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 drivers/s390/net/ism.h     |  6 ------
 drivers/s390/net/ism_drv.c | 36 ++++--------------------------------
 include/linux/ism.h        |  1 -
 include/net/smc.h          |  1 -
 net/smc/smc_ism.c          | 40 ++++++++++++++++++++++++++++++----------
 net/smc/smc_ism.h          |  8 ++++++++
 6 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 70c5bbd..49ccbd68 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -192,12 +192,6 @@ struct ism_sba {
 #define ISM_CREATE_REQ(dmb, idx, sf, offset)		\
 	((dmb) | (idx) << 24 | (sf) << 23 | (offset))
 
-struct ism_systemeid {
-	u8	seid_string[24];
-	u8	serial_number[4];
-	u8	type[4];
-};
-
 static inline void __ism_read_cmd(struct ism_dev *ism, void *data,
 				  unsigned long offset, unsigned long len)
 {
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 250248b..3c69504 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -36,6 +36,7 @@
 						/* a list for fast mapping  */
 static u8 max_client;
 static DEFINE_MUTEX(clients_lock);
+static bool ism_v2_capable;
 struct ism_dev_list {
 	struct list_head list;
 	struct mutex mutex; /* protects ism device list */
@@ -443,32 +444,6 @@ int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx, bool sf,
 }
 EXPORT_SYMBOL_GPL(ism_move);
 
-static struct ism_systemeid SYSTEM_EID = {
-	.seid_string = "IBM-SYSZ-ISMSEID00000000",
-	.serial_number = "0000",
-	.type = "0000",
-};
-
-static void ism_create_system_eid(void)
-{
-	struct cpuid id;
-	u16 ident_tail;
-	char tmp[5];
-
-	get_cpu_id(&id);
-	ident_tail = (u16)(id.ident & ISM_IDENT_MASK);
-	snprintf(tmp, 5, "%04X", ident_tail);
-	memcpy(&SYSTEM_EID.serial_number, tmp, 4);
-	snprintf(tmp, 5, "%04X", id.machine);
-	memcpy(&SYSTEM_EID.type, tmp, 4);
-}
-
-u8 *ism_get_seid(void)
-{
-	return SYSTEM_EID.seid_string;
-}
-EXPORT_SYMBOL_GPL(ism_get_seid);
-
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
@@ -560,7 +535,7 @@ static int ism_dev_init(struct ism_dev *ism)
 
 	if (!ism_add_vlan_id(ism, ISM_RESERVED_VLANID))
 		/* hardware is V2 capable */
-		ism_create_system_eid();
+		ism_v2_capable = true;
 
 	mutex_lock(&ism_dev_list.mutex);
 	mutex_lock(&clients_lock);
@@ -665,8 +640,7 @@ static void ism_dev_exit(struct ism_dev *ism)
 	}
 	mutex_unlock(&clients_lock);
 
-	if (SYSTEM_EID.serial_number[0] != '0' ||
-	    SYSTEM_EID.type[0] != '0')
+	if (ism_v2_capable)
 		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
 	unregister_ieq(ism);
 	unregister_sba(ism);
@@ -812,8 +786,7 @@ static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
 
 static int smcd_supports_v2(void)
 {
-	return SYSTEM_EID.serial_number[0] != '0' ||
-		SYSTEM_EID.type[0] != '0';
+	return ism_v2_capable;
 }
 
 static u64 ism_get_local_gid(struct ism_dev *ism)
@@ -859,7 +832,6 @@ static inline struct device *smcd_get_dev(struct smcd_dev *dev)
 	.signal_event = smcd_signal_ieq,
 	.move_data = smcd_move,
 	.supports_v2 = smcd_supports_v2,
-	.get_system_eid = ism_get_seid,
 	.get_local_gid = smcd_get_local_gid,
 	.get_chid = smcd_get_chid,
 	.get_dev = smcd_get_dev,
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 9a4c204..5428edd 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -86,7 +86,6 @@ int  ism_register_dmb(struct ism_dev *dev, struct ism_dmb *dmb,
 int  ism_unregister_dmb(struct ism_dev *dev, struct ism_dmb *dmb);
 int  ism_move(struct ism_dev *dev, u64 dmb_tok, unsigned int idx, bool sf,
 	      unsigned int offset, void *data, unsigned int size);
-u8  *ism_get_seid(void);
 
 const struct smcd_ops *ism_get_smcd_ops(void);
 
diff --git a/include/net/smc.h b/include/net/smc.h
index a0dc1187e..c9dcb30 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -73,7 +73,6 @@ struct smcd_ops {
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
 	int (*supports_v2)(void);
-	u8* (*get_system_eid)(void);
 	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
 	u16 (*get_chid)(struct smcd_dev *dev);
 	struct device* (*get_dev)(struct smcd_dev *dev);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index a33f861..d463d05 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -43,6 +43,27 @@ static void smcd_handle_irq(struct ism_dev *ism, unsigned int dmbno,
 };
 #endif
 
+static void smc_ism_create_system_eid(void)
+{
+	struct smc_ism_seid *seid =
+		(struct smc_ism_seid *)smc_ism_v2_system_eid;
+#if IS_ENABLED(CONFIG_S390)
+	struct cpuid id;
+	u16 ident_tail;
+	char tmp[5];
+
+	memcpy(seid->seid_string, "IBM-SYSZ-ISMSEID00000000", 24);
+	get_cpu_id(&id);
+	ident_tail = (u16)(id.ident & SMC_ISM_IDENT_MASK);
+	snprintf(tmp, 5, "%04X", ident_tail);
+	memcpy(seid->serial_number, tmp, 4);
+	snprintf(tmp, 5, "%04X", id.machine);
+	memcpy(seid->type, tmp, 4);
+#else
+	memset(seid, 0, SMC_MAX_EID_LEN);
+#endif
+}
+
 /* Test if an ISM communication is possible - same CPC */
 int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
 		    struct smcd_dev *smcd)
@@ -70,6 +91,11 @@ bool smc_ism_is_v2_capable(void)
 	return smc_ism_v2_capable;
 }
 
+void smc_ism_set_v2_capable(void)
+{
+	smc_ism_v2_capable = true;
+}
+
 /* Set a connection using this DMBE. */
 void smc_ism_set_conn(struct smc_connection *conn)
 {
@@ -431,14 +457,8 @@ static void smcd_register_dev(struct ism_dev *ism)
 
 	mutex_lock(&smcd_dev_list.mutex);
 	if (list_empty(&smcd_dev_list.list)) {
-		u8 *system_eid = NULL;
-
-		system_eid = smcd->ops->get_system_eid();
-		if (smcd->ops->supports_v2()) {
-			smc_ism_v2_capable = true;
-			memcpy(smc_ism_v2_system_eid, system_eid,
-			       SMC_MAX_EID_LEN);
-		}
+		if (smcd->ops->supports_v2())
+			smc_ism_set_v2_capable();
 	}
 	/* sort list: devices without pnetid before devices with pnetid */
 	if (smcd->pnetid[0])
@@ -542,10 +562,10 @@ int smc_ism_init(void)
 {
 	int rc = 0;
 
-#if IS_ENABLED(CONFIG_ISM)
 	smc_ism_v2_capable = false;
-	memset(smc_ism_v2_system_eid, 0, SMC_MAX_EID_LEN);
+	smc_ism_create_system_eid();
 
+#if IS_ENABLED(CONFIG_ISM)
 	rc = ism_register_client(&smc_ism_client);
 #endif
 	return rc;
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 0e5e563..6903cd5 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -16,6 +16,7 @@
 #include "smc.h"
 
 #define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
+#define SMC_ISM_IDENT_MASK		0x00FFFF
 
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
@@ -30,6 +31,12 @@ struct smc_ism_vlanid {			/* VLAN id set on ISM device */
 	refcount_t refcnt;		/* Reference count */
 };
 
+struct smc_ism_seid {
+	u8 seid_string[24];
+	u8 serial_number[4];
+	u8 type[4];
+};
+
 struct smcd_dev;
 
 int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
@@ -45,6 +52,7 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
 bool smc_ism_is_v2_capable(void);
+void smc_ism_set_v2_capable(void);
 int smc_ism_init(void);
 void smc_ism_exit(void);
 int smcd_nl_get_device(struct sk_buff *skb, struct netlink_callback *cb);
-- 
1.8.3.1

