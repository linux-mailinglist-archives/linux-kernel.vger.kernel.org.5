Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16DD7FA388
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjK0OwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjK0Ovr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:51:47 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AD2CD4E;
        Mon, 27 Nov 2023 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=kcr3CAPjvM7RAzYgAV
        J54nu7H1Z0vqjPoUncJfKtUjM=; b=Z87GTetnWsEoVgdzWVhIOC2S0xI0mIKwcC
        LYgbo9nV4S38m82QLn2hy7IZxji1h1HvL3o0jio0U/OGl4VBo9u090Ubmu6yLuM6
        xqjQY7Jxda1IpIGL0v/ckl/Y87eikaDAKENAyhddNS8vq4JLi4yypOluxza2K+nc
        uI1GLDP1k=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wCHrzLarGRlak9rEA--.27728S2;
        Mon, 27 Nov 2023 22:51:07 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     richard.henderson@linaro.org
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] alpha: Improve error handling in alpha_rtc_init
Date:   Mon, 27 Nov 2023 06:51:03 -0800
Message-Id: <20231127145103.29912-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wCHrzLarGRlak9rEA--.27728S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4DAry5Zw4kWr1UGFyxGrg_yoW3Gwc_Kr
        1Sv34kWFyxCF4qvF45Aw43Zr4Sya95Krs5tw12qFWjy34fXF1rZ398JF13Xr15GF48CFZ2
        grn8Gryvyr1xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRZuciUUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgE1gletj1OaTgABs3
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

This patch enhances the alpha_rtc_init function in
arch/alpha/kernel/rtc.c by adding error handling for the
platform_device_register_simple call.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 arch/alpha/kernel/rtc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/rtc.c b/arch/alpha/kernel/rtc.c
index fb3025396ac9..576397b1fac2 100644
--- a/arch/alpha/kernel/rtc.c
+++ b/arch/alpha/kernel/rtc.c
@@ -209,6 +209,9 @@ alpha_rtc_init(void)
 	init_rtc_epoch();
 
 	pdev = platform_device_register_simple("rtc-alpha", -1, NULL, 0);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
 	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
-- 
2.17.1

