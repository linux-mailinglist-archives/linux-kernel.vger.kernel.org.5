Return-Path: <linux-kernel+bounces-9054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036581BFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2046F1F25E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7495768F0;
	Thu, 21 Dec 2023 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkq6TDeA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C2760B8;
	Thu, 21 Dec 2023 20:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBD8C433CA;
	Thu, 21 Dec 2023 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703191140;
	bh=NMCNTOGjIUtjnoYrDj2+Py8VXq1beUxtq9Z1hpoLDOQ=;
	h=From:Date:Subject:To:Cc:From;
	b=Pkq6TDeA6ngQsrhYyVqQm/idj9fXZtFQtsuSbSopT6bzKYv28z4XiEQFJ/5BLNLJy
	 Rk/05qVu8QpEkS8EYnVR7ra86Pyx40hiU3RnlzLCEhjMVgEPox7TZiOHJzxTFBM+DB
	 C0nHQRHbw1wO3aPy4PF0PLijGu8Y1dc9W+HRqerOgt1EC3SF9cdswrgLBZPNjJKx0v
	 pH/VzfezIRm71wm6HJT5L92Sq03yXUCN1ObsbeeQJX8iFnOcUPULc4qzBtzzEtmpeN
	 uoLwgAgRDyWzEJhOAedouy/GuYgXj8C6n/bzhj9hwzVKT03CKXBCtmeGALmH1vpfzM
	 pl9TL+WXyck1Q==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 21 Dec 2023 20:38:48 +0000
Subject: [PATCH] lsm: Add a __counted_by() annotation to lsm_ctx.ctx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-lsm-fix-counted-by-v1-1-12cc27597cdf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFeihGUC/x2MSQqAMAwAvyI5G7AR3L4iHqpNNaBVWhVF/LvF4
 8DMPBDYCwdokgc8nxJkdRFUmsAwaTcyiokMlFGuiBTOYUErFw7r4XY22N9oa2sqKpkKrSGGm+d
 o/NO2e98Pp1ZjTmQAAAA=
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NMCNTOGjIUtjnoYrDj2+Py8VXq1beUxtq9Z1hpoLDOQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhKJhcHJcTcKYxgKCegncjDqmRlmBIi6dxCHmcStR
 /v7DxBWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYSiYQAKCRAk1otyXVSH0LZ2B/
 91niFJEPlxuNvwaLVf8Borg/kzwBNfXZHOzrVQ1pmEzl/ULhg4pQBoRUtDcPR4zvEU0jvs506fiJR7
 ob+A6xca+oAIvyUiohTJa6cCgVlYpGXS6H1pzPe8wIeysWjrkivsfjw0+qAYD8f8rUPd0H0TQ9Eb24
 /yRITWpBTY/u9WdncGgLZHogYpMHC2XtXIz8Y2HeMU36mx51anGb7Rku6gTGG+upZWnkR9Bk/nqzl6
 gkUCM24nA832MoTh3FpUA+qLJGcpB3K9oRQNCZDqr0l8S8vafQZaOLRJnQSMmjT63Fy2GyE4oGznr5
 PirKGhhlwDKvAHNNXD/T5EMgjNgKH1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ctx in struct lsm_ctx is an array of size ctx_len, tell the compiler
about this using __counted_by() where supported to improve the ability to
detect overflow issues.

Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/linux/lsm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f0386880a78e..4150333d224f 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -36,7 +36,7 @@ struct lsm_ctx {
 	__u64 flags;
 	__u64 len;
 	__u64 ctx_len;
-	__u8 ctx[];
+	__u8 ctx[] __counted_by(ctx_len);
 };
 
 /*

---
base-commit: ec4e9d630a64df500641892f4e259e8149594a99
change-id: 20231221-lsm-fix-counted-by-f9fd827e26aa

Best regards,
-- 
Mark Brown <broonie@kernel.org>


