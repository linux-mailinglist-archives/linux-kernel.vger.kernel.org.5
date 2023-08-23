Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643F784FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjHWFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjHWFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:14:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC97E57
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:14:56 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58de42f9f05so54660177b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692767695; x=1693372495;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3CTb60vp1T1lh9oDcHmIIF0P5J2klG07sdTavTJbf0c=;
        b=CbKL3WxN7ItM+ZH0lQ582XMB0fXou8ULzlR4X7ZUliorGB6Xqq7ZJi1h01bCjXo0Pg
         zjCc8KRb48umQJo/XMu4G0J06YdTbBWZjQ09P/zqq6IHuJKD31E80SIqeqsTXuCFmNbi
         759eGDKtHio0TZ8Py4QcNwsx3uTLSWuShB/AQVwkEiVyI13BSFeBbEi2NmKRJCd0cCRY
         JhvlPzoI2afkJVdRrB9PH6P61QC8j8gENmSshZU6OiwYg9MWVuegwWW8+jZig/vLwNPU
         /RNifRtf36bq/mK85mqs5EL3UbqL8s7prMCQx00kOgnx1KIL3e5cNdD3VtfCJkxFiAgs
         KOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692767695; x=1693372495;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CTb60vp1T1lh9oDcHmIIF0P5J2klG07sdTavTJbf0c=;
        b=M7JMoZGJoO5ip95ADq0ApfT4WAMljvf9aLImuLlWJ5W+r7ZQvmZG9n7nEcVOjQrPO8
         DxN351vM16QFUv0c7oiRornhF3ibHoLlL9uzvDMSrFVcyI8QUIOmpU0xRV0bxs3dc/TZ
         W4zdBquZRmA4zmUJFWx5DUjNtG3DeQ/+rd5urD4Eo+RnbDC44EEBJjVJvBIhVGfZrw9o
         Y2LQZoa9kOidHnMfC2kQkdBiae/Uj5DHCGj5lOclNFMhQT5/LbCwexeQ2jQcmN53mYVd
         mF8p1t6G3ILqdJNiDT20Fwu6dNJ0Eoi9YmnV0JQfXdgbIOlJMwEr6koX24+BZMgu5PIB
         eIKQ==
X-Gm-Message-State: AOJu0Yy/6YOscEqs1B5vzoXProv3HfEQcP+hVbCpm4NYr+Wpo42sNzDP
        Wb4rlUDkyx2RTqfTo/8CgNboIQ==
X-Google-Smtp-Source: AGHT+IEVo6Uw6EP+G7LmxwNxYXkC8mncBJRfLAroWqt/vqp4we0nE9bT4rSu1myGU2RDZUJD898l6w==
X-Received: by 2002:a0d:cc4f:0:b0:589:9717:22c7 with SMTP id o76-20020a0dcc4f000000b00589971722c7mr12539538ywd.22.1692767695505;
        Tue, 22 Aug 2023 22:14:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j80-20020a819253000000b005845e6f9b50sm3182329ywg.113.2023.08.22.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 22:14:55 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:14:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Edward Liaw <edliaw@google.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mm-hotfixes-unstable] shmem: fix smaps BUG sleeping while
 atomic
Message-ID: <6fe3b3ec-abdf-332f-5c23-6a3b3a3b11a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smaps_pte_hole_lookup() is calling shmem_partial_swap_usage() with page
table lock held: but shmem_partial_swap_usage() does cond_resched_rcu()
if need_resched(): "BUG: sleeping function called from invalid context".

Since shmem_partial_swap_usage() is designed to count across a range, but
smaps_pte_hole_lookup() only calls it for a single page slot, just break
out of the loop on the last or only page, before checking need_resched().

Fixes: 230100321518 ("mm/smaps: simplify shmem handling of pte holes")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org # 5.16+
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7a0c1e19d9f8..c512a5e82f8d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -806,14 +806,16 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
 	unsigned long swapped = 0;
+	unsigned long max = end - 1;
 
 	rcu_read_lock();
-	xas_for_each(&xas, page, end - 1) {
+	xas_for_each(&xas, page, max) {
 		if (xas_retry(&xas, page))
 			continue;
 		if (xa_is_value(page))
 			swapped++;
-
+		if (xas.xa_index == max)
+			break;
 		if (need_resched()) {
 			xas_pause(&xas);
 			cond_resched_rcu();
-- 
2.35.3

