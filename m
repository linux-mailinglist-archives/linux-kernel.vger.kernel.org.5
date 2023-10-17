Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446EE7CCF31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjJQVZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344345AbjJQVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F021C126
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:54 -0700 (PDT)
Message-ID: <20231017211723.131454229@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QfJgwvaKg9KDiVtt/bFmM4IrpyyKSnPnwhur+L5KJQY=;
        b=e00lgK0DRqOEfU52Ne3s53o+MgjBCGgovEyu0/2ynCn5FA6HM5NPf1folkm3p9kxW8zO2R
        9I+OQ6j/RocuZEoiDDWNGESQuNabCqBJe0m8c0Qi6SUyWqyq/kkkrd2D18CTeHZCOQ0dam
        aePXbAWa8ulRgjFmW+grfgM+j+5Sc8aj3LCP2HAimjN09KJIvADLu5rzwHDK3b6PZ+dNUC
        daveamMXE+FYKz890J548mS9CMslw4Rr/ch5KcMJM5JAomHkJxBuKpTg/W6g7cm7xGnukC
        IRPZ1QdK5HRXb2bF+NkP+RhcIt8W7841+988Ls5n5rHtkUcu9VBVz1w7s3nrWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QfJgwvaKg9KDiVtt/bFmM4IrpyyKSnPnwhur+L5KJQY=;
        b=UYjLIWBgfoxZ/nskVAHhlvCmiHI7TQxwmKsvRfNm2+hzLWTkJzZtgNKBpOLBN2P8ojCEDd
        ib+bXEUdDjkuCwBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 21/39] x86/microcode/amd: Cache builtin microcode too
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:52 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

save_microcode_in_initrd_amd() fails to cache builtin microcode and only
scans initrd.

Use find_blobs_in_containers() instead which covers both.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f6ed2c5be932..046b3a6c8594 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -533,7 +533,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	cp = find_microcode_in_initrd(ucode_path);
+	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 

