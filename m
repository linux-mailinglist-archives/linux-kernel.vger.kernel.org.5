Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C056B75F2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjGXKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjGXKRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:17:19 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8665B7;
        Mon, 24 Jul 2023 03:09:36 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56597d949b1so2542379eaf.1;
        Mon, 24 Jul 2023 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690193375; x=1690798175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=hrex/GaUVfMUNZRWvZGpegE4riCW/oOM8uo1UlMmZrlwQR1Y5g9p5yiEY70tHm1Nzn
         Kr5sAEgXdRnmXkRixZ7uSFsyu3mNjkPZQedetliik0YCgA1z5anwyhWO9wgDZJyycz8L
         bqVnG2/rUHzputkQE2I8YmX+z8H53N83YyFIUqLlAn9cJmQ4l5FtwSeir3YT0mCh/CG7
         JEi1SSLS+YGBbkTVOq9MO8LWjBph4mBH+cWBfdLJUhXU6fvKZdialD83Hcug1zFLoGt6
         BHhQtXdk8mLSMT19jnYSRQvWcdarZMfp3CBtw3bGQxqh6FJqAgde0fb2q24nvFcehQ0V
         1Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193375; x=1690798175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDlfftCqHuUNq6LkkwKxzRiSDkmFGSCz0/vq6oh3T+s=;
        b=HH3TfRjHnWS8nK9abvA1Fzry8XUzkeK3UrglqfGgYbWjfsuVjOZM72N79wKtn/ayvN
         prjT/cNuI1siVpZY8AiWsMzdyKzESirDuUCVmI/Ua5zjaSHgqSB4JnqDLwUt1A4Q7g+F
         OaSdGNpuVrHSaCe9JjYqhEY54b2eS6h7s24OiXQQBrZ2pn6+j+7eSHXuPXXktlQTC5Ek
         eVMaoDK3DYVInFkNq5WFIB57pHbGODDXcGJMwx6MXdNUuAxRr1D8U/DwiOclgb5FOFfJ
         GJVPCnLv+WqsVVgBMTqYo16pEHaOoUxAR+zIKOWuUunCxDJw1qU77gmiGKlAuMz6T+Hm
         ETfQ==
X-Gm-Message-State: ABy/qLbfVbDi/kmT9vy5zLi550CfcBOqDaD1wdsGS6qM+2wULgVInhF0
        Dn6Le5UK1EwNXOofx/Nj0Hk=
X-Google-Smtp-Source: APBJJlHdgdC3rG6LO2coONZP/kkI0Ylc1MgH/PIQ2Zz6Htck/GwFgmmgxR6G3vTB6BKFwu4lvsrr9w==
X-Received: by 2002:a05:6808:1410:b0:3a3:5fc6:3ba6 with SMTP id w16-20020a056808141000b003a35fc63ba6mr12452468oiv.42.1690193375682;
        Mon, 24 Jul 2023 03:09:35 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c90:2347:5782:34b7:c2b6:16d2])
        by smtp.gmail.com with ESMTPSA id t29-20020a63b25d000000b0051b8172fa68sm8272826pgo.38.2023.07.24.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:09:35 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, xianting.tian@linux.alibaba.com,
        suagrfillet@gmail.com, anup@brainfault.org, robh@kernel.org,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        conor.dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in vmcoreinfo
Date:   Mon, 24 Jul 2023 18:09:16 +0800
Message-Id: <20230724100917.309061-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
from the physical start of the kernel to the actual start of the DRAM.

The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].

Export kernel_map.va_kernel_pa_offset in vmcoreinfo to help Crash translate
the kernel virtual address correctly.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/ [1]
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
index b351a3c01355..55f1d7856b54 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
@@ -18,4 +18,6 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
 #endif
 	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
+	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
+						kernel_map.va_kernel_pa_offset);
 }
-- 
2.20.1

