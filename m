Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A67F373E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjKUUZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:25:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FB01A2;
        Tue, 21 Nov 2023 12:25:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32f78dcf036so91023f8f.0;
        Tue, 21 Nov 2023 12:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700598318; x=1701203118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lC0ovH1sMR+X7ZTtQkf2fWPZEJbRi0PVuO8TV/5qUo=;
        b=eNU0cESzL7InNB3CyoxDzMC8/UaX5HgOVKszvKMaMyytddUKsJVvWiynYNOYlPzTJ+
         uyNWNoYzwN4HiyiAjIZ/UfbiLVyo8tVsTBbwQbooHfYk6klaWp5BGLotSyzzLnviIpHQ
         cU7p0zY5Yyg/yTEMiLEd8B2JbT6CaYDrxyHSlvpuPY3u69oN9RBz7ZuT2JgZAfR/PD1I
         SbjupM0O5/ffVNmpLS5ys2SrCd6FLi3XNQAID+1ZvL1HLFLCNeZOWcuB4bbsyYMB/kfB
         TYbt8KXkk6IxqFK7oznmcyFHyVcQpapoiFcBTNqdrX2VWuJEnD+jx6qBIRGbXE62n5rA
         Ko5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598318; x=1701203118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lC0ovH1sMR+X7ZTtQkf2fWPZEJbRi0PVuO8TV/5qUo=;
        b=qgi68dgj3CAPRCDwyKE0mfoV1qHqR+erKKGRvhATLP0bshl1cvSBbI7roZ9+D/h0xM
         S7sXM6OQVWVHg7ZVM1qO/Nh6klijHoNS1DyDOZhddRzb/cbtDkSiKzr37rv5JpYCM9qg
         AZlMjcNL1liZW0PEtW3RwSGWEZDEKjEFZwVbjDg3O7n/kGySOPcVwgGwVLxSQpgsVThh
         pIVbRKmFs7SOtX+AoZ1bNWEfb3a1sa6G5gsgBgayLACPWWScz3rfIXcQweQM7a/CyEfD
         nCt/KBgPKsuq0csbA6F78qo/iHTKNLg/i7wMr+SYL2FJkhFKaHzFMMnoPbP27iRrFJP4
         1/hQ==
X-Gm-Message-State: AOJu0YxkP8eSKKo02m20FRugVFzE3VpxTBnQS5l4OL6a8VC0mNmTh1XI
        YWazHrZzLEA/UNxtCwy4J7A=
X-Google-Smtp-Source: AGHT+IGnOJCswD/GMiWfzz5U/DvJq6IUq4AzQP1MJUZYSDpefmTpGDGZ71qCsRphGv/gClRSdHwzFg==
X-Received: by 2002:a5d:584b:0:b0:32f:7a22:8b42 with SMTP id i11-20020a5d584b000000b0032f7a228b42mr3418449wrf.23.1700598318173;
        Tue, 21 Nov 2023 12:25:18 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:cf5b:fb56:995b:b106])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm15370009wrj.11.2023.11.21.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:25:17 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yu Chien Peter Lin <peterlin@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] riscv: errata: andes: Probe IOCP during boot stage
Date:   Tue, 21 Nov 2023 20:24:59 +0000
Message-Id: <20231121202459.36874-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

We should be probing for IOCP during boot stage only. As we were probing
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
probing IOCP during boot stage only.

Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/errata/andes/errata.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index d2e1abcac967..1c0fef111273 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -60,7 +60,8 @@ void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct al
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

