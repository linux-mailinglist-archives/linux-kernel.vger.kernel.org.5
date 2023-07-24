Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F675F2C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjGXKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjGXKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:17:33 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E58C8A47;
        Mon, 24 Jul 2023 03:09:48 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34884a8f285so24131625ab.0;
        Mon, 24 Jul 2023 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690193387; x=1690798187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vwxb4dr9ed/m5CEyUxwJ1RrHPJUl/WASFTIF6qacv2g=;
        b=VD0NxzawoiPeT3noLpC6aX3MxiFFLuHuf3NInzssCr435rIpjai1Q9BKajTHw377io
         aXSypTdyUU+RFfzj2Zr9fY4+fYt5SJX0e+Vyy+XxqgO3jmXJEByYRFRtziGQzbao7+EF
         lA6e/r7AXXdNRbfFEaN7L4pzWHV9yf3b4SstMGls2JQpxcPFJZZPqG4VrKwfmUQkRsRr
         oTtZ4iW7aj1br5A6e/Y/BP1G4KeI4pUH+Pahde61X+gUa/GdrUCSMcFV6VgBciamhSP2
         z/1aqxOd8/QuVJJsh34jNZnDBMwHRpa4bgSn/smjgD3YFNYeixnDN1ipAKBxBFRwj+TT
         kMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193387; x=1690798187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vwxb4dr9ed/m5CEyUxwJ1RrHPJUl/WASFTIF6qacv2g=;
        b=UlcC3O/LMKyeIGmEDnebtK9EReQyEEK1DGJxCWIRSUOQE5DdtWl8xDbQAyLhCZK69B
         cf5Ncr1TgHYDEXet1UaTq/ZqpbF6OXUC6Of1dlnGYm2nkdQYg05Om2wLhgBVGzNbZhXy
         +SLReRLg+jh6UYOXX7bhouvbj2hfc3hx1QGRXtWHTqepfn1bp+7Ckv/luzPmzDEtuIdd
         lX5XUO30tzutLauX3xGZmHvKn0mEN2HTfG3uenhceQ3ET58WRgq4V9uycG1s1gJEhAvd
         +sFvC3vg9VZbjMzt6hYeAd3Azm2j2vHgF42DGZHbw93QFpkJA6/dIWU5H46MTNFglXS8
         8I2A==
X-Gm-Message-State: ABy/qLYLzm9iZSwlE2X2pIN8PbbpjRATkqyVQZi7F+iOqrUQSqcnr/wX
        DbB+tLiSMeA6Vp2SruZ0eU4=
X-Google-Smtp-Source: APBJJlHJ5PE83v9b1yIa2tiwwMnAmbYros48TQ/r/GuSfcXorXE/PyaC9/EV9Q/TEW8XN+CxxXkwYw==
X-Received: by 2002:a05:6e02:20e1:b0:346:e96:7cbb with SMTP id q1-20020a056e0220e100b003460e967cbbmr9064158ilv.30.1690193387442;
        Mon, 24 Jul 2023 03:09:47 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:c90:2347:5782:34b7:c2b6:16d2])
        by smtp.gmail.com with ESMTPSA id t29-20020a63b25d000000b0051b8172fa68sm8272826pgo.38.2023.07.24.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:09:47 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, xianting.tian@linux.alibaba.com,
        suagrfillet@gmail.com, anup@brainfault.org, robh@kernel.org,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        conor.dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RESEND PATCH -fixes 2/2] Documentation: kdump: Add va_kernel_pa_offset for RISCV64
Date:   Mon, 24 Jul 2023 18:09:17 +0800
Message-Id: <20230724100917.309061-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
References: <20230724100917.309061-1-suagrfillet@gmail.com>
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

RISC-V Linux exports "va_kernel_pa_offset" in vmcoreinfo to help
Crash-utility translate the kernel virtual address correctly.

Here adds the definition of "va_kernel_pa_offset".

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Link: https://lore.kernel.org/linux-riscv/20230724040649.220279-1-suagrfillet@gmail.com/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index c18d94fa6470..f8ebb63b6c5d 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -624,3 +624,9 @@ Used to get the correct ranges:
   * VMALLOC_START ~ VMALLOC_END : vmalloc() / ioremap() space.
   * VMEMMAP_START ~ VMEMMAP_END : vmemmap space, used for struct page array.
   * KERNEL_LINK_ADDR : start address of Kernel link and BPF
+
+va_kernel_pa_offset
+-------------------
+
+Indicates the offset between the kernel virtual and physical mappings.
+Used to translate virtual to physical addresses.
-- 
2.20.1

