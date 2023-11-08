Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4A7E52C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjKHJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjKHJlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:41:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC0199
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699436458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NyFFI+QLTn/KCY41JKK+/gb0GFQOellCsquJKsgSF6E=;
        b=KOAUZlhOHY14IpwxsJMhu8Bw0LQRlVM7ZK3YQXVDRS4bBuqRIVS4s2O5yRETgOACGo+gu1
        PFlZ6LlpEhBuHvWBUXoCkorCrsof3dF/YEbvFwo3wLx02bIFu1Mm5OL+l0J4cey7Dq/Dv/
        2FUO8AdnzWUXz87P/7GTs2TJkqR5BbI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-5G49vdi4MKGlCodbOb3dYQ-1; Wed,
 08 Nov 2023 04:40:56 -0500
X-MC-Unique: 5G49vdi4MKGlCodbOb3dYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B9031C06EC1;
        Wed,  8 Nov 2023 09:40:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C8B740C6EB9;
        Wed,  8 Nov 2023 09:40:56 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH] selftests: kvm/s390x: use vm_create_barebones()
Date:   Wed,  8 Nov 2023 04:40:55 -0500
Message-Id: <20231108094055.221234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function does the same but makes it clearer why one would use
the "____"-prefixed version of vm_create().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/s390x/cmma_test.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
index c8e0a6495a63..626a2b8a2037 100644
--- a/tools/testing/selftests/kvm/s390x/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
@@ -94,11 +94,6 @@ static void guest_dirty_test_data(void)
 	);
 }
 
-static struct kvm_vm *create_vm(void)
-{
-	return ____vm_create(VM_MODE_DEFAULT);
-}
-
 static void create_main_memslot(struct kvm_vm *vm)
 {
 	int i;
@@ -157,7 +152,7 @@ static struct kvm_vm *create_vm_two_memslots(void)
 {
 	struct kvm_vm *vm;
 
-	vm = create_vm();
+	vm = vm_create_barebones();
 
 	create_memslots(vm);
 
@@ -276,7 +271,7 @@ static void assert_exit_was_hypercall(struct kvm_vcpu *vcpu)
 
 static void test_migration_mode(void)
 {
-	struct kvm_vm *vm = create_vm();
+	struct kvm_vm *vm = vm_create_barebones();
 	struct kvm_vcpu *vcpu;
 	u64 orig_psw;
 	int rc;
@@ -670,7 +665,7 @@ struct testdef {
  */
 static int machine_has_cmma(void)
 {
-	struct kvm_vm *vm = create_vm();
+	struct kvm_vm *vm = vm_create_barebones();
 	int r;
 
 	r = !__kvm_has_device_attr(vm->fd, KVM_S390_VM_MEM_CTRL, KVM_S390_VM_MEM_ENABLE_CMMA);
-- 
2.39.1

