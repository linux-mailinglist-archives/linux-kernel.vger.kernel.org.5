Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F707BFF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJJO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjJJO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:53 -0400
Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD56103
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696948127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lBUz50yRXYSwkMpVqbF4xKRgGKpQYvwhtcgTljx7wmY=;
        b=YUXjCIGKTxNpExiRwy5wj5HYemZEfcJ9ufogB+8cHg/UjkS0SCbQYARvOV3YrvQJ8h+xbz
        Th5rey7xD3OZISdwToRtGiUKbk9WRMhfP9YBFG3zk/ZKVyPJvSt0FCzAdLhCmhLVFpVm/Q
        O+0tz8vCi9Sa5w73oy9N7qPq9/zVhQ8=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] include/uapi/linux/kernel-page-flags.h: define KPF_FOLIO
Date:   Tue, 10 Oct 2023 23:27:57 +0900
Message-Id: <20231010142801.3780917-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Define a new KPF flag to represent folio in /proc/kpageflags and
in-kernel user page-types.c.

Note that in page-types.c I chose 'f' for the character representing folio,
which conflicts with KPF_SOFTDIRTY, but we have no other choice because
all reasonable choices ('f', 'F', 'o', 'O', 'l', 'L', 'i', and 'I') are
already used.  You need to pay attention to long flag names or the position
of 'f' in short form.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/uapi/linux/kernel-page-flags.h | 1 +
 tools/mm/page-types.c                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index 6f2f2720f3ac..9b43dadb7f49 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -36,5 +36,6 @@
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
 #define KPF_PGTABLE		26
+#define KPF_FOLIO		27
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 8d5595b6c59f..b78448d19e88 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -126,6 +126,7 @@ static const char * const page_flag_names[] = {
 	[KPF_PGTABLE]		= "g:pgtable",
 	[KPF_ZERO_PAGE]		= "z:zero_page",
 	[KPF_IDLE]              = "i:idle_page",
+	[KPF_FOLIO]		= "f:folio",
 
 	[KPF_RESERVED]		= "r:reserved",
 	[KPF_MLOCKED]		= "m:mlocked",
-- 
2.25.1

