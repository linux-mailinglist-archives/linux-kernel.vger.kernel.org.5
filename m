Return-Path: <linux-kernel+bounces-20959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF88287CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA181C2428A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBA39FFD;
	Tue,  9 Jan 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpbQntHn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17239AEC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704809490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaLjeKjKaXvkCYG3XZyStpbWPQkFTJ1s4eXSvcd81Xc=;
	b=hpbQntHnEXYV5hdjYqIYMAhiRI6+UGgz7S3VANIIirlKpgozJjeR2avJ4rTFCIuRgLckk5
	bVTUTtk0dM1+G8dFxsy1g5eg1WKd21nVs3CSI+UeYg/RzBjpepwX0LV86a6BfD580zfPPk
	NEnXixEbuyR4QZLU4XCRpq9P6HLK1Fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-6aYvM4ATNmqCQSQLTwRDlg-1; Tue, 09 Jan 2024 09:11:26 -0500
X-MC-Unique: 6aYvM4ATNmqCQSQLTwRDlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DEA386C049;
	Tue,  9 Jan 2024 14:11:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A22CE51E3;
	Tue,  9 Jan 2024 14:11:24 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Oliver Upton <oupton@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] KVM: selftests: Use generic sys_clocksource_is_tsc() in vmx_nested_tsc_scaling_test
Date: Tue,  9 Jan 2024 15:11:18 +0100
Message-ID: <20240109141121.1619463-3-vkuznets@redhat.com>
In-Reply-To: <20240109141121.1619463-1-vkuznets@redhat.com>
References: <20240109141121.1619463-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Despite its name, system_has_stable_tsc() just checks that system
clocksource is 'tsc'; this can now be done with generic
sys_clocksource_is_tsc().

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index e710b6e7fb38..93b0a850a240 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -116,23 +116,6 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
-static bool system_has_stable_tsc(void)
-{
-	bool tsc_is_stable;
-	FILE *fp;
-	char buf[4];
-
-	fp = fopen("/sys/devices/system/clocksource/clocksource0/current_clocksource", "r");
-	if (fp == NULL)
-		return false;
-
-	tsc_is_stable = fgets(buf, sizeof(buf), fp) &&
-			!strncmp(buf, "tsc", sizeof(buf));
-
-	fclose(fp);
-	return tsc_is_stable;
-}
-
 int main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
@@ -148,7 +131,7 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
-	TEST_REQUIRE(system_has_stable_tsc());
+	TEST_REQUIRE(sys_clocksource_is_tsc());
 
 	/*
 	 * We set L1's scale factor to be a random number from 2 to 10.
-- 
2.43.0


