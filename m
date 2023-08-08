Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B785E774F23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHHXOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjHHXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:13:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788F81BCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:13:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d47d125f5afso2916359276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691536423; x=1692141223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aS9+bqGGIGJd4osXg0UNYpwpvIxhiWvvz+QMPQ0Ulo=;
        b=r5BfuQMefAg0Tnr2FQaEIivjC4JzNAMuw4qxGVtci6+U9djSIpA11Hdl+rJc6en91J
         y/h+YDs0QAA5xFNhoGQE0fza9XyovVTAf2+ZIQj9pZdiciK8WN7z5vHDkRS5bze2JrvX
         1Pi0zGoodsu607T4DyfgYeotzEFP9OFg33WWk/J6RT4OzDi2b1Fi3JqRQ6HpyZZ+gywn
         +UZCzVUhZNvWuqdnzNxXM4bRsJeE1eSS8tnxOTUMx2/t6MN7k2idS2QWNmkVWa/w66NG
         yQ/AVA1aDJm/DL0O+01cjluCupsA1erg2PPaJFd5MY5BuRKvpf3vdiz+yo1bLlWRTbiY
         xCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691536423; x=1692141223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aS9+bqGGIGJd4osXg0UNYpwpvIxhiWvvz+QMPQ0Ulo=;
        b=KzQ4jzI8gKGq+k+B3d3+FWtVS++cwPzzOkTwj0POIrHLC/Uf3Q+HuQJcpOkoxx0mHo
         4rSWlN5OJODbmrjvnghiuWYnJfkiXCmgNOp92AK2/x55Tj3QejDmGkHdFO3nWW+7NxKd
         Inb5ZeMzuxpe8ru6LWZO+vfSwREiruAIXHRUWSmD+XSa64P+mQTAp3jtefl7QEmP2ibl
         d2Ugh6uoQztlam0tMBvvsGY5cgd8lG6ub127IYVlN47s7oYRH8Eg0AbCphviST8SuDUT
         FR1zRLmJ39Y6xkiT5pK5rhGp2sww5xpCu6iBeQZo+bbfbrWpIzACpZiqdYeD7LSQc7h2
         6y2Q==
X-Gm-Message-State: AOJu0YwfAfYIIa6mj57aVSKdiz+MGpIuazDnCGbMZ0qB0qhByavsOkXD
        IcP9hRmhZ/NpgZJe/f81d5qxwRsA+aNy
X-Google-Smtp-Source: AGHT+IGN6Wyp+xgEmWlEdpiyTqEz05f+ph0g541H8xJPxC5yzYpq7Xwg2KskI5Za7Uo8sgiAN3njNrOwDHIy
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a5b:890:0:b0:d10:dd00:385 with SMTP id
 e16-20020a5b0890000000b00d10dd000385mr25024ybq.0.1691536423557; Tue, 08 Aug
 2023 16:13:43 -0700 (PDT)
Date:   Tue,  8 Aug 2023 23:13:24 +0000
In-Reply-To: <20230808231330.3855936-1-rananta@google.com>
Mime-Version: 1.0
References: <20230808231330.3855936-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808231330.3855936-9-rananta@google.com>
Subject: [PATCH v8 08/14] arm64: tlb: Implement __flush_s2_tlb_range_op()
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        David Matlack <dmatlack@google.com>,
        Fuad Tabba <tabba@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define __flush_s2_tlb_range_op(), as a wrapper over
__flush_tlb_range_op(), for stage-2 specific range-based TLBI
operations that doesn't necessarily have to deal with 'asid'
and 'tlbi_user' arguments.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/tlbflush.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index b9475a852d5be..93f4b397f9a12 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -340,6 +340,9 @@ do {									\
 	}								\
 } while (0)
 
+#define __flush_s2_tlb_range_op(op, start, pages, stride, tlb_level) \
+	__flush_tlb_range_op(op, start, pages, stride, 0, tlb_level, false)
+
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level,
-- 
2.41.0.640.ga95def55d0-goog

