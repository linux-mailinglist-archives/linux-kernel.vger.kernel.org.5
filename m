Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A537D51EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbjJXNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjJXNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:36:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45776E82
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:27:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a80e2a86so1552125e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698154077; x=1698758877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJFNx5rx7qhUkqIPLwjnmrfGOQmOs2H4ET4l8FDTOVI=;
        b=Zbyz6T5qbkAMpwaeneQdg3zL3d47suRKNRrvsFDD+y3Ei0XN24YX430fRV1uiUpXrC
         Ho35mh39xUWgM+tsLLTefNAshXDfuhoJIINl+Pv2mjsgk/ZY7I71iIpPGM97nDFyHYAx
         TMzqoVJ1M0MFdvWdH7hlCqzp4NdoZrbzwyYwAEAH5pWIcJfbYSwWei6D4TrjsBVIW9YD
         g6DtBPKZMqUFMxnSyWEJ5fbPxIK1UdVT4QmZaVniG4OzeornVF+LI/pnHKlqMddH1ydw
         P0frM3i3i1uH3gUMhfJR4nkh7UNliUnPBx/EbrYnzMY3SZha/xujawddGvjYQcjAeJ4u
         TZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698154077; x=1698758877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJFNx5rx7qhUkqIPLwjnmrfGOQmOs2H4ET4l8FDTOVI=;
        b=DWQ+/ahpoq63zwwPbDs+KYMfiRQGr98NRhyEUu0aTriSkOtF9kXWFrNmdTY328lfhi
         XsAM9lMCN4MdBy63WPAt11uKKODnq3YGVrotV/7kB9kDmHhpBTuHTp0ee4AYchoXF+h9
         p1/MP7ydpHyBSemRzdL1OoxvkqnMTekCLiKAfL4oHHTpdSR0VwifCjcvazriE9JThDlt
         bOcG4Ygkz1f55nNtiUElnNPAOTlkcC6dFNELGSyQjsiweBlhX6DLPHXVuVlNC4+q/p7R
         Fy3axfysembtAvsZuTQKRx2BIdd3IX24zX6RmUwB3XePfORLajKgR//WQLbjKiprH0BO
         R4zg==
X-Gm-Message-State: AOJu0Yxk2HumCOSKm0mNr0MnrMR9c1l9mJDK7CQe1l9sBw/+ZyzMS0CT
        UuXqlZrgLZzNWMgnryJNYdyibQ==
X-Google-Smtp-Source: AGHT+IFWdNIkY0t6ET2TzgVKN75LNnZuJm4w1A0MxXp+TA6JlTnULSfRKZHPZd/CGJzYRaN7/ZBuVA==
X-Received: by 2002:a05:6512:ac3:b0:505:7123:21ae with SMTP id n3-20020a0565120ac300b00505712321aemr8618901lfu.6.1698154076939;
        Tue, 24 Oct 2023 06:27:56 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:597d:e2c5:6741:bac9])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4151000000b0032d87b13240sm10034964wrq.73.2023.10.24.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:27:56 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: [PATCH v2 5/5] riscv: kvm: use ".L" local labels in assembly when applicable
Date:   Tue, 24 Oct 2023 15:26:55 +0200
Message-ID: <20231024132655.730417-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024132655.730417-1-cleger@rivosinc.com>
References: <20231024132655.730417-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of coherency, use local labels in assembly when
applicable. This also avoid kprobes being confused when applying a
kprobe since the size of function is computed by checking where the
next visible symbol is located. This might end up in computing some
function size to be way shorter than expected and thus failing to apply
kprobes to the specified offset.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_switch.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
index 8b18473780ac..0c26189aa01c 100644
--- a/arch/riscv/kvm/vcpu_switch.S
+++ b/arch/riscv/kvm/vcpu_switch.S
@@ -45,7 +45,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 	REG_L	t0, (KVM_ARCH_GUEST_SSTATUS)(a0)
 	REG_L	t1, (KVM_ARCH_GUEST_HSTATUS)(a0)
 	REG_L	t2, (KVM_ARCH_GUEST_SCOUNTEREN)(a0)
-	la	t4, __kvm_switch_return
+	la	t4, .Lkvm_switch_return
 	REG_L	t5, (KVM_ARCH_GUEST_SEPC)(a0)
 
 	/* Save Host and Restore Guest SSTATUS */
@@ -113,7 +113,7 @@ SYM_FUNC_START(__kvm_riscv_switch_to)
 
 	/* Back to Host */
 	.align 2
-__kvm_switch_return:
+.Lkvm_switch_return:
 	/* Swap Guest A0 with SSCRATCH */
 	csrrw	a0, CSR_SSCRATCH, a0
 
-- 
2.42.0

