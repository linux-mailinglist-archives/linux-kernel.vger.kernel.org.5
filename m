Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA77FFD7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376890AbjK3V1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3V1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:27:12 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD0133;
        Thu, 30 Nov 2023 13:27:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3333074512bso40468f8f.1;
        Thu, 30 Nov 2023 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701379637; x=1701984437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KqgjcL24ZMnKLsXbYwH0Kk7Ypb9AJnVc4DeykxITi3c=;
        b=isu3R+PyHMfWu5eH8kC5q5DDANjZdpYGp6bHfr62a4B5D3LfAezAlyuqg4Lj2MqmSk
         8cpYeXxUW4UzmQE3WY0YRQcRKKHOgjpeoifjiccIqKPBFsgx2S5JURZKkRNT3AaWY4rd
         E3JH+Oq3irY1U8CS7VEqr2srRGUNPdC/iLQBGIQXDY8D7zogZuX4rgtYCCd7KHAn7c8z
         Lhxt3uPVHBj79yVJm0kONaYQwQ8mpw0aYbLU1PygR2YKgTvqhqD+MiSwjBexYaVE+Z8I
         L3+LtbrGy7gOmC+i4EPz3p/3FuAK2sx1W5Gn5Iy8dUd96aZKyYhYI+wM9MMcDhKIeKqm
         HysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379637; x=1701984437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqgjcL24ZMnKLsXbYwH0Kk7Ypb9AJnVc4DeykxITi3c=;
        b=sFzJgfPmM/RBywqCZq+ltJTcWz6QiWSTSfALjiP8D6VbbtzYaa0kFAptGPcucxjCvN
         wpeOuserHg5KuMTKlQMdr2Kw2uUmIBV96Qucj43IUTAb+ChOZcmrGIbBvjWc5rOAvyxn
         8rjY3wwoPh8mCgG5rnnckHQNHN4lNLP2GXUtzXq4OpgivHFHIHb7tgB9hRdVjapzujkh
         47b+63qwZ4Eez21BRQ5zUM2rzqeoXlcrosJ1SLg6ZUNZoeV4kNUR3eB5HG3XJnys+CUh
         UIFURoBwzspQvEYQv6UCQqw4DMjfgsAuaIQEV+ft8oUUy6cmkTQZ3mD2LDYA/but9rNI
         yErQ==
X-Gm-Message-State: AOJu0YzNUXcqjRoveZuSkD11CFPu41pC5XZqIn2uDdqXKiLLbmVrYDss
        yAY3eqiBasEr2Pm41ezigK0=
X-Google-Smtp-Source: AGHT+IHKBeHl7stvLYTFaI4jG/zWMybVzNEIz41y+IHoeV42m4AZDHT+xqfJgF2OkZwBJforvNzzyA==
X-Received: by 2002:a05:600c:4da4:b0:40b:5e26:238c with SMTP id v36-20020a05600c4da400b0040b5e26238cmr95459wmp.61.1701379637105;
        Thu, 30 Nov 2023 13:27:17 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b003fc0505be19sm3271440wmb.37.2023.11.30.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:27:16 -0800 (PST)
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
Subject: [PATCH v3] riscv: errata: andes: Probe for IOCP only once in boot stage
Date:   Thu, 30 Nov 2023 21:26:47 +0000
Message-Id: <20231130212647.108746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
"done" which will be set to true upon IOCP probe in errata_probe_iocp()
and we bail out early if "done" is set to true.

While at it make return type of errata_probe_iocp() to void as we were
not checking the return value in andes_errata_patch_func().

Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/errata/andes/errata.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index 197db68cc8da..17a904869724 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -38,29 +38,35 @@ static long ax45mp_iocp_sw_workaround(void)
 	return ret.error ? 0 : ret.value;
 }
 
-static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
+static void errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
 {
+	static bool done;
+
 	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
-		return false;
+		return;
+
+	if (done)
+		return;
+
+	done = true;
 
 	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
-		return false;
+		return;
 
 	if (!ax45mp_iocp_sw_workaround())
-		return false;
+		return;
 
 	/* Set this just to make core cbo code happy */
 	riscv_cbom_block_size = 1;
 	riscv_noncoherent_supported();
-
-	return true;
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

