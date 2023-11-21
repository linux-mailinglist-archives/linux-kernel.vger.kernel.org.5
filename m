Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB87F7F2D71
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjKUMmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjKULzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:55:46 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431C7121;
        Tue, 21 Nov 2023 03:55:43 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1cc5b705769so48243745ad.0;
        Tue, 21 Nov 2023 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567743; x=1701172543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcIUiVFJ9kNUHsMFbutrGQOUAvjm4DvZ3i9nKoJpoeY=;
        b=ZHQab0DxQkvijR8myKa62GvPPmtvhCNjI6tFcTMF/+ay2HwLWb6gnZJmdlyuV8lwCh
         mTFxzzJbxRVMo4Z48ChrJ4iy5yvGdCCefgYW/nU0zpThdh7MVAXJ5LlMyj9rWb5cIPvw
         Lgl2lD+o+KV15BJORAeWqqsWSkPgYD6+4Shdj7orAHKUpQJkmggVshGzr8uG0vDfIDON
         ad9cQXDfm7vPorFQ/omkehvs/uu/lR73WrOhMVNCR1VAxZ7JtBN1RbjTh388qBOHANpl
         Xlx4NF89wvUNCkB0f6KWRnkfGoiJw9VRqmuYZAxsIasvTHZN4SUTS2MX+gTVI1a+VVQO
         cITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567743; x=1701172543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcIUiVFJ9kNUHsMFbutrGQOUAvjm4DvZ3i9nKoJpoeY=;
        b=bEceUq3yLmwhB/O6wueRKya0S/2D3jmREkbNNKOeQOpC4TPYTxxyArtWXhmqV81EhM
         KDHls3cdSRNDmCEzLazCjpQvoZuE9R301+BfoS5NH9Fu3h84jtRZOnKtbuHLzJu2ow3C
         9+0MPvHSnMVnKccR32dM+W6/ftge2GcsDwKLvuZMhzNnCa6zhftA++8DbJitOxktSR46
         b2Jpp6RrQqO0Wzj0Pu6E6ZTVU3bJ66i4ijKGuJZ9AyjIdfWEKC/rW5CrhVuIC4AOItrL
         Rl0jpSumUBuFYEJnQM4okWXHQyOEp74l3Ryft8okFEbelrzQBwP0DS8T+zQRhRmGxX59
         McCg==
X-Gm-Message-State: AOJu0YzpVADuv6FICXhxUHm0qNJLIGorKtehsgy5VTNfRg1Pfvv9+l89
        Zc4Re4898HabrSky729QUpc=
X-Google-Smtp-Source: AGHT+IETOPDqdGGWx+gtadvWxNkqg1/j3k0Gk8ZaufqAETHs1EWB2OAg0zqi98n2V+xUpD4J0t2h7w==
X-Received: by 2002:a17:902:7244:b0:1cf:665a:925 with SMTP id c4-20020a170902724400b001cf665a0925mr4132100pll.38.1700567742755;
        Tue, 21 Nov 2023 03:55:42 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001cc1dff5b86sm7685431pll.244.2023.11.21.03.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:55:42 -0800 (PST)
From:   Jinrong Liang <ljr.kernel@gmail.com>
X-Google-Original-From: Jinrong Liang <cloudliang@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Jinrong Liang <ljr.kernel@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] KVM: selftests: Add x86 feature and properties for AMD PMU in processor.h
Date:   Tue, 21 Nov 2023 19:54:52 +0800
Message-Id: <20231121115457.76269-5-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121115457.76269-1-cloudliang@tencent.com>
References: <20231121115457.76269-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add x86 feature and properties for AMD PMU so that tests don't have
to manually retrieve the correct CPUID leaf+register, and so that the
resulting code is self-documenting.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index ba16d714b451..250ace4f14b8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -176,6 +176,7 @@ struct kvm_x86_cpu_feature {
  * Extended Leafs, a.k.a. AMD defined
  */
 #define	X86_FEATURE_SVM			KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 2)
+#define	X86_FEATURE_PERFCTR_CORE	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 23)
 #define	X86_FEATURE_NX			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 20)
 #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
 #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
@@ -192,6 +193,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
+#define X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 
 /*
  * KVM defined paravirt features.
@@ -276,6 +278,7 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_MAX_PHY_ADDR		KVM_X86_CPU_PROPERTY(0x80000008, 0, EAX, 0, 7)
 #define X86_PROPERTY_MAX_VIRT_ADDR		KVM_X86_CPU_PROPERTY(0x80000008, 0, EAX, 8, 15)
 #define X86_PROPERTY_PHYS_ADDR_REDUCTION	KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 6, 11)
+#define X86_PROPERTY_PMU_NR_CORE_COUNTERS	KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 0, 3)
 
 #define X86_PROPERTY_MAX_CENTAUR_LEAF		KVM_X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)
 
-- 
2.39.3

