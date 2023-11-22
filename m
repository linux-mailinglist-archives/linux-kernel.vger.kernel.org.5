Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6307F423C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbjKVJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjKVJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:44:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0981D78
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:44:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C67C433C7;
        Wed, 22 Nov 2023 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646270;
        bh=qEFrCNf3UEgHGW1T9wtS9jRJz/KS9KwPB3lxI2GEsTI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rTp3IgyIvQfGD4I+L4TFOAbCJv9NbsiNeIDD4RtpVFyB4VfP3fsoai+tC4z4rivNB
         8csRCTYL8ZxeIFyOEnSQA4auqXLMjPB0TV4q9PD4M8mgIYeKJidyttb6RB1TqgN3n/
         7KFCMpd6Y97LNcgEUgDa3TuB2NG38oyO3WYbYyT4ZlzJStWJg4OpYtI1zx1GNbFLcQ
         EqvGVx0LQC1NgAEZKJhwgqD7BpUehJeQAuBogQ81mPWkWennLwbFNmzi6M9MU9ePt7
         EfPhNaYflYB6bWpv0JVKbnZGesMDPr2M3n8dHIwjEE+6mu+EB7/vi4iVvbD9/uCSfp
         qfBU5xs5TJplw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:23 +0000
Subject: [PATCH v7 13/39] arm64/mm: Map pages for guarded control stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-13-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qEFrCNf3UEgHGW1T9wtS9jRJz/KS9KwPB3lxI2GEsTI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0A24D56zutL8bLQvd52fo0wC43SRULlWAh1
 +rU/4PE4q6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NAAAKCRAk1otyXVSH
 0HxeB/wMjuD6MVRsjymmm5q0PFo3mPpIDfrsn5bfPM93xyIkhexzp3o8MKMLZJR6AyWc5SU9ANA
 9VNb9/Gq2SqulwM+T75NERQoIaX5QN0rnERoUsbZEovn2OVcl1rKgSR9V3pSg6Qe7bTHQI1RXba
 52pV6lnw7K6QWG67Rs68SOCjwuPipie41cnu7hHYrKAVPUJgJ3xAaTF3zvDCHGppy2hPtemSDue
 xvPJt2OEUG/I7wwXpBQXAIdu64425sWrMATEdrAKaBbTDiRIX3QHYitwt4URVvOPC092qkbtgUq
 ocdLzNoIZ+MRZVauVM6J+z8pX5L1QoZViXQ6EXKLKo+5igsQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map pages flagged as being part of a GCS as such rather than using the
full set of generic VM flags.

This is done using a conditional rather than extending the size of
protection_map since that would make for a very sparse array.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h |  9 +++++++++
 arch/arm64/mm/mmap.c          | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index c21849ffdd88..6d3fe6433a62 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -61,6 +61,15 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
 			return false;
 	}
 
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		/*
+		 * An executable GCS isn't a good idea, and the mm
+		 * core can't cope with a shared GCS.
+		 */
+		if (vm_flags & (VM_EXEC | VM_ARM64_BTI | VM_SHARED))
+			return false;
+	}
+
 	return true;
 
 }
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 645fe60d000f..605d4e6edc1d 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -79,9 +79,20 @@ arch_initcall(adjust_protection_map);
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	pteval_t prot = pgprot_val(protection_map[vm_flags &
+	pteval_t prot;
+
+	/* If this is a GCS then only interpret VM_WRITE. */
+	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
+		if (vm_flags & VM_WRITE)
+			prot = _PAGE_GCS;
+		else
+			prot = _PAGE_GCS_RO;
+	} else {
+		prot = pgprot_val(protection_map[vm_flags &
 				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+	}
 
+	/* VM_ARM64_BTI on a GCS is rejected in arch_valdiate_flags() */
 	if (vm_flags & VM_ARM64_BTI)
 		prot |= PTE_GP;
 

-- 
2.39.2

