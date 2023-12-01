Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E988004AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377724AbjLAHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjLAHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:21:36 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C9103
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:21:42 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d8481094f9so140640a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701415301; x=1702020101; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tya0TWa3RItcX8nqIYUWWzzHkzOVOpUqH7JgJB50qPo=;
        b=pprgWGcPM/3T9jfq/bJZT/rESzI2nYsXQPD+XwefIc8nfm8J1p2BgxayUsWqv0sRNS
         J7Rzw3fWZIyEvcoL1VpoN+edE1UsXxGvZH8H7tzmJFsSAcOSajlHjHHfuZi+5hmpHwmd
         pm0yxDpKxly0var0U6vTtPbncZeUnD6Rxu9ZcW58D7df1nxOCxy0aGRfXxjQCt0FDzU3
         KXz2W8+fKdLSNNPkeA/PI0s1o+Ho6FmiadQY06LYFeFcaXncrRLQb0YZAkI5wXANUMSh
         zY+O7x8L7mukF2C6S3/T0BSRCOHaPvq839GPrhmfSrhIaw5dz5PilWjhHyUlzXDcLiBG
         jEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701415301; x=1702020101;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tya0TWa3RItcX8nqIYUWWzzHkzOVOpUqH7JgJB50qPo=;
        b=oMl5gF6xQEHDnJpm4eN2OJMe/lBnFggFYWZZ8Xe3R8wWmYABYkaE6bG6/AgB3c3neq
         XOKXBGUmPKF8c7HpomFLai3ximDhuj4SwKS6+Bei9kRDER1MG6IA9lxx4CwOqK1lSUON
         tN85Vkqa5Gr3YFhjvcmJj8j/LoWR1/2AfTFZQqH8JwiIMjDRldkY8dZUO+awu0QjOzD2
         eAgGDkKkJJQZDybL4BY54TVx2QXha2z+HwLJx78sV1LIoRjRHFZGJywprf03SRA7wx7k
         OHWzr6e1TpJX32STAtijChGDLdvxVQbiu4lbletV2at2tloPI78H3ifqdGXPgGV/dyj/
         7LTg==
X-Gm-Message-State: AOJu0YyKVl16diy/1Xo68Ams/F3BDUlEnmREQfMfm1wRiVV5x+Na05G0
        lmi9QKiRINd1CFnOoYGIR0v/7Q==
X-Google-Smtp-Source: AGHT+IHinSg3Zb9kf7EJbJUB60bwZkBnSz+AR6pXi1DiHaOh4toVAr901y3hOTXt6k2BGn9lyMq4wg==
X-Received: by 2002:a05:6830:2099:b0:6bb:1629:ab44 with SMTP id y25-20020a056830209900b006bb1629ab44mr2124999otq.7.1701415301509;
        Thu, 30 Nov 2023 23:21:41 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id v23-20020a0568301bd700b006d7f8da1b57sm412662ota.62.2023.11.30.23.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:21:41 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date:   Thu, 30 Nov 2023 23:21:34 -0800
Message-Id: <20231130-fencei-v2-0-2cb623ab1b1f@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6JaWUC/zXMQQrCMBCF4auUWRvJjGKrq95DuminEzsLE0kkK
 CV3NxZd/o/Ht0KSqJLg0qwQJWvS4GvQrgFeRn8To3NtIEsHRGyNE8+ixp3dyc5td3SjhXp+RHH
 62qDrUHvR9AzxvbkZv+uPIPoTGY01k7DtEHkipD5qDkk97zncYSilfACkqQconwAAAA==
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701415300; l=1252;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=b2zSSjTaQJ7sjFJuqSSx5uHyDjW7oZfa+GC3felkcT4=;
 b=QuTLw6KTUXYWFveyBXw4+Jiy8hHpNSCmoo5bYnYjdnPJekg5cZnQ28amZhiK1f6m2FMyTRDKt
 iANhxEXAhkjDM80OIdzE4k9cK34yLk4RYHWS8/zrvh0/ZkK+pMYkZ1q
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

[1] https://github.com/riscv/riscv-j-extension

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Fix kernel-doc comment (Conor)
- Link to v1: https://lore.kernel.org/r/20231122-fencei-v1-0-bec0811cb212@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Include riscv_set_icache_flush_ctx prctl
      documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl

 Documentation/arch/riscv/cmodx.rst | 98 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 arch/riscv/include/asm/mmu.h       |  2 +
 arch/riscv/include/asm/processor.h |  6 +++
 arch/riscv/mm/cacheflush.c         | 37 ++++++++++++++
 arch/riscv/mm/context.c            |  8 ++--
 include/uapi/linux/prctl.h         |  3 ++
 kernel/sys.c                       |  6 +++
 8 files changed, 158 insertions(+), 3 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie

