Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83A77FEF94
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbjK3M4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345369AbjK3M43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:56:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D30810C2;
        Thu, 30 Nov 2023 04:56:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332ed1bd4cbso567188f8f.2;
        Thu, 30 Nov 2023 04:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701348994; x=1701953794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyD+yl2bHZjrxQ6uqMRfoBj0ywuOG/6z0iIPw0pQbBM=;
        b=PjNhhZOdBh9lo5TrxJxjFgeWogrfj2OcmCoXFii9EgcnRw5nlX/dpUedxpmNGtx/le
         hkhHUHAV2ePhhPlXdQF831BM44VdJcHm3C8YZ6AAMgp4xbUUJRh3L+1Xtey6Ok1lmL3I
         5IXFZ+kfTpds5ZOi+NjDlUPcxpEMD92TdpiwoWMCL2zMIUxe3CyTbTIkX+HUDtf7Jib4
         jr9N9ahFMNrcJXa+Z+UCqTzJlHENcasLez7sOmXh0nSWrpWCQ7DN0cf9/+81p1nOUlTR
         UKmINX6p5XIL4LlSbve52iify8mstN9Ajbbsmx7Il8JPvnq9hUAPQ76drZcI0Ptynxru
         bGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701348994; x=1701953794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyD+yl2bHZjrxQ6uqMRfoBj0ywuOG/6z0iIPw0pQbBM=;
        b=CpB6Slf58wcyIqcfnIylpnrkGGEHRZfyyDpa3Ndsyublzl5WBalz9M+YW5PhhXwI2V
         wwOUPJCVROrp72hIb41xVHl2dJLbl4TgXF5/InFTpkN/zlIX38xDNI+z5I35eC+St31i
         fQWY7r3hK+2W5rIVwlHiU36f5wkoutPZRdhhceqI55ZGk8B3fH7p2w4iTXB3N6pR+3Na
         9NYgdWGRZDJ7G+WPJWIq+8ZzX8i6jDqpQ7+S5uBZrwNrRfqDtVc/DviIb269ItoTbg7b
         +NfRgVeehV4EJFua8Dj0O1rncLzH1o6JG96wULAvDoYceAzxHmzn191ZYnj68pnth9Hm
         I8cg==
X-Gm-Message-State: AOJu0YxyM6DsauQ28KwAVAhM9fBKsjSg60UYOOsktE5DHc/3Mw1NvsbH
        EZjls+RP3KmvX3MaAqJOSMY=
X-Google-Smtp-Source: AGHT+IH7MbMZQhB4klE0BbfdgOc2EVNygz66QSdNWQ8VAEJy9K365/fx1q+fEAVewBWf1IDSVP1Hzw==
X-Received: by 2002:adf:e841:0:b0:333:179:d8ef with SMTP id d1-20020adfe841000000b003330179d8efmr7830573wrn.24.1701348993691;
        Thu, 30 Nov 2023 04:56:33 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id t9-20020a5d6a49000000b0033172f984eesm1488463wrw.50.2023.11.30.04.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 04:56:33 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yu Chien Peter Lin <peterlin@andestech.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] riscv: errata: andes: Probe for IOCP only once in boot stage
Date:   Thu, 30 Nov 2023 12:56:06 +0000
Message-Id: <20231130125606.64931-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

We need to probe for IOCP only once during boot stage, as we were probing
for IOCP for all the stages this caused the below issue during module-init
stage,

[9.019104] Unable to handle kernel paging request at virtual address ffffffff8100d3a0
[9.027153] Oops [#1]
[9.029421] Modules linked in: rcar_canfd renesas_usbhs i2c_riic can_dev spi_rspi i2c_core
[9.037686] CPU: 0 PID: 90 Comm: udevd Not tainted 6.7.0-rc1+ #57
[9.043756] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[9.050339] epc : riscv_noncoherent_supported+0x10/0x3e
[9.055558]  ra : andes_errata_patch_func+0x4a/0x52
[9.060418] epc : ffffffff8000d8c2 ra : ffffffff8000d95c sp : ffffffc8003abb00
[9.067607]  gp : ffffffff814e25a0 tp : ffffffd80361e540 t0 : 0000000000000000
[9.074795]  t1 : 000000000900031e t2 : 0000000000000001 s0 : ffffffc8003abb20
[9.081984]  s1 : ffffffff015b57c7 a0 : 0000000000000000 a1 : 0000000000000001
[9.089172]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff8100d8be
[9.096360]  a5 : 0000000000000001 a6 : 0000000000000001 a7 : 000000000900031e
[9.103548]  s2 : ffffffff015b57d7 s3 : 0000000000000001 s4 : 000000000000031e
[9.110736]  s5 : 8000000000008a45 s6 : 0000000000000500 s7 : 000000000000003f
[9.117924]  s8 : ffffffc8003abd48 s9 : ffffffff015b1140 s10: ffffffff8151a1b0
[9.125113]  s11: ffffffff015b1000 t3 : 0000000000000001 t4 : fefefefefefefeff
[9.132301]  t5 : ffffffff015b57c7 t6 : ffffffd8b63a6000
[9.137587] status: 0000000200000120 badaddr: ffffffff8100d3a0 cause: 000000000000000f
[9.145468] [<ffffffff8000d8c2>] riscv_noncoherent_supported+0x10/0x3e
[9.151972] [<ffffffff800027e8>] _apply_alternatives+0x84/0x86
[9.157784] [<ffffffff800029be>] apply_module_alternatives+0x10/0x1a
[9.164113] [<ffffffff80008fcc>] module_finalize+0x5e/0x7a
[9.169583] [<ffffffff80085cd6>] load_module+0xfd8/0x179c
[9.174965] [<ffffffff80086630>] init_module_from_file+0x76/0xaa
[9.180948] [<ffffffff800867f6>] __riscv_sys_finit_module+0x176/0x2a8
[9.187365] [<ffffffff80889862>] do_trap_ecall_u+0xbe/0x130
[9.192922] [<ffffffff808920bc>] ret_from_exception+0x0/0x64
[9.198573] Code: 0009 b7e9 6797 014d a783 85a7 c799 4785 0717 0100 (0123) aef7
[9.205994] ---[ end trace 0000000000000000 ]---

This is because we called riscv_noncoherent_supported() for all the stages
during IOCP probe. riscv_noncoherent_supported() function sets
noncoherent_supported variable to true which has an annotation set to
"__ro_after_init" due to which we were seeing the above splat. Fix this by
probing for IOCP only once in boot stage by having a boolean variable
is_iocp_probe_done which will be set to true upon IOCP probe in
errata_probe_iocp() and we bail out early if is_iocp_probe_done is set.

While at it make return type of errata_probe_iocp() to void as we were
not checking the return value in andes_errata_patch_func().

Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* As RISCV_ALTERNATIVES_BOOT stage can happen twice add a is_iocp_probe_done
  variable to probe for IOCP only once.
* Updated commit message
* Make return value of errata_probe_iocp() to void
---
 arch/riscv/errata/andes/errata.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index 197db68cc8da..b8eadb3b10d8 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -38,29 +38,36 @@ static long ax45mp_iocp_sw_workaround(void)
 	return ret.error ? 0 : ret.value;
 }
 
-static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
+static void errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
 {
+	static bool is_iocp_probe_done;
+
 	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
-		return false;
+		return;
+
+	if (is_iocp_probe_done)
+		return;
 
 	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
-		return false;
+		return;
 
-	if (!ax45mp_iocp_sw_workaround())
-		return false;
+	if (!ax45mp_iocp_sw_workaround()) {
+		is_iocp_probe_done = true;
+		return;
+	}
 
 	/* Set this just to make core cbo code happy */
 	riscv_cbom_block_size = 1;
 	riscv_noncoherent_supported();
-
-	return true;
+	is_iocp_probe_done = true;
 }
 
 void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 					      unsigned long archid, unsigned long impid,
 					      unsigned int stage)
 {
-	errata_probe_iocp(stage, archid, impid);
+	if (stage == RISCV_ALTERNATIVES_BOOT)
+		errata_probe_iocp(stage, archid, impid);
 
 	/* we have nothing to patch here ATM so just return back */
 }
-- 
2.34.1

