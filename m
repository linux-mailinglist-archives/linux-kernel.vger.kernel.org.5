Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731AC80F855
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377373AbjLLUtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjLLUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:48:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5515C1BDD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daee86e2d70so6839872276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414062; x=1703018862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZdQqVk39iJlhBpyUnh6sf+6Hw3ATYVfrr1vi3AMJYE=;
        b=mtpFjSLqKP9FQ+2PgecqAf3DHWIAPOQF2s/DwxfYT7RTWLBqTk2vuzBQ7RV6Uwi0nm
         JzwTkNEFOCIZvJoS8qYa7VUyAhy88hyg12THsWeP/p52LvmZz7znMXUqM7ORnKfnZ62m
         UxPdO3//KctHbVTIBOmMvor22gRA2wOuCsJHc0DJ0uc37RgJ0/wiyxfGow8HT4CSjCxA
         DkTmTcu5s4Ts+MbCKFPoOFZZfW9+U62jTkdktM0RQuPdn8wdtdl55LSlhotMvs/lQ07e
         CAY7K96Du6ZcOkqdlcW/+oLDosm9PKfmaOBPzTjm2+HIoUHqB1HaXmLruGDzDg5x2SVM
         grFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414062; x=1703018862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZdQqVk39iJlhBpyUnh6sf+6Hw3ATYVfrr1vi3AMJYE=;
        b=Op51A+S4EH+MXAxYUoXMR4nGA6uh3uhzcIJDlIXz7fTPLSZtblfrCQsTLfmn4TiFK/
         GCDMxxQBJg4ZEYP8aD5oT9ig0oqHy5hS54R+oiOiPiCYSRpj73ZEgcjx5pJWlpEv8Ggu
         UQm+feO5mPhDBSM4A4usZ2d9sXMjwG/v1+7zBz1/ysIrsK1j+pSrGA/gTnx1+i37P5Ww
         yPZi8BhxHmhYFmbrYVrVwKy92ELrAnNCXsxG2OvGxI1APONHpnZ3+r6XZ0aYJazt+yfv
         miBmb4q2dfmJGEYv8hgyVV9ucd3MhEmFHQbQ5BAuxSwvQ4Nr0N4JGL95+LdJspgOGfYB
         ibZA==
X-Gm-Message-State: AOJu0YxD9TKqcrKip1ATpyY8FSqoEqSTNlo8bE2XXJpm/NkV2/cLX9sk
        GvTeEdqOb1ycT+Vh+/D3yhPtmuNd2w==
X-Google-Smtp-Source: AGHT+IH9RTDsHLGt6TFEaMhulg0Kd1/ZUyxFq2VWB91JPo3oRoRjEYyJ0UXRvW/aN3iOVxrGFxYaEUsQOw==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a25:9e90:0:b0:db3:fa34:50b0 with SMTP id
 p16-20020a259e90000000b00db3fa3450b0mr51580ybq.4.1702414061971; Tue, 12 Dec
 2023 12:47:41 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:39 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-25-sagis@google.com>
Subject: [RFC PATCH v5 24/29] KVM: selftests: Expose _vm_vaddr_alloc
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org,
        Ackerley Tng <ackerleytng@google.com>,
        Ryan Afranji <afranji@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Roger Wang <runanwang@google.com>,
        Vipin Sharma <vipinsh@google.com>, jmattson@google.com,
        dmatlack@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ackerley Tng <ackerleytng@google.com>

vm_vaddr_alloc always allocates memory in memslot 0. This allows users
of this function to choose which memslot to allocate virtual memory
in.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c          | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index efd7ae8abb20..5dbebf5cfd07 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -561,6 +561,9 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 void vm_populate_vaddr_bitmap(struct kvm_vm *vm);
 vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
+			      vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+			      uint32_t data_memslot, bool encrypt);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 28780fa1f0f2..d024abc5379c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1410,9 +1410,9 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  * a unique set of pages, with the minimum real allocation being at least
  * a page.
  */
-static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
-				     vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
-				     uint32_t data_memslot, bool encrypt)
+vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
+			      vm_vaddr_t vaddr_min, vm_paddr_t paddr_min,
+			      uint32_t data_memslot, bool encrypt)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
-- 
2.43.0.472.g3155946c3a-goog

