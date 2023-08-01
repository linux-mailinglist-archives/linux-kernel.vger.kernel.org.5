Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4D276C0A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjHAXFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjHAXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:05:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A8E61
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:05:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so6370175276.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690931134; x=1691535934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lOE510A+r2SLKIiF63zcAdgP6ekXGYyGQOz9dKOk6xM=;
        b=oykWRz0UvoWkHbMJ4JcV2bJNVGfHj4zIiBnJtx63aKkLAy6kg9qQMbD7+1jLlv7IFd
         VrHAJma/Eq0svEihuDhUE7kQXOCMuCSI0o8tIiWe7B2X0KZsdFU12oq9GJDLBL7PSEN8
         0Z7q6ykZx9xGSShNvxrNhG0j0I/kwdceref5gVQTRrZ9b6vaf9Fg7+blFmDQ4/QY4d9g
         7lVpy1PXiImwfgBxul4u5JylRrPA9bWCmejtPePjWKQN9sl8lt9g6wykdHmyH2lpTqoF
         oxgvXhxnOpsg+TB4fKlBpM7Wk69dkXgj3x9oxH8BmJlHx2QeALFUwF0fAa+Bx4E6ouSb
         eTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690931134; x=1691535934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOE510A+r2SLKIiF63zcAdgP6ekXGYyGQOz9dKOk6xM=;
        b=lNAHuJVkLL0q8cZCIAWj6uzqBLqLyT16su9c1R3BcKyylxmJzNemNsviwyaEC6oLG1
         3EXvGcUeF9nAb0aBXGta527bMXd2IMIqRPw2KFynB2YRC0z+GkITCnd++TPW4Ug1w2k8
         NpOpAYhDnao2OBTvHIIQTluxxYJB0FR3lwSeQjgDzD1DRdIFcNkrw8odhP/AGqLF+rU2
         qk73sVJXJWecKFznYNKsMtSZbUuYLOzMQaESUjOlq0VOTTjAaYWqyKUV4n3AecBLN2JD
         z2rZcnnT9PKaNaERbk3mcR1iIjtJrdNc8INmKaKeo/NxI3mMQwlk9M8lFVOtLT14xDEc
         ENrw==
X-Gm-Message-State: ABy/qLaMn7EHzQJIDUxdACiCd4msetShp20iY0sX05uN5Zu2U+1gaw/t
        AjIodbDDB8oAlCVLY+qOLgAKaZKrhak=
X-Google-Smtp-Source: APBJJlHn1e4ri559tI6+3xb+Npi5fhlcyuFCEAVF9xRaO+W0uxQM7JO0odUJ8x7oUL++20OucTcpgdatf0E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2057:0:b0:c41:4696:e879 with SMTP id
 g84-20020a252057000000b00c414696e879mr85006ybg.7.1690931133875; Tue, 01 Aug
 2023 16:05:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  1 Aug 2023 16:05:21 -0700
In-Reply-To: <20230729013535.1070024-7-seanjc@google.com>
Mime-Version: 1.0
References: <20230729013535.1070024-7-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801230520.1509954-2-seanjc@google.com>
Subject: [PATCH v4.1] drm/i915/gvt: Explicitly check that vGPU is attached
 before shadowing
From:   Sean Christopherson <seanjc@google.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check that a vGPU is attached from is_2MB_gtt_possible() all the
way up to shadow_ppgtt_mm() to avoid unnecessary work, and to make it more
obvious that a future cleanup of is_2MB_gtt_possible() isn't introducing a
bug.

is_2MB_gtt_possible() has only one caller, ppgtt_populate_shadow_entry(),
and all paths in ppgtt_populate_shadow_entry() eventually check for
attachment by way of intel_gvt_dma_map_guest_page().

And of the paths that lead to ppgtt_populate_shadow_entry(),
shadow_ppgtt_mm() is the only one that doesn't already check for
INTEL_VGPU_STATUS_ACTIVE or INTEL_VGPU_STATUS_ATTACHED.

  workload_thread() <= pick_next_workload() => INTEL_VGPU_STATUS_ACTIVE
  |
  -> dispatch_workload()
     |
     |-> prepare_workload()
         |
         -> intel_vgpu_sync_oos_pages()
         |  |
         |  |-> ppgtt_set_guest_page_sync()
         |      |
         |      |-> sync_oos_page()
         |          |
         |          |-> ppgtt_populate_shadow_entry()
         |
         |-> intel_vgpu_flush_post_shadow()
             |
  1:         |-> ppgtt_handle_guest_write_page_table()
                 |
                 |-> ppgtt_handle_guest_entry_add()
                     |
  2:                 | -> ppgtt_populate_spt_by_guest_entry()
                     |    |
                     |    |-> ppgtt_populate_spt()
                     |        |
                     |        |-> ppgtt_populate_shadow_entry()
                     |            |
                     |            |-> ppgtt_populate_spt_by_guest_entry() [see 2]
                     |
                     |-> ppgtt_populate_shadow_entry()

  kvmgt_page_track_write()  <= KVM callback => INTEL_VGPU_STATUS_ATTACHED
  |
  |-> intel_vgpu_page_track_handler()
      |
      |-> ppgtt_write_protection_handler()
          |
          |-> ppgtt_handle_guest_write_page_table_bytes()
              |
              |-> ppgtt_handle_guest_write_page_table() [see 1]

Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v4.1:

 - Actually make the code do what the changelog says. [Yan]
 - Fix a typo in the changelog. [Yan]

 drivers/gpu/drm/i915/gvt/gtt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 5426a27c1b71..de6a484090d7 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1163,8 +1163,6 @@ static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
 		return 0;
 
-	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
-		return -EINVAL;
 	pfn = gfn_to_pfn(vgpu->vfio_device.kvm, ops->get_pfn(entry));
 	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
@@ -1827,6 +1825,9 @@ static int shadow_ppgtt_mm(struct intel_vgpu_mm *mm)
 	if (mm->ppgtt_mm.shadowed)
 		return 0;
 
+	if (!test_bit(INTEL_VGPU_STATUS_ATTACHED, vgpu->status))
+		return -EINVAL;
+
 	mm->ppgtt_mm.shadowed = true;
 
 	for (index = 0; index < ARRAY_SIZE(mm->ppgtt_mm.guest_pdps); index++) {

base-commit: 03e8f77e106ba1d2fd980f8b38339dad33333a07
-- 
2.41.0.585.gd2178a4bd4-goog

