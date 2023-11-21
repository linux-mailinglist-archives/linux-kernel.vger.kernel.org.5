Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86B7F2C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjKUL4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjKUL4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:56:02 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4F5112;
        Tue, 21 Nov 2023 03:55:56 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6c34e87b571so4378434b3a.3;
        Tue, 21 Nov 2023 03:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700567756; x=1701172556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOxT43FDAQ5Xr6ouV6ennVtlCzo8xO0nJHSFrJt6nz4=;
        b=IiVajqij9UsYMMk6Oje17e96U1r4I6l3nsFCYF0apFiNfDb2iGPB8Z2T51iV6tuV6R
         lHQJH+TnZGeDtqh69sVN/QD7yYSQQtd9gjAWK1Bwk4rVHrtwp0q44SOp28gyaAVLZ02V
         ThhbWwol0acelCHY3kkJRAujF/Al1QShCddgidYNn93Mnk9wRmMwercan+7IWtsSeH4U
         acxo33Brr3LF8y7h/8i6GxRvOZZf+X7huq0kCpfsB4zPoO95vNhZI98oAvD7cwmQ8C3b
         gTFOoxCFPznic2no255GoYRng9/uJFzpqHI8Z4VRDR5qzgJYLoqvjo0lQdpr+ZqR+oLd
         ZHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700567756; x=1701172556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOxT43FDAQ5Xr6ouV6ennVtlCzo8xO0nJHSFrJt6nz4=;
        b=n5mzJhwkHc2yGjkP+mWq+vlS1TsblBsLccrML9z3TWtSegjwJm0Fipu0c2naPLnj07
         eW8bhrgvDJpwM/2yUDh+nW2bv04wilWQjOEBKJ1M/p63aobJXLk+UMRymZRypReJ9gm0
         bfQDThcmMZ9u3zNOUUQSqKewrbxjF+tG4Eo1D3OTULtpghH3NJCZ2Dz7xvc+savjujCb
         3NTw3s+XXc+Uqu+aEMmFBY2sLNL8S1rG8ideQiXkLDHj8o3XES8yl7G2bqqoth3S/ExT
         ZAAPnEXUf1yRfR8tPKsMMWsDuFlCTCgEeMRmRP+kK+5s5xUHsnMnnG9L7ZiMqNyPyPkQ
         9Gww==
X-Gm-Message-State: AOJu0YzmVvKkHCUFrycpBMVltcT3tn4NbidBAxeLI5wpRZ3FbvEkWyvY
        rOrliIP7V7NurG4/gfGpHO4=
X-Google-Smtp-Source: AGHT+IFghql4Rbf15JDxeEuYt95Vz/RngIzBoF2uPGTDd8wm25ZtSEbNG//EtMwT/wDjrcARhRrgBg==
X-Received: by 2002:a05:6a20:9f89:b0:187:f549:e2e7 with SMTP id mm9-20020a056a209f8900b00187f549e2e7mr11003353pzb.7.1700567756010;
        Tue, 21 Nov 2023 03:55:56 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902740a00b001cc1dff5b86sm7685431pll.244.2023.11.21.03.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:55:55 -0800 (PST)
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
Subject: [PATCH 9/9] KVM: selftests: Test AMD Guest PerfMonV2
Date:   Tue, 21 Nov 2023 19:54:57 +0800
Message-Id: <20231121115457.76269-10-cloudliang@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121115457.76269-1-cloudliang@tencent.com>
References: <20231121115457.76269-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinrong Liang <cloudliang@tencent.com>

Add test case for AMD Guest PerfMonV2.

Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index ca5b352ea6ae..aa44f2282996 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -722,6 +722,38 @@ static void set_amd_counters(uint8_t *nr_amd_ounters, uint64_t *ctrl_msr,
 	}
 }
 
+static void guest_test_amd_perfmonv2(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < AMD64_NR_COUNTERS_CORE; i++) {
+		wrmsr(MSR_F15H_PERF_CTL0 + i * 2, 0);
+		wrmsr(MSR_F15H_PERF_CTR0 + i * 2, ARCH_PERFMON_EVENTSEL_OS |
+		      ARCH_PERFMON_EVENTSEL_ENABLE | AMD_ZEN_CORE_CYCLES);
+
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+		GUEST_ASSERT(!_rdpmc(i));
+
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, BIT_ULL(i));
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+		GUEST_ASSERT(_rdpmc(i));
+
+		wrmsr(MSR_F15H_PERF_CTL0 + i * 2, (1ULL << 48) - 2);
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, 0xff);
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, BIT_ULL(i));
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+		GUEST_ASSERT(rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS) &
+			     BIT_ULL(i));
+
+		wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, BIT_ULL(i));
+		GUEST_ASSERT(!(rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS) &
+			     BIT_ULL(i)));
+	}
+}
+
 static void guest_test_amd_counters(void)
 {
 	bool guest_pmu_is_perfmonv2 = this_cpu_has(X86_FEATURE_PERFMON_V2);
@@ -747,6 +779,9 @@ static void guest_test_amd_counters(void)
 		}
 	}
 
+	if (guest_pmu_is_perfmonv2)
+		guest_test_amd_perfmonv2();
+
 	GUEST_DONE();
 }
 
-- 
2.39.3

