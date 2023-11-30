Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31127FFB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376411AbjK3TZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376398AbjK3TZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:25:50 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B3BD48;
        Thu, 30 Nov 2023 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1701372346; x=1701977146; i=spasswolf@web.de;
        bh=USw4Ysbq1SDuHrOYgS+lpeVdJC1FeC4zmu7k2jpDy5k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=vvlJdCa3R5x9YEY1m8yK02scFGGhHgGkZJXJDIhgImpoRIhPAk0r1ojRxQnxHKD0
         QmBVTTUmjQRRha8dbxbohRv6tLHoV94kgTEBpKyY/MGNbFN+uFM+/HbbKOVzbOonD
         HUE3cGzuT+towh3yU1J8jBkPBO41wOhEHiCqg4F6SqSOPGeVk9mCYQAmB3fCNpKkd
         jIcqQNslFRLlkfOYS+Sd7D/7Ud2HrSpRCfc8T0FbvuB6ANZoAK9y0R6wlRsF03Ert
         wcWhZ6/BsCOo6L61xJtpNlQ53elr1iqH2sXBqx46wT4uCGbgYdnVUXs25icdQwNGM
         CYX3WtfCea2w2hpvBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from lisa.home ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1rKOUD0XhD-017ICe; Thu, 30
 Nov 2023 20:25:46 +0100
From:   Bert Karwatzki <spasswolf@web.de>
To:     kuba@kernel.org, almasrymina@google.com, edumazet@google.com,
        hawk@kernel.org, pabeni@redhat.com
Cc:     Bert Karwatzki <spasswolf@web.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: page_pool: Fix NULL pointer dereference in page_pool_unlist()
Date:   Thu, 30 Nov 2023 20:25:42 +0100
Message-Id: <20231130192542.4503-1-spasswolf@web.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OS6As1TPNz0orakhqyGewZGr2+rIRvZRtQqpbCEdMt+Rt9dtmtt
 j8q3Hzhx3CjkZm422gk2352wJpHy5/XhIbh7pKwNu7+QeMf12Te+dKwAOcze4AumMteu1fQ
 kWUs5X35TIzmqN2E5GXTV+7rK0l90XGZpg/wivKf+NCNPHALAmg4kmeHgOvrSMA3TFHVqm2
 1rFuYojOHr/7jHMlZ8J6A==
UI-OutboundReport: notjunk:1;M01:P0:mynq7xYW9nk=;jnaHIDoBBZ2PGvL8Uf5AVuX/2mV
 Q+vN74VzL9OBwFpT6Tw5JE1peAItIOKfTuZcWM9Koq9DCpN+FvcTapmNsLSb9AWOrxmkYq353
 egxIvMBCLg3iyqR+nHYUQkILT+NChfjgKQjXzQ2WM251ex2XRXMJmVejvbz762kIJceoGgNpo
 j/Db4+b8i/OwAMjTbnQkoFB908JEwiNjUOeMyjdNKigTH0SFsxVv8lHJjrcC/5Hqbvf+gZsaP
 dV4V//yzDNgoQCvjY2c56DXbAuIvEpEcgdou/uugvTOq7afhKo4j49sI4iebflbkXJXneM3ri
 nFIKsL9NGtikNLp5WBKYc2CRUjPYClsyW4uAXvi9f1KZ6u/qPOI0I2sDobm8wbkUqzJb+jobA
 9cvG96JRUUeYUiJPC9RAmGab5xigiYlD83nUrVdsmYmimwMzllyYMaR9BVx2+7Sd9pLe+1yu9
 l0MY/YWaJF5CnaeomYfBRWCFWke0Ikz2wX+JxGLkqcj+5UrrtJaFtWUEfmPgcDxuUFRZ1Gg6v
 d1Jg/vnpg8kB+bj3+Trw2stNwV8YnWkO+XkdqM7YkQKPBFHKx57MCWxN3Kig848Y1RvGu1pgX
 fLbjjxjUx1VoEcKQtQspnk7Ocg/lrbk3AHEA4Yv6OpfbDxF2VZyiuSoVztxu0L0iXC2lZamw2
 uN7Q1xqpSK9yfHd8vuHdVuabSi54qquAYlyhTvqRWMzeurkMgvNArOl5/7yVbRF2R6mOtZEmc
 VXtLShx4W47c4B2RzDRMA0gPuw4rBHooxCP/OZL8FVMh3V1GAEAIzvzfIg2nCvc/0mJJ3HQS3
 /QkiJZaBb4WXtEuxMjAFvF8kTdqeul0AzUN2adZ+hCv2c96Uwp/hWKSNuZJ3lMuaIxK3bxSgL
 kpT2Y+YnLBjhjzIIH4wDuveXjVuhulcM0uvOwks9AR9G3Mo576ma2FnHRyNLdXNKPhxIMj3jE
 QWFxgA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the the hlist_node pool->user.list is in an in an unhashed state,
