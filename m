Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF37D7F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjJZJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjJZJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:03:34 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136810E;
        Thu, 26 Oct 2023 02:03:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SGKHz6ZNmz9yKXj;
        Thu, 26 Oct 2023 16:50:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3T5FOKzplbiTyAg--.23455S2;
        Thu, 26 Oct 2023 10:03:17 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH] security: Don't yet account for IMA in LSM_CONFIG_COUNT calculation
Date:   Thu, 26 Oct 2023 11:02:59 +0200
Message-Id: <20231026090259.362945-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3T5FOKzplbiTyAg--.23455S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1rZr4rZFW5uw45CF4UArb_yoWfGrcEka
        1kAr40y3y7ZF93WF47A3W8ZF1vg3y8XrnxG3WYyr13uws8Wr1rXFZ7J34fAF1rJFnxGFWv
        ka1fKFy3Aw1ktjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4eHgUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBF1jj5WKUwACs4
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Since IMA is not yet an LSM, don't account for it in the LSM_CONFIG_COUNT
calculation, used to limit how many LSMs can invoke security_add_hooks().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/security.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 988483fcf153..7281aa90ca20 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,7 +44,6 @@
 	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
-- 
2.34.1

