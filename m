Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7267AA535
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjIUWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjIUWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:50:24 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552B6585C3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c40ac5b6e7so11371695ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328418; x=1695933218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pekGycpm690ftEnzP10xe6Ye5goWUg/PNLNn/FLDQrU=;
        b=lwSNIm63R+7w1SGh93pi7J7uo6VBJm+uY9BngSBpoYHuLRB1GwdCJ7SWRCejttudXa
         ThCTZ+h2tE/t/XM3gNkIreJrE6CjrLT4MeO5waQTOpIbIirJ958HB0ItsrXXUAhkK3pz
         6+j2P74GJCOqjsYqPrVPu2z25l34HXWg1Fr7d7Ub7xY9E1PGz43Rmplcd45u3ml5LZ8J
         Gc/KittbcQLNdF4Ctn3YV4aorSEWHg0epHChNlB1R59rDpndkyVrdmRogZp556tzw/8B
         6U5czBzwMrasMbHvuB6OeEWhkMco9dQg2/jFPlwO7ePqYf3JHivzvTKbdPKDLrnvAsXU
         uyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328418; x=1695933218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pekGycpm690ftEnzP10xe6Ye5goWUg/PNLNn/FLDQrU=;
        b=Uas5/zbHSmNeRkpivWyOkg+cW5EQopM+75DicCWV1Hs7uG46RKCVH5H3pB/Y5N6ILd
         n/hRoz48JifMZBZy6idKlgKYBHj+iFyZVwm3sdU3kM3S2Gmy2qX1poRqWFGGkyPzZwhz
         XEgW60KKCnilSXJ8jy7elT2ApzOpTdY2As3iJB+2e5bQ9BNbQsnH+NUAGyKvS3o7c3g2
         cGZRYW3yPqzOvY5Q/GhM1wKracY807SLMhVaeQ+dPHRzK1vWydeWPG5ze3H0nTlVU9hL
         AxyelhzM5BaIWeRO6Y+GdKmkNsJBlDg6wpewW5Ta6vRQPpXIsMKMYWD6wfd8JX+/SLjQ
         rxVg==
X-Gm-Message-State: AOJu0YywB/I4KgRXKqgHCT0auAKHIwK5PXHxhfXmJi9d9U1W1pWzI6QB
        f0KWN9Mf2OWzs9xzLslTuW5xEjv40Sc=
X-Google-Smtp-Source: AGHT+IEF4UT19Y0uaQX2IVlYHJIurtmC15TJZ1HuZVfkpN+vNSXFUmg/Of1RoXtQbwOKngdV2kpar7enry4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c945:b0:1c5:a79f:8ebb with SMTP id
 i5-20020a170902c94500b001c5a79f8ebbmr85481pla.6.1695328417821; Thu, 21 Sep
 2023 13:33:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Sep 2023 13:33:19 -0700
In-Reply-To: <20230921203331.3746712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230921203331.3746712-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921203331.3746712-3-seanjc@google.com>
Subject: [PATCH 02/13] KVM: Actually truncate the inode when doing PUNCH_HOLE
 for guest_memfd
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>,
        Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the call to truncate_inode_pages_range() in guest_memfd's handling
of PUNCH_HOLE that was unintentionally removed in a rebase gone bad.

Reported-by: Michael Roth <michael.roth@amd.com>
Fixes: 1d46f95498c5 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_mem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index a819367434e9..3c9e83a596fe 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -140,10 +140,13 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	 */
 	filemap_invalidate_lock(inode->i_mapping);
 
-	list_for_each_entry(gmem, gmem_list, entry) {
+	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_begin(gmem, start, end);
+
+	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+
+	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_end(gmem, start, end);
-	}
 
 	filemap_invalidate_unlock(inode->i_mapping);
 
-- 
2.42.0.515.g380fc7ccd1-goog

