Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959E07C47E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbjJKClu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344787AbjJKCls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:41:48 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 19:41:44 PDT
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 838D98F;
        Tue, 10 Oct 2023 19:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=UQ1kl
        Q9cDn4IIBIuv0bV5gMlUx5TS2lof+8CE+oLg7s=; b=drF9sXSykqmp6TnA7O9k1
        hizLBpTHDk5uy8pRBneAIU8pHTfBs9J+opfF0KnIajlE7c5e4ecr9A5UjEKzn7yq
        +7366hEM0P0U0YDtGx9e/2lutlvNUZSdhoMDNbWsUtEZNgxG30P10zSnC6ESl96m
        5avSKzY49g894laKWPsf6g=
Received: from king.lan (unknown [103.163.180.22])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wDHj6PPByZlpGyQBg--.7S2;
        Wed, 11 Oct 2023 10:26:26 +0800 (CST)
From:   wangyouwan@126.com
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        youwan Wang <wangyouwan@126.com>
Subject: [PATCH] Bluetooth: btusb: Add date->evt_skb is NULL check
Date:   Wed, 11 Oct 2023 10:26:04 +0800
Message-Id: <20231011022604.88595-1-wangyouwan@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHj6PPByZlpGyQBg--.7S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4kXFy7Cr47GFy8XFykuFg_yoW5Aw45pr
        1rt3WDCF4kW3yUJr15XF18Aw4UXr42vFy5Jr9rZr45XFy3Ka1DJa4xJrWUKr1DGr4agw13
        ta4kJw10gw1DGaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piPxhdUUUUU=
X-Originating-IP: [103.163.180.22]
X-CM-SenderInfo: 5zdqw5prxzt0a6rslhhfrp/1tbidxUGFVpD3-UDQwAAsC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: youwan Wang <wangyouwan@126.com>

fix crash because of null pointers

[ 6104.969662] BUG: kernel NULL pointer dereference, address: 00000000000000c8
[ 6104.969667] #PF: supervisor read access in kernel mode
[ 6104.969668] #PF: error_code(0x0000) - not-present page
[ 6104.969670] PGD 0 P4D 0
[ 6104.969673] Oops: 0000 [#1] SMP NOPTI
[ 6104.969684] RIP: 0010:btusb_mtk_hci_wmt_sync+0x144/0x220 [btusb]
[ 6104.969688] RSP: 0018:ffffb8d681533d48 EFLAGS: 00010246
[ 6104.969689] RAX: 0000000000000000 RBX: ffff8ad560bb2000 RCX: 0000000000000006
[ 6104.969691] RDX: 0000000000000000 RSI: ffffb8d681533d08 RDI: 0000000000000000
[ 6104.969692] RBP: ffffb8d681533d70 R08: 0000000000000001 R09: 0000000000000001
[ 6104.969694] R10: 0000000000000001 R11: 00000000fa83b2da R12: ffff8ad461d1d7c0
[ 6104.969695] R13: 0000000000000000 R14: ffff8ad459618c18 R15: ffffb8d681533d90
[ 6104.969697] FS:  00007f5a1cab9d40(0000) GS:ffff8ad578200000(0000) knlGS:0000000000000000
[ 6104.969699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6104.969700] CR2: 00000000000000c8 CR3: 000000018620c001 CR4: 0000000000760ef0
[ 6104.969701] PKRU: 55555554
[ 6104.969702] Call Trace:
[ 6104.969708]  btusb_mtk_shutdown+0x44/0x80 [btusb]
[ 6104.969732]  hci_dev_do_close+0x470/0x5c0 [bluetooth]
[ 6104.969748]  hci_rfkill_set_block+0x56/0xa0 [bluetooth]
[ 6104.969753]  rfkill_set_block+0x92/0x160
[ 6104.969755]  rfkill_fop_write+0x136/0x1e0
[ 6104.969759]  __vfs_write+0x18/0x40
[ 6104.969761]  vfs_write+0xdf/0x1c0
[ 6104.969763]  ksys_write+0xb1/0xe0
[ 6104.969765]  __x64_sys_write+0x1a/0x20
[ 6104.969769]  do_syscall_64+0x51/0x180
[ 6104.969771]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 6104.969773] RIP: 0033:0x7f5a21f18fef
[ 6104.969778] RSP: 002b:00007ffeefe39010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[ 6104.969780] RAX: ffffffffffffffda RBX: 000055c10a7560a0 RCX: 00007f5a21f18fef
[ 6104.969781] RDX: 0000000000000008 RSI: 00007ffeefe39060 RDI: 0000000000000012
[ 6104.969782] RBP: 00007ffeefe39060 R08: 0000000000000000 R09: 0000000000000017
[ 6104.969784] R10: 00007ffeefe38d97 R11: 0000000000000293 R12: 0000000000000002
[ 6104.969785] R13: 00007ffeefe39220 R14: 00007ffeefe391a0 R15: 000055c10a72acf0

Signed-off-by: youwan Wang <wangyouwan@126.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3fdad35e5e1d..d793dcd06687 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2824,6 +2824,9 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 		goto err_free_wc;
 	}
 
+	if (data->evt_skb == NULL)
+		goto err_free_wc;
+
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
 	if (wmt_evt->whdr.op != hdr->op) {
-- 
2.25.1

