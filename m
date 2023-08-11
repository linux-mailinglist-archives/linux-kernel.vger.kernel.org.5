Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93984778777
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjHKGaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHKGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:30:17 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F232A10D;
        Thu, 10 Aug 2023 23:30:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VpWG8Xa_1691735398;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VpWG8Xa_1691735398)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 14:30:12 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jorge.lopez2@hp.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] platform/x86: hp-bioscfg: Remove useless else
Date:   Fri, 11 Aug 2023 14:29:57 +0800
Message-Id: <20230811062957.82728-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assignment of the else and if branches is the same, so the else
here is redundant, so we remove it.

./drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:545:3-5: WARNING: possible condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 03d0188804ba..771e554182dc 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -541,14 +541,8 @@ void hp_exit_password_attributes(void)
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

