Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3803A7E5593
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbjKHLbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjKHLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:31:14 -0500
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB311BD5;
        Wed,  8 Nov 2023 03:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699442663; x=1730978663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLo3D2RUMSrAbuSqouFk5tJc54p3vvp1g/yHmuVwsBM=;
  b=NjJluvCsCOrrryqvOqaerCThOkjj/PpkYw8LvGx1ve233rFh0+IfCpxW
   PoywF4AxUXWtszrYkNj8fgDp11qt5QGVFhaP+rxzf/7mmr29gIJb55apl
   9ftHBAnSgUSRs7U+e9gUQRS9VRy/q9gseAHzWCywm08lTRdbl9HSp9/do
   s=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="41962461"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:24:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-00fceed5.us-east-1.amazon.com (Postfix) with ESMTPS id 8D412A0DAB;
        Wed,  8 Nov 2023 11:24:15 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:9042]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.101:2525] with esmtp (Farcaster)
 id ed9999cc-88dc-4223-ba6e-3219e585d98f; Wed, 8 Nov 2023 11:24:14 +0000 (UTC)
X-Farcaster-Flow-ID: ed9999cc-88dc-4223-ba6e-3219e585d98f
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:24:14 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:24:09 +0000
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     <kvm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <anelkz@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
        <jgowans@amazon.com>, <corbert@lwn.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [RFC 28/33] x86/hyper-v: Introduce memory intercept message structure
Date:   Wed, 8 Nov 2023 11:18:01 +0000
Message-ID: <20231108111806.92604-29-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231108111806.92604-1-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce struct hv_memory_intercept_message, which is used when issuing
memory intercepts to a Hyper-V VSM guest.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 76 ++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index af594aa65307..d3d74fde6da1 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -799,6 +799,82 @@ struct hv_get_vp_from_apic_id_in {
 	u32 apic_ids[];
 } __packed;
 
+
+/* struct hv_intercept_header::access_type_mask */
+#define HV_INTERCEPT_ACCESS_MASK_NONE    0
+#define HV_INTERCEPT_ACCESS_MASK_READ    1
+#define HV_INTERCEPT_ACCESS_MASK_WRITE   2
+#define HV_INTERCEPT_ACCESS_MASK_EXECUTE 4
+
+/* struct hv_intercept_exception::cache_type */
+#define HV_X64_CACHE_TYPE_UNCACHED       0
+#define HV_X64_CACHE_TYPE_WRITECOMBINING 1
+#define HV_X64_CACHE_TYPE_WRITETHROUGH   4
+#define HV_X64_CACHE_TYPE_WRITEPROTECTED 5
+#define HV_X64_CACHE_TYPE_WRITEBACK      6
+
+/* Intecept message header */
+struct hv_intercept_header {
+	__u32 vp_index;
+	__u8 instruction_length;
+#define HV_INTERCEPT_ACCESS_READ    0
+#define HV_INTERCEPT_ACCESS_WRITE   1
+#define HV_INTERCEPT_ACCESS_EXECUTE 2
+	__u8 access_type_mask;
+	union {
+		__u16 as_u16;
+		struct {
+			__u16 cpl:2;
+			__u16 cr0_pe:1;
+			__u16 cr0_am:1;
+			__u16 efer_lma:1;
+			__u16 debug_active:1;
+			__u16 interruption_pending:1;
+			__u16 reserved:9;
+		};
+	} exec_state;
+	struct hv_x64_segment_register cs;
+	__u64 rip;
+	__u64 rflags;
+} __packed;
+
+union hv_x64_memory_access_info {
+	__u8 as_u8;
+	struct {
+		__u8 gva_valid:1;
+		__u8 _reserved:7;
+	};
+};
+
+struct hv_memory_intercept_message {
+	struct hv_intercept_header header;
+	__u32 cache_type;
+	__u8 instruction_byte_count;
+	union hv_x64_memory_access_info memory_access_info;
+	__u16 _reserved;
+	__u64 gva;
+	__u64 gpa;
+	__u8 instruction_bytes[16];
+	struct hv_x64_segment_register ds;
+	struct hv_x64_segment_register ss;
+	__u64 rax;
+	__u64 rcx;
+	__u64 rdx;
+	__u64 rbx;
+	__u64 rsp;
+	__u64 rbp;
+	__u64 rsi;
+	__u64 rdi;
+	__u64 r8;
+	__u64 r9;
+	__u64 r10;
+	__u64 r11;
+	__u64 r12;
+	__u64 r13;
+	__u64 r14;
+	__u64 r15;
+} __packed;
+
 #include <asm-generic/hyperv-tlfs.h>
 
 #endif
-- 
2.40.1

