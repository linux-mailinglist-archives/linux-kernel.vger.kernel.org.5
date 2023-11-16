Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4467EE82E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbjKPUQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjKPUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6389E131
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700165755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVI0G/o2WVlv6Ps9x/muR3n3l0/Wk8HAmms0O3t+e7A=;
        b=HSAVCuIL2t2DIYS831ApH1+gEOYQlD8DqMveKP01DunmehYWIFpNZfofwQbQSu291ND2cT
        tpZaY24vWxpGwIHOTAI0tdQleBFj5NXh8nms2vfljz5b2+4plg81qROn6t0Q7alBbXd1ZU
        xvJGD+rIMou1o8SwnrqPn+MRpNAgWzk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-HvXjgfiSOzOKR2awrTdG0Q-1; Thu, 16 Nov 2023 15:15:53 -0500
X-MC-Unique: HvXjgfiSOzOKR2awrTdG0Q-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77a02ceef95so18075885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165753; x=1700770553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVI0G/o2WVlv6Ps9x/muR3n3l0/Wk8HAmms0O3t+e7A=;
        b=TfLa/imSRczWOZpalZyVQcnsiHc7mBJSsFhsp4mngLpN0vdNdFVhv+3HYmRd6lz9S3
         xMfYZ0Xa+fVku6dpxoNcXRcp/YcXCvvcTpJNuAxDjz3sA6KxL+Ru6UryTVgou0mvz85F
         GSYJRhfJjol2gRG+/ustFekZaG7yC5Q6hc0pgaELiVbSW4yqYXHIWvjMxkR7hsOYGKuj
         yHLAxwhphp9BUNSg7T2rk5EcdI9DuNjWnGbjVcKtDFs4b6580P74Ag7pscLBHdphXmIc
         ZPQE0KeL7/XCKmxJU+Y02hEQUoKMeD1XcqB4MaORvZ0k8ApGL5AY5oviVlQ3jsMk/U6l
         +tDA==
X-Gm-Message-State: AOJu0Yz/0uF7AGf2BERCNcBFkzbvt7ThIR4pW8JTY2a6+U9MPhnmyC9M
        N1ky+TbZDO1Hif32v0OTkubOK5uBYCQx7WruQumDoVhBuxFTYcyeDP6g7GDLCZz1S+nTwOE6Ms/
        6N+0mx8qskHsOxaBx/osIGQyR
X-Received: by 2002:a05:620a:bd3:b0:772:5300:1c3d with SMTP id s19-20020a05620a0bd300b0077253001c3dmr9471538qki.0.1700165753215;
        Thu, 16 Nov 2023 12:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6NhVg5ATijtU5gZAjIsSdXlgC1Wv7DJob8yOxfAJNeWszVXZfkcVZW+Oo0riZTR5pk+BEJA==
X-Received: by 2002:a05:620a:bd3:b0:772:5300:1c3d with SMTP id s19-20020a05620a0bd300b0077253001c3dmr9471523qki.0.1700165752989;
        Thu, 16 Nov 2023 12:15:52 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b19-20020a05620a271300b007659935ce64sm65524qkp.71.2023.11.16.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 12:15:52 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com
Subject: [PATCH 2/3] mm/pagemap: Fix wr-protect even if PM_SCAN_WP_MATCHING not set
Date:   Thu, 16 Nov 2023 15:15:46 -0500
Message-ID: <20231116201547.536857-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116201547.536857-1-peterx@redhat.com>
References: <20231116201547.536857-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new pagemap ioctl contains a fast path for wr-protections without
looking into category masks.  It forgets to check PM_SCAN_WP_MATCHING
before applying the wr-protections.  It can cause, e.g., pte markers
installed on archs that do not even support uffd wr-protect.

WARNING: CPU: 0 PID: 5059 at mm/memory.c:1520 zap_pte_range mm/memory.c:1520 [inline]

Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")
Reported-by: syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e91085d79926..d19924bf0a39 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2171,7 +2171,7 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 		return 0;
 	}
 
-	if (!p->vec_out) {
+	if ((p->arg.flags & PM_SCAN_WP_MATCHING) && !p->vec_out) {
 		/* Fast path for performing exclusive WP */
 		for (addr = start; addr != end; pte++, addr += PAGE_SIZE) {
 			if (pte_uffd_wp(ptep_get(pte)))
-- 
2.41.0

