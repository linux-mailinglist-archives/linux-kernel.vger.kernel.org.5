Return-Path: <linux-kernel+bounces-15063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4D8226DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ED32845E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E417DB;
	Wed,  3 Jan 2024 02:18:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4C17980;
	Wed,  3 Jan 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vzs30th_1704248268;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vzs30th_1704248268)
          by smtp.aliyun-inc.com;
          Wed, 03 Jan 2024 10:17:57 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jorge.lopez2@hp.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] platform/x86: hp-bioscfg: Remove useless else
Date: Wed,  3 Jan 2024 10:17:46 +0800
Message-Id: <20240103021746.5337-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assignment of the else and if branches is the same, so the else
here is redundant, so we remove it.

./drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:544:3-5: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7817
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index f7efe217a4bb..18c60a847842 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -540,14 +540,8 @@ void hp_exit_password_attributes(void)
 		struct kobject *attr_name_kobj =
 			bioscfg_drv.password_data[instance_id].attr_name_kobj;
 
-		if (attr_name_kobj) {
-			if (!strcmp(attr_name_kobj->name, SETUP_PASSWD))
-				sysfs_remove_group(attr_name_kobj,
-						   &password_attr_group);
-			else
-				sysfs_remove_group(attr_name_kobj,
-						   &password_attr_group);
-		}
+		if (attr_name_kobj)
+			sysfs_remove_group(attr_name_kobj, &password_attr_group);
 	}
 	bioscfg_drv.password_instances_count = 0;
 	kfree(bioscfg_drv.password_data);
-- 
2.20.1.7.g153144c


