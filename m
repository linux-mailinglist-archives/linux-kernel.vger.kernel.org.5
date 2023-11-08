Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9507E4E0C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjKHAcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjKHAby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:31:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EC61707
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:31:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b02ed0f886so86120427b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403511; x=1700008311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xR4tNxv+g07FJHlmB9dj3yDxoywssp8UIvL+izkb3n8=;
        b=mcuBP0qPGUO84/kUz8vmjV6Gtnm+1X39C8G3AoHnlxpn9GODEWIQICrU97Y8LVHmH5
         wsisMZjO9tHWduxCKM7Hk3y9zWAKSZPkEhPjZ+b6G/CK5eYmahqJxGgkbGXSaA3QVIp1
         lpkeRKeq58bpXFr3qhEQOKY/0n6lTxX/qNENL81LC5s8MiCh3aMltl3Ggrf4G0RXS3uc
         QKIhPueQkz/3PgQcu1/rAbK1DOdyrLAsqbzqcR65xNlcNFjSuOYrpsLvIo5blZkkpqYL
         NJPeRXtsXHO85/v20pnmK/rtFUQNR0ZvfEf+BTWFd3VswUtMtF5eIfIc/afOZOwAornB
         VQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403511; x=1700008311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR4tNxv+g07FJHlmB9dj3yDxoywssp8UIvL+izkb3n8=;
        b=DGahTvpVP3pAJqp+L6iqFjKx5D6B281RVZxWf7VhpsIycDsjeN628ggoqDqMP2DdaI
         0xNAiFQiaxIdPIkXwWaAiyyo1bciAThtn+Sl53pd/QPB66USkJIWgADhBYxfv2+y128s
         g+Ria+IDjQmYefObLMkULTsgZ6FgMG3G1Udx3i/a3+aX96+DqlEBIJMLua/h9GyBq0Ds
         i/K3986hqCfoqgbBdQXjfbmqR1nQ3SqmMgEgqLLkRN0LJamMRW/J7VVXbi50+lLXRnfJ
         FTWzlB+9CzxabuGVacn8PG3zpFOL6z3pjk+KNWOCVLYwyQANQwOxRIWHHhkk1IGbzpoH
         hZ+g==
X-Gm-Message-State: AOJu0YxnXqJlUxjcDGE7TNNkx8CmcIviSo6YuidrdrT2Szzxkr0f3c2F
        XZgVdkvOFIrTVTLHU6KI0zSiaRK5FqY=
X-Google-Smtp-Source: AGHT+IEMuUTqh4Bl3DMMRgwFv9jyV30xQL6LnHwAkTaR1MPQyVNzmMe6GDxJa4AwDqIXY4bVj1WjZTNM/DQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1366:b0:dae:49a3:ae23 with SMTP id
 bt6-20020a056902136600b00dae49a3ae23mr6014ybb.7.1699403511034; Tue, 07 Nov
 2023 16:31:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:22 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-7-seanjc@google.com>
Subject: [PATCH v7 06/19] KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
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