calling hlist_del() leads to a NULL pointer dereference. This happens
e. g. when rmmod'ing the mt7921e (mediatek wifi driver) kernel module.
An additional check fixes the issue.

Fixes: 083772c9f972dc ("net: page_pool: record pools per netdev")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 net/core/page_pool_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 1426434a7e15..47d7d32288ab 100644
=2D-- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -339,7 +339,8 @@ void page_pool_unlist(struct page_pool *pool)
 	mutex_lock(&page_pools_lock);
 	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
 	xa_erase(&page_pools, pool->user.id);
-	hlist_del(&pool->user.list);
+	if(!hlist_unhashed(&pool->user.list))
+		hlist_del(&pool->user.list);
 	mutex_unlock(&page_pools_lock);
 }

=2D-
2.39.2

Since kernel version linux-next-20231129 I noticed that my MSI Alpha 15
laptop would hang on shutdown with blinking capslock, indicating a
kernel panic. I bisected the error to commit 083772c9f972dcc24891 an notic=
ed that
error can also be triggered by rmmod'ing the mt7921e (mediatek wifi
driver) kernel module, giving the following backtrace (using the guess
unwinder):

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] PREEMPT SMP NOPTI
 CPU: 10 PID: 3053 Comm: modprobe Not tainted 6.7.0-rc3-next-20231130 #981
 Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L,=
 BIOS E158LAMS.107 11/10/2021
 RIP: 0010:page_pool_unlist+0x41/0x80

 RSP: 0018:ffffb9a9c5be3d78 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffff9a1006944000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff9c8dc2c0
 RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000000
 R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
 R13: ffff9a10185147e8 R14: ffff9a1018512528 R15: 0000000000000000
 FS:  00007f507e775040(0000) GS:ffff9a12de880000(0000) knlGS:0000000000000=
000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 00000001872ba000 CR4: 0000000000750ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die+0x1e/0x60
  ? page_fault_oops+0x157/0x430
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? iommu_completion_wait.part.0.isra.0+0x78/0xf0
  ? exc_page_fault+0x5f/0x90
  ? asm_exc_page_fault+0x26/0x30
  ? page_pool_unlist+0x41/0x80
  ? page_pool_unlist+0x33/0x80
  ? page_pool_release+0x18a/0x1e0
  ? page_pool_destroy+0x95/0x150
  ? mt76_dma_cleanup+0x118/0x1f0 [mt76]
  ? mt7921_pci_remove+0xbf/0x130 [mt7921e]
  ? pci_device_remove+0x35/0xa0
  ? device_release_driver_internal+0x19a/0x200
  ? driver_detach+0x43/0x90
  ? bus_remove_driver+0x68/0xf0
  ? pci_unregister_driver+0x3a/0x80
  ? __do_sys_delete_module+0x1a8/0x2e0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __fput+0x119/0x2b0
  ? do_syscall_64+0x45/0xf0
  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
  </TASK>

The given patch addresses the issue by adding an extra check to
page_pool_unlist().

Bert Karwatzki
