Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62240781788
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 07:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245223AbjHSFwz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Aug 2023 01:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbjHSFw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 01:52:28 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A2420C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 22:52:25 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37J5qHWa010293;
        Sat, 19 Aug 2023 13:52:17 +0800 (+08)
        (envelope-from Yanxin.Huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RSSWF2gYZz2PbwF0;
        Sat, 19 Aug 2023 13:50:01 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sat, 19 Aug
 2023 13:52:15 +0800
From:   Yanxin Huang <yanxin.huang@unisoc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 4/7] nvmem: sprd: Optimize the block lock operation
Date:   Sat, 19 Aug 2023 13:51:38 +0800
Message-ID: <20230819055141.29455-4-yanxin.huang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230819055141.29455-1-yanxin.huang@unisoc.com>
References: <20230819055141.29455-1-yanxin.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com 37J5qHWa010293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may program the efuse block partially many times, or we may program the
efuse block as a whole, but either way programming, the bytes parameter
passed in is SPRD_EFUSE_BLOCK_WIDTH. If we judge whether to lock the efuse
block or not by bytes and SPRD_efuse_block_WIDTH size, then the block will
be locked after the first time we programmed the efuse block, and we will
not be able to program the block again in the following period, so
removing the locked efuse block judgment.

In addition, since there is no need to lock the efuse block in the current
unisoc platform, we will change the default value of lock to flase, and
then develop according to the need if there is a need to lock the efuse
block.

Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
---
 drivers/nvmem/sprd-efuse.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 3818d83de722..7370f8f9595f 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -326,7 +326,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
        struct sprd_efuse *efuse = context;
        bool blk_double = efuse->data->blk_double;
        u32 index = offset / SPRD_EFUSE_BLOCK_WIDTH + efuse->data->blk_offset;
-       bool lock;
+       bool lock = false;
        int ret;

        ret = sprd_efuse_lock(efuse);
@@ -337,19 +337,6 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
        if (ret)
                goto unlock;

-       /*
-        * If the writing bytes are equal with the block width, which means the
-        * whole block will be programmed. For this case, we should not allow
-        * this block to be programmed again by locking this block.
-        *
-        * If the block was programmed partially, we should allow this block to
-        * be programmed again.
-        */
-       if (bytes < SPRD_EFUSE_BLOCK_WIDTH)
-               lock = false;
-       else
-               lock = true;
-
        ret = sprd_efuse_raw_prog(efuse, index, blk_double, lock, val);

        clk_disable_unprepare(efuse->clk);
--
2.17.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
