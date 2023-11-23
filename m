Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B307F620E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbjKWOw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbjKWOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:52:56 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BAAD47;
        Thu, 23 Nov 2023 06:53:00 -0800 (PST)
X-UUID: 1255a04c70214ee6bb249e348d20f2df-20231123
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ef8221b1-476d-4f41-9062-25c916e30c71,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:ef8221b1-476d-4f41-9062-25c916e30c71,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:8e75bc95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:23112322524517KDZH01,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1255a04c70214ee6bb249e348d20f2df-20231123
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 570105261; Thu, 23 Nov 2023 22:52:41 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     tony@atomide.com, linux@armlinux.org.uk, ruslan.bilovol@ti.com
Cc:     linux-omap@vger.kernel.org, kunwu.chan@hotmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ARM: OMAP2+: Fix null pointer dereference and memory leak in omap_soc_device_init
Date:   Thu, 23 Nov 2023 22:52:37 +0800
Message-Id: <20231123145237.609442-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasprintf() returns a pointer to dynamically allocated memory which can
be NULL upon failure. When 'soc_dev_attr->family' is NULL,it'll trigger
the null pointer dereference issue, such as in 'soc_info_show'.

And when 'soc_device_register' fails, it's necessary to release
'soc_dev_attr->family' to avoid memory leaks.

Fixes: 6770b2114325 ("ARM: OMAP2+: Export SoC information to userspace")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/arm/mach-omap2/id.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 98999aa8cc0c..7f387706368a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -793,11 +793,16 @@ void __init omap_soc_device_init(void)
 
 	soc_dev_attr->machine  = soc_name;
 	soc_dev_attr->family   = omap_get_family();
+	if (!soc_dev_attr->family) {
+		kfree(soc_dev_attr);
+		return;
+	}
 	soc_dev_attr->revision = soc_rev;
 	soc_dev_attr->custom_attr_group = omap_soc_groups[0];
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
 		kfree(soc_dev_attr);
 		return;
 	}
-- 
2.34.1

