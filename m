Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51BF7E8ED4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjKLG0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKLG01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4483C15
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E993CC433CA;
        Sun, 12 Nov 2023 06:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769886;
        bh=pCbLyhlTiTCPVyjC6F0x/RIOJUl3eHTLK6u1tDMFHiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbhMDVf5Ls3HY7vX7w6FISj1kn1U4VVPGZX4dsUZKDlZoIDE6gN68LYCDykSmzwq/
         HW0hrA9GMbmEYenBeVuylzxp0i40jlJS2sb74sRLRaQ7a28yqIyPj9pyIMqLEXwWdH
         womA6+yJRG46rjsiYplmtxAQnB1q+T0g11SjcvYIFwMpeVdQxIM03g9v2CFzu3QD95
         4kfemghrnDw8pcpdHOqG0p/JJMRLzSyTLGUTIt1gBNht3bc8n9RJ547lfMACGeRf9M
         0cQcGwBytXmIbT0qepXitV/1fhx0YB7aPqbEHs86kXMbtwoNMJH7ZAyUeICU2LVS3C
         QAYg6f/FQx6MQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 26/38] riscv: s64ilp32: Disable KVM
Date:   Sun, 12 Nov 2023 01:15:02 -0500
Message-Id: <20231112061514.2306187-27-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Disable the KVM host feature for s64ilp32 first, and let's work on this
feature after the s64ilp32 main feature is merged.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index dfc237d7875b..3033fc1f7271 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -20,6 +20,7 @@ if VIRTUALIZATION
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support (EXPERIMENTAL)"
 	depends on RISCV_SBI && MMU
+	depends on !ARCH_RV64ILP32
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
-- 
2.36.1

