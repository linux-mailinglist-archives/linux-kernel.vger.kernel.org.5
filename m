Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1192480F852
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377350AbjLLUtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjLLUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:48:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27691FDA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db512266d27so6409844276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414067; x=1703018867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFmE+BG4/EJDZrVEh/xZNdnTy9FeH/PqMcDgQWjrrOU=;
        b=KO1fhvEqSnWjbbd24F9xNUUoNic6nJw5QlWdLiaY2/t6mmt2DuSGLbGWmtuJr2Et1t
         GqhUuBBAwUbG2cj2Xl8vHL2WpJK1O90k9XkTJxyqVAfyVSav/QVBguBih8lZ0qzAoy6U
         Zf0tzH8GCWmg2B3qlzb0ey9zvI446FRhDMCIDgqXpNr9lQfESw6uOeP3wvVfiBFIJbUT
         WUf0PY8RNQ9FZIcCA4emQ9BdMnJOxV0lHMw78fz3SfLxhXDndpnwf+dRgE0dMyFyvbh/
         5CY+5wTN9TQBbv3z2YWFqbECdObzcedrIToGy/BgdPfHvbcqcIy9fv1SudSqcWsmEEox
         RKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414067; x=1703018867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFmE+BG4/EJDZrVEh/xZNdnTy9FeH/PqMcDgQWjrrOU=;
        b=SrHjvZJYsRHz0gdUHkhnrIAoA4xsW6XcElKls+2++IcHkBnTfxk2WYBruJBQndaxwk
         pwzvlZQ4y+x8gG5JlCVSMLNarhkRhMFvbM4x4dmxHO+yXzSzHjMqrPOMt1iEYjy1Wy/1
         iOyO6iqEzGDqAvMNZe+ZVfRVi6OllFTDfvRizKm8pf5LLLWWIrLRQOC+8sdOA2N51d21
         UCsY1xx3mbEUB+jw9YS/1mX2EzSp0zT8eCWkyQP0OVndJOLnwqnmN5UortqrU/xfn422
         Xkms54cHmArz3X67VXSjBQlk6Jbk2LOz9xw2xOSKtq00KwDRTk5ePemKuPUw0fN4ul91
         SzFQ==
X-Gm-Message-State: AOJu0Yx8rAVxcBuKpcVB5zeTtrzkBYbKXDnCcLt92awIf8BwNcKxen8b
        D3dGNf+i4CXjHIGuM+aLzSlvg8Ojsw==
X-Google-Smtp-Source: AGHT+IEfV9mKSOUMKRt6QzMdx4NjK5Xm4g7Lzg/OSBchtLDS9HiwFFeqtcXo/zBjodXwgzfPibVCMzwJXQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a25:d204:0:b0:dbc:cbd9:3cd0 with SMTP id
 j4-20020a25d204000000b00dbccbd93cd0mr566ybg.8.1702414067193; Tue, 12 Dec 2023
 12:47:47 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:46:42 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-28-sagis@google.com>
Subject: [RFC PATCH v5 27/29] KVM: selftests: Propagate KVM_EXIT_MEMORY_FAULT
 to userspace
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to handle KVM_EXIT_MEMORY_FAULT instead of triggering
TEST_ASSERT.

From the KVM_EXIT_MEMORY_FAULT documentation:
Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in that it
accompanies a return code of '-1', not '0'!  errno will always be set to EFAULT
or EHWPOISON when KVM exits with KVM_EXIT_MEMORY_FAULT, userspace should assume
kvm_run.exit_reason is stale/undefined for all other error numbers.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d024abc5379c..8fb041e51484 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1742,6 +1742,10 @@ void vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int ret = _vcpu_run(vcpu);
 
+	// Allow this scenario to be handled by the caller.
+	if (ret == -1 && errno == EFAULT)
+		return;
+
 	TEST_ASSERT(!ret, KVM_IOCTL_ERROR(KVM_RUN, ret));
 }
 
-- 
2.43.0.472.g3155946c3a-goog

