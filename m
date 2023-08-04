Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169F770675
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjHDQ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHDQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:57:18 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F7198B;
        Fri,  4 Aug 2023 09:57:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3ADCA60177;
        Fri,  4 Aug 2023 18:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691168235; bh=3pO4ASe2Rzwm3FUFHEkivkWRWqhULtw+aTw1zJGZjmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vreioAkmf/qehNVmhzht4oP7bZ/JTEaMCqCXzBjMopwjm65/IZHQFKHncjFc37s8y
         QHIPWUEYj6A6cXcDPOZ8fACnIbirL1Mtwv9eDuInOCYUy/2hozApKcK3kfBVCcXTQJ
         3VdFJQssHmMtcWUBuxF8WCpNSWQgfjcllsBNnhii7b2YSD7eV34sZSm8JYjY7/eQQM
         rmaT/2NzSywdtGQ9EunzNCpYT9e0SBYZvx6b3tEbf1ojgV9qO7S9AuUpsWnmGhxEVI
         YbJrP6quxKBiCWI0nrjCrWYSm4SP4q394aEv2ImCTjovWXbu+09EY3A8UbUSsYLzGH
         6PBJVElU2/pdA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J24Tgs8Bafjn; Fri,  4 Aug 2023 18:57:12 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 8639A60174;
        Fri,  4 Aug 2023 18:57:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691168232; bh=3pO4ASe2Rzwm3FUFHEkivkWRWqhULtw+aTw1zJGZjmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9MxCLuMzRqZ7/ry+rC7ynGvw5L0UpnVx+7zwF1StZGBdOvD9ghnQpXgYIF4ElvHt
         pWlCGf5eBObyA/Fr2hXuue3GqBrsiu2YUdhaKRrV3mfuXsy5/BV9r+rESWabe5mfoc
         JJGmOXYDcgMGblrMmsaqkKDkD357J2TRII6uwC2hHIXh4J95V+YIVSW2bFqAq8CWow
         JmiTR9pGmfXoviM2SBUpbVzcCiq9EmbO4FJuqAKajqu9RHtYNn8DmR1h2w5klEz3F9
         T29txfIPzOxDlwchFyE4DXhZOWlOUaQWz57VaIq/rblQHf5Ghbgj6mglvGLdH20GSC
         exegF1AQ00BGw==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 4.19 2/2] test_firmware: return -ENOMEM instead of -ENOSPC on failed memory allocation
Date:   Fri,  4 Aug 2023 18:53:23 +0200
Message-Id: <20230804165321.92163-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804165321.92163-1-mirsad.todorovac@alu.unizg.hr>
References: <20230804165321.92163-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
[ semantic differences in the commit. The same fix applies to 4.19 and 4.14	]
[ tree. The backport is provided for completenes sake so the bug would be fixed	]
[ for all of the supported LTS kernels						]

---
v2 -> v3:
 minor clarifications with the versioning for the patchwork. no change to commit.

v1 -> v2:
 removed the Reviewed-by: and Acked-by tags, as this is a slightly different patch and
 those need to be reacquired

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

