Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F37F59AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344892AbjKWH6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWH6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:58:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE9DD;
        Wed, 22 Nov 2023 23:58:46 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so632218b3a.1;
        Wed, 22 Nov 2023 23:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700726326; x=1701331126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3vC/J3cIXPZBm8Pko+lyPgPSd9eGkIB3K0+4Ev4dyA=;
        b=A1uiInaFXswshn632jXmttI8Il+oHfJCiYj0Ar1+MKDGn/XsoZRnqNzDErmYmC0arF
         fszROVUzj+k3yd+3W7zegjMSKns9bfPHvkbzGPbeoMBbqueDTB+Lri0IltuYL9IRyOoB
         XQ2ZpBCO1qFwjcMc34L+n1GcGdQa4sKwWh0I76jlQO/IkVk2RF4ouFqXwdx8+jUeR8bX
         sQ6yr/SJe2jNc7kgJOMQ8Fjbpa0yGwozRvVIBsw3qg63FWtxoPlW54jmmjCFnwBzfhWn
         C7Uh56RdmJdnRzphEAMTG5figJHO0bXgoFp+71l32+OHvA038/mRmhRDgm0/rjMV/aLR
         cMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726326; x=1701331126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3vC/J3cIXPZBm8Pko+lyPgPSd9eGkIB3K0+4Ev4dyA=;
        b=VlLvfttbYKYWxJGBMdIhX1Oj64ewGkaT8VqaYwIyrXWitym/8mrdxF/t74K3syqkhP
         MZ+MKT0OU3CrlTX8RuhBpvpweX26G0BY3FZFAU8lABeFPgSZ9E2sHlcX7iEgYEft9qBc
         xTVqV5UpWBZsMmw7N8WVdBydT6571y5ZZtTgRFiJqDrFW2pCc/d9tCwWUpG5M+e1xN3C
         usol1MI1YFffvEuOIfODMQWhJTOmHlxV6KvMp252PcmqtoN5oRKDg8C+8PYimNY4257f
         LHykO/Wa5hBZNZfb9YMGwLYAfrLumQEhsAtEXdD3zOJNx9yPbBteVEf9YzRZON7HUij/
         9xUQ==
X-Gm-Message-State: AOJu0YxJb6BYPQPqPG3ug8E2pXr6pX/+6KCb47dHAJVocsluldNMGSNP
        d+nCwg2K+Whsjz5t50657RM=
X-Google-Smtp-Source: AGHT+IGSQbxFVTSDHtkXkl2mrLrTC0aN8/10oVHBHhlFlyIC81cD8RDetRNtVsS/5GX3tGq1GojtVg==
X-Received: by 2002:a05:6a21:3290:b0:162:ee29:d3c0 with SMTP id yt16-20020a056a21329000b00162ee29d3c0mr5396574pzb.42.1700726325838;
        Wed, 22 Nov 2023 23:58:45 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id b24-20020aa78718000000b006cbb40669b1sm656434pfo.23.2023.11.22.23.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:58:45 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Use get_cpl directly in case of vcpu_load to improve accuracy
Date:   Thu, 23 Nov 2023 15:58:18 +0800
Message-ID: <20231123075818.12521-1-likexu@tencent.com>
X-Mailer: git-send-email 2.43.0
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

From: Like Xu <likexu@tencent.com>

When vcpu is consistent with kvm_get_running_vcpu(), use get_cpl directly
to return the current exact state for the callers of vcpu_in_kernel API.

In scenarios where VM payload is profiled via perf-kvm, it's noticed that
the value of vcpu->arch.preempted_in_kernel is not strictly synchronised
with current vcpu_cpl.

This affects perf/core's ability to make use of the kvm_guest_state() API
to tag guest RIP with PERF_RECORD_MISC_GUEST_{KERNEL|USER} and record it
in the sample. This causes perf/tool to fail to connect the vcpu RIPs to
the guest kernel space symbols when parsing these samples due to incorrect
PERF_RECORD_MISC flags:

   Before (perf-report of a cpu-cycles sample):
      1.23%  :58945   [unknown]         [u] 0xffffffff818012e0

Given the semantics of preempted_in_kernel, it may not be easy (w/o extra
effort) to reconcile changes between preempted_in_kernel and CPL values.
Therefore to make this API more trustworthy, fallback to using get_cpl()
directly when the vcpu is loaded:

   After:
      1.35%  :60703   [kernel.vmlinux]  [g] asm_exc_page_fault

More performance squeezing is clearly possible, with priority given to
correcting its accuracy as a basic move.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c924075f6f1..c454df904a45 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13031,7 +13031,10 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_state_protected)
 		return true;
 
-	return vcpu->arch.preempted_in_kernel;
+	if (vcpu != kvm_get_running_vcpu())
+		return vcpu->arch.preempted_in_kernel;
+
+	return static_call(kvm_x86_get_cpl)(vcpu) == 0;
 }
 
 unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)

base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
-- 
2.43.0

