Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B89791D78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbjIDTHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjIDTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:07:53 -0400
X-Greylist: delayed 911 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Sep 2023 12:07:49 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDD74189
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tFiB4
        rpT5GiAdPtD1qmOD69qLox33MrE/eP1Ywnvmw4=; b=IFTQrnecQq2hsF6VpWN0p
        ygtUBk92xQZDqtdHBIoBNU5JJ6UtyAzWQSy+ac8D15VJ3T/V4bGvXlETOoy4cIdn
        VecjXUi9t6Oa8q32J2jpxyEqeyi0s8DvRNfN5J5X9KDTC0gTFO3fmgjXIsO/Cdu5
        LWNEdTrpPRqBT4Zr9kx2N4=
Received: from localhost.localdomain.localdomain (unknown [203.168.1.80])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wDnW+xmJ_ZkTaeLAQ--.56883S2;
        Tue, 05 Sep 2023 02:52:23 +0800 (CST)
From:   Yan Zhu <zhuyan2015@126.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Yan Zhu <zhuyan2015@126.com>
Subject: [PATCH] ima: add check for khdr->buffer_size
Date:   Wed, 30 Aug 2023 15:31:22 +0800
Message-Id: <20230830073122.7522-1-zhuyan2015@126.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnW+xmJ_ZkTaeLAQ--.56883S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4rXFWrJFWDGw17CryfWFg_yoWftwcEka
        s5Zr1xZrsrZF4xA3yqvF1I9aykK345Zr1Sg3yUKa97AFy8Aw13J348XFs7WryUXry7Xr4D
        X398K34Sqwn8ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbPrc3UUUUU==
X-Originating-IP: [203.168.1.80]
X-CM-SenderInfo: 52kx5tzqsqika6rslhhfrp/1tbi4wjgDFpEDoIvUwAAsp
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When khdr->buffer_size > size, continuing to use ima_parse_buf
may cause memory access out of bounds.

Fixes: 94c3aac567a9 ("ima: on soft reboot, restore the measurement list")

Signed-off-by: Yan Zhu <zhuyan2015@126.com>
---
 security/integrity/ima/ima_template.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index e5d941f48..02a38b2ee 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -399,6 +399,12 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		return -EINVAL;
 	}
 
+	if (khdr->buffer_size > (u64)size) {
+		pr_err("hkdr->buffer_size(%llu) is larger then size(%lld)", khdr->buffer_size,
+			size);
+		return -EINVAL;
+	}
+
 	bitmap_zero(hdr_mask, HDR__LAST);
 	bitmap_set(hdr_mask, HDR_PCR, 1);
 	bitmap_set(hdr_mask, HDR_DIGEST, 1);
-- 
2.33.0

