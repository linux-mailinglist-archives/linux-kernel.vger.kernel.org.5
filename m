Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874EF7FCEED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjK2GQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2GQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:16:30 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26C1891
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Bn+rIHSzLTV0YAJtS1
        GN2lf/FR7N9D56ZeUjloibZus=; b=KFq4SZkgRjW0QW0+HP3oUKV9r+pCcguEYd
        yEXZ9nL62RKRKf6ZtCfK9YyEpuwB+Y4x+t9/gjqQ3r7XU/vDB17yV2mxUPNHx0g/
        /bYmx0iSZgEiMmUcTW+zHBdtifknMfu+BOjT4W2WMtzSgyY2eAOEFOP28wawNeSV
        6oWNx3O3Y=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wD3Xy3t1mZltMU1Bw--.35417S2;
        Wed, 29 Nov 2023 14:15:11 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [ARM] tcm: Add error handling for gen_pool_create in setup_tcm_pool
Date:   Tue, 28 Nov 2023 22:15:08 -0800
Message-Id: <20231129061508.31057-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3Xy3t1mZltMU1Bw--.35417S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw43Xr17WF4kJFWfKF4fGrg_yoW3ZFcEgr
        4fXw1kWrWSvF4qgr17Aw43Xr1Sga15KFyvq3WIg3W3Gw13XrZrWrWDXF9Yg3Z5urykK398
        CrZIkwnIyr13KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRt6wZJUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgs2gletj25kkgABsh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new code checks the return value of gen_pool_create, and if
it indicates an error, the setup process is aborted, and an
appropriate error code is returned. This ensures that the TCM pool
setup does not silently fail.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 arch/arm/kernel/tcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index f59927bcfbce..df25d310abc3 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -393,6 +393,10 @@ static int __init setup_tcm_pool(void)
 	 * line alignments does not matter in TCM!
 	 */
 	tcm_pool = gen_pool_create(2, -1);
+	if (!tcm_pool) {
+		pr_err("Failed to create TCM memory pool\n");
+		return -ENOMEM;
+	}
 
 	pr_debug("Setting up TCM memory pool\n");
 
-- 
2.17.1

