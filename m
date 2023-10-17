Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EEF7CB7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjJQAvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJQAvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0993D9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697503858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GO2d9NWO0GoUyOwGcMRCtNHLdBdqp9AanbpVwqLlSTc=;
        b=RZesrRwlH2dF4gHlSlF9TG4yKslLjYP2ziajUwLWas6E/S+NE/dtkgODNozjUjzN4Wtw+Y
        fl0HKo9vkCrQIMaJ1OaT/pi9iKQ4RQyoe/dC7fZmFI4Z5jnmgxjcAjpuVObLj8P8fH0Emd
        cZ1u4oWPI8D8JuzLEik3fDBPtFpiyaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-VaYN-kyEOza8WvxkLKatPQ-1; Mon, 16 Oct 2023 20:50:53 -0400
X-MC-Unique: VaYN-kyEOza8WvxkLKatPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08672185A790;
        Tue, 17 Oct 2023 00:50:53 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 647F640C6F79;
        Tue, 17 Oct 2023 00:50:50 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64: Remove system_uses_lse_atomics()
Date:   Tue, 17 Oct 2023 10:50:36 +1000
Message-ID: <20231017005036.334067-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two variants of system_uses_lse_atomics(), depending on
CONFIG_ARM64_LSE_ATOMICS. The function isn't called anywhere when
CONFIG_ARM64_LSE_ATOMICS is disabled. It can be directly replaced
by alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS) when the kernel
option is enabled.

No need to keep system_uses_lse_atomics() and just remove it.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/lse.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
index cbbcdc35c4cd..3129a5819d0e 100644
--- a/arch/arm64/include/asm/lse.h
+++ b/arch/arm64/include/asm/lse.h
@@ -16,14 +16,9 @@
 #include <asm/atomic_lse.h>
 #include <asm/cpucaps.h>
 
-static __always_inline bool system_uses_lse_atomics(void)
-{
-	return alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS);
-}
-
 #define __lse_ll_sc_body(op, ...)					\
 ({									\
-	system_uses_lse_atomics() ?					\
+	alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS) ?		\
 		__lse_##op(__VA_ARGS__) :				\
 		__ll_sc_##op(__VA_ARGS__);				\
 })
@@ -34,8 +29,6 @@ static __always_inline bool system_uses_lse_atomics(void)
 
 #else	/* CONFIG_ARM64_LSE_ATOMICS */
 
-static inline bool system_uses_lse_atomics(void) { return false; }
-
 #define __lse_ll_sc_body(op, ...)		__ll_sc_##op(__VA_ARGS__)
 
 #define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
-- 
2.41.0

