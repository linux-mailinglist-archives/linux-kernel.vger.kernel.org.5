Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12FC805C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbjLEQwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjLEQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA9A10F3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAB2C433CA;
        Tue,  5 Dec 2023 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795110;
        bh=qb52W/FnN/1SulYmCofB+kYw3kMDdBBbntUr0aosnTs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=T34l3XKnE5gECQM5L6taQY0p3+GIfL+S5exCF0e6AFcFvBu3gn9UJbRw0Gc29c1Vl
         +ObdIVRfzPk4qMkiS1vL6H3bIidZ1hgR1toS8QwCsOh2erkxs5gjwHzSB+mD9WNG6b
         nngGk3RBvg9lRAnm4p7XL5nuYdxK2+i7l7dvURwxpcKn+zbC/wHqaKJP7atHlpoc/a
         Kr3ODfek+6ZH6jAWGlufsaJKNn1G2SPeqMHY7bEfR6ntwj4YqakLQ0E4DeMZj6l/7M
         zFz2VhAkwGY6ZLXVlJLQn+qJo8s8SRrA/IjxP9xGDjrLQuApw9RRcgY98gXmQ+I9zH
         XqKr06C88W42A==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:10 +0000
Subject: [PATCH v3 12/21] arm64/signal: Add FPMR signal handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-12-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=4170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qb52W/FnN/1SulYmCofB+kYw3kMDdBBbntUr0aosnTs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1Ty3DJCPBiQ3pPRLeMudBSQufj2eMfHt4Hg/rab
 nrar9cmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U8gAKCRAk1otyXVSH0CMdB/
 9rvTD79SVpqdgCB6JORythRzbySDQ9lA+ijLtJeO9lOtj5I4QJd2qCeJOe5/R26gBSZqMJVXtMZ2Jt
 Ts6CsETSCV0v0uFZi7Liz76BbntjU/6BhVfl+jADUtNdfWul4KyYo+1RPAyzyoaV8l7tzP2PAEbtNZ
 sEuOifI13xNo7pDYGq0hKJ5ehmE8IN9D93p+rjMM4vbiQS7jdnahmWl5Ha/mZJWz+pQC2nKvY1fy1j
 3i4keDlZ5CC45MYQ9UMnj0JkdGSRSkSZEhg5BiOjxjtPHOaktdCEWPaDmOBPmipBXrwtuA1kHWbkap
 Oni+rqtXUOWMXhiE9BLnGa+mmGIU8w
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose FPMR in the signal context on systems where it is supported. The
kernel validates the exact size of the FPSIMD registers so we can't readily
add it to fpsimd_context without disruption.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  8 +++++
 arch/arm64/kernel/signal.c               | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index f23c1dc3f002..8a45b7a411e0 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -152,6 +152,14 @@ struct tpidr2_context {
 	__u64 tpidr2;
 };
 
+/* FPMR context */
+#define FPMR_MAGIC	0x46504d52
+
+struct fpmr_context {
+	struct _aarch64_ctx head;
+	__u64 fpmr;
+};
+
 #define ZA_MAGIC	0x54366345
 
 struct za_context {
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0e8beb3349ea..e8c808afcc8a 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -60,6 +60,7 @@ struct rt_sigframe_user_layout {
 	unsigned long tpidr2_offset;
 	unsigned long za_offset;
 	unsigned long zt_offset;
+	unsigned long fpmr_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
 };
@@ -182,6 +183,8 @@ struct user_ctxs {
 	u32 za_size;
 	struct zt_context __user *zt;
 	u32 zt_size;
+	struct fpmr_context __user *fpmr;
+	u32 fpmr_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -227,6 +230,33 @@ static int restore_fpsimd_context(struct user_ctxs *user)
 	return err ? -EFAULT : 0;
 }
 
+static int preserve_fpmr_context(struct fpmr_context __user *ctx)
+{
+	int err = 0;
+
+	current->thread.fpmr = read_sysreg_s(SYS_FPMR);
+
+	__put_user_error(FPMR_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
+	__put_user_error(current->thread.fpmr, &ctx->fpmr, err);
+
+	return err;
+}
+
+static int restore_fpmr_context(struct user_ctxs *user)
+{
+	u64 fpmr;
+	int err = 0;
+
+	if (user->fpmr_size != sizeof(*user->fpmr))
+		return -EINVAL;
+
+	__get_user_error(fpmr, &user->fpmr->fpmr, err);
+	if (!err)
+		write_sysreg_s(fpmr, SYS_FPMR);
+
+	return err;
+}
 
 #ifdef CONFIG_ARM64_SVE
 
@@ -590,6 +620,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->tpidr2 = NULL;
 	user->za = NULL;
 	user->zt = NULL;
+	user->fpmr = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -684,6 +715,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->zt_size = size;
 			break;
 
+		case FPMR_MAGIC:
+			if (!system_supports_fpmr())
+				goto invalid;
+
+			if (user->fpmr)
+				goto invalid;
+
+			user->fpmr = (struct fpmr_context __user *)head;
+			user->fpmr_size = size;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -806,6 +848,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
+	if (err == 0 && system_supports_fpmr() && user.fpmr)
+		err = restore_fpmr_context(&user);
+
 	if (err == 0 && system_supports_sme() && user.za)
 		err = restore_za_context(&user);
 
@@ -928,6 +973,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 		}
 	}
 
+	if (system_supports_fpmr()) {
+		err = sigframe_alloc(user, &user->fpmr_offset,
+				     sizeof(struct fpmr_context));
+		if (err)
+			return err;
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -983,6 +1035,13 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_tpidr2_context(tpidr2_ctx);
 	}
 
+	/* FPMR if supported */
+	if (system_supports_fpmr() && err == 0) {
+		struct fpmr_context __user *fpmr_ctx =
+			apply_user_offset(user, user->fpmr_offset);
+		err |= preserve_fpmr_context(fpmr_ctx);
+	}
+
 	/* ZA state if present */
 	if (system_supports_sme() && err == 0 && user->za_offset) {
 		struct za_context __user *za_ctx =

-- 
2.30.2

