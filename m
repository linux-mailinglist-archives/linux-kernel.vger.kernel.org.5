Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF77FC27D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346435AbjK1Oy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346416AbjK1OyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A310DC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:23 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cff3a03dfaso8288185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183263; x=1701788063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqoarEcYKPTwyPmOGP/1tRxw/l4x1unFGwuPZisXSs0=;
        b=ZyB5NGaaVVjLSIkAX4xKpip9qQ1O/BbdB1h8f1W7Wuz2wptTFHu3mzJU9cnan/cMLG
         cmR9EE5EZy4sY+1FDVgICcGnWGwpcnTb5wCqZd0Z07QnZ/mucdE0RqOmLLQJe60W2FbH
         8BSXTSU89JTXqLYTODcYFEqwJE9Z2i1253T5JED4txDyjjK1PIwQtTRiH/rxA+8JmY5u
         5rdHh2bKQS9CBjcxBv/uIgEMRN42cvGvI9sk/V5M3uR3+mDvnqtLiHmPMOWqvrv02qTq
         AsuJLZt3w0PNd0DQUZnqS7I54HWidKgoR8UcTuE6iO+hBzcfJjxA9cHlbWKINCD/JH8n
         5MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183263; x=1701788063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqoarEcYKPTwyPmOGP/1tRxw/l4x1unFGwuPZisXSs0=;
        b=WR6uMXb5lWGKBPrs1ybUU3cdRMd1KyNSRUf/Z/8rMLEPDIFkkqDj4HxTKJd9FlKdqO
         wpA3SbtAyAiwt2aNynC+cLEwuva7jSzew78LULyDhUTFDQUSRoUO23+WKTOHwSHadqgV
         uuYXx9EsJDqzBY/5LT64Y3dOA7VIC7sSYU8GuqqkGy61x20WfglV4iMMn/+Uza09AUh4
         rQnKqpXNueJncKQ+utv+aT1kxG6vbvkzUm1lzPl5Zk4jVVVWgv/cTldiXgOVBIRDmClw
         /sRScxdkStlrEA/DpYqDB84Rv0O+ZMdARRCJS9sPae20rH+jr0lbXy91VlX0CPxGI3F3
         RE3Q==
X-Gm-Message-State: AOJu0Yyw0pkUwLD+VKFXptIOB6XW6BNxloRFebBhm9TNOUIrTnMX+ZRu
        RYVYIXDu3O5oGV9MDW/rqQKLRw==
X-Google-Smtp-Source: AGHT+IF0goMcAklKoJKTKjWtl2nqOMf0dgEj4xslQsxSZoF9zhQ3gTvjB8b3QY0TAV4Wuuo/tXKSpA==
X-Received: by 2002:a17:902:e843:b0:1cf:c404:45dd with SMTP id t3-20020a170902e84300b001cfc40445ddmr8585604plg.57.1701183262958;
        Tue, 28 Nov 2023 06:54:22 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:22 -0800 (PST)
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
Subject: [PATCH 03/15] KVM: riscv: selftests: Add Zbc extension to get-reg-list test
Date:   Tue, 28 Nov 2023 20:23:45 +0530
Message-Id: <20231128145357.413321-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM RISC-V allows Zbc extension for Guest/VM so let us add
this extension to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index b6b4b6d7dacd..4b75b011f2d8 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -44,6 +44,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
@@ -361,6 +362,7 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(SVPBMT),
 		KVM_ISA_EXT_ARR(ZBA),
 		KVM_ISA_EXT_ARR(ZBB),
+		KVM_ISA_EXT_ARR(ZBC),
 		KVM_ISA_EXT_ARR(ZBS),
 		KVM_ISA_EXT_ARR(ZICBOM),
 		KVM_ISA_EXT_ARR(ZICBOZ),
@@ -739,6 +741,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
 KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
 KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
@@ -761,6 +764,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_svpbmt,
 	&config_zba,
 	&config_zbb,
+	&config_zbc,
 	&config_zbs,
 	&config_zicbom,
 	&config_zicboz,
-- 
2.34.1

