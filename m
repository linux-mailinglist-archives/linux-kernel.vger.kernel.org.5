Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFCC76BD15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjHAS4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjHAS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:56:34 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8239FFF;
        Tue,  1 Aug 2023 11:56:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id ACBC660182;
        Tue,  1 Aug 2023 20:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690916180; bh=MPYljj3h/SN6YXOHz3zCHJ6JU1rITTD4c44UeRuh36Q=;
        h=From:To:Cc:Subject:Date:From;
        b=IUxyKyWtm1Yqnyayl7fu2PbJK5kmHUKYV5V5PVmU+VnUeM/4mo69iEy+FNJeECmkc
         Gt3rTc7CUe6q3HxacyVc6TJ0zbY5kVTuIkAacvfrMV8DD18+Wqx2vKk8CUNhEHpnvO
         F4aby3MJMBMtGt4Cb1Pt3jAnGOxiUBnGcRA79vgdvvroaIahyLOwtCNLIrvZpiWbOj
         91CUza+jvwO2O0QwfYxlWBnCKAj50ZEbmN2vGgKBYD+2uK2r1rH+ls5RSHeY8zcmZQ
         m09HO4BCF98nESN2M3AUi2dnF7T9kIQGPkn4cb/WlUYhDrltbFEaSRDojBQDJSEMEX
         aRX1SesPDjxfg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6nGW5UqLdght; Tue,  1 Aug 2023 20:56:18 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id D19BF6015F;
        Tue,  1 Aug 2023 20:56:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690916178; bh=MPYljj3h/SN6YXOHz3zCHJ6JU1rITTD4c44UeRuh36Q=;
        h=From:To:Cc:Subject:Date:From;
        b=N/NwOhcvsN59P/LNNc4ACP1mfQ3tUsVp1adujxkcrN2lTd/BvCHzVktlbi5k1+4+g
         g2Qojk3vNFQ64oQoHYGnx8Z1YY/erWJr9KT5iPYckyITyeQJm1RbOCg8WrjUjSOhIl
         HXxHe2O3/wk2EI0M2smesPpPlm21iCaxsHQ5pNVevpLNUF3uUiS7rseaInXm3pWkeW
         SUatlKDYMc5l+8VJuOL1NeTGnkg28opFiiVlIVQmB4zg1xB42qa7OsnJuCxF9z3w+2
         gGhDOHaVbm5Nu7tL7ixZOO4F4ZDiAJwby4OWEexIYvGEA3WJjypp2aOp119ZL4R9jZ
         cdSW+4JiMdeng==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v1 1/1] test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
Date:   Tue,  1 Aug 2023 20:53:25 +0200
Message-Id: <20230801185324.197544-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FILL_THIS_FORM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7dae593cd226a0bca61201cf85ceb9335cf63682 ]

In a couple of situations like

	name = kstrndup(buf, count, GFP_KERNEL);
	if (!name)
		return -ENOSPC;

the error is not actually "No space left on device", but "Out of memory".

It is semantically correct to return -ENOMEM in all failed kstrndup()
and kzalloc() cases in this driver, as it is not a problem with disk
space, but with kernel memory allocator failing allocation.

The semantically correct should be:

        name = kstrndup(buf, count, GFP_KERNEL);
        if (!name)
                return -ENOMEM;

Cc: Dan Carpenter <error27@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: stable@vger.kernel.org # 4.19, 4.14
Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
Fixes: 0a8adf584759c ("test: add firmware_class loader test")
Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
Link: https://lore.kernel.org/all/20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This is the backport of the patch to 4.19 and 4.14 branches. There are no	]
[ semantic differences in the commit. Backport is provided for completenes sake	]
[ so it would apply to all of the supported LTS kernels				]
---
v1:
 no semantic difference, but there is change in code (one less patched instance of -ENOSPC),
 so I am submitting the patch for a review.

 lib/test_firmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index e4688821eab8..b5e779bcfb34 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -160,7 +160,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -456,7 +456,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -497,7 +497,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -540,7 +540,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
-- 
2.34.1

