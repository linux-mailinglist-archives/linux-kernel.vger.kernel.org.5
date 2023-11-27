Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0339D7FA32C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjK0Olq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjK0Olo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:41:44 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F763C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=XRQp0zOYdNbHHuto1y
        IZyaF4vtL+R1Yy6pinuFlVyl8=; b=G2kFeCATce1RM9VxhgJW3Ni3vKuNEVGlSV
        z5z7sCjf5f+tGWBCo8lzrOsC3sK+ji6ZJlmbV0ZzPbc9JEetumc3AZKgfK3FAlrx
        2Nqe6Vr/1fytMTZZqs/xVlK3CukUyt9ZcbCHjB830BSb6OoUkoyj1TQmx2HAoHcP
        wNM6Bbyyw=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wB3FVSGqmRlvUJQEA--.27646S2;
        Mon, 27 Nov 2023 22:41:12 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     npiggin@gmail.com
Cc:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] powerpc/powernv: Add error handling to opal_prd_range_is_valid
Date:   Mon, 27 Nov 2023 06:41:08 -0800
Message-Id: <20231127144108.29782-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wB3FVSGqmRlvUJQEA--.27646S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWUuF13Xr1ruF1kCF1fCrg_yoWftFgEq3
        WxCa10qw48Wr4q9w1DCr1rGrnFk343Gr4UKr1Ig3ZFkryavasxC3s7ZrZ3WF17WrW2krZx
        GF98Kws8A3WSvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRufO2UUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgE1gletj1OaTQAAs1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the opal_prd_range_is_valid function within opal-prd.c,
error handling was missing for the of_get_address call.
This patch adds necessary error checking, ensuring that the
function gracefully handles scenarios where of_get_address fails.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 arch/powerpc/platforms/powernv/opal-prd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 327e2f76905d..b66b06efcef1 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -66,6 +66,8 @@ static bool opal_prd_range_is_valid(uint64_t addr, uint64_t size)
 		const char *label;
 
 		addrp = of_get_address(node, 0, &range_size, NULL);
+		if (!addrp)
+			continue;
 
 		range_addr = of_read_number(addrp, 2);
 		range_end = range_addr + range_size;
-- 
2.17.1

