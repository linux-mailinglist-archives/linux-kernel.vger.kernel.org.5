Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7285576B2D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjHALOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjHALOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:14:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415F2103
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:10:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f25d045cso3695437b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690888232; x=1691493032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=korDIX4sAxkkpV8e2u1lpZVVT/VDItzmnploqLBkDn8=;
        b=Wnq3DcKZan5Aboi+g1Wj9nsuA84KdfbJtt+q3/KNQzTxN3hYM4f9QnqXKiLq7+3A1o
         Guy/RsJkRpJbXECMZwp+ncrLvFsLksgEiV2jrnzbsqRuJgth/Yjh0aj7OmTcaB+B8UEZ
         wG9REFyMJ2rR8HmLXnwkBooGtg1Erc1E9Ylbas2+BKUg3LK1mlBpbEe/5b4v9nARxycD
         6fZKEyLyYMm/Et6ruaDUC9n+hlydZEir8iBIZ4lb6H4O0dXolAG/wybyGdB/eXCvyIPs
         2S4LPsJcm4KmFFKy4aanULlgUbNgR/gZBqy8ypMdv1wNlsP5rIPpla2uDZL8TvlJxY/W
         VsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690888232; x=1691493032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=korDIX4sAxkkpV8e2u1lpZVVT/VDItzmnploqLBkDn8=;
        b=eyfJ1LkH+IihEwK64Txep8ePAzOLkgs+YYAbozIMFOdvPX+MZWwlHc3E/fJ9Y0ZGPo
         BTWwn9jIVWwYXaORkTtVY/V245HsLxpEsDmP5HdTDT1yxjxnWD+Dy36XMyMkLLxvbWan
         r7quxtlyHvDEonFbOAleRqhdGmLKZJN4dqmNGvT+SeucZtix+31V4rw2fX05BMtzRL4Z
         IQHEd94bMuyD6JUXZ12SSmMRrrYj6gNahoFFLLZhMouxjT345g5iUed6CyY3w9GAEVkk
         HfwSNTkyjtuXh3I3L7OUAI68ryFU4DPRaqfuydJW+W9U05L/JtvAgXjydhlPWajN1/U+
         yn5A==
X-Gm-Message-State: ABy/qLZqei/Y+KrjQ4SqLm74H0EoF0gpZ3+omGPU4zIbAPxkR5XYAr2a
        ou7WhTPfmagPxPpjbgnlLh8=
X-Google-Smtp-Source: APBJJlEYp1j6BwyQLziDwdHTNZ+u1PmA2QBMmpEqC8F6TVbtI0o0UaxbKtb/ll5qLBcPF6fJW/ZwFw==
X-Received: by 2002:a05:6a21:35c9:b0:131:5995:340 with SMTP id ba9-20020a056a2135c900b0013159950340mr11470828pzc.20.1690888231952;
        Tue, 01 Aug 2023 04:10:31 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c00:f3f:aeab:c5ff:e07e:654d])
        by smtp.gmail.com with ESMTPSA id g1-20020aa78741000000b00682ad3613eesm9047516pfo.51.2023.08.01.04.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:10:31 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        guoren@kernel.org, alexghiti@rivosinc.com,
        sergey.matyukevich@syntacore.com, david@redhat.com,
        wangkefeng.wang@huawei.com, panqinglin2020@iscas.ac.cn,
        woodrow.shen@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] riscv: Correct the MODULES_VADDR
Date:   Tue,  1 Aug 2023 19:10:14 +0800
Message-Id: <20230801111014.1432679-1-suagrfillet@gmail.com>
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

As Documentation/riscv/vm-layout.rst describes, the 2G-sized "modules, BPF"
area should lie right before the "kernel" area. But the current definition
of MODULES_VADDR isn't consistent with that, so correct it.

Before this patch, the size of "modules" from print_vm_layout() is not 2G.

[    0.000000]      modules : 0xffffffff2ff2f000 - 0xffffffffae600000 (2022 MB)
[    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000 (1024 MB)
[    0.000000]       kernel : 0xffffffffae600000 - 0xffffffffffffffff (1305 MB)

After this patch, the size is 2G.

[    0.000000]      modules : 0xffffffff3a000000 - 0xffffffffba000000 (2048 MB)
[    0.000000]       lowmem : 0xff60000000000000 - 0xff60000040000000 (1024 MB)
[    0.000000]       kernel : 0xffffffffba000000 - 0xffffffffffffffff (1119 MB)

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 75970ee2bda2..7c57e17fc758 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -53,8 +53,8 @@
 #ifdef CONFIG_64BIT
 /* This is used to define the end of the KASAN shadow region */
 #define MODULES_LOWEST_VADDR	(KERNEL_LINK_ADDR - SZ_2G)
-#define MODULES_VADDR		(PFN_ALIGN((unsigned long)&_end) - SZ_2G)
 #define MODULES_END		(PFN_ALIGN((unsigned long)&_start))
+#define MODULES_VADDR		(MODULES_END - SZ_2G)
 #endif
 
 /*
-- 
2.20.1

