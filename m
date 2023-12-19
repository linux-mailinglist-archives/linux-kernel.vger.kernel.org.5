Return-Path: <linux-kernel+bounces-5362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2321B8189E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695D1280BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104752031E;
	Tue, 19 Dec 2023 14:26:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C631D53E;
	Tue, 19 Dec 2023 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vyr7Wz0_1702995995;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vyr7Wz0_1702995995)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 22:26:37 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 06/10] net/smc: define a reserved CHID range for virtual ISM devices
Date: Tue, 19 Dec 2023 22:26:12 +0800
Message-ID: <20231219142616.80697-7-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219142616.80697-1-guwen@linux.alibaba.com>
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to virtual ISM support feature defined by SMCv2.1, CHIDs in
the range 0xFF00 to 0xFFFF are reserved for use by virtual ISM devices.

And two helpers are introduced to distinguish virtual ISM devices from
the existing platform firmware ISM devices.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/smc/smc_ism.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 832b2f42d79f..d1228a615f23 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -15,6 +15,8 @@
 
 #include "smc.h"
 
+#define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
+
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
 	struct mutex mutex;	/* Protects list of devices */
@@ -56,4 +58,22 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
 	return rc < 0 ? rc : 0;
 }
 
+static inline bool __smc_ism_is_virtual(u16 chid)
+{
+	/* CHIDs in range of 0xFF00 to 0xFFFF are reserved
+	 * for virtual ISM device.
+	 *
+	 * loopback-ism:	0xFFFF
+	 * virtio-ism:		0xFF00 ~ 0xFFFE
+	 */
+	return ((chid & 0xFF00) == 0xFF00);
+}
+
+static inline bool smc_ism_is_virtual(struct smcd_dev *smcd)
+{
+	u16 chid = smcd->ops->get_chid(smcd);
+
+	return __smc_ism_is_virtual(chid);
+}
+
 #endif
-- 
2.43.0


