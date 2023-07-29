Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66205767AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjG2BgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbjG2Bf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:35:57 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A54B3C22
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:35:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c79a5565aso1694072a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690594554; x=1691199354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tz4uZaQVsPCslkoe6oa8SQY3RtzZLjpuGTuCE1x/oxo=;
        b=rnGsAGmCsCVkvzk/4CeEhRS1uhNwHejWNQjYMUjzvZ9b23PXZzLzHQ7iKvpLO1Zm5o
         sEcAHLrTsKB5yVIPzAw8RrH5ORymgpPHAiDM/Xt64Kov2IqERUDoqTcOGXvoUfc0u6QZ
         X447SLnRfwc80YMR7mIfaKfWAMT5mvZyKlEiZnQwjTwDCpRahtP32ZcYRt0CvZz8E8v4
         t+00GUoSXANKgzpGij7yjEmTxBvUqSswKC0SsnODhH6NFOjVBdboK2rHspDOAzwSQjkg
         IDf0q+2jpzHxwTOMoB02hlRckExnus6yP9NdAAWtZPE/Leok5f6GGdwTeP7Yu3zaGG/L
         0eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690594554; x=1691199354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tz4uZaQVsPCslkoe6oa8SQY3RtzZLjpuGTuCE1x/oxo=;
        b=EyRkZwGpnXwiyVYrDJpN4M4TbMnGgSA/XwEyrjIG4yxs3Ygyu2RVQbUGTEC71zT+D1
         KIo5BDPdqjxKEg1giYQQ8QAgxJKy2jydX0kkmsyd0OO6r1p5y2El0iVuvpiQvHm2JANQ
         T9wPllMxGiofLGEUa93m86Qks57Rv6OUT8deBHvEDH3pKdEpaRh5WoFtw1m73GnuZIy3
         2qtGx/jEn+GncFjPVgky9Nz0nvVdVSSaCQC2p0HGlooBAm2jrdyG3epvyW+XYkZ1gqEK
         KYhw1t+hwux9z6LU1+BRqiHbdPFCHgIH1pblWqq74LJNuf8mWRxjqvVHUF2xlmZX66lS
         zntg==
X-Gm-Message-State: ABy/qLbdm6/2i2LbnldI4Afx+mmNPa9Z1EGV8c7v/OOegDjv+EScM5B9
        IDJoZjgKSfqMrNJx7OEn/nbxIx1Zkbs=
X-Google-Smtp-Source: APBJJlFTmYd3lxACjYxVtuqT/iV7PakjZr1YHFf1k1mB2XIV8e9HvgrPxsj425QqhvZ8l6epZt90DIBSddM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5c1:b0:1b7:edcd:8dcf with SMTP id
 u1-20020a170902e5c100b001b7edcd8dcfmr14524plf.4.1690594553462; Fri, 28 Jul
 2023 18:35:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:35:11 -0700
In-Reply-To: <20230729013535.1070024-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729013535.1070024-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729013535.1070024-6-seanjc@google.com>
Subject: [PATCH v4 05/29] drm/i915/gvt: Put the page reference obtained by
 KVM's gfn_to_pfn()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Yongwei Ma <yongwei.ma@intel.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put the struct page reference acquired by gfn_to_pfn(), KVM's API is that
the caller is ultimately responsible for dropping any reference.

Note, kvm_release_pfn_clean() ensures the pfn is actually a refcounted
struct page before trying to put any references.

Fixes: b901b252b6cf ("drm/i915/gvt: Add 2M huge gtt support")
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index f30922c55a0c..5426a27c1b71 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1158,6 +1158,7 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 {
 	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	kvm_pfn_t pfn;
+	int ret;
 
 	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
 		return 0;
@@ -1171,7 +1172,9 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	if (!pfn_valid(pfn))
 		return -EINVAL;
 
-	return PageTransHuge(pfn_to_page(pfn));
+	ret = PageTransHuge(pfn_to_page(pfn));
+	kvm_release_pfn_clean(pfn);
+	return ret;
 }
 
 static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
-- 
2.41.0.487.g6d72f3e995-goog

