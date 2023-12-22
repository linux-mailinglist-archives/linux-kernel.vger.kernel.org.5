Return-Path: <linux-kernel+bounces-9795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5CD81CB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442F41F23D68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1085F2374C;
	Fri, 22 Dec 2023 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmE7+o7x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4423740;
	Fri, 22 Dec 2023 14:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC2BC433C7;
	Fri, 22 Dec 2023 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703256882;
	bh=Tf6r9+dOJakriookGkExO9gdNVREb4CJwWTm93Lq6B8=;
	h=From:Date:Subject:To:Cc:From;
	b=BmE7+o7xibvyL1cPsn3sUQEc2K7uvqtKiHB8ZEUmzHqC1V0M3gJGUhBUv9/gUtDAa
	 OhikQutGcBJikPIH1PWNSh3W0fe8nusKNfELhZPkRhR0SdCH9ctEuUp+BoaJaZ90/b
	 cUcea556r653aV87getayQiU2dP26arQlVz3xukFLSdbyCnm6gY1oHKlSl7kr3zJv5
	 EtPpqvTJAYYukwNFSortNLXTXOwbStMINfpR+GFzMpLPtei7rVqiimH0W9RxgHL61h
	 yTSp/aOiBCEi1nBaU67U5VSg5cVEE3KjOzzwcvPq9xXWuOQaV2v0bV5U6QqOcZOGCt
	 yWl9+6/K/FTeA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 14:54:37 +0000
Subject: [PATCH v2] lsm: Add a __counted_by() annotation to lsm_ctx.ctx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-lsm-fix-counted-by-v2-1-f1237a095bdc@kernel.org>
X-B4-Tracking: v=1; b=H4sIACyjhWUC/32NTQ7CIBCFr9LM2jEyRrGuvIfpAmFoiRUaqMSm4
 e5iD2De6nt5Pyskjo4TXJsVImeXXPAVaNeAHpTvGZ2pDHSgoyASOKYXWvdBHd5+ZoOPBW1rzYU
 k01kpqMUpck1so/eu8uDSHOKyfWTxc//OZYFVpDXJUyu1sbcnR8/jPsQeulLKF+dZ4DO1AAAA
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Aishwarya TCV <aishwarya.tcv@arm.com>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Tf6r9+dOJakriookGkExO9gdNVREb4CJwWTm93Lq6B8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhaMv/ELUVrM0GuXyutYsNbqAiTiWGM2DJYFEcwQ8
 cfgmv++JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYWjLwAKCRAk1otyXVSH0LQZB/
 sEPxe44AsrwfISPQhOJQqpoDU08dBpuIpRT3OXE0oJFqhXeSccZBba0BM3U10GzFS2UK9FLlGjoIbh
 FKz6IXXIKUgZu+z8XyyDQk9Z73+Feex94HtfaQL4qpgAIwELqP6ff0jScbiK6E6swF9JDo28aqjLjh
 v2S/sBBc+OEu8iLFA9V5eT+Qi6I1XfJhYxH8+/ZrdJ6d3CDSjSJ4FvNc9E0L0UQB7neJf8TcjqvnOr
 Cmv/ebG5qqNhnkW46R5Mafbeb+pWTWJg4uRrXH9DlRag5nIAtGanyCy+cocIk9DMx0/MhhFOWJr/3h
 c/VbPTFugX9+OqPEOcoHnwf8rRbqn/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ctx in struct lsm_ctx is an array of size ctx_len, tell the compiler
about this using __counted_by() where supported to improve the ability to
detect overflow issues.

Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Add explicit stddef.h inclusion in case __counted_by() definition
  isn't otherwise pulled in.
- Link to v1: https://lore.kernel.org/r/20231221-lsm-fix-counted-by-v1-1-12cc27597cdf@kernel.org
---
 include/uapi/linux/lsm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index f0386880a78e..f8aef9ade549 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -9,6 +9,7 @@
 #ifndef _UAPI_LINUX_LSM_H
 #define _UAPI_LINUX_LSM_H
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/unistd.h>
 
@@ -36,7 +37,7 @@ struct lsm_ctx {
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


