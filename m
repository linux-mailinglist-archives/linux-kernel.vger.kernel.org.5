Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863A3764379
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjG0BnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjG0BnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:43:22 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0AE212B;
        Wed, 26 Jul 2023 18:43:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VoIhdCU_1690422195;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VoIhdCU_1690422195)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 09:43:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     Shyam-sundar.S-k@amd.com
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] platform/x86/amd/pmf: Fix unsigned comparison with less than zero
Date:   Thu, 27 Jul 2023 09:43:15 +0800
Message-Id: <20230727014315.51375-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from the call to amd_pmf_get_pprof_modes() is int.
However, the return value is being assigned to an unsigned char
variable 'mode', so making 'mode' an int.

silence the warning:
./drivers/platform/x86/amd/pmf/sps.c:183:5-9: WARNING: Unsigned expression compared with zero: mode < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5995
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/platform/x86/amd/pmf/sps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index ab69d517a36a..a70e67749be3 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -176,7 +176,8 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 
 int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 {
-	u8 mode, flag = 0;
+	u8 flag = 0;
+	int mode;
 	int src;
 
 	mode = amd_pmf_get_pprof_modes(dev);
-- 
2.20.1.7.g153144c

