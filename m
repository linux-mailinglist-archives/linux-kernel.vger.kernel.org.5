Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC6C7AAC42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjIVIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjIVILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:11:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E57E61;
        Fri, 22 Sep 2023 01:11:39 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:11:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695370297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=geNEPFvjv2X0tF060Xkd/gkYK1ZYVMX72QmM0tmt0Sg=;
        b=4t2Ml+6ms+YGiUdMNzCyd1HU3b5svpkAez+g7/WPUDmvni39qBn1siGeS/Nim+C4crgOoe
        NUSPim8FcBUwhQvA4DqZEWA4K7Ren3uD/SgfyoDt4n3FspcIJ7lthp3ALw7Hn4m4DSx2/J
        m2YiNjJGURK09bXUEVmHGLFBTyYDIfPS6psJJZYSLVQxjHzRkEwFOWQa/fu1fA2lv5Z+38
        yYlFfsYzkEDui6SlGKIqW1TwpIMfByj6G20v1ZVRw5SyLsQ/SJyuv8u4ax+JblfjTdohIT
        qvMC4Q2DdI5WpMfIhkZF4dJMfge+AKyaQf3z420GJI/Eqhk9AO6IDC6UabESAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695370297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=geNEPFvjv2X0tF060Xkd/gkYK1ZYVMX72QmM0tmt0Sg=;
        b=tYkk6tq4bBwOXxiWGlFsM6p7E46uo1bNvu6Aw+IwIc9s6KcYwjGbO+B30kOiEUPunG9VwP
        IvMMBL0hIr4emvDQ==
From:   "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex/test: Make sure we bail out
 instead of livelock
Cc:     Li Zhijian <zhijianx.li@intel.com>,
        John Stultz <jstultz@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230922043616.19282-4-jstultz@google.com>
References: <20230922043616.19282-4-jstultz@google.com>
MIME-Version: 1.0
Message-ID: <169537029684.27769.17114350620697997504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cfa92b6d52071aaa8f27d21affdcb14e7448fbc1
Gitweb:        https://git.kernel.org/tip/cfa92b6d52071aaa8f27d21affdcb14e7448fbc1
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Fri, 22 Sep 2023 04:36:01 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 09:43:41 +02:00

locking/ww_mutex/test: Make sure we bail out instead of livelock

I've seen what appears to be livelocks in the stress_inorder_work()
function, and looking at the code it is clear we can have a case
where we continually retry acquiring the locks and never check to
see if we have passed the specified timeout.

This patch reworks that function so we always check the timeout
before iterating through the loop again.

I believe others may have hit this previously here:

  https://lore.kernel.org/lkml/895ef450-4fb3-5d29-a6ad-790657106a5a@intel.com/

Reported-by: Li Zhijian <zhijianx.li@intel.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230922043616.19282-4-jstultz@google.com
---
 kernel/locking/test-ww_mutex.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 358d661..78719e1 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -465,17 +465,18 @@ retry:
 			ww_mutex_unlock(&locks[order[n]]);
 
 		if (err == -EDEADLK) {
-			ww_mutex_lock_slow(&locks[order[contended]], &ctx);
-			goto retry;
+			if (!time_after(jiffies, stress->timeout)) {
+				ww_mutex_lock_slow(&locks[order[contended]], &ctx);
+				goto retry;
+			}
 		}
 
+		ww_acquire_fini(&ctx);
 		if (err) {
 			pr_err_once("stress (%s) failed with %d\n",
 				    __func__, err);
 			break;
 		}
-
-		ww_acquire_fini(&ctx);
 	} while (!time_after(jiffies, stress->timeout));
 
 	kfree(order);
