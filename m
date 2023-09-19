Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2884F7A6713
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjISOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjISOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:43:30 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14170CE0;
        Tue, 19 Sep 2023 07:43:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxWEI_1695134583;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxWEI_1695134583)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:43:04 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 14/18] net/smc: add operation for getting DMB attribute
Date:   Tue, 19 Sep 2023 22:41:58 +0800
Message-Id: <1695134522-126655-15-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390, ISM devices are used on machine level hypervisors which is a
partitioning hypervisor without paging. The sndbufs and peer DMBs in such
case can't be mapped to the same physical memory.

However in other cases, such as communication within the same OS instance
with loopback, the sndbufs and peer DMBs can be mapped to the same physical
memory to avoid memory copy from sndbufs to peer DMBs.

So this patch introduces an operation to smcd_ops to judge whether the
sndbufs-DMB map is available. And for reuse, the interface is designed to
return DMB attribute, not only the sndbuf-DMB map feature.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h | 5 +++++
 net/smc/smc_ism.c | 8 ++++++++
 net/smc/smc_ism.h | 1 +
 3 files changed, 14 insertions(+)

diff --git a/include/net/smc.h b/include/net/smc.h
index 389d26d..6930c8a 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -55,6 +55,10 @@ struct smcd_seid {
 
 #define ISM_ERROR	0xFFFF
 
+enum {
+	ISM_ATTR_DMB_MAP = 0,
+};
+
 struct smcd_dev;
 
 struct smcd_gid {
@@ -82,6 +86,7 @@ struct smcd_ops {
 	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
 	u16 (*get_chid)(struct smcd_dev *dev);
 	struct device* (*get_dev)(struct smcd_dev *dev);
+	int (*get_dev_attr)(struct smcd_dev *dev);
 };
 
 struct smcd_dev {
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index ba37b27..14e018c 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -214,6 +214,14 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 	return rc;
 }
 
+bool smc_ism_dmb_mappable(struct smcd_dev *smcd)
+{
+	if (smcd->ops->get_dev_attr &&
+	    (smcd->ops->get_dev_attr(smcd) & BIT(ISM_ATTR_DMB_MAP)))
+		return true;
+	return false;
+}
+
 int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 			 struct smc_buf_desc *dmb_desc)
 {
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 7ab82dd..cef212c 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -44,6 +44,7 @@ int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
 int smc_ism_register_dmb(struct smc_link_group *lgr, int buf_size,
 			 struct smc_buf_desc *dmb_desc);
 int smc_ism_unregister_dmb(struct smcd_dev *dev, struct smc_buf_desc *dmb_desc);
+bool smc_ism_dmb_mappable(struct smcd_dev *smcd);
 int smc_ism_signal_shutdown(struct smc_link_group *lgr);
 void smc_ism_get_system_eid(u8 **eid);
 u16 smc_ism_get_chid(struct smcd_dev *dev);
-- 
1.8.3.1

