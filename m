Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8E7A88CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbjITPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbjITPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:46:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46683A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:46:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c453379020so33310935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695224784; x=1695829584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HIC1z+Y5X7nE4BXr1975QA3QvmpInOTVPTiyv7G4DQk=;
        b=Zc4mumcs4PLbklSIehlaVVP4N/0QW604dbJlsdHfeJjeTzimaTiUyYP4lJMPUwb2Wj
         K/0oPDgTqY8Wed0KEqKrKdqiX2PaP9a3/FgYWzVj3gCQuNSDMjlEZfW7uKh5LpDv0geh
         hs1HHCQTxWLHGQLSZOg9bH/Z7oTdbVI2OJAQdJwCsyv4dgwEdiwYiEkjFReXahFuUuCK
         MCczDjB3xIqRcKkpafTDMC73usHZi58yIVHJS4odLzidZTJhkBLBjkt7kOnqCuhgyH3z
         yzPoBjmPmFWWzmXUVv1ZT5ZJ3iP4P1Y7dHR8q2KQpM5py2xDU0kM6vRcAyru5sKpdGvo
         0ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224784; x=1695829584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIC1z+Y5X7nE4BXr1975QA3QvmpInOTVPTiyv7G4DQk=;
        b=UiB7QVK/8FREBtczzQ9OSgenBFgMcSZrkouiQxtp0JVRSKbz4Kg9zXlsHVp9QkmrKl
         QsjPG+nGjPtMaK3J5AGI4HROURucw6vC0eNReDQM24dKQZ55lyGKc23WYbSD2SAUewO0
         r1V12eACSTV8D8rE6oW4VIDXedtS7Fnp+98o0HxNeENr3m2gzDgExnCe0VJYnk9yUyUo
         mg+UagfyhoG8fRK7MZSM8nDqNm/U7Tqdd6F1wImCqJIzcUBavFdn4rqplkRMXRltgiw3
         ZEcykpdpPRGtUnd8a+lw239TIotoZoavbaT1oaowNN3Qh3LrUdhBAPr9tFt9DyA4YB5E
         zbZA==
X-Gm-Message-State: AOJu0YxHyTBHCUBVbvD/XrXkznbcSmy7YZB2lfw39y1FcF9aoEkCVLWZ
        Dg5+m/DhRtJDxy+Y28Zdtlp8gw==
X-Google-Smtp-Source: AGHT+IH3EjLrv/byDVEUBKjQ6K2VTEFNBFwq6oAb2NPMTHvNIVpZJ/QjFXRiSyjLYbNycwjvDS1j2g==
X-Received: by 2002:a17:902:dad2:b0:1c4:c92:2320 with SMTP id q18-20020a170902dad200b001c40c922320mr3107163plx.31.1695224783665;
        Wed, 20 Sep 2023 08:46:23 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001c0de73564dsm11995153plx.205.2023.09.20.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:46:22 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 0/4] KVM RISC-V fixes for ONE_REG interface
Date:   Wed, 20 Sep 2023 21:16:04 +0530
Message-Id: <20230920154608.1447057-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes few assorted fixes for KVM RISC-V ONE_REG interface
and KVM_GET_REG_LIST API.

These patches can also be found in riscv_kvm_onereg_fixes_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Addressed Drew's comments in PATCH4

Anup Patel (4):
  RISC-V: KVM: Fix KVM_GET_REG_LIST API for ISA_EXT registers
  RISC-V: KVM: Fix riscv_vcpu_get_isa_ext_single() for missing
    extensions
  KVM: riscv: selftests: Fix ISA_EXT register handling in get-reg-list
  KVM: riscv: selftests: Selectively filter-out AIA registers

 arch/riscv/kvm/vcpu_onereg.c                  |  7 ++-
 .../selftests/kvm/riscv/get-reg-list.c        | 58 ++++++++++++++-----
 2 files changed, 47 insertions(+), 18 deletions(-)

-- 
2.34.1

