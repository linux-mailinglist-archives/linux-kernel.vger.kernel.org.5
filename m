Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BEF7A581D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjISDyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjISDyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:54:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA41AA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:54:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4299259a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695095666; x=1695700466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfvmhBSCKy1EtjBZwA/dMnNMj/Sq3SnHobn1iIDa23k=;
        b=CVlwW+v4ozsvUCXqToXkiNqpHqEKOTWO+P+exSrUP1X9KQCS6R6/Q3DW93TDVuvR9O
         WpaDr553Xt+fufYlNriKSVt8TZB2EG4Vvvh3d1Dp1bCuT2JkB0J7Xd9Q5bD8MSddNqC0
         mZ6dH4oO1kozxpFFzcDa9f1szXHHnjmG5ROp5A7qDBawFW8CfMFQ+XU0xdJSmswlW+S5
         ymo37x5KAxwqpXQ9iZeqkpUonJXMBWADuMveDVQ15ROA3EV/HvjH/aucEuU10IFfh8T/
         4zmBBKi1MXXWgpteQTLm1nAV3SPihASotfKSkYc+rlvLM442wT/Zq0JhQe1keEZFPno+
         ZT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095666; x=1695700466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfvmhBSCKy1EtjBZwA/dMnNMj/Sq3SnHobn1iIDa23k=;
        b=IwO1Lean5XuYSNS0Dak/X/pY6byR4ckcO4e57lYYObnXohLd7mSgil1Exw336Tg/Mx
         E0EnLmmlVyZMR+Ql30ttl3GjFR1TZtJEnNl7G4M0Ot9gJbg+idGzb5bQ1z1gRXsQltIz
         RWo06Y9jqbmL4MM6ATce0aia8RvJA/O8K3GHH/Rxw0YbA4fUN4C1HjA8U1SKs0r1xqHi
         HYFidGr7i8oIE2TAZi45yc0NxM2gVXjNnwM6jZSMvxn1tAXYTDTsvZBcTQMoBoQkdEwg
         actl9/0LZ8T0Tgg2Co5tpN9zUj9H89WutUVjV3V5YCO28/B7LmXFYPBfyGWgL+A0aDIF
         xv1A==
X-Gm-Message-State: AOJu0YzDsQgRFw3HW5w88rxsghs1/9xAuqZ9Tjpd1RJTGVh7QZGvFRcx
        2+6u5g4gf/TOTLcqukL179BwLw==
X-Google-Smtp-Source: AGHT+IFWOuCFmAAL9BpJh0Ux9/VFPokWaaBfZihC75JvOcaJslymvgs6sdUGv9tDlKZqw185zQ04Vw==
X-Received: by 2002:a17:90a:4e81:b0:262:f449:4497 with SMTP id o1-20020a17090a4e8100b00262f4494497mr9895737pjh.2.1695095666229;
        Mon, 18 Sep 2023 20:54:26 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b00273fc850342sm4000802pjf.20.2023.09.18.20.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 20:54:25 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 5/7] KVM: riscv: selftests: Add senvcfg register to get-reg-list test
Date:   Tue, 19 Sep 2023 09:23:41 +0530
Message-Id: <20230919035343.1399389-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919035343.1399389-1-apatel@ventanamicro.com>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a new senvcfg register in the general CSR ONE_REG interface
so let us add it to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 85907c86b835..0928c35470ae 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -209,6 +209,8 @@ static const char *general_csr_id_to_str(__u64 reg_off)
 		return RISCV_CSR_GENERAL(satp);
 	case KVM_REG_RISCV_CSR_REG(scounteren):
 		return RISCV_CSR_GENERAL(scounteren);
+	case KVM_REG_RISCV_CSR_REG(senvcfg):
+		return RISCV_CSR_GENERAL(senvcfg);
 	}
 
 	TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
@@ -532,6 +534,7 @@ static __u64 base_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sip),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(satp),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(scounteren),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(senvcfg),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(frequency),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(time),
 	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(compare),
-- 
2.34.1

