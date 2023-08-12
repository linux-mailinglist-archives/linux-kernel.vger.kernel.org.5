Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995C2779D57
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHLFqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjHLFqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:46:46 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963322712;
        Fri, 11 Aug 2023 22:46:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 5A0E16015E;
        Sat, 12 Aug 2023 07:46:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691819203; bh=YZBcXmmJnd5USNFvIod8cr+dIcpfsOLq31FsgTOIxVg=;
        h=From:To:Cc:Subject:Date:From;
        b=XAcW+GJlv7E0K+7kajDHdHF7LTeDnB1AUTq43mcSREkdhZYi3tnHwSJORb37gKpOb
         jJvTic/GjeRhtpsvwHmFIYa6GgwXhM972OFw9kI2q5cFYUyOj3drdPcTE39us7YR5E
         bIDQBNf/VT/Oq563dSBwQcsvULauOUTaGmN5eE4/7CuVNE8rkml7a8Ve4FUf5ab1S3
         OU6SpnNc+PdpNc6dOaJbkKEfr6z2dRkWoyx3Z6rAS/fn2tK89VMyxSYkylScjZYeIA
         Fj764HFUe45P3d6I+b8LZ3UHEkfy5pS6NeqLLuEdYMCfK8kKMJ0nXlq1A3+SSmBqRC
         MQ7PZKny/l1vg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xud7GHiPjFbs; Sat, 12 Aug 2023 07:46:40 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 821A46015F;
        Sat, 12 Aug 2023 07:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691819200; bh=YZBcXmmJnd5USNFvIod8cr+dIcpfsOLq31FsgTOIxVg=;
        h=From:To:Cc:Subject:Date:From;
        b=i3gCIaL+iUSwCLda2vi/oe85P9G1sGUWf8UNZwUrUZ8i/Mr5togCSvC4iV/YwD05e
         n8xW2pBE92h7L7ZwlfZliMFJuuaeKzQc8eOM4PxWjP8RVW3cU9QDNeL++H9Mf9ezdv
         ADbCOjA9iN5PDuYzhk4CIeoWKgU9lqoFxbJKDFTp0HphEFWVGn5pkOXSxbb+AvQp9v
         HUR9uS0v6d31ptiOS/CLFuiHS42PyA9bhg323b/NAvDMvj6n9sLpyGDhWCnllDcKZa
         HQA4WUQEPB4gBW0yErKeePT070/Iv1RW9Otd76bAM5GVrJysOxHXbFN7VSZ9Ws5Qvv
         FZ2XUoZ6drotg==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 1/1] test_fimware: return -ENOMEM instead of -ENOSPC on failed memory allocation
Date:   Sat, 12 Aug 2023 07:43:47 +0200
Message-Id: <20230812054346.168223-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FILL_THIS_FORM,SPF_HELO_NONE,SPF_PASS,
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
Cc: stable@vger.kernel.org # 4.14
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
v3 -> v4:
 no changes. resubmitting for 4.14 because the patchwork didn't apply to the 4.14 tree.

v2 -> v3:
 minor clarifications with the versioning for the patchwork. no change to commit.

v1 -> v2:
 removed the Reviewed-by: and Acked-by tags, as this is a slightly different patch and
 those need to be reacquired

 lib/test_firmware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 5318c5e18acf..34210306ea66 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -159,7 +159,7 @@ static int __kstrncpy(char **dst, const char *name, size_t count, gfp_t gfp)
 {
 	*dst = kstrndup(name, count, gfp);
 	if (!*dst)
-		return -ENOSPC;
+		return -ENOMEM;
 	return count;
 }
 
@@ -459,7 +459,7 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -500,7 +500,7 @@ static ssize_t trigger_async_request_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s'\n", name);
 
@@ -543,7 +543,7 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	name = kstrndup(buf, count, GFP_KERNEL);
 	if (!name)
-		return -ENOSPC;
+		return -ENOMEM;
 
 	pr_info("loading '%s' using custom fallback mechanism\n", name);
 
-- 
2.34.1

