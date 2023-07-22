Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2175DD5E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGVQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGVQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:03:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D44A1FDF;
        Sat, 22 Jul 2023 09:03:31 -0700 (PDT)
Date:   Sat, 22 Jul 2023 16:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690041808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIlUKNOZbqeMD94L3neoznK1YkPZS74c2BtITe69l/k=;
        b=GGLv4iM6WnZDW78RJ5+CuAvj80uZMdsF5isE4nKovuV+++ySEwVRCRwRWhwoc8f8isH6+n
        7B1es3eD35+kc6RQ2hWSoru+0jmIJouVw7EV1D0EuI/jNH2r6cF/Zk+uQiOM9neAQ2WFMr
        rjt90USSL+l9mZesrd25Tmk+NYTauYOzxii+cQ5HaYguOM1tsUOia8sLhiXVXHTSFh4fdG
        CaUS+8wpG/0c1/KCIokzSTCaE4f8t5v/AOjhs2oUoRhIAqNIiYlad0Ot0IZu/sjpx+gWIA
        VWqV+/TZilJQd9QK59KPEwJpBEAuVB/a9YnAzRF95FVqaQtp5qyql1Bi9/yX4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690041808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIlUKNOZbqeMD94L3neoznK1YkPZS74c2BtITe69l/k=;
        b=iz75Bid9Qiui3nrBFlzThsbpB+ZeyI752O9Sc9AbsfayQZYbO5VcIy/KsrpvBz3ztfT/QM
        BZRiVJNnENZn1LCg==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Calpine=2ELRH=2E2=2E02=2E2205301145540=2E2584?=
 =?utf-8?q?0=40file01=2Eintranet=2Eprod=2Eint=2Erdu2=2Eredhat=2Ecom=3E?=
References: =?utf-8?q?=3Calpine=2ELRH=2E2=2E02=2E2205301145540=2E25840?=
 =?utf-8?q?=40file01=2Eintranet=2Eprod=2Eint=2Erdu2=2Eredhat=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169004180799.28540.1304114763325215952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3ba2e83334bed2b1980b59734e6e84dfaf96026c
Gitweb:        https://git.kernel.org/tip/3ba2e83334bed2b1980b59734e6e84dfaf96026c
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 06 Jun 2022 19:45:56 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 22 Jul 2023 17:35:16 +02:00

x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks

AMD systems from Family 10h to 16h share MCA bank 4 across multiple CPUs.
Therefore, the threshold_bank structure for bank 4, and its threshold_block
structures, will be initialized once at boot time. And the kobject for the
shared bank will be added to each of the CPUs that share it. Furthermore,
the threshold_blocks for the shared bank will be added again to the bank's
kobject. These additions will increase the refcount for the bank's kobject.

For example, a shared bank with two blocks and shared across two CPUs will
be set up like this:

  CPU0 init
    bank create and add; bank refcount = 1; threshold_create_bank()
      block 0 init and add; bank refcount = 2; allocate_threshold_blocks()
      block 1 init and add; bank refcount = 3; allocate_threshold_blocks()
  CPU1 init
    bank add; bank refcount = 3; threshold_create_bank()
      block 0 add; bank refcount = 4; __threshold_add_blocks()
      block 1 add; bank refcount = 5; __threshold_add_blocks()

Currently in threshold_remove_bank(), if the bank is shared then
__threshold_remove_blocks() is called. Here the shared bank's kobject and
the bank's blocks' kobjects are deleted. This is done on the first call
even while the structures are still shared. Subsequent calls from other
CPUs that share the structures will attempt to delete the kobjects.

During kobject_del(), kobject->sd is removed. If the kobject is not part of
a kset with default_groups, then subsequent kobject_del() calls seem safe
even with kobject->sd == NULL.

Originally, the AMD MCA thresholding structures did not use default_groups.
And so the above behavior was not apparent.

However, a recent change implemented default_groups for the thresholding
structures. Therefore, kobject_del() will go down the sysfs_remove_groups()
code path. In this case, the first kobject_del() may succeed and remove
kobject->sd. But subsequent kobject_del() calls will give a WARNing in
kernfs_remove_by_name_ns() since kobject->sd == NULL.

Use kobject_put() on the shared bank's kobject when "removing" blocks. This
decrements the bank's refcount while keeping kobjects enabled until the
bank is no longer shared. At that point, kobject_put() will be called on
the blocks which drives their refcount to 0 and deletes them and also
decrementing the bank's refcount. And finally kobject_put() will be called
on the bank driving its refcount to 0 and deleting it.

The same example above:

  CPU1 shutdown
    bank is shared; bank refcount = 5; threshold_remove_bank()
      block 0 put parent bank; bank refcount = 4; __threshold_remove_blocks()
      block 1 put parent bank; bank refcount = 3; __threshold_remove_blocks()
  CPU0 shutdown
    bank is no longer shared; bank refcount = 3; threshold_remove_bank()
      block 0 put block; bank refcount = 2; deallocate_threshold_blocks()
      block 1 put block; bank refcount = 1; deallocate_threshold_blocks()
    put bank; bank refcount = 0; threshold_remove_bank()

Fixes: 7f99cb5e6039 ("x86/CPU/AMD: Use default_groups in kobj_type")
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com
---
 arch/x86/kernel/cpu/mce/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5e74610..c4ec4ca 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1261,10 +1261,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
 
-	kobject_del(b->kobj);
+	kobject_put(b->kobj);
 
 	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_del(&pos->kobj);
+		kobject_put(b->kobj);
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)
