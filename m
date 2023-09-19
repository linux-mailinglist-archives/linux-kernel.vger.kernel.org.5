Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DCA7A5807
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjISDyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjISDyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:54:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C62FD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:53:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3ab3aceaf2aso3643938b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695095635; x=1695700435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvg3SR+EIFOsYy/qoodlQ+dG3JVvlqb84MODfhL50Kc=;
        b=JbPJU5nnSbZaYZRt/oSridjA3Sc5nGiFWsmhl2f4b9Scu0J0+1j+n46ahtGANrMbf9
         3430+ft1eqOnzQdd5Y016/Co+b35IwhN9oyoxmw6Uy8y/EEH+vnxFWBwRk3fL+QkXxCS
         OAFpeE83shtFUk6E2B8Mz2dji+brCY8PUJBEtCtrxZbUnoJUh1eqe6Js7w1gB7+M6S/A
         RL4knlAjhS4knF40tpkS+AMYTw4nZL51u/JoHGFfhid3JSrvTlV+7OCNACimSRs1f278
         jl/fsewlsqJ6Rf4591gOqOSwmAh4ce2ZtGSdqReZomoft1xZJ7GG/FIG8ConRuL2VLKe
         ipbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095635; x=1695700435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rvg3SR+EIFOsYy/qoodlQ+dG3JVvlqb84MODfhL50Kc=;
        b=mTyB9x+lu/4FKCZwGhRx8RaS42bXRifsuetPdLcn7BHfI2LdjUVpqI+XaIXhbsoTj7
         wmHeJ8pDTPRoMz+mqIvOcXMgEUNWR6nXqx5Q7fUFf60zoSzwIoyG8y1zNRHoDqBYuxI/
         RDn8its7Vcbz9yVliUxg3q75o9Q3zAhDmpUaWofI8R/jDbBHBK8XI8fh9RAF/ddFw/OR
         /RfeRSyy1CzUy30rs03JnDOh07TH2Murw7dOjOmCqWL+xzaIehMOrusp+1ikJvkFtRWa
         8xjvY67lHBtMjuPAfajclYXXiUQGAQxkaX1QBlgh42fgj0PeOzpPmqlOf2S/6oJjyxZ1
         qrvA==
X-Gm-Message-State: AOJu0YxLzU170lfAfn7rO7yw2iq8wxjIi3KntjcTxebbNL7afXHL85uU
        Jr2v9pe5vK396KnFOr335Oyeyg==
X-Google-Smtp-Source: AGHT+IHSFRjaMNl5z6gZsQCX5N7BoHMId7wpAKCC/vOe9wh+dDpFGMxbeXkA8oaPp9V2562aa7na1w==
X-Received: by 2002:a05:6808:b0c:b0:3a9:c25d:176a with SMTP id s12-20020a0568080b0c00b003a9c25d176amr12387561oij.36.1695095635453;
        Mon, 18 Sep 2023 20:53:55 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b00273fc850342sm4000802pjf.20.2023.09.18.20.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 20:53:54 -0700 (PDT)
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
Subject: [PATCH 0/7] KVM RISC-V Conditional Operations
Date:   Tue, 19 Sep 2023 09:23:36 +0530
Message-Id: <20230919035343.1399389-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
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

This series extends KVM RISC-V to allow Guest/VM discover and use
conditional operations related ISA extensions (namely XVentanaCondOps
and Zicond).

To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_condops_v1
branch at: https://github.com/avpatel/kvmtool.git

These patches are based upon the latest riscv_kvm_queue and can also be
found in the riscv_kvm_condops_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (7):
  RISC-V: Detect XVentanaCondOps from ISA string
  RISC-V: Detect Zicond from ISA string
  RISC-V: KVM: Allow XVentanaCondOps extension for Guest/VM
  RISC-V: KVM: Allow Zicond extension for Guest/VM
  KVM: riscv: selftests: Add senvcfg register to get-reg-list test
  KVM: riscv: selftests: Add smstateen registers to get-reg-list test
  KVM: riscv: selftests: Add condops extensions to get-reg-list test

 .../devicetree/bindings/riscv/extensions.yaml | 13 ++++++
 arch/riscv/include/asm/hwcap.h                |  2 +
 arch/riscv/include/uapi/asm/kvm.h             |  2 +
 arch/riscv/kernel/cpufeature.c                |  2 +
 arch/riscv/kvm/vcpu_onereg.c                  |  4 ++
 .../selftests/kvm/riscv/get-reg-list.c        | 41 +++++++++++++++++++
 6 files changed, 64 insertions(+)

-- 
2.34.1

