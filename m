Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686B87F8942
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjKYIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjKYId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:33:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F61B2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700901244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37TsTYXqNHIurQZSI6nP6/rFe+8uy0S4I2sdRSNsCA0=;
        b=HJZoy4TFwsSlkfNj5t+rT8wY7NxVDiE8BUmvTbaKCnzDKS+IAPS7bsnYlYgAieKvTahgfQ
        c4QJREBt8Wnib362U3WJX/AXOrH0h2k30DxqZsRFV2hVv3Yw62CcZYhQq19VV6hczKl1CI
        HV1wlMhTHeJ8VUSAVhlgECKTqy3UWbo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-ekSR8i3BPkK372lj5BasCw-1; Sat, 25 Nov 2023 03:34:02 -0500
X-MC-Unique: ekSR8i3BPkK372lj5BasCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAD6A82BA81;
        Sat, 25 Nov 2023 08:34:01 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8B081121306;
        Sat, 25 Nov 2023 08:34:01 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, mlevitsk@redhat.com
Subject: [PATCH v2 4/4] KVM: x86/mmu: fix comment about mmu_unsync_pages_lock
Date:   Sat, 25 Nov 2023 03:34:00 -0500
Message-Id: <20231125083400.1399197-5-pbonzini@redhat.com>
In-Reply-To: <20231125083400.1399197-1-pbonzini@redhat.com>
References: <20231125083400.1399197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the comment about what can and cannot happen when mmu_unsync_pages_lock
is not help.  The comment correctly mentions "clearing sp->unsync", but then
it talks about unsync going from 0 to 1.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1cb81573a60b..a71b8813febe 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2840,9 +2840,9 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 			/*
 			 * Recheck after taking the spinlock, a different vCPU
 			 * may have since marked the page unsync.  A false
-			 * positive on the unprotected check above is not
+			 * negative on the unprotected check above is not
 			 * possible as clearing sp->unsync _must_ hold mmu_lock
-			 * for write, i.e. unsync cannot transition from 0->1
+			 * for write, i.e. unsync cannot transition from 1->0
 			 * while this CPU holds mmu_lock for read (or write).
 			 */
 			if (READ_ONCE(sp->unsync))
-- 
2.39.1

