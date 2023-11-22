Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0809C7F429C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbjKVJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjKVJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:47:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADC1725
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:46:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866E8C43395;
        Wed, 22 Nov 2023 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646383;
        bh=0y6nS2SVdzl2qxV5TcDCnpKi8YQvhWLC/gR5WsuQggw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZNt/mhOldQGyAGrFdcd7zCoYi9c4Cpbfl611N1nCbvre1FYvH7Zl1qxYMHlLUXK/R
         oTr4pGgCl3ZqkdfLg9vxV823aJQE0eCLlAhRLaW1gT0pmdwjk38uP6NXqfphyDxggd
         Nce0uiHdxAcfp2N1Y9laenaA7HV7sOUFODNyqrBMy7XcrOzKnRNQTKmHrYboi3WFf4
         QOpE3cQlVvo2KE6NieOOuSEronhIGHfX5fucm1ZO0NVH0NxleNUmMK8+wdtaJLpRNh
         bN4Wz6vhiC+V3XP1enBFhlP/PZm5aE6IiSJnXGkBC62BqC2W7W+tQNNElkgCPc4NEY
         Pt1AESbQWlpmQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:37 +0000
Subject: [PATCH v7 27/39] arm64: Add Kconfig for Guarded Control Stack
 (GCS)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-27-201c483bd775@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0y6nS2SVdzl2qxV5TcDCnpKi8YQvhWLC/gR5WsuQggw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0LjTRQMrZZBOJgPLB48tbG4uiml7CZIDEV5
 uQD798eCNqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NCwAKCRAk1otyXVSH
 0Iq3B/9HlE8pfPFk2nuyqu1U5wC2TDnfo30tlZoqa72rjxWoZMeOZIt03d7ifiDGT60BAhV7DR/
 X2q4ijl0gxsqAdoQTECIT09I17i0jhkg4sOrFnUM9S88Dc3B+OIQORdu8k6AozeCurJMkcd/ICY
 snWt5N0Nh2ox8T7U6IwsCVSrOZfctm8ylWDVAVHxsy53/DBhuI0FtT+rlbYGseRcYj1zRLPXpf+
 BVttx7Ntz2AelFYWVTuV1+GEKIwFIHMxKR/QSrU8uS9CzItwTUAOZKN30cLz7YqjsJMsYAnSVKN
 Bd8Eqt+f6s9NrIoUWZmOF8FfRH4sNLQwPl0XXWRCxkdsmJNx
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

Provide a Kconfig option allowing the user to select if GCS support is
built into the kernel.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..05cffc0f5786 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2078,6 +2078,26 @@ config ARM64_EPAN
 	  if the cpu does not implement the feature.
 endmenu # "ARMv8.7 architectural features"
 
+menu "v9.4 architectural features"
+
+config ARM64_GCS
+	bool "Enable support for Guarded Control Stack (GCS)"
+	default y
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Guarded Control Stack (GCS) provides support for a separate
+	  stack with restricted access which contains only return
+	  addresses.  This can be used to harden against some attacks
+	  by comparing return address used by the program with what is
+	  stored in the GCS, and may also be used to efficiently obtain
+	  the call stack for applications such as profiling.
+
+	  The feature is detected at runtime, and will remain disabled
+	  if the system does not implement the feature.
+
+endmenu # "v9.4 architectural features"
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y

-- 
2.39.2

