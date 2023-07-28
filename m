Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B15766D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbjG1Mj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjG1MjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:39:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABC187
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:39:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f090310dso1922438b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690547964; x=1691152764;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUYz9DxHb0BxaPBN23fsdi77Kis6R4w2zVWPl0XBjM4=;
        b=pdvmo6sySg9ljyMCjFTMkd6V44TyuL3hy6OFtHT7GItX+3R53wNVRaJ/hgCVwG7Sep
         YUSZbkl8pnxRiwBiP4hkStMCEKypXEeQooPnMQ9tQgbp1v10b72QvIA64N1sgigeG5Xp
         zWXOVwILasP6EilqLVBxHTn4lGTChPsQAQ8O0HStdsqPC4EM8yiItzBL9Hz+W/RLhqKq
         IipytywlarzjQ2tLy5E630mOg8KlkMWbvpsP2LtMhH7LKUO8xPYyg0XxK6dJih3ts92p
         UFbO4NLIjPpR/1P7mjJVwld/eVFLtQgVM+m5sd3OF3PgWPpucreD44V8iyVTxYSKnjIr
         f9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690547964; x=1691152764;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUYz9DxHb0BxaPBN23fsdi77Kis6R4w2zVWPl0XBjM4=;
        b=LVCTRLx4XQvcQb/Qtaflpuh3FhC8Uuo+wif1Hx6tNR70UyxCQBt5vL7A76Vw/nkYCE
         aG7+um157aUWBZ+rlsBOAK/43HFmcYG10mhbjuYS64sqx8D2M8I8Zr29erjimgAUEDOQ
         pdqM05j5xK8cL+tCoJfzW7D5B0WQQffECrvm5231tc5MF7kB+JupnNmb+bs5IxKz1rEh
         9d4pMOb7++zlYmpEcm4LJhoX9kxuWov/MU7XlZWs32aZkpNp8r2yerTNGDjploYGP0kk
         4NI0FewLwKNvwCrFULHuJzeZU/Ml5ZlwQQTEf1ZC+S+ECOHwmDKKdJrlVOSKRy566/tK
         G96g==
X-Gm-Message-State: ABy/qLaRN9/fsdd5A9TIQbY5dhCBM5x0jNgzo00JUSeqo9H/92EO4pSS
        cYT8TJUHY7MRISdWHvnspUc=
X-Google-Smtp-Source: APBJJlFhfiQDYsOIbPBkS9vZsWUAoKZK6liJl5V9kZcmxo5u/N5Q3jy1h98OsTDUjPjxvj9FoujspA==
X-Received: by 2002:a05:6a00:1249:b0:674:6dd4:8337 with SMTP id u9-20020a056a00124900b006746dd48337mr1953113pfi.12.1690547964545;
        Fri, 28 Jul 2023 05:39:24 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78245000000b0064fd4a6b306sm3138775pfn.76.2023.07.28.05.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:39:23 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, bhelgaas@google.com,
        russell.h.weight@intel.com
Cc:     linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] tty: synclink_gt: Fix potential deadlock on &info->lock
Date:   Fri, 28 Jul 2023 12:39:01 +0000
Message-Id: <20230728123901.64225-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &info->lock is acquired by slgt_interrupt() under irq context, other
process context code acquiring the lock should disable irq, otherwise
deadlock could happen if the irq preempt the execution while the
lock is held in process context on the same CPU.

Lock acquisition inside set_params32() does not disable irq, and this
function is called by slgt_compat_ioctl() from process context.

Possible deadlock scenario:
slgt_compat_ioctl()
    -> set_params32()
    -> spin_lock(&info->lock)
        <irq>
        -> slgt_interrupt()
        -> spin_lock(&info->lock); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock. x86_64 allmodconfig using gcc shows no new
warning.

The patch fixes the potential deadlock by spin_lock_irqsave() like other
lock acquisition sites.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/tty/synclink_gt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 16e469e581ec..e86bb6228e0f 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1088,12 +1088,13 @@ static long get_params32(struct slgt_info *info, struct MGSL_PARAMS32 __user *us
 static long set_params32(struct slgt_info *info, struct MGSL_PARAMS32 __user *new_params)
 {
 	struct MGSL_PARAMS32 tmp_params;
+	unsigned long flags;
 
 	DBGINFO(("%s set_params32\n", info->device_name));
 	if (copy_from_user(&tmp_params, new_params, sizeof(struct MGSL_PARAMS32)))
 		return -EFAULT;
 
-	spin_lock(&info->lock);
+	spin_lock_irqsave(&info->lock, flags);
 	if (tmp_params.mode == MGSL_MODE_BASE_CLOCK) {
 		info->base_clock = tmp_params.clock_speed;
 	} else {
@@ -1111,7 +1112,7 @@ static long set_params32(struct slgt_info *info, struct MGSL_PARAMS32 __user *ne
 		info->params.stop_bits       = tmp_params.stop_bits;
 		info->params.parity          = tmp_params.parity;
 	}
-	spin_unlock(&info->lock);
+	spin_unlock_irqrestore(&info->lock, flags);
 
 	program_hw(info);
 
-- 
2.17.1

