Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19D767B1F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbjG2Bgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbjG2Bg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:36:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328E49D5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:36:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584375eacacso27056177b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690594561; x=1691199361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/2DXbiQb11naI17RMd9UQ+SDW96I3DO0Ug1YMgWLfXI=;
        b=N/Xuo31FD/HpJ/r+aiswhIOdyyLh/aqswWM/9gDeiWpXkOdw/BybOvDSugphjjH8vY
         czkCQ+tWVfw/K0ROTwpFPjyoZ51Hk33bVR6kSeUS5Q07NBHU+9puAFJWpliJC7Kcnsgw
         DFvz5oS/ppK6Pc7hv2pMJ+KN22NAhA7ZjuxoVq5Zi9bmUdnU0M+QCo2g8xsLagNC4PKy
         saSZeaXWNfeMQ5IHCoKm13WWjRyS4qfzbr2FQrD2W4y2GkvB0Xbs2lZZrrJ+f/6Os44D
         CcefGXGMTcsMhro4vMfe22toBHH+4FqzhGk8KS/5pO5Cd3dH/EcnHrsxFwYJ1GujncZ1
         /cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690594561; x=1691199361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2DXbiQb11naI17RMd9UQ+SDW96I3DO0Ug1YMgWLfXI=;
        b=iYSnffQ2sFBAjGu2z3fnFF+Iv7jxeFXapcAXCrmoS9R7zHRumA3x7c2hv5CyubDDFd
         5pWKaiA5fRtESolVlynr3O0KXg8GzKQixrirUKTl+b51Ujto7TfKll3jRWFrZbwcmaC3
         ZWGmto1962eY3teRU+HnX7JNW4LiMrm0yNzgiXpXnzJvpj3mOSo3s1+67RNJwiuxQ11G
         Q3GQaN+yq8ybjc7nCguPCWANGdFmptfxRzOZMubPPnJQ3ozRbc1Uj+jk3pvL0YGeaKcs
         tvGEJsekcPM25b+iQ0G6TiST7baxFfFkwKN3vpWP8ZjYAsAk6Gw9Ut1JlwprVLVBHfdl
         7K/Q==
X-Gm-Message-State: ABy/qLYvNJMYPomyjP6KGYc8d6Vtm4LJlEdbnl+pwV5a9CjsmyCMMYxS
        CExAOxPpCF9xhM/vx7dZTGKu7UWD6nk=
X-Google-Smtp-Source: APBJJlHjJijCc55w0wljCYyBWJLS5e6GQQI49bMEWRqbhx7NrZHhLmDEmMDXWNJlzx+OwSHEGbtvbQN0Kcs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ae13:0:b0:576:9519:7085 with SMTP id
 m19-20020a81ae13000000b0057695197085mr24135ywh.7.1690594561504; Fri, 28 Jul
 2023 18:36:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:35:15 -0700
In-Reply-To: <20230729013535.1070024-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729013535.1070024-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729013535.1070024-10-seanjc@google.com>
Subject: [PATCH v4 09/29] drm/i915/gvt: Use an "unsigned long" to iterate over
 memslot gfns
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

Use an "unsigned long" instead of an "int" when iterating over the gfns
in a memslot.  The number of pages in the memslot is tracked as an
"unsigned long", e.g. KVMGT could theoretically break if a KVM memslot
larger than 16TiB were deleted (2^32 * 4KiB).

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 97c6d3c53710..6f52886c4051 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1620,7 +1620,7 @@ static void kvmgt_page_track_flush_slot(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		struct kvm_page_track_notifier_node *node)
 {
-	int i;
+	unsigned long i;
 	gfn_t gfn;
 	struct intel_vgpu *info =
 		container_of(node, struct intel_vgpu, track_node);
-- 
2.41.0.487.g6d72f3e995-goog

