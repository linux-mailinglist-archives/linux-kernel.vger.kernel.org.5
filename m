Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8AC7E7727
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjKJCOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjKJCNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:13:45 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4E49CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2801b74012bso1710881a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582412; x=1700187212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xR4tNxv+g07FJHlmB9dj3yDxoywssp8UIvL+izkb3n8=;
        b=4UsDFgy+kwsdVXxWBCJ2D9vib0ODCGM75Lhsb373o099RH5BDg1qGOO+FAN0pF+3bM
         FKK7/MyRXMn+ZDvia2IeBOLpechVYY984TXowFicuivK/SizSWT/Y30aZDftDPSNxjQL
         opYK41R6Ue982jaJ/H9MCvMT2M1a6etxQKbIdOc/orIpTLEYPNbDvLk4fh46ncWv7pV+
         DX36j0ySDUQ6YjoMGsXqzFiY9n+q0v0yw8sfMsMnyxgyZ3mBJHhvBhtXrPzuOxdRFil7
         BTLrjXY9vFOIJ5DVIj9MGiIwoWHTpXqnPKlNXIUEju5PUbaXWSo7z+o/UnT7FeBwT9F4
         Ztlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582412; x=1700187212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR4tNxv+g07FJHlmB9dj3yDxoywssp8UIvL+izkb3n8=;
        b=iQ/bcM6wjXUzp/agMjFSktyio5bXk0gtFx24Rhks/YZA9yhWn7Y05ZFpSlyt0gDGyi
         vPR7SfqGeA0FKU60IJuoF09lc9PQ6e9PYXX283tQwwMXTA+f983wO2ToMtFHW7eqQB+L
         SOCvUEudoDMNcCkEfe6iIxMBk/+IPsMYefiMYCI68aunBry2CBU1fW02lJome5WQgVSP
         2z3jrogEAcWEyG0ANEhnNuzJCXvMa/mQ31OO5QwDt7JiqjHcUWXhePwJSpglXvaCKck1
         qN5mJQGa40xjdvvjFz5pUt+0MLDUlOGqh2JYKMrlDj/p02ImDZHa+HCb7qJVNYzJ5dOX
         a80w==
X-Gm-Message-State: AOJu0Yzd9A6T3TjUDe3t9hbMniaeFkX/BHUWtCY0Yo0E9wJ9nc/WkcQR
        0LC+Y7HLcekH/LYiEy1k6wMmBU3Czmc=
X-Google-Smtp-Source: AGHT+IGk9Th9IVLtHKmeUR2wtmElNnCg6h0KoNuCyxTp8Aq1fusMyQ/Jl9J62V/d2c1CkvE5vAdM050RYzI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:344a:b0:280:cd4e:76d2 with SMTP id
 lj10-20020a17090b344a00b00280cd4e76d2mr823816pjb.7.1699582412087; Thu, 09 Nov
 2023 18:13:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:12:50 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-11-seanjc@google.com>
Subject: [PATCH v8 10/26] KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the "name" parameter from KVM_X86_PMU_FEATURE(), it's unused and
the name is redundant with the macro, i.e. it's truly useless.

Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a01931f7d954..2d9771151dd9 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -289,7 +289,7 @@ struct kvm_x86_cpu_property {
 struct kvm_x86_pmu_feature {
 	struct kvm_x86_cpu_feature anti_feature;
 };
-#define	KVM_X86_PMU_FEATURE(name, __bit)					\
+#define	KVM_X86_PMU_FEATURE(__bit)						\
 ({										\
 	struct kvm_x86_pmu_feature feature = {					\
 		.anti_feature = KVM_X86_CPU_FEATURE(0xa, 0, EBX, __bit),	\
@@ -298,7 +298,7 @@ struct kvm_x86_pmu_feature {
 	feature;								\
 })
 
-#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(BRANCH_INSNS_RETIRED, 5)
+#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(5)
 
 static inline unsigned int x86_family(unsigned int eax)
 {
-- 
2.42.0.869.gea05f2083d-goog

