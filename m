Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A497CB7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjJQAyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjJQAyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F7AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697503998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FVYfxxgypJNUOYWqlo9r89JsXo7lPpAWq0cYDAv2yF0=;
        b=grk8m27yD4tWdX6vOHhkHP5j4831qJR5viSoPxpG8inE6NO0x2HtHuvDKkSYmWEstXO/R4
        8Cp59cMn7mTw4E8nqFVUbuw4Ak0NkfP6mKWogvz8x4IiC5i3PKTJGZjfR8YdvSspr+/fAc
        1y6poJKk2P3bygLJzB4CAC97243XsH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-i2a4zPEuMQ6T_suWUDgpzw-1; Mon, 16 Oct 2023 20:53:13 -0400
X-MC-Unique: i2a4zPEuMQ6T_suWUDgpzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA2C5185A795;
        Tue, 17 Oct 2023 00:53:12 +0000 (UTC)
Received: from gshan.redhat.com (unknown [10.64.136.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32E1840C6F79;
        Tue, 17 Oct 2023 00:53:09 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, ryan.roberts@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64: mm: Validate CONFIG_PGTABLE_LEVELS conditionally
Date:   Tue, 17 Oct 2023 10:53:00 +1000
Message-ID: <20231017005300.334140-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's allowed for the fixmap virtual address space to span multiple
PMD entries. Instead, the address space isn't allowed to span multiple
PUD entries. However, PMD entries are folded to PUD and PGD entries
in the following combination. In this particular case, the validation
on NR_BM_PMD_TABLES should be avoided.

  CONFIG_ARM64_PAGE_SHIFT = 14
  CONFIG_ARM64_VA_BITS_36 = y
  CONFIG_PGTABLE_LEVELS   = 2

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/mm/fixmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c0a3301203bd..5384e5c3aeaa 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -18,10 +18,11 @@
 
 #define NR_BM_PTE_TABLES \
 	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
+#if CONFIG_PGTABLE_LEVELS > 2
 #define NR_BM_PMD_TABLES \
 	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PUD_SHIFT)
-
 static_assert(NR_BM_PMD_TABLES == 1);
+#endif
 
 #define __BM_TABLE_IDX(addr, shift) \
 	(((addr) >> (shift)) - (FIXADDR_TOT_START >> (shift)))
-- 
2.41.0

