Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE597F427C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjKVJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjKVJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:46:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E00619AD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:45:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF98C43395;
        Wed, 22 Nov 2023 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646345;
        bh=NWVJpdky41RR5z+76XsSxPAX8JBO81FQgE/78Pibz4I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=K/G00O1WsBVKAEIul9z7M9wwqUCctNvCWPIaRc94+Gvlyf4ztcyShJLjmynNGk+0B
         7hq8h2uawUA22gE15dEZ51ZTQ925UaN/8M9vgcTDnOwWQsuUaff39e7A4k0MYaYQei
         kbeJ26pPSy+RavFC5jiQzP68OxdewcWNTDUx+97/iR+Wod7dBZrpJhL+zFSllgaOU4
         tTAwtGqFpeCW/XVRsAzFRAm4U0v25Q+Vt+EYrKl876crUoM8lp3JjUPcemuqRNmigp
         osHPuhMKVym0baNytxZlIId5GP3XNo+tBA2/HwMdSZQ13zyKoep+bol7KRP3sZl1Y6
         5c5nQ4gyCyVog==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:33 +0000
Subject: [PATCH v7 23/39] arm64/mm: Implement map_shadow_stack()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-23-201c483bd775@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NWVJpdky41RR5z+76XsSxPAX8JBO81FQgE/78Pibz4I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0Ip6PqHo/mfAIYxGDeH30hQhlkTVEtnfk4p
 U/mjwHwk4uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NCAAKCRAk1otyXVSH
 0MvzB/9fzWnM1qf2rhce2NWjEOKbFvvKGljLcOVUTHACXD9yQBR9F7owkcySZ9VXjzQbfvkKGXP
 9KBhY9vBnEONt/apYyW01/mhfN+uI9680+VgwQRrwPP2yyMoTRFej/ZISyD4X7zqhOohmgBMTls
 we4TRIcF7x/2ZIRovz3jyjHZW4De+AalqERXlrJXgUEBHNiMQyi97JE+muLMn0kqMhzS0KM0fqo
 EUqWgO/phoFoU4p6c8gieIGuKOJ8elT3uUiZAeB+kK2rCc7bZbL9koFjnhS4mYcFlRDToQhQpFv
 GD6HdRG8hNRI9z4hGkH/MB88HcPqkexmwToLVqmqilFiuS8b
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

As discussed extensively in the changelog for the addition of this
syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
existing mmap() and madvise() syscalls do not map entirely well onto the
security requirements for guarded control stacks since they lead to
windows where memory is allocated but not yet protected or stacks which
are not properly and safely initialised. Instead a new syscall
map_shadow_stack() has been defined which allocates and initialises a
shadow stack page.

Implement this for arm64.  Two flags are provided, allowing applications
to request that the stack be initialised with a valid cap token at the
top of the stack and optionally also an end of stack marker above that.
We support requesting an end of stack marker alone but since this is a
NULL pointer it is indistinguishable from not initialising anything by
itself.

Since the x86 code has not yet been rebased to v6.5-rc1 this includes
the architecture neutral parts of Rick Edgecmbe's "x86/shstk: Introduce
map_shadow_stack syscall".

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/gcs.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 315bd698de86..02f8f6046c10 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -84,6 +84,67 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	return addr;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	unsigned long alloc_size;
+	unsigned long __user *cap_ptr;
+	unsigned long cap_val;
+	int ret = 0;
+	int cap_offset;
+
+	if (!system_supports_gcs())
+		return -EOPNOTSUPP;
+
+	if (flags & ~(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER))
+		return -EINVAL;
+
+	if (addr && (addr % PAGE_SIZE))
+		return -EINVAL;
+
+	if (size == 8 || size % 8)
+		return -EINVAL;
+
+	/*
+	 * An overflow would result in attempting to write the restore token
+	 * to the wrong location. Not catastrophic, but just return the right
+	 * error code and block it.
+	 */
+	alloc_size = PAGE_ALIGN(size);
+	if (alloc_size < size)
+		return -EOVERFLOW;
+
+	addr = alloc_gcs(addr, alloc_size, 0, false);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	/*
+	 * Put a cap token at the end of the allocated region so it
+	 * can be switched to.
+	 */
+	if (flags & SHADOW_STACK_SET_TOKEN) {
+		/* Leave an extra empty frame as a top of stack marker? */
+		if (flags & SHADOW_STACK_SET_MARKER)
+			cap_offset = 2;
+		else
+			cap_offset = 1;
+
+		cap_ptr = (unsigned long __user *)(addr + size -
+						   (cap_offset * sizeof(unsigned long)));
+		cap_val = GCS_CAP(cap_ptr);
+
+		put_user_gcs(cap_val, cap_ptr, &ret);
+		if (ret != 0) {
+			vm_munmap(addr, size);
+			return -EFAULT;
+		}
+
+		/* Ensure the new cap is viaible for GCS */
+		gcsb_dsync();
+	}
+
+	return addr;
+}
+
 /*
  * Apply the GCS mode configured for the specified task to the
  * hardware.

-- 
2.39.2

