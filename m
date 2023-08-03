Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0418B76F035
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjHCQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjHCQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:59:00 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C02685;
        Thu,  3 Aug 2023 09:58:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C70D860182;
        Thu,  3 Aug 2023 18:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691081936; bh=gBCmijaU2KouC7TJYd+EMbkpcws2DFinyyAcksA4MUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcrBww0UGnswTuZcz5G/e+x5fZkZZmpJxb4AW0L4chrPZH2BvQpu8lvQ3OjC9LBAP
         Y0VDK69tuVfFPwMUUb6l/1DiUlepZ3LHN4WnamySQf66EA92inFiuHLn6etw/Thyi3
         WPtR1Mj7H224gakw4ac4QnN5eJmYQ0NF+HvBDMgADAixHRCY2X/HeEubTabqSVx41Z
         7Epmd8ptNtQ9Ns88OmonJF5UDHId1tdJ5Vob1k12W+3i+lcujdLwR9IPuMk50XIar2
         Dnn4trUedpRX98UBus8fn92LU7ZHHhfv+Y1CaqyeZmerfUeNsL0y/9vu0J8FjarteY
         Ll4fz5BNI0hBA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0GbZcXAcB8Pa; Thu,  3 Aug 2023 18:58:54 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 29CE26017F;
        Thu,  3 Aug 2023 18:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691081934; bh=gBCmijaU2KouC7TJYd+EMbkpcws2DFinyyAcksA4MUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVq1/hg+xv1eAm/Fpdb0L1ojHCQZOgwg0gl6l264uSDs3lCtkEPxD4E8Uj5qM5jak
         NoCsKgTgjQzSJB2ciwoOXONxve+ftkCa0euUaWHDrFTYMYAkPYRKSzItkGnCOCLk/W
         oR87PHyKGexH0nD3dCo8OSLLLG6G1xnCSUi6kAoUbVD4y58sZs9Ou8dno52ECD/M12
         nLMfhL5pF32dmNAmS12jsuHzcWKVAUzAc3B1FjqAI867g3oASBg4AqTgL5qhJSjw3J
         Kce0eUYkCItNIuaLpJSO46seP+8pgX3cgGi2ht5aceMV7sUGpSxtsw889QvEHP/BeG
         gSLFgRL83NflA==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 2/2] test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
Date:   Thu,  3 Aug 2023 18:53:06 +0200
Message-Id: <20230803165304.9200-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803165304.9200-1-mirsad.todorovac@alu.unizg.hr>
References: <20230803165304.9200-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Cc: stable@vger.kernel.org # 5.4
Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
Fixes: 0a8adf584759c ("test: add firmware_class loader test")
Fixes: eb910947c82f9 ("test: firmware_class: add asynchronous request trigger")
Fixes: 061132d2b9c95 ("test_firmware: add test custom fallback trigger")
Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Link: https://lore.kernel.org/all/20230606070808.9300-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This is the backport of the patch to specific to the 5.4 branch. There are no		]
[ semantic differences in the commit when compared to upstream, only fewer instances	]
[ of error code replacement. Backport is provided for completeness sake			]
[ so it would apply to all of the supported LTS kernels.				]
---
 v3:
	fixed a minor typo. no change to commit.

 v2:
	tested on 5.4 stable build.

 lib/test_firmware.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 92d7195d5b5b..dd3850ec1dfa 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -173,7 +173,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -509,7 +509,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -552,7 +552,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -597,7 +597,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
@@ -648,7 +648,7 @@ static int test_fw_run_batch_request(void *data)
 
 		test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
 		if (!test_buf)
-			return -ENOSPC;
+			return -ENOMEM;
 
 		req->rc = request_firmware_into_buf(&req->fw,
 						    req->name,
-- 
2.34.1

