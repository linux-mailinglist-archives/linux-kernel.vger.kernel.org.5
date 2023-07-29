Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC5767AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbjG2Bf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjG2Bfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:35:52 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731BC3C12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:35:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584139b6b03so27878337b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690594549; x=1691199349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jEX944Eq3FR7IMm0zyV2J78IA1pYMR7a1LBZmsndkp4=;
        b=EusHJXExcAmxW94p+Y+WzpBoXgOHGapVubepNLVe1AjQFq4L5DyiXFwSfT7lAKZP2B
         LbstAlazYFqIHYNHWE9V6nKli4q5Y0K2fyfD216QZG3evAmQp6EgzhArMOhsjP2D0ElV
         B6qwPZ9a/i9In0E55fHIM4mb9ugp3zYDctkxuHsv6F88IcOYAE2VED+v+Lk/ZmoPYG/2
         lkQCY3PhAbTRH+u8Ae/SnMEwzw13MNUKDcBi0qG4LXNUvbTFAvrgKXodpE6AzSf38TDQ
         sMQJ+cT1fMFi0cUz1wu0ff5mLmSDncQAQiHhjP1MSwt+Xyt6OmHxozc9Cly/LUlxpBCN
         YceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690594549; x=1691199349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEX944Eq3FR7IMm0zyV2J78IA1pYMR7a1LBZmsndkp4=;
        b=fO3DfKCJ4T9TWX2k4HHwSnlVqw7d1GEsDZeZ0B+CUVY7hRkAPI+Ms4aej18Y38etwF
         K7bLzWT/mAXuLY2A+laiqbpCE16VEXOG2Gqp/RBLQyPCArrJldNE06AGtI5koRl9gGYa
         AntKFd/0dAv4+I2HDgWIQ+o4ZXGE/957ZTbIpGclMT1WCi/l5o4AX8wxqIXSUZ0JX8y4
         Pr6AFKtgIhu7bd5m7CpLCvHoWfqoTCrHC1tb+/7OytV+RHf1eIGxw42LC+9QFNiyRuo1
         jWf8Uy3k9I2kMxaaZ44O0OsD7/l8QaGCh+gbXaV9kiHsHSj8Wb5tCmeiBWOrXfOneyCV
         iF0g==
X-Gm-Message-State: ABy/qLZhmRZjFoEBq1CPvBa/Vyl7O1xAqB/5p6ZWJHccCvUwB48jo7Vb
        rScI+4I4mjdeF4NVeQR8d/5Z/l3Svao=
X-Google-Smtp-Source: APBJJlHaMJ266s4owvydBsGasNevM0zaMSoOGKTU1pN9RjVzgaKXC6MzhQvAdGBBorhN1PRis7f6VXl7qB0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af03:0:b0:583:9db4:6c20 with SMTP id
 n3-20020a81af03000000b005839db46c20mr22745ywh.1.1690594549610; Fri, 28 Jul
 2023 18:35:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 18:35:09 -0700
In-Reply-To: <20230729013535.1070024-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729013535.1070024-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729013535.1070024-4-seanjc@google.com>
Subject: [PATCH v4 03/29] drm/i915/gvt: Verify hugepages are contiguous in
 physical address space
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

When shadowing a GTT entry with a 2M page, verify that the pfns are
contiguous, not just that the struct page pointers are contiguous.  The
memory map is virtual contiguous if "CONFIG_FLATMEM=y ||
CONFIG_SPARSEMEM_VMEMMAP=y", but not for "CONFIG_SPARSEMEM=y &&
CONFIG_SPARSEMEM_VMEMMAP=n", so theoretically KVMGT could encounter struct
pages that are virtually contiguous, but not physically contiguous.

In practice, this flaw is likely a non-issue as it would cause functional
problems iff a section isn't 2M aligned _and_ is directly adjacent to
another section with discontiguous pfns.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index de675d799c7d..429f0f993a13 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -161,7 +161,7 @@ static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 
 		if (npage == 0)
 			base_page = cur_page;
-		else if (base_page + npage != cur_page) {
+		else if (page_to_pfn(base_page) + npage != page_to_pfn(cur_page)) {
 			gvt_vgpu_err("The pages are not continuous\n");
 			ret = -EINVAL;
 			npage++;
-- 
2.41.0.487.g6d72f3e995-goog

