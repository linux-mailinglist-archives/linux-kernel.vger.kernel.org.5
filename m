Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B41783DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjHVK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjHVK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79410E51;
        Tue, 22 Aug 2023 03:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1259A65134;
        Tue, 22 Aug 2023 10:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC36C433C7;
        Tue, 22 Aug 2023 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692700147;
        bh=IvGfBZV/2Fq02VPlpwX47hDqBBEMCLHL/8A28vWDXUc=;
        h=From:To:Cc:Subject:Date:From;
        b=uqwRdGXrLVVBzIrINCLqNlhho2l5dOyRLX1h/2OMPF3QFkA+7uotHE76sAa8VIjYF
         k+fhy01JNfiBFQ44lEw50tXOhL0YrJ4yLdtUEAxBPf3IktZr0ZlHHPODFVar1aziel
         6RAyn4VX8VBpS8NgDz0+9S9X07mvyZiZrw/l0+QPZp82mbFJrWdaLBiSh+B+cp/JkM
         CBkVX7MpUB/q6pV1EIiqOoJNRElangAk5sKwHkFj6jNTZAFe031xrgJw+8pUewD0PN
         W1Jrn0Hu2smyWzlHqy4t8r4oA0hzgqG1LHyxnpWiB6AbxLlIe46kIFbrp3sPey0iv/
         j66lhtnxaN+Jg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sgx: Describe the parameters of sgx_calc_section_metric()
Date:   Tue, 22 Aug 2023 13:28:53 +0300
Message-Id: <20230822102853.15078-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: stable@vger.kernel.org # v5.11+
Fixes: e7e0545299d8 ("x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308221542.11UpkVfp-lkp@intel.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 166692f2d501..388350b8f5e3 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -732,6 +732,10 @@ int arch_memory_failure(unsigned long pfn, int flags)
 }
 
 /**
+ * sgx_calc_section_metric() - Calculate an EPC section metric
+ * @low:	low 32-bit word from CPUID:0x12:{2, ...}
+ * @high:	high 32-bit word from CPUID:0x12:{2, ...}
+ *
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
  * metric.
-- 
2.39.2

