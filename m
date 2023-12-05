Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC98050A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376645AbjLEKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjLEKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CBA1BFD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701772684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gK4jXLoCS0bqGNjgQzNnw64KFoSSKVngg1q4fCtnDfA=;
        b=CeimODA5HiwtVBIiWVzRhO3MQHwGkd270ZvqF4fFIYupKC8hNRfa4oF5fn2d12RNF+UQk2
        YKQyicJjpenGaWkcJt5JWfTpkP9NeQSORAvOVcQK2RrR8n+00mO1NMxmGfvYBfjuNl3To5
        GZ6NiyHikMzXBdgVIqmVNoz9hw0Dqsg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-pUCADUVKOrqcI-bkOCOCOQ-1; Tue, 05 Dec 2023 05:37:58 -0500
X-MC-Unique: pUCADUVKOrqcI-bkOCOCOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BA6E85A589;
        Tue,  5 Dec 2023 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2217EC15E6A;
        Tue,  5 Dec 2023 10:37:54 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v4 3/4] KVM: x86: add information about pending requests to kvm_exit tracepoint
Date:   Tue,  5 Dec 2023 12:37:44 +0200
Message-Id: <20231205103745.506724-4-mlevitsk@redhat.com>
In-Reply-To: <20231205103745.506724-1-mlevitsk@redhat.com>
References: <20231205103745.506724-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to gather information on how often kvm interrupts vCPUs due
to specific requests.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/trace.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 28e8a63368cc021..e275a02a21e5233 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -316,12 +316,14 @@ TRACE_EVENT(name,							     \
 		__field(	u32,	        intr_info	)	     \
 		__field(	u32,	        error_code	)	     \
 		__field(	unsigned int,	vcpu_id         )	     \
+		__field(	u64,		requests        )	     \
 	),								     \
 									     \
 	TP_fast_assign(							     \
 		__entry->guest_rip	= kvm_rip_read(vcpu);		     \
 		__entry->isa            = isa;				     \
 		__entry->vcpu_id        = vcpu->vcpu_id;		     \
+		__entry->requests       = READ_ONCE(vcpu->requests);	     \
 		static_call(kvm_x86_get_exit_info)(vcpu,		     \
 					  &__entry->exit_reason,	     \
 					  &__entry->info1,		     \
@@ -331,11 +333,13 @@ TRACE_EVENT(name,							     \
 	),								     \
 									     \
 	TP_printk("vcpu %u reason %s%s%s rip 0x%lx info1 0x%016llx "	     \
-		  "info2 0x%016llx intr_info 0x%08x error_code 0x%08x",	     \
+		  "info2 0x%016llx intr_info 0x%08x error_code 0x%08x "      \
+		  "requests 0x%016llx",					     \
 		  __entry->vcpu_id,					     \
 		  kvm_print_exit_reason(__entry->exit_reason, __entry->isa), \
 		  __entry->guest_rip, __entry->info1, __entry->info2,	     \
-		  __entry->intr_info, __entry->error_code)		     \
+		  __entry->intr_info, __entry->error_code, 		     \
+		  __entry->requests)					     \
 )
 
 /*
-- 
2.26.3

