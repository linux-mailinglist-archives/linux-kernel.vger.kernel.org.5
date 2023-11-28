Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3217FC1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346675AbjK1O4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346606AbjK1Ozn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:55:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE67211D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285d1101868so1887661a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183327; x=1701788127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VVLFlRU9wYvo88+4OGIocSm8Yau0IVgd5ynlDYwNo0=;
        b=FCKkVKyvcgg2+FuLc7kglFATD0ozGf/gJK2xQP7zxLCp9d/x3u32YbiaqQomA6VieS
         CDfqC3ufh5zsv3SuyE0WdkNCp+Y4haDkLmAQq4xWn/fumm9S2iIF7sjXo63OLgoNxn3C
         kLPU8SKAF6XLDMErpBz0OS3kds0tUaJ6Jskrl3+1havDFGoUsE0KlXmgZ7z8ivFbUuIE
         7GwgEAt8tM/1Ta0i8b6PJojNPX8ptjNGzGydXqyVeTl0M9f+ApU3KbvQQt8+RZVGLXIk
         ONEahHSYkK6WvwZ8i1iLo15iE55JHOJXgqesTtYQxd5SnJ85FDR8oJE4GQQ06ZyQHR20
         kFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183327; x=1701788127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VVLFlRU9wYvo88+4OGIocSm8Yau0IVgd5ynlDYwNo0=;
        b=oXqr3cZUK6sqNpNL3KnsOQT1/s9JpUFMhhPW8lqq/mej9a/pdWGzbVCVUeFYuoEXNn
         v5f56ue8o/ElQSl66PGi9ElQzJVUzwAwYDPWEyoCUURqQNxYZKAECtjEixzZ+ct8KQj8
         ex91AgeU04yE+AdEDcFDQo2DMdjqgCFtc+ihWwegm/HG8cLebbivpEWBcRME3HAZcX0f
         GdHVK74S32TdDGEamXjJgXjg2yjGgM8JEJR4haI580XhDR8PsK1R9ewztLZQ07RI0JcX
         h05O8Q3uYCikhosx0u/B6QR51NgGN8r4B53OVq/lwDDcKIzj6yNkpYtcrPzXwn6nQEtz
         oezQ==
X-Gm-Message-State: AOJu0YxpU+K9IcrkVvxJOm9Io7NPwsIl0Ltq3r1Iwd6C68wA4RJj2PTT
        lvvMya/9y6KSJGDxr+WprGT2pA==
X-Google-Smtp-Source: AGHT+IHZ95VAy9/7S8RkRKOXL8kFHrGKjfJWJoXp0yuxzlNt0eSXamoYyifB6bHsdqesqmrNE+3K7g==
X-Received: by 2002:a17:90a:1a5d:b0:280:24c7:509 with SMTP id 29-20020a17090a1a5d00b0028024c70509mr13617016pjl.46.1701183327478;
        Tue, 28 Nov 2023 06:55:27 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:55:27 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 15/15] KVM: riscv: selftests: Add Zfa extension to get-reg-list test
Date:   Tue, 28 Nov 2023 20:23:57 +0530
Message-Id: <20231128145357.413321-16-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM RISC-V allows Zfa extension for Guest/VM so let us
add this extension to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index df03bc511fbf..3ae919469c38 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -49,6 +49,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFHMIN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
@@ -392,6 +393,7 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZBKC),
 		KVM_ISA_EXT_ARR(ZBKX),
 		KVM_ISA_EXT_ARR(ZBS),
+		KVM_ISA_EXT_ARR(ZFA),
 		KVM_ISA_EXT_ARR(ZFH),
 		KVM_ISA_EXT_ARR(ZFHMIN),
 		KVM_ISA_EXT_ARR(ZICBOM),
@@ -796,6 +798,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
@@ -844,6 +847,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zbkc,
 	&config_zbkx,
 	&config_zbs,
+	&config_zfa,
 	&config_zfh,
 	&config_zfhmin,
 	&config_zicbom,
-- 
2.34.1

