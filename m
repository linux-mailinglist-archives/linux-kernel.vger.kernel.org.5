Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F376CF26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjHBNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjHBNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:47:52 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EF7BE4E;
        Wed,  2 Aug 2023 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=dVgWIM8YuM9CFvEhJo
        a8zLm0hBVzbWotmxIWfv0g+SQ=; b=E4ihzV9yhbGmh6m3gvlbqfpsZKtDTnK6VL
        ymvz79Tl209AXdtrO82r4M/pdwpXfJwKx0vHaOvyBmMYk0cITOAubgKoj/0Fl85+
        NYHjo+hHCXe4Rre+UVzLa2DaOf9sSe4lokIqueQjdMQAx2yp/QCTG5fc8Gh5LvR5
        HdEbc/dRs=
Received: from os-l3a203-yehs1-dev01.localdomain (unknown [103.244.59.1])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wAXR4dZXspkvTXRBw--.23077S2;
        Wed, 02 Aug 2023 21:47:05 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     lenb@kernel.org, rafael@kernel.org, tony.luck@intel.com
Cc:     rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaocli@redhat.com,
        ahuang12@lenovo.com, Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH v1] ACPI: extlog: Fix finding the generic error data for v3 structure
Date:   Wed,  2 Aug 2023 21:47:46 +0800
Message-Id: <1690984066-31757-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: _____wAXR4dZXspkvTXRBw--.23077S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1DGw1rAr45Ww15XF4kXrb_yoWkAwbE9r
        s2gwn7Gr15Ar18GF1SkrWSvFyq9F4UWF1vy3ZrtFyrAw18Zw1Sv3Z2vrs7Zr97uw4UWay3
        Xw4kXw429w1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1GYLPUUUUU==
X-Originating-IP: [103.244.59.1]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1S2mDh6-QGSAXJEHcAAAsx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

Fix by using acpi_hest_get_payload( ) to find out the correct
generic error data for v3 structure. The revision v300 generic
error data is different from the old one, so for compatibility
with old and new version, change to a new interface to locate
the right memory error section that was defined in CPER.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 drivers/acpi/acpi_extlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e648158368a7..e120a96e1eae 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -172,7 +172,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			fru_text = "";
 		sec_type = (guid_t *)gdata->section_type;
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem = (void *)(gdata + 1);
+			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
 
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
-- 
2.37.3

