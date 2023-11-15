Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5D7EC0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjKOKsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:48:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E0010F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700045290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sY+7WKoyMMy/V4oZ7M1gjiU0erpOSU8OhEEVrkBYQUU=;
        b=C6rlyFwFnZCmCX21Ng1jeAp4+4woAUIp70bFJ5GyxTrWPZap27rv+iNIm6fhK7FO00rUp0
        josm2tSnTOX99GBVWcXb8Rbh/VfhTPTK6Pb9SOWTQ4VHGtKQ1P2Ktj5H5EsoxuWOSItbhh
        PPBwEoS1/Jv6hY2LkMmsRM3Jlk97Hm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-a2i6MBMUOI-iZjeE1juWsg-1; Wed,
 15 Nov 2023 05:48:06 -0500
X-MC-Unique: a2i6MBMUOI-iZjeE1juWsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4C7229ABA09;
        Wed, 15 Nov 2023 10:48:05 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4637F40C6EB9;
        Wed, 15 Nov 2023 10:48:05 +0000 (UTC)
From:   Shaoqin Huang <shahuang@redhat.com>
To:     kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc:     Shaoqin Huang <shahuang@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: selftests: Clean up the GIC[D,R]_BASE_GPA
Date:   Wed, 15 Nov 2023 05:47:57 -0500
Message-Id: <20231115104757.15710-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC[D,R]_BASE_GPA has been defined in multiple files with the same
value, define it in one place to make the code clean.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 tools/testing/selftests/kvm/aarch64/arch_timer.c   | 3 ---
 tools/testing/selftests/kvm/aarch64/vgic_irq.c     | 3 ---
 tools/testing/selftests/kvm/dirty_log_perf_test.c  | 3 ---
 tools/testing/selftests/kvm/include/aarch64/vgic.h | 3 +++
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 274b8465b42a..818854007bfd 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -59,9 +59,6 @@ static struct test_args test_args = {
 
 #define msecs_to_usecs(msec)		((msec) * 1000LL)
 
-#define GICD_BASE_GPA			0x8000000ULL
-#define GICR_BASE_GPA			0x80A0000ULL
-
 enum guest_stage {
 	GUEST_STAGE_VTIMER_CVAL = 1,
 	GUEST_STAGE_VTIMER_TVAL,
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 2e64b4856e38..a48aff110fb6 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -19,9 +19,6 @@
 #include "gic_v3.h"
 #include "vgic.h"
 
-#define GICD_BASE_GPA		0x08000000ULL
-#define GICR_BASE_GPA		0x080A0000ULL
-
 /*
  * Stores the user specified args; it's passed to the guest and to every test
  * function.
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index d374dbcf9a53..4971e8f77a0a 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -22,9 +22,6 @@
 #ifdef __aarch64__
 #include "aarch64/vgic.h"
 
-#define GICD_BASE_GPA			0x8000000ULL
-#define GICR_BASE_GPA			0x80A0000ULL
-
 static int gic_fd;
 
 static void arch_setup_vm(struct kvm_vm *vm, unsigned int nr_vcpus)
diff --git a/tools/testing/selftests/kvm/include/aarch64/vgic.h b/tools/testing/selftests/kvm/include/aarch64/vgic.h
index 0ac6f05c63f9..9dbb342fd808 100644
--- a/tools/testing/selftests/kvm/include/aarch64/vgic.h
+++ b/tools/testing/selftests/kvm/include/aarch64/vgic.h
@@ -33,4 +33,7 @@ void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu);
 
 #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
 
+#define GICD_BASE_GPA		0x08000000ULL
+#define GICR_BASE_GPA		0x080A0000ULL
+
 #endif // SELFTEST_KVM_VGIC_H
-- 
2.40.1

