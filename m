Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1DE7FDDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjK2Qzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2Qzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:55:36 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B4BA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:55:40 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:93e7:15e4:6acd:f55])
        by andre.telenet-ops.be with bizsmtp
        id GGvb2B00H4TDgPo01GvbkD; Wed, 29 Nov 2023 17:55:37 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r8NqI-00ALyF-Hn;
        Wed, 29 Nov 2023 17:55:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r8NqZ-00BcaL-9i;
        Wed, 29 Nov 2023 17:55:35 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] reset: Fix crash when freeing non-existent optional resets
Date:   Wed, 29 Nov 2023 17:55:33 +0100
Message-Id: <2440edae7ca8534628cdbaf559ded288f2998178.1701276806.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When obtaining one or more optional resets, non-existent resets are
stored as NULL pointers, and all related error and cleanup paths need to
take this into account.

Currently only reset_control_put() and reset_control_bulk_put()
get this right.  All of __reset_control_bulk_get(),
of_reset_control_array_get(), and reset_control_array_put() lack the
proper checking, causing NULL pointer dereferences on failure or
release.

Fix this by moving the existing check from reset_control_bulk_put() to
__reset_control_put_internal(), so it applies to all callers.
The double check in reset_control_put() doesn't hurt.

Fixes: 17c82e206d2a3cd8 ("reset: Add APIs to manage array of resets")
Fixes: 48d71395896d54ee ("reset: Add reset_control_bulk API")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Crash seen on the Renesas R-Car S4-based Spider development board, using
a (buggy) out-of-tree patch[1].  As the (mutually-exclusive) PCIe host and
endpoint nodes share the same reset,
devm_reset_control_bulk_get_optional_exclusive() fails, and crashes in
the error path:

    /soc/pcie@e65d0000 requests exclusive control over reset pwr shared with /soc/pcie-ep@e65d0000 on /soc/clock-controller@e6150000
    Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
    Mem abort info:
      ESR = 0x0000000096000005
      EC = 0x25: DABT (current EL), IL = 32 bits
      SET = 0, FnV = 0
      EA = 0, S1PTW = 0
      FSC = 0x05: level 1 translation fault
    Data abort info:
      ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
    user pgtable: 4k pages, 39-bit VAs, pgdp=00000004810b4000
    [000000000000001c] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
    Internal error: Oops: 0000000096000005 [#1] SMP
    pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : __reset_control_put_internal+0x90/0xc8
    lr : __reset_control_bulk_get+0xd4/0xd8
    sp : ffffffc08174ba20
    x29: ffffffc08174ba20 x28: ffffff8440010cd0 x27: ffffff8440a6f8c0
    x26: 0000000000000001 x25: 0000000000000001 x24: 0000000000000000
    x23: ffffff84409d4410 x22: ffffff8440a6fe48 x21: ffffffc080e8fae0
    x20: 0000000000000005 x19: 0000000000000000 x18: 0000000000000000
    x17: 6168732072777020 x16: 7465736572207265 x15: 766f206c6f72746e
    x14: 6f63206576697375 x13: 3030303035313665 x12: 4072656c6c6f7274
    x11: 6e6f632d6b636f6c x10: 632f636f732f206e x9 : 6c63786520737473
    x8 : 6575716572203030 x7 : 205d383432323136 x6 : ffffffc080e8fae0
    x5 : ffffffc080e8fae0 x4 : 0000000000000004 x3 : 0000000000000000
    x2 : 000000000000001c x1 : 00000000ffffffff x0 : 000000000000001c
    Call trace:
     __reset_control_put_internal+0x90/0xc8
     __reset_control_bulk_get+0xd4/0xd8
     __devm_reset_control_bulk_get+0x78/0xcc
     dw_pcie_get_resources+0x2e8/0x344
     dw_pcie_host_init+0x64/0x538
     rcar_gen4_pcie_probe+0x1a8/0x1ec
     platform_probe+0x68/0xb8
     really_probe+0x140/0x278
     __driver_probe_device+0xf4/0x10c
     driver_probe_device+0x50/0x100
     __device_attach_driver+0xb0/0xd0
     bus_for_each_drv+0xa8/0xd0
     __device_attach_async_helper+0x70/0xc4
     async_run_entry_fn+0x38/0x108
     process_scheduled_works+0x1c4/0x270
     worker_thread+0x1fc/0x26c
     kthread+0xbc/0xcc
     ret_from_fork+0x10/0x20
    Code: 97f88daf 14000009 91007262 12800001 (b8610041)
    ---[ end trace 0000000000000000 ]---

[1] "[PATCH v3] reset: Exclusive resets must be dedicated to a single
     hardware block"
    https://lore.kernel.org/r/20181113133520.20889-1-geert+renesas@glider.be
---
 drivers/reset/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7ece6a8e9858555d..4d5a78d3c085bc76 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -807,6 +807,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
+	if (IS_ERR_OR_NULL(rstc))
+		return;
+
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
@@ -1017,11 +1020,8 @@ EXPORT_SYMBOL_GPL(reset_control_put);
 void reset_control_bulk_put(int num_rstcs, struct reset_control_bulk_data *rstcs)
 {
 	mutex_lock(&reset_list_mutex);
-	while (num_rstcs--) {
-		if (IS_ERR_OR_NULL(rstcs[num_rstcs].rstc))
-			continue;
+	while (num_rstcs--)
 		__reset_control_put_internal(rstcs[num_rstcs].rstc);
-	}
 	mutex_unlock(&reset_list_mutex);
 }
 EXPORT_SYMBOL_GPL(reset_control_bulk_put);
-- 
2.34.1

