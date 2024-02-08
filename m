Return-Path: <linux-kernel+bounces-58680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3A84E9E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE271F2D978
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3F4F89F;
	Thu,  8 Feb 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bs/wKA6e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EED4F889
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425341; cv=none; b=C8mgxS1tJ76BpzYHChxSx3FX/+XqWaGMdnjxy/862VWW+kYxvBE/k1IqYtktx+L7JwJTA9qs3nTQshMZ5WwLqm1zxSY2F8hMN28V8jnclasUMoSv7KZ9/cTPh/Vsh9wt4FdM60+as/njBXYbx1QSXxM6y+jowdCMRnmKshNRB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425341; c=relaxed/simple;
	bh=VI7qXJxS/lasyNThrbyjvkzs+3R4P9ZKyEkXMk7ilKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1G7vmO+CaKTF5vA3Btvr/4dvKIlcF0eeMojhBJCe3/Du+96hqIMOlwyRGFeUck841GZamEu0OrAR0mwJFFoiRThVqYleFEamU+o4LS+1hYAN9BGzUJsmhqI/3YB8mZFIIeWDNbFWovXcpVURrnmN8Tez+gPMvHlnSx1QIOFLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bs/wKA6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBTElX16WHnJ/uasV+kMXYqDLGTcdRCMmjiGOz8erC0=;
	b=Bs/wKA6eiGTfNTIosnLpIs/XPLgk0MVJ56tVjXaqH7CJxkRHZG39IvkWXl+w8oRyvPmweK
	/ftJFOLDFHbp4Gcm4XpxDObX4uQJhA2W5vLlYlAEo6lrkev7Zb1/L5TENQ22jIh1aurws9
	mA8jbIFHQtpYSv5Qy6GxctHb/uHWLZs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-Fdy4qd_EMbOwjBSIVnuhwQ-1; Thu,
 08 Feb 2024 15:48:56 -0500
X-MC-Unique: Fdy4qd_EMbOwjBSIVnuhwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7D211C05141;
	Thu,  8 Feb 2024 20:48:55 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 856C91C10C0E;
	Thu,  8 Feb 2024 20:48:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 4/8] KVM: selftests: Add a macro to define a test with one vcpu
Date: Thu,  8 Feb 2024 21:48:40 +0100
Message-ID: <20240208204844.119326-5-thuth@redhat.com>
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
References: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Most tests are currently not giving any proper output for the user
to see how much sub-tests have already been run, or whether new
sub-tests are part of a binary or not. So it would be good to
support TAP output in the KVM selftests. There is already a nice
framework for this in the kselftest_harness.h header which we can
use. But since we also need a vcpu in most KVM selftests, it also
makes sense to introduce our own wrapper around this which takes
care of creating a VM with one vcpu, so we don't have to repeat
this boilerplate in each and every test. Thus let's introduce
a KVM_ONE_VCPU_TEST() macro here which takes care of this.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/Y2v+B3xxYKJSM%2FfH@google.com/
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/include/kvm_test_harness.h  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/kvm_test_harness.h

diff --git a/tools/testing/selftests/kvm/include/kvm_test_harness.h b/tools/testing/selftests/kvm/include/kvm_test_harness.h
new file mode 100644
index 0000000000000..8f7c6858e8e2d
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/kvm_test_harness.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Macros for defining a KVM test
+ *
+ * Copyright (C) 2022, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_TEST_HARNESS_H
+#define SELFTEST_KVM_TEST_HARNESS_H
+
+#include "kselftest_harness.h"
+
+#define KVM_ONE_VCPU_TEST_SUITE(name)					\
+	FIXTURE(name) {							\
+		struct kvm_vcpu *vcpu;					\
+	};								\
+									\
+	FIXTURE_SETUP(name) {						\
+		(void)vm_create_with_one_vcpu(&self->vcpu, NULL);	\
+	}								\
+									\
+	FIXTURE_TEARDOWN(name) {					\
+		kvm_vm_free(self->vcpu->vm);				\
+	}
+
+#define KVM_ONE_VCPU_TEST(suite, test, guestcode)			\
+static void __suite##_##test(struct kvm_vcpu *vcpu);			\
+									\
+TEST_F(suite, test)							\
+{									\
+	vcpu_arch_set_entry_point(self->vcpu, guestcode);		\
+	__suite##_##test(self->vcpu);					\
+}									\
+static void __suite##_##test(struct kvm_vcpu *vcpu)
+
+#endif /* SELFTEST_KVM_TEST_HARNESS_H */
-- 
2.43.0


