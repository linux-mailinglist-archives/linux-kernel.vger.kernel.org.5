Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DAC7BC5D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjJGHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343572AbjJGHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:55:11 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37D40C2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=x2ubb
        SHf4h71EdcfZci9RUDCMhjc8OXOUwYHNzSoY6Q=; b=H+XLaN0p9rpVzkesPKMb5
        6z4+k09YuiKq4qkndyJZ+O6sxaY30al422d4w6HCfEaFe20IF6E+21SxI/GtOMwX
        DXrzT+wZV+vzzzh8YUEDktlDiP8lVeIVXZf8Jxd1P7GY+5nEzb/kT7vtS6y48Zzp
        kykLlbg/dvK0IOi0YUqkbs=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wBnQ2W5DiFlDjo+EA--.50968S4;
        Sat, 07 Oct 2023 15:54:41 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init
Date:   Sat,  7 Oct 2023 15:54:32 +0800
Message-Id: <20231007075432.4002092-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnQ2W5DiFlDjo+EA--.50968S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XryDZryftFW5AFyfAr15XFb_yoWxZFc_WF
        yUWFn7JF40kr4rGw12vr43uryqvr1kWF1kWF48tFyfZ340v34xGF12gFn5Aa48uFsavF92
        kF4Dur1Syr17ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRN89NJUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRMCC2B9oZ0BegAAsV
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

Add the missing of_node_put() to release the refcount incremented
by of_find_matching_node().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/irqchip/irq-gic-v2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f2ff4387870d..d3e54c557b4c 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -427,6 +427,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 		ret = of_address_to_resource(child, 0, &res);
 		if (ret) {
 			pr_err("Failed to allocate v2m resource.\n");
+			of_node_put(child);
 			break;
 		}
 
-- 
2.37.2

