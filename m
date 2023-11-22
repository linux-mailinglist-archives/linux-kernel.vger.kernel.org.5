Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571747F42A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbjKVJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjKVJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:47:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECC81737
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:46:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A99AC43391;
        Wed, 22 Nov 2023 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700646391;
        bh=I+uVw8aipGa+8Ns9k+b3dq26kNHNXYgyRv4lZpoE8Nc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fUa44Bi64x8jXoE/MvI8BIoiZzNypKXZeeiprmYPWGJR3lX5FGydI1vtuAYWadks7
         UasgH5m/KtJQsDRJFu9SVTzRRZ09vZBslyb0Ho2ASTSMbx7DP6p+CS8+ianT5KLmas
         tJXDc07OIjutHkKJCdOQ9rbHFcS+M1Xk9x0/2ZDaXRW8l9gWOsMXGxNr64kYyyP2wN
         wkARHPE4CLrm5Ok5GqnIBpxAl47axEAxsh9fxCbSQqsYrNum0vfC6FHddFrleyQ0jj
         1fispSHLot6aPOIBz5WXtqFTgm3jtICwL5ybtt6OQ3R735RlkVitJiiQ8Rd9rwhnj7
         yf08/Sy6l7Hug==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Nov 2023 09:42:38 +0000
Subject: [PATCH v7 28/39] kselftest/arm64: Verify the GCS hwcap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-28-201c483bd775@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I+uVw8aipGa+8Ns9k+b3dq26kNHNXYgyRv4lZpoE8Nc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0MyzVIJO4Kid9gCsCQr45ifThlTEHkARV/j
 UTsXVxwqbuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NDAAKCRAk1otyXVSH
 0PTmCACERewHlO0lUDAx7VBob22qNqbBIi4nI0finRcfRAMHGdVUVIxWAqs+6UQtEQWTanwoxxh
 RHNYkE5AnkhBIVqgo9rPkkciwxmqsPMafm9s1H0t/nysi4FdiMxIMpg6pQt0D3ydQ1Psg/yCml7
 nbLsDLWDnrT2PZBbwMSZdbxpf6TLjfDdFnf2PqTp7lJXdovzdfaZM83h4amYvIT+snl3MZDg+DE
 yO8Tc24qt+aAP5Fbjm4kLsSFx2poUdmSadKGczZTZxfOnsCSNiQjkj2FshEGptZPCYDyN1vmU0z
 I1pxYkitO980tsJqitFcBPPgoo+CvzMYooor7SZAL9CXXBHj
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

Add coverage of the GCS hwcap to the hwcap selftest, using a read of
GCSPR_EL0 to generate SIGILL without having to worry about enabling GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 1189e77c8152..bc9e3250a9df 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -63,6 +63,17 @@ static void fp_sigill(void)
 	asm volatile("fmov s0, #1");
 }
 
+static void gcs_sigill(void)
+{
+	unsigned long *gcspr;
+
+	asm volatile(
+		"mrs	%0, S3_3_C2_C5_1"
+	: "=r" (gcspr)
+	:
+	: "cc");
+}
+
 static void ilrcpc_sigill(void)
 {
 	/* LDAPUR W0, [SP, #8] */
@@ -360,6 +371,14 @@ static const struct hwcap_data {
 		.cpuinfo = "fp",
 		.sigill_fn = fp_sigill,
 	},
+	{
+		.name = "GCS",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_GCS,
+		.cpuinfo = "gcs",
+		.sigill_fn = gcs_sigill,
+		.sigill_reliable = true,
+	},
 	{
 		.name = "JSCVT",
 		.at_hwcap = AT_HWCAP,

-- 
2.39.2

