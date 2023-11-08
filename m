Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292B17E554A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjKHLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbjKHLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:23:42 -0500
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE260212E;
        Wed,  8 Nov 2023 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699442620; x=1730978620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=76x6TGe5VGp4tVKNePmei2SbV9igg1iA9dnaIZiL/jY=;
  b=i97E7MABqSRQDtyaydCEB1rsc8IE0TjnNqrtGQB1JKMxakIFXmg9HS8g
   jyFUBdrAZWZXmYZxbYssDPmL4sN6rRYDGpd98gfbqQyLdKnF+9/vPEEoR
   TBOJVkPyqscHKzBCRwvqr6iUjrR3jar3V9/EfC3amdOV9VW2uN/irtgD3
   U=;
X-IronPort-AV: E=Sophos;i="6.03,286,1694736000"; 
   d="scan'208";a="614866283"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:23:37 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 4CDD76098A;
        Wed,  8 Nov 2023 11:23:36 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:38586]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.103:2525] with esmtp (Farcaster)
 id 9f4672c1-7f67-4ab2-9c06-a6e837041bd2; Wed, 8 Nov 2023 11:23:35 +0000 (UTC)
X-Farcaster-Flow-ID: 9f4672c1-7f67-4ab2-9c06-a6e837041bd2
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:23:35 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 8 Nov 2023 11:23:30 +0000
From:   Nicolas Saenz Julienne <nsaenz@amazon.com>
To:     <kvm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <anelkz@amazon.com>, <graf@amazon.com>, <dwmw@amazon.co.uk>,
        <jgowans@amazon.com>, <corbert@lwn.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <decui@microsoft.com>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [RFC 25/33] KVM: Introduce a set of new memory attributes
Date:   Wed, 8 Nov 2023 11:17:58 +0000
Message-ID: <20231108111806.92604-26-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231108111806.92604-1-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the following memory attributes:
 - KVM_MEMORY_ATTRIBUTE_READ
 - KVM_MEMORY_ATTRIBUTE_WRITE
 - KVM_MEMORY_ATTRIBUTE_EXECUTE
 - KVM_MEMORY_ATTRIBUTE_NO_ACCESS

Note that NO_ACCESS is necessary in order to make a distinction between
the lack of attributes for a gfn, which defaults to the memory
protections of the backing memory, versus explicitly prohibiting any
access to that gfn.

These new memory attributes will, for now, only made be available
through the VSM KVM device (which we introduce in subsequent patches).

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 include/uapi/linux/kvm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index bd97c9852142..6b875c1040eb 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -2314,7 +2314,11 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+#define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
+#define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
+#define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+#define KVM_MEMORY_ATTRIBUTE_NO_ACCESS         (1ULL << 4)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 
-- 
2.40.1

