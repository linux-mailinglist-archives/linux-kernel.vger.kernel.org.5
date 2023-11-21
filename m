Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F967F345B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjKUQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKUQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD792
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700585962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=te+7SJJrn2ZP2JBi0ktcZa5AVQEsIzQSk/RVCYrsUho=;
        b=O31llLHJbVXNWCjJQY/AypIFKk5f9i4f5XKv1GPMiz8rUwCNBXP/rB28KhwO6R9wM9I4dh
        THlUV8PJwx8dcnQImyBcBNDZCm9WY+2iuPS/v/JVuojXiuAzG93ZIUofTihO/ExRfq8v6f
        bRSJKZRYEjTzEF9mrVu8BAyzudNkjSM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-GeD7BnVpNNiKB6tUoXHLsA-1; Tue,
 21 Nov 2023 11:59:16 -0500
X-MC-Unique: GeD7BnVpNNiKB6tUoXHLsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E1051C07597;
        Tue, 21 Nov 2023 16:59:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31BB61C060AE;
        Tue, 21 Nov 2023 16:59:16 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [PATCH] selftests/kvm: fix compilation on non-x86_64 platforms
Date:   Tue, 21 Nov 2023 11:59:15 -0500
Message-Id: <20231121165915.1170987-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MEM_REGION_SLOT and MEM_REGION_GPA are not really needed in
test_invalid_memory_region_flags; the VM never runs and there are no
other slots, so it is okay to use slot 0 and place it at address
zero.  This fixes compilation on architectures that do not
define them.

Fixes: 5d74316466f4 ("KVM: selftests: Add a memory region subtest to validate invalid flags", 2023-11-14)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 1efee1cfcff0..6637a0845acf 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -349,8 +349,8 @@ static void test_invalid_memory_region_flags(void)
 		if ((supported_flags & BIT(i)) && !(v2_only_flags & BIT(i)))
 			continue;
 
-		r = __vm_set_user_memory_region(vm, MEM_REGION_SLOT, BIT(i),
-						MEM_REGION_GPA, MEM_REGION_SIZE, NULL);
+		r = __vm_set_user_memory_region(vm, 0, BIT(i),
+						0, MEM_REGION_SIZE, NULL);
 
 		TEST_ASSERT(r && errno == EINVAL,
 			    "KVM_SET_USER_MEMORY_REGION should have failed on v2 only flag 0x%lx", BIT(i));
@@ -358,16 +358,16 @@ static void test_invalid_memory_region_flags(void)
 		if (supported_flags & BIT(i))
 			continue;
 
-		r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, BIT(i),
-						 MEM_REGION_GPA, MEM_REGION_SIZE, NULL, 0, 0);
+		r = __vm_set_user_memory_region2(vm, 0, BIT(i),
+						 0, MEM_REGION_SIZE, NULL, 0, 0);
 		TEST_ASSERT(r && errno == EINVAL,
 			    "KVM_SET_USER_MEMORY_REGION2 should have failed on unsupported flag 0x%lx", BIT(i));
 	}
 
 	if (supported_flags & KVM_MEM_GUEST_MEMFD) {
-		r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT,
+		r = __vm_set_user_memory_region2(vm, 0,
 						 KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_GUEST_MEMFD,
-						 MEM_REGION_GPA, MEM_REGION_SIZE, NULL, 0, 0);
+						 0, MEM_REGION_SIZE, NULL, 0, 0);
 		TEST_ASSERT(r && errno == EINVAL,
 			    "KVM_SET_USER_MEMORY_REGION2 should have failed, dirty logging private memory is unsupported");
 	}
-- 
2.39.1

