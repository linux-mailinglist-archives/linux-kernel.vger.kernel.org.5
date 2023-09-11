Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D588C79A12A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjIKCQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjIKCQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:16:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF019C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:16:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c336f5b1ffso32267545ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694398610; x=1695003410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD7OvstxKA2joN48f33NVGVEMdOf8iSPumL3dY1BcYQ=;
        b=KpzPGRTPJIOXslaJubNz4CHsx8oC1BP8q7hW3MovPQRg2n7pXN+BEfMf6OH/FtPMp2
         Z8ERzb26RnE3ayc38bR/QC7kXjCkv4Y5RJgzgOAyc6kW2npk/0EenUsoGrjOPpV+kK7S
         QxsF4LsSiQ4VioT0KRLxUQX87NZHQuOVy7X5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694398610; x=1695003410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xD7OvstxKA2joN48f33NVGVEMdOf8iSPumL3dY1BcYQ=;
        b=dd899DSSFFQoevJ9jTBhRwdt7/pt2S0rz8laL81UkHWFgJI3uZfHaEd2aREYnxl0VH
         rr9FgZStaOSinCSEevc3BnxJ30TqSnduZM8CPakVpbma5r8WbBDDw3vzpU17tvX/Ez+B
         og/8lEaQeurkRwTq5TCV/NciouKeZQaO6x6TSRwBhEH3C1/fSHhk87GY60bgH3rxM41h
         CSEde/u3gpWdRGBZx/6omzMMo7wR2rSvldHrs5e3G8gR9lbqJt55ZNz4tt7gmVu10BRB
         wKHoFpBBbdoB+2l1/jfGJfGnLDCsNVwYJHftcNOBrLswW+vC/zEU7OJuRSSL//FeMAAb
         dsSg==
X-Gm-Message-State: AOJu0Yw3xEqPShkTyZ1ZJs3B2aPXAG/ZSgB4UaQrHtay2nrc9n2IGPcI
        egODkldNu8pxXkA0A1hMbL/1iw==
X-Google-Smtp-Source: AGHT+IFy++BuFNruJ3+F43z5nLA2htPWCJELp/lRQsizzfJXm9VzGe4L5Ti1kzq6zJIZvRm4jK0CGg==
X-Received: by 2002:a17:903:228d:b0:1c3:9aaf:97be with SMTP id b13-20020a170903228d00b001c39aaf97bemr5233193plh.56.1694398610653;
        Sun, 10 Sep 2023 19:16:50 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:282a:59c8:cc3a:2d6])
        by smtp.gmail.com with UTF8SMTPSA id x12-20020a1709028ecc00b001b8a897cd26sm5162528plo.195.2023.09.10.19.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 19:16:50 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v9 1/6] KVM: Assert that a page's refcount is elevated when marking accessed/dirty
Date:   Mon, 11 Sep 2023 11:16:31 +0900
Message-ID: <20230911021637.1941096-2-stevensd@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230911021637.1941096-1-stevensd@google.com>
References: <20230911021637.1941096-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Assert that a page's refcount is elevated, i.e. that _something_ holds a
reference to the page, when KVM marks a page as accessed and/or dirty.
KVM typically doesn't hold a reference to pages that are mapped into the
guest, e.g. to allow page migration, compaction, swap, etc., and instead
relies on mmu_notifiers to react to changes in the primary MMU.

Incorrect handling of mmu_notifier events (or similar mechanisms) can
result in KVM keeping a mapping beyond the lifetime of the backing page,
i.e. can (and often does) result in use-after-free.  Yelling if KVM marks
a freed page as accessed/dirty doesn't prevent badness as KVM usually
only does A/D updates when unmapping memory from the guest, i.e. the
assertion fires well after an underlying bug has occurred, but yelling
does help detect, triage, and debug use-after-free bugs.

Note, the assertion must use page_count(), NOT page_ref_count()!  For
hugepages, the returned struct page may be a tailpage and thus not have
its own refcount.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d63cf1c4f5a7..ee6090ecb1fe 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2914,6 +2914,19 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
 
 static bool kvm_is_ad_tracked_page(struct page *page)
 {
+	/*
+	 * Assert that KVM isn't attempting to mark a freed page as Accessed or
+	 * Dirty, i.e. that KVM's MMU doesn't have a use-after-free bug.  KVM
+	 * (typically) doesn't pin pages that are mapped in KVM's MMU, and
+	 * instead relies on mmu_notifiers to know when a mapping needs to be
+	 * zapped/invalidated.  Unmapping from KVM's MMU must happen _before_
+	 * KVM returns from its mmu_notifier, i.e. the page should have an
+	 * elevated refcount at this point even though KVM doesn't hold a
+	 * reference of its own.
+	 */
+	if (WARN_ON_ONCE(!page_count(page)))
+		return false;
+
 	/*
 	 * Per page-flags.h, pages tagged PG_reserved "should in general not be
 	 * touched (e.g. set dirty) except by its owner".
-- 
2.42.0.283.g2d96d420d3-goog

