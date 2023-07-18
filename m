Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC707589A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjGRXxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGRXvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:51:37 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C030C5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:50:02 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b89e3715acso32243685ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724158; x=1692316158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AUBNLiIlxTx1F6mRQya+iPZZUvsAoMeHoSeivXTBAJs=;
        b=m1E5CQsRhxPohHIaVjXNzAfw9sKja8GxErI8tb88+m9ohtM/2UTUV4KI0EStxpO4aq
         e3MZZP48Hes3EH+ziFJ16ESLBaMphjB9wBUbLKvQFLpYn2bcEMb9Uv2TfKXvMSlsG4ax
         +5bc2E2M24iRgByLib+vhoObgGZN9pfMuLHGBIbrmouSiZYtP7I+o1+DUjs0jJquORQM
         WZA9ZhPgQfZ0ViRdW+5zM3kLeIAxBI958QaGMn+cpDeKcYSO3MEZRWesl52iNilZN/Ay
         f7w1zt9jHHbnKZaxjQB9PYpmQD1oIBOzEUWtcHD4Ui+04jNinOeJzuhQDL4PbgsMw1sC
         a+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724158; x=1692316158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUBNLiIlxTx1F6mRQya+iPZZUvsAoMeHoSeivXTBAJs=;
        b=kcQhHmxlGSV8FmYLHgvJ5Jd0bYm0AnA5Bu+M9X5hHatGvOH9tJvCOKHWq3tH4eM5HW
         qLnI5uZjOJHytZPPzN+Q0iQN+kzkcj6pr4qUguQZDD/jYxHi7yni0n//6WpZ7lcoxcaw
         MydgtBuRrRTaRu9VKrTBLifkY+P2T4NfiL/w7AtBG/+N6g/nJc4yEhsiE3At1TtXD1IA
         JjAJbyy7u6FGcPwBX1ognTQTqiBP7blMKqQ7RmecxgL7VUwoXcDui8etsaWr6L6A7jgH
         7i3e7lMyUaFoSaKXZ6/ybQ8B5N9p5Vvt3flhzY5TOXkB/36F8VHtsT/kkCXiak8cjfL+
         GEfA==
X-Gm-Message-State: ABy/qLb3veB+p5IIMxAXz3mJN14NlocC7itl2e3PNrBFvD+YV5WVzEhY
        QK5jjG5TN+bOdoJev0OVi0mvTplw93k=
X-Google-Smtp-Source: APBJJlGZj18kUtv2DZbfIQmZu2TXCF9UTMkYGVm3bO/BF1sxl/m3e0941s7v3QsOSVZsOvdKY/T33+qfBEc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c6:b0:1b1:7336:2637 with SMTP id
 o6-20020a170902d4c600b001b173362637mr16836plg.11.1689724157723; Tue, 18 Jul
 2023 16:49:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:45:07 -0700
In-Reply-To: <20230718234512.1690985-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230718234512.1690985-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-25-seanjc@google.com>
Subject: [RFC PATCH v11 24/29] KVM: selftests: Add GUEST_SYNC[1-6] macros for
 synchronizing more data
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/ucall_common.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 1a6aaef5ccae..8087c877fd58 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -46,6 +46,18 @@ void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
 #define GUEST_SYNC(stage)	ucall(UCALL_SYNC, 2, "hello", stage)
+
+#define GUEST_SYNC1(arg0)	ucall(UCALL_SYNC, 1, arg0)
+#define GUEST_SYNC2(arg0, arg1)	ucall(UCALL_SYNC, 2, arg0, arg1)
+#define GUEST_SYNC3(arg0, arg1, arg2) \
+				ucall(UCALL_SYNC, 3, arg0, arg1, arg2)
+#define GUEST_SYNC4(arg0, arg1, arg2, arg3) \
+				ucall(UCALL_SYNC, 4, arg0, arg1, arg2, arg3)
+#define GUEST_SYNC5(arg0, arg1, arg2, arg3, arg4) \
+				ucall(UCALL_SYNC, 5, arg0, arg1, arg2, arg3, arg4)
+#define GUEST_SYNC6(arg0, arg1, arg2, arg3, arg4, arg5) \
+				ucall(UCALL_SYNC, 6, arg0, arg1, arg2, arg3, arg4, arg5)
+
 #define GUEST_DONE()		ucall(UCALL_DONE, 0)
 
 enum guest_assert_builtin_args {
-- 
2.41.0.255.g8b1d071c50-goog

