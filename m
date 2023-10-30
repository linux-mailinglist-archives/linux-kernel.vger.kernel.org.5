Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC24B7DBB95
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjJ3ORh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjJ3ORf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:17:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C9BC0;
        Mon, 30 Oct 2023 07:17:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B59E521906;
        Mon, 30 Oct 2023 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698675451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JL0o6ejOmiqyX7RlEJrZ7RAI8Gjvf0EzzlogCece80k=;
        b=Wjl2lgZqWUg/a9AE3QuJHK6+NDQzHMDQTy31U33Llwff6vIw9Uw3qZJEK6BBLQK7obO/sZ
        t2Mtq/tO6UUvCOg2E8yhcLo1TzdTXF2lTFc0SzApsN+9MC+1pLb4PGPjwQK+Xh8b3RevrF
        dn4G3KmXXo2GEKtZOC/O72raxnLbkZw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66803138F8;
        Mon, 30 Oct 2023 14:17:31 +0000 (UTC)
Received: from dovecot-director1.suse.de ([192.168.254.64])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jifVFvu6P2VsOgAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Mon, 30 Oct 2023 14:17:31 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     seanjc@google.com
Cc:     pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] KVM: x86: User mutex guards to eliminate __kvm_x86_vendor_init()
Date:   Mon, 30 Oct 2023 16:17:28 +0200
Message-Id: <20231030141728.1406118-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current separation between (__){0,1}kvm_x86_vendor_init() is superfluos as
the the underscore version doesn't have any other callers.

Instead, use the newly added cleanup infrastructure to ensure that
kvm_x86_vendor_init() holds the vendor_module_lock throughout its
exectuion and that in case of error in the middle it's released. No
functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/kvm/x86.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 41cce5031126..cd7c2d0f88cb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9446,11 +9446,13 @@ static void kvm_x86_check_cpu_compat(void *ret)
 	*(int *)ret = kvm_x86_check_processor_compatibility();
 }
 
-static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
+int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 {
 	u64 host_pat;
 	int r, cpu;
 
+	guard(mutex)(&vendor_module_lock);
+
 	if (kvm_x86_ops.hardware_enable) {
 		pr_err("already loaded vendor module '%s'\n", kvm_x86_ops.name);
 		return -EEXIST;
@@ -9580,17 +9582,6 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	kmem_cache_destroy(x86_emulator_cache);
 	return r;
 }
-
-int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
-{
-	int r;
-
-	mutex_lock(&vendor_module_lock);
-	r = __kvm_x86_vendor_init(ops);
-	mutex_unlock(&vendor_module_lock);
-
-	return r;
-}
 EXPORT_SYMBOL_GPL(kvm_x86_vendor_init);
 
 void kvm_x86_vendor_exit(void)
-- 
2.34.1

