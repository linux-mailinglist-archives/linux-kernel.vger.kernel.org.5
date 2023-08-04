Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8DE76F69C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjHDAnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjHDAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:43:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A424215
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:42:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bba5563cd6so13212005ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691109754; x=1691714554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J+mxzLyo3KvL1X1/io+X1OzBSufdvdiiGzpaJwRMhFQ=;
        b=SOX0LmZ7M/i5Xu6IShPkO2I+BxiwZ7/tKfFw/OszRJyMzjeA8srrxfMqCj4Z29VgNn
         T0538ljVhrlqi2oWqsf8SDO/oV45EgP4x4oPafLtiFcA3cCpGCSnbWPlD7O1UBhgOJNe
         iWOEAZPpkZuEI+dl8Vup28taKKrYkoe9EEkFDZdVyWlSSumkRefUTDG/veJy2F6RniEr
         D4CN9ItmtE3GLQpzTfzusmxS7gLu+J3zXqOmaxg3BFTHOgLSHC5+aOpOePxVzXkX7y+j
         40aPvclyhw23NLYArpVti1fhnKJ/y5UqJGdMWPnW2w3RzepQtSrazDZXeGyOlRrMC0eG
         uSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691109754; x=1691714554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+mxzLyo3KvL1X1/io+X1OzBSufdvdiiGzpaJwRMhFQ=;
        b=XFCSILRo7y9GT8x1MZy8twQCQW92YEOFCXdo930T1lY7oVu7PF33Px/j4/WmxqbzBp
         u+lQY8aJl1g2OCA88tUMD4YUmKcvMaDZJoIpoJurwwYOQyqKBUYAj9vHCN9eNRxSiQo5
         sehWEbErLwUJu6G0HMkEnNx7fyHXwsouIHzeZTMpSATquEloVWtDLa9rqKY41oQ1S6eg
         wG/BgosxM1sBV+ew2FitJEMKl8M7CYUzUfHnP/0JgrUGmmSr2/0YzG0iL297Ynl7yaDl
         6K1/veAMmn9Ca3z3NXMHfTIw/TP8KHCW//uxvMC7T/UyaJhfhdH8wGlaSwOZCd1KhHNb
         Yl3g==
X-Gm-Message-State: AOJu0YywOL5AVe8LMKejcmWx8ZcxBWzaohRyqHtDuDDa1yGQZuB6/l1I
        5E4Bkgv50xJ+iO3jZa3FOP44+N2u/Z4=
X-Google-Smtp-Source: AGHT+IHgxmGXjdzVwOxMuN7YUlHLd0HAzkRoLNDux7bwtM6itZt1UHKYVf8WxlurAEE0Phc3A5aSSAIz63w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dad1:b0:1b8:a555:385d with SMTP id
 q17-20020a170902dad100b001b8a555385dmr1165plx.9.1691109754176; Thu, 03 Aug
 2023 17:42:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  3 Aug 2023 17:42:25 -0700
In-Reply-To: <20230804004226.1984505-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230804004226.1984505-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804004226.1984505-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: selftests: Use asserting kvm_ioctl() macros when
 getting ARM page sizes
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

Use kvm_ioctl() instead of open coding equivalent ioctl()+TEST_ASSERT()
calls when getting the support page sizes on ARM.  The macro usage is a
little funky since the "kvm_fd" parameter implies an actual /dev/kvm fd,
but on the other hand the code is invoking KVM ioctl()s.

Alternatively, the core utilities could expose a vm_open()+vm_close()
pair so that the ARM code could create a dummy, on-stack VM+vCPU pair and
use {vm,vcpu}_ioctl() as appropriate.  But the odds of something breaking
due to oddball, partial usage of kvm_vm and kvm_vcpu structures is much
higher than realizing meaningful benefit from using {vm,vcpu}_ioctl().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/aarch64/processor.c      | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 3a0259e25335..afec1a30916f 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -496,7 +496,7 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 				      bool *ps4k, bool *ps16k, bool *ps64k)
 {
 	struct kvm_vcpu_init preferred_init;
-	int kvm_fd, vm_fd, vcpu_fd, err;
+	int kvm_fd, vm_fd, vcpu_fd;
 	uint64_t val;
 	struct kvm_one_reg reg = {
 		.id	= KVM_ARM64_SYS_REG(SYS_ID_AA64MMFR0_EL1),
@@ -504,19 +504,13 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
 	};
 
 	kvm_fd = open_kvm_dev_path_or_exit();
-	vm_fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, (void *)(unsigned long)ipa);
-	TEST_ASSERT(vm_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm_fd));
+	vm_fd = kvm_fd_ioctl(kvm_fd, KVM_CREATE_VM, (void *)(unsigned long)ipa);
+	vcpu_fd = kvm_fd_ioctl(vm_fd, KVM_CREATE_VCPU, (void *)0ul);
 
-	vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
-	TEST_ASSERT(vcpu_fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu_fd));
+	kvm_ioctl(vm_fd, KVM_ARM_PREFERRED_TARGET, &preferred_init);
+	kvm_ioctl(vcpu_fd, KVM_ARM_VCPU_INIT, &preferred_init);
 
-	err = ioctl(vm_fd, KVM_ARM_PREFERRED_TARGET, &preferred_init);
-	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_PREFERRED_TARGET, err));
-	err = ioctl(vcpu_fd, KVM_ARM_VCPU_INIT, &preferred_init);
-	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_ARM_VCPU_INIT, err));
-
-	err = ioctl(vcpu_fd, KVM_GET_ONE_REG, &reg);
-	TEST_ASSERT(err == 0, KVM_IOCTL_ERROR(KVM_GET_ONE_REG, vcpu_fd));
+	kvm_ioctl(vcpu_fd, KVM_GET_ONE_REG, &reg);
 
 	*ps4k = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64MMFR0_TGRAN4), val) != 0xf;
 	*ps64k = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64MMFR0_TGRAN64), val) == 0;
-- 
2.41.0.585.gd2178a4bd4-goog

