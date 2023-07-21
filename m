Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F7075CAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGUOvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGUOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:51:30 -0400
X-Greylist: delayed 47216 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 07:51:22 PDT
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E91510FE;
        Fri, 21 Jul 2023 07:51:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [115.206.160.60])
        by mail-app2 (Coremail) with SMTP id by_KCgC3n35Xm7pkHgtKCg--.1270S4;
        Fri, 21 Jul 2023 22:51:04 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v2] xfrm: add NULL check in xfrm_update_ae_params
Date:   Fri, 21 Jul 2023 22:51:03 +0800
Message-Id: <20230721145103.2714073-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgC3n35Xm7pkHgtKCg--.1270S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw48Xw4UZr1xJryktw15twb_yoWrXFy7pF
        W5K3yjkrs5Xw1UZr4UAr1aqr1jvF48ZF1DCr93Xr1FvFy5Grn5WFy5J3yj9rykArWDAFy7
        J3W5tr18tw1YkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ry5
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbkR65UUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, x->replay_esn and x->preplay_esn should be allocated at
xfrm_alloc_replay_state_esn(...) in xfrm_state_construct(...), hence the
xfrm_update_ae_params(...) is okay to update them. However, the current
implementation of xfrm_new_ae(...) allows a malicious user to directly
dereference a NULL pointer and crash the kernel like below.

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 8253067 P4D 8253067 PUD 8e0e067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 98 Comm: poc.npd Not tainted 6.4.0-rc7-00072-gdad9774deaf1 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.o4
RIP: 0010:memcpy_orig+0xad/0x140
Code: e8 4c 89 5f e0 48 8d 7f e0 73 d2 83 c2 20 48 29 d6 48 29 d7 83 fa 10 72 34 4c 8b 06 4c 8b 4e 08 c
RSP: 0018:ffff888008f57658 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffff888008bd0000 RCX: ffffffff8238e571
RDX: 0000000000000018 RSI: ffff888007f64844 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888008f57818
R13: ffff888007f64aa4 R14: 0000000000000000 R15: 0000000000000000
FS:  00000000014013c0(0000) GS:ffff88806d600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000054d8000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ? __die+0x1f/0x70
 ? page_fault_oops+0x1e8/0x500
 ? __pfx_is_prefetch.constprop.0+0x10/0x10
 ? __pfx_page_fault_oops+0x10/0x10
 ? _raw_spin_unlock_irqrestore+0x11/0x40
 ? fixup_exception+0x36/0x460
 ? _raw_spin_unlock_irqrestore+0x11/0x40
 ? exc_page_fault+0x5e/0xc0
 ? asm_exc_page_fault+0x26/0x30
 ? xfrm_update_ae_params+0xd1/0x260
 ? memcpy_orig+0xad/0x140
 ? __pfx__raw_spin_lock_bh+0x10/0x10
 xfrm_update_ae_params+0xe7/0x260
 xfrm_new_ae+0x298/0x4e0
 ? __pfx_xfrm_new_ae+0x10/0x10
 ? __pfx_xfrm_new_ae+0x10/0x10
 xfrm_user_rcv_msg+0x25a/0x410
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 ? __alloc_skb+0xcf/0x210
 ? stack_trace_save+0x90/0xd0
 ? filter_irq_stacks+0x1c/0x70
 ? __stack_depot_save+0x39/0x4e0
 ? __kasan_slab_free+0x10a/0x190
 ? kmem_cache_free+0x9c/0x340
 ? netlink_recvmsg+0x23c/0x660
 ? sock_recvmsg+0xeb/0xf0
 ? __sys_recvfrom+0x13c/0x1f0
 ? __x64_sys_recvfrom+0x71/0x90
 ? do_syscall_64+0x3f/0x90
 ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
 ? copyout+0x3e/0x50
 netlink_rcv_skb+0xd6/0x210
 ? __pfx_xfrm_user_rcv_msg+0x10/0x10
 ? __pfx_netlink_rcv_skb+0x10/0x10
 ? __pfx_sock_has_perm+0x10/0x10
 ? mutex_lock+0x8d/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 xfrm_netlink_rcv+0x44/0x50
 netlink_unicast+0x36f/0x4c0
 ? __pfx_netlink_unicast+0x10/0x10
 ? netlink_recvmsg+0x500/0x660
 netlink_sendmsg+0x3b7/0x700

This Null-ptr-deref bug is assigned CVE-2023-3772. And this commit
adds additional NULL check in xfrm_update_ae_params to fix the NPD.

Fixes: d8647b79c3b7 ("xfrm: Add user interface for esn and big anti-replay windows")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1 -> V2: fix some typos: impelementation -> implementation,
          frm_update_ae_params -> xfrm_update_ae_params

 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c34a2a06ca94..bf2564967501 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -628,7 +628,7 @@ static void xfrm_update_ae_params(struct xfrm_state *x, struct nlattr **attrs,
 	struct nlattr *rt = attrs[XFRMA_REPLAY_THRESH];
 	struct nlattr *mt = attrs[XFRMA_MTIMER_THRESH];
 
-	if (re) {
+	if (re && x->replay_esn && x->preplay_esn) {
 		struct xfrm_replay_state_esn *replay_esn;
 		replay_esn = nla_data(re);
 		memcpy(x->replay_esn, replay_esn,
-- 
2.17.1

