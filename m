Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E0765E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjG0V1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjG0V06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:26:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172851BC6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:26:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so899417b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690493216; x=1691098016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcvGxWKs0ioHSwaNFVtuDJQ1B/8SpZlsoy8QXz36r7I=;
        b=O0RhQf8KfE7AkPva40tWc9J+su1HI1UE2kEfdz7pkwxir6Zk97X4vA7+YDbYbExjNZ
         4RyRTkXeeZg8c5H4DsdkNwy5z0Oc/dOtYSntC5cuj+IHiZcJVOOl/pSPl7D3Ihdgfc6g
         IPIa1TkeHGbit0ypGybX6xXCaiyifj2oUvQhzSw14P8D1lwo9LkNq8obIlWu0dEXqnfq
         NOq9monYfeRcCg+StWnRJrEbiF6xrTEIpjpHi2DRzaZs15+pTwpPDnYlfAInaRS4UyKP
         klrItNmQI+SFf7u8/3WOJRIz/cZ031FyXJArV/48cx9URntu/5ar9hUBmNCWWhDXMrQw
         OqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493216; x=1691098016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcvGxWKs0ioHSwaNFVtuDJQ1B/8SpZlsoy8QXz36r7I=;
        b=G7oczf4TNtQsSkJ7Sh8Tt4pDkbKDabQ+vf6i8HJV8AOKKhrj0XESZQgzU1XeYzW/NT
         cwnNJkfL3sqkzrrOgw6Wd1ApHFtOau75WMkPrNyToLiDuFoBSwsB9zJK6Q+bfyajBUfb
         r74z2OpieETpajkVoY3e0cgpEsoRDZZca1BhD8NgX5kKnvEX8DuQ0a9RtthDay9CX1L3
         HGN5hEFQrgsAETbok29zTRKeTjYKLjesF7NtMOdat7rnPLZuiZ1Sim5wb7tGIMVpBYPr
         KlfNCBIKmgKTMkowFJQwKjHn78E60ZXsgB5gFsgHbUqU/zNvlVz92Dljsc8a+SJzD9wA
         ODAw==
X-Gm-Message-State: ABy/qLZyvXIxpo7sKz3+vOjFWJoYncKeARhb0gXuv7K3e02CFpClpSZ3
        tWuo4aauAUFKIJC1XYXk7eFdnw==
X-Google-Smtp-Source: APBJJlFlY+9HLXpB5MOpoEilud+PtI86fX/t6QctT4gfhpPOy7817Igg+eQtg4O7iE22xtMxf1LQKw==
X-Received: by 2002:a05:6a21:3984:b0:12f:d350:8a12 with SMTP id ad4-20020a056a21398400b0012fd3508a12mr467624pzc.21.1690493216617;
        Thu, 27 Jul 2023 14:26:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c5-20020aa78c05000000b00682562b1549sm1912312pfd.24.2023.07.27.14.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:26:56 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v8 4/4] RISC-V: mm: Document mmap changes
Date:   Thu, 27 Jul 2023 14:26:29 -0700
Message-ID: <20230727212647.4182407-5-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727212647.4182407-1-charlie@rivosinc.com>
References: <20230727212647.4182407-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The behavior of mmap is modified with this patch series, so explain the
changes to the mmap hint address behavior.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/riscv/vm-layout.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
index 5462c84f4723..69ff6da1dbf8 100644
--- a/Documentation/riscv/vm-layout.rst
+++ b/Documentation/riscv/vm-layout.rst
@@ -133,3 +133,25 @@ RISC-V Linux Kernel SV57
    ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
    ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
   __________________|____________|__________________|_________|____________________________________________________________
+
+
+Userspace VAs
+--------------------
+To maintain compatibility with software that relies on the VA space with a
+maximum of 48 bits the kernel will, by default, return virtual addresses to
+userspace from a 48-bit range (sv48). This default behavior is achieved by
+passing 0 into the hint address parameter of mmap. On CPUs with an address space
+smaller than sv48, the CPU maximum supported address space will be the default.
+
+Software can "opt-in" to receiving VAs from another VA space by providing
+a hint address to mmap. A hint address passed to mmap will cause the largest
+address space that fits entirely into the hint to be used, unless there is no
+space left in the address space. If there is no space available in the requested
+address space, an address in the next smallest available address space will be
+returned.
+
+For example, in order to obtain 48-bit VA space, a hint address greater than
+:code:`1 << 47` must be provided. Note that this is 47 due to sv48 userspace
+ending at :code:`1 << 47` and the addresses beyond this are reserved for the
+kernel. Similarly, to obtain 57-bit VA space addresses, a hint address greater
+than or equal to :code:`1 << 56` must be provided.
-- 
2.41.0

