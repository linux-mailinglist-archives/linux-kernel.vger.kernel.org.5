Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08776F69B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHDAnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjHDAnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:43:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D567F49F5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:42:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bbbc4ae328so12083665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691109750; x=1691714550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TPdXiND7N94yuFEwSbECpKkQfmAanLh9RZ+A6BrvR7M=;
        b=2tZIajDGiYM8LOP6oRS7sIm2pcBnaXfZ7Wymplbdn69KUU8q53NcZ7y0HFK8pN3rJv
         XsgnlEdOHLu6ZqLedVwaja+dve26SOtilLHroxOKcn1gMKyUuqCKj30/Z97mg+qQ0A5R
         3Ikj3Cg1e6W0kaLu9miTZWiHb9zsHokxrA3qv+mc/lCMvO6k2YOsSQj0EFs1erqLxsGU
         3tJpi1uPKeG7pLmg5VlnYlIpw8x0qWFmi2sg4OydjUAuuqTERt756yyvc0gyoig//M6H
         5fTKOOVxD2iGkXDjRyyWPE5G1u+8j6kSj/3rqzdeuj9Xdr5V2hQG6q1B7q16VMnrsqdk
         zf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691109750; x=1691714550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPdXiND7N94yuFEwSbECpKkQfmAanLh9RZ+A6BrvR7M=;
        b=Xu9uRQfdLYOcd4RmRjDP9S8PwYhWjThZSnHP+QHxGoU/k8hTJpxitbVkk2jNTvrPeS
         1CW4fhakKkjDy0otXCQbmLDvjPxJAkdAWpxVopEZIjS3n9CysrM96kSqOR/wWrkbv26p
         IyARcrnRsM2On7QAAjQv+Z3z7PHkdRs0nMECl+h6B4ISOExscbzhW15bxwfig2dP4hmO
         6LZJCmZflwfOMwQ9GCsG1+clEdy7Cp3Bsr1dq5+gnJ1ax4ky2HtwXs3mHgKpU5lT7vdU
         JkWxpLSv4GUSdoGVtBLpYXiDk+tyi2rTBGGDb8RZu86uMiWmn1Wov+DC97Crr19r4NfO
         9XgA==
X-Gm-Message-State: AOJu0YxzIPiveMNUVgsKmAA9oW1dKSQ6uE2aQaFb5U8rLiUPj1XiH/py
        hBuZKgoZXFQTOTK+3taBGXj+vPCFT6Y=
X-Google-Smtp-Source: AGHT+IGxPWjxkWB9Y/JG84vlZ7jPt3zPsnr0k+1ejtlvOppoogL05sX+e7/sQkS50kBaur8MYBj5ozDKMXE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:32d2:b0:1b8:5541:9d4d with SMTP id
 i18-20020a17090332d200b001b855419d4dmr1307plr.6.1691109750368; Thu, 03 Aug
 2023 17:42:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  3 Aug 2023 17:42:23 -0700
In-Reply-To: <20230804004226.1984505-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230804004226.1984505-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804004226.1984505-2-seanjc@google.com>
Subject: [PATCH 1/4] KVM: selftests: Drop the single-underscore ioctl() helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop _kvm_ioctl(), _vm_ioctl(), and _vcpu_ioctl(), as they are no longer
used by anything other than the no-underscores variants (and may have
never been used directly).  The single-underscore variants were never
intended to be a "feature", they were a stopgap of sorts to ease the
conversion to pretty printing ioctl() names when reporting errors.

Opportunistically add a comment explaining when to use __KVM_IOCTL_ERROR()
versus KVM_IOCTL_ERROR().  The single-underscore macros were subtly
ensuring that the name of the ioctl() was printed on error, i.e. it's all
too easy to overlook the fact that using __KVM_IOCTL_ERROR() is
intentional.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 42 +++++++++----------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 07732a157ccd..90b7739ca204 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -227,6 +227,13 @@ static inline bool kvm_has_cap(long cap)
 #define __KVM_SYSCALL_ERROR(_name, _ret) \
 	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
 
+/*
+ * Use the "inner", double-underscore macro when reporting errors from within
+ * other macros so that the name of ioctl() and not its literal numeric value
+ * is printed on error.  The "outer" macro is strongly preferred when reporting
+ * errors "directly", i.e. without an additional layer of macros, as it reduces
+ * the probability of passing in the wrong string.
+ */
 #define __KVM_IOCTL_ERROR(_name, _ret)	__KVM_SYSCALL_ERROR(_name, _ret)
 #define KVM_IOCTL_ERROR(_ioctl, _ret) __KVM_IOCTL_ERROR(#_ioctl, _ret)
 
@@ -239,17 +246,13 @@ static inline bool kvm_has_cap(long cap)
 #define __kvm_ioctl(kvm_fd, cmd, arg)				\
 	kvm_do_ioctl(kvm_fd, cmd, arg)
 
-
-#define _kvm_ioctl(kvm_fd, cmd, name, arg)			\
+#define kvm_ioctl(kvm_fd, cmd, arg)				\
 ({								\
 	int ret = __kvm_ioctl(kvm_fd, cmd, arg);		\
 								\
-	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));	\
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
 })
 
-#define kvm_ioctl(kvm_fd, cmd, arg) \
-	_kvm_ioctl(kvm_fd, cmd, #cmd, arg)
-
 static __always_inline void static_assert_is_vm(struct kvm_vm *vm) { }
 
 #define __vm_ioctl(vm, cmd, arg)				\
@@ -258,16 +261,12 @@ static __always_inline void static_assert_is_vm(struct kvm_vm *vm) { }
 	kvm_do_ioctl((vm)->fd, cmd, arg);			\
 })
 
-#define _vm_ioctl(vm, cmd, name, arg)				\
-({								\
-	int ret = __vm_ioctl(vm, cmd, arg);			\
-								\
-	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));	\
-})
-
 #define vm_ioctl(vm, cmd, arg)					\
-	_vm_ioctl(vm, cmd, #cmd, arg)
-
+({								\
+	int ret = __vm_ioctl(vm, cmd, arg);			\
+								\
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
+})
 
 static __always_inline void static_assert_is_vcpu(struct kvm_vcpu *vcpu) { }
 
@@ -277,15 +276,12 @@ static __always_inline void static_assert_is_vcpu(struct kvm_vcpu *vcpu) { }
 	kvm_do_ioctl((vcpu)->fd, cmd, arg);			\
 })
 
-#define _vcpu_ioctl(vcpu, cmd, name, arg)			\
-({								\
-	int ret = __vcpu_ioctl(vcpu, cmd, arg);			\
-								\
-	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(name, ret));	\
-})
-
 #define vcpu_ioctl(vcpu, cmd, arg)				\
-	_vcpu_ioctl(vcpu, cmd, #cmd, arg)
+({								\
+	int ret = __vcpu_ioctl(vcpu, cmd, arg);			\
+								\
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
+})
 
 /*
  * Looks up and returns the value corresponding to the capability
-- 
2.41.0.585.gd2178a4bd4-goog

