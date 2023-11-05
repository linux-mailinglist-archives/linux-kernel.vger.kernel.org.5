Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8587E1314
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 11:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjKEKpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 05:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 05:45:12 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE522BF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 02:45:08 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id zacnqtRsUBKTszacoqttjX; Sun, 05 Nov 2023 11:45:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1699181105;
        bh=9b85zzslUSMT7EI5O+bY45Xi0oEa+NJhiBDoT4Py3kM=;
        h=From:To:Cc:Subject:Date;
        b=YmYTctjNTeAjCTVWG7IO4d3lf9haWgfL5VQ4C4gOCKG0x8gMkkvZd+AAz4r/pS+kH
         NG2sOv9e8AdfPl+V8G18Xddd6INznvqog217VqbEa7pGRdPLumwAS8vF9C1bOsP/oa
         bCmFMBWJGvcExWYthxeBXcWTJzp+fcJTBAuHPms3lebu1cAO519lgdnOiwZoHGV8lo
         ygJ0tCuXCPtweITlPklBINhK/FvcLEDawmOHgxaHPPhMpQiYMonDy0fWYeYsxm97GH
         xBy69tve1IfzWadKK4GYhliv3crg+5MeMzQba7V2EPudz2gl9hNUOsYPg1oDRhbqQa
         /laOR8v7O4+Tg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 05 Nov 2023 11:45:05 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rostedt@goodmis.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, willy@infradead.org,
        senozhatsky@chromium.org
Cc:     list@mail.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/i915/uc: Simplify an error handling path in uc_fw_rsa_data_create()
Date:   Sun,  5 Nov 2023 11:45:01 +0100
Message-Id: <0468666539199f4a440c0a60553b24832a50256a.1699180889.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i915_vma_unpin_and_release() is already called in the error handling path,
there is no need to call it here as well.

It is harmless, because the 2nd call will be a no-op, but it is cleaner
and less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
index 362639162ed6..228c58f38489 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
@@ -1216,7 +1216,6 @@ static int uc_fw_rsa_data_create(struct intel_uc_fw *uc_fw)
 	vaddr = i915_gem_object_pin_map_unlocked(vma->obj,
 						 intel_gt_coherent_map_type(gt, vma->obj, true));
 	if (IS_ERR(vaddr)) {
-		i915_vma_unpin_and_release(&vma, 0);
 		err = PTR_ERR(vaddr);
 		goto unpin_out;
 	}
-- 
2.34.1

