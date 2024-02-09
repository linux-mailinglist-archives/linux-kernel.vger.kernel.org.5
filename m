Return-Path: <linux-kernel+bounces-59682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934284FA4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DD61F291B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0DD86AD8;
	Fri,  9 Feb 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp3HUt2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36337BB04
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497623; cv=none; b=VW1OcTI2oUPvncm+anLZJ4viodVpKFT8+Fkl16W05YCm7amU16rYqVQvmBUf9fzLiyA0vcRXlq+f6//DwZWbtNyRcIiK0ULldeiJZH35E00kwhJTyl3CfebAODnc1wKhOg3KagDXmXdLfW0TMl3BxjIDYqHBFnYwGGXCmY2e2pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497623; c=relaxed/simple;
	bh=LPmWvu0/qYz7qCac8LkiBOl/gSdLmPufqHJzTjBvvM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VWevraRFjd6tGQRJToJOP1nDU3gc/bePknBPGEfls9B7Nt8GqTsDndt9hOg2GJujxdd/94JWBmruaB8+VojVxVnTusG/I+5G0zgAU2KP6rf9F5o7U3uqoABLW23uaKo0McF2pa6FKSm70eTBf6O8XMWj5jarQlkf0SMbZywEm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp3HUt2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2758C433F1;
	Fri,  9 Feb 2024 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707497622;
	bh=LPmWvu0/qYz7qCac8LkiBOl/gSdLmPufqHJzTjBvvM4=;
	h=From:Date:Subject:To:Cc:From;
	b=Gp3HUt2rqPqLr4EMOCQJj5WycB+cykYdg+NQQwt2ATnp+Pm9/U1C444psESIa6glw
	 Ynf76roOpbKW5Gr93ed7GQR1e9YL8A+KpLyyRECYnhr0USMxWELDmuzYrodh25ifrz
	 BnAwnj89onLl5FU1ZV7qLV1c9GDoKfUhcqqdQtGxZR/0xaUIuIOxVC/YvrVasGi+qA
	 5hSPCbgwGGllkEGRxPRU47hXGlO3wCIh5IkkiPhiI33BR3zmQ/X8k0VBR7+OsT3P3A
	 wEesH6ZlkJUPdI4REe5xCLoLT/pfnxV8F2tE+jTwJDCme5IvMeZW2uOL6b+1nOHOzz
	 ld3iFECIdQ1UQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Feb 2024 16:53:36 +0000
Subject: [PATCH v2] arm64/sve: Document that __SVE_VQ_MAX is much larger
 than needed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-arm64-sve-vl-max-comment-v2-1-111b283469ee@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI9YxmUC/42NQQ7CIBBFr9LM2jFAkYUr72G6IGVoiQXM0JCap
 ncXewKX7yX//R0KcaAC924HphpKyKmBunQwzjZNhME1BiWUFkoYtByNxlIJ64LRbjjmGCmtaDR
 523vRG3WDNn8z+bCd6efQeA5lzfw5n6r82T+iVaJE55yXRkutpXq8iBMt18wTDMdxfAFTjwwzw
 QAAAA==
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LPmWvu0/qYz7qCac8LkiBOl/gSdLmPufqHJzTjBvvM4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlxliTT4K6oUVqMYwdqskmUbVXtesPvccvCYH0x
 PiAa2UdVxSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcZYkwAKCRAk1otyXVSH
 0K+tB/40gNlnhJ/eFz4vBSvLpUHQ40bd5sRJGwfngnD7yqxirWxxPBg9Aqi1XhM5xxV0AMoHRSo
 c9KtV1OaZvigEjTrMLGeVSagQ7U2+DT+0pdPkcice/rGFb4PhfA4qzWqyLEyyfDsF4rpwXxWR9/
 L5RH/uqktwzlspDwgrJ8LVwLyScRd7IGhWOm5ZNqWo+y+RZQ1dNPcRE3o0iXy1EGwG/ccJpBfc0
 J2tlTPXb6+9DG/5xYq5CrwH4PKqpoOfS6gQ9qe9xmH/vilegBXuldWlypDSbU4Xl5OnITEpDPHp
 GnzETzf994WWCNwCDGzQM8BlmVGqG7p2G96utjT1DyfqiCjC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

__SVE_VQ_MAX is defined without comment as 512 but the actual
architectural maximum is 16, a substantial difference which might not
be obvious to readers especially given the several different units used
for specifying vector sizes in various contexts and the fact that it's
often used via macros.  In an effort to minimise surprises for users who
might assume the value is the architectural maximum and use it to do
things like size allocations add a comment noting the difference, and
add a note for SVE_VQ_MAX to aid discoverability.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Use new wording mostly provided by Dave Martin.
- Reference __SVE_VQ_MAX comment near SVE_VQ_MAX define.
- Link to v1: https://lore.kernel.org/r/20240206-arm64-sve-vl-max-comment-v1-1-dddf16414412@kernel.org
---
 arch/arm64/include/uapi/asm/sve_context.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sve_context.h b/arch/arm64/include/uapi/asm/sve_context.h
index 754ab751b523..72aefc081061 100644
--- a/arch/arm64/include/uapi/asm/sve_context.h
+++ b/arch/arm64/include/uapi/asm/sve_context.h
@@ -13,6 +13,17 @@
 
 #define __SVE_VQ_BYTES		16	/* number of bytes per quadword */
 
+/*
+ * Yes, __SVE_VQ_MAX is 512 QUADWORDS.
+ *
+ * To help ensure forward portability, this is much larger than the
+ * current maximum value defined by the SVE architecture.  While arrays
+ * or static allocations can be sized based on this value, watch out!
+ * It will waste a surprisingly large amount of memory.
+ *
+ * Dynamic sizing based on the actual runtime vector length is likely to
+ * be preferable for most purposes.
+ */
 #define __SVE_VQ_MIN		1
 #define __SVE_VQ_MAX		512
 

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240206-arm64-sve-vl-max-comment-64efa3f03625

Best regards,
-- 
Mark Brown <broonie@kernel.org>


