Return-Path: <linux-kernel+bounces-108146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8328806A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FDC284843
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D143FBAF;
	Tue, 19 Mar 2024 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmfLCLnL"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C614EB5D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883202; cv=none; b=hsVY2hvWKwzZL9SmmACPwaPZeXnIQWko/nymG5nH6bU7wy27ze4UFvknlDFPE7ixpj+QsqFS+JlwhmGoFvUnZoTaA6LO2wJoitCbc0RHshCZETWwzJ6y4tA0+vByU7E4vVjMIK54O4yU3Vhz/ttwtUFtL6JeGCXie2Uvr9vjDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883202; c=relaxed/simple;
	bh=Mdg4v+gVR1XXoJ7LDiKyb/js1DlYqwa9cvruL0+pdyw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZhkIlF5+vrPLoO7UXtdY+UkEx2o70b4+iyMrphumSJ0h7QUeSzZoP3YBw0fOTjFL7JgZQ/kahJdxzgbnbXTioPzNZg4Ip+T673JEB46ybU+GtyaitCiImax2zrpgJ69ypZwrNO63Eba4WTUnqXGp3Sry7C6bYT7rdvo7JqCmw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmfLCLnL; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7cc764c885bso284938639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710883200; x=1711488000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+P2giq0KAVuF343w/p3qlKL7+PcOe1+28vHCwGD1ebk=;
        b=RmfLCLnLmsR9mhY3CO9C4W3I/PUHsHFJIbovRwyI0rs07KY/tcsHC4cZ4XccrlHgEs
         bBxJ0/3MZRMDkwD6WLAOpWnEDY4FSoATZf7xbBASfMyIeuVRhgdJ/8XgsApTVqBZRB4F
         CFALffKel050sCsHst0biguvm7miVHy326nF1baL0hXUHXy1Noe5XZmOBrVVOSkMnozR
         bHAazkPyloya5GSO3CLap49iqRCi7SlXXd5VwEanCwkc43MjbxK/zKoF3EIBVY5M8px+
         JAJrXReqNYOshyNx0+6a34AN2kcDaMawlOUPHRi3jLFys8nkAfpsw90wQsgcRWzGf5bV
         CCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710883200; x=1711488000;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+P2giq0KAVuF343w/p3qlKL7+PcOe1+28vHCwGD1ebk=;
        b=EGZj9GMkjv2OzV1dJcUsUaNY/5NQDzO0FI04OkClnyEA0BhnewYffcPqwFEG0+83E4
         C+uwMJkM5pHIBPOyOc4gWqaWXXJR2XWpryp+4an1zYInFW6riX7xFVBpb3czYjzH7Aav
         BspqLznsaXHShQ2mUm3tjyrVPcnlywmCiZKjdq8dMwmn1b72RvgDnxezX6gUl0aRnW3q
         Aqxf/Xg5v2WqWojFHo3yHEUPdC8LWWgkhHf9krUmFUIMsYjjeb6+OimELh3dffvDfvvE
         e21L2LWPR4wonpJevTQ73Y/WkyOvnpZgHoMNea3JWUsy1Lo/yXANGBtgs4DoQ/pqNUaV
         yYjg==
X-Forwarded-Encrypted: i=1; AJvYcCWjmYK3YUIPCzzQEOzNo4oFRj+lgFUHa6uG6dkGi3gcwjRQhNVSEYo2H9hJ7NY6yGPe6NrwOFYn0vS8ozuYv1vD/SG3CUfQsY6u7anc
X-Gm-Message-State: AOJu0YyVd3CSzpdV0fgEYQXpyafLzyTCUenxVbQX2dC/X3g9QiVB/bPZ
	rL80BlRo+K1h2QDqNVepgXrlGObPtnKWmcHBCNWTAn0A88c+9bDpUlu7uXpCafUWs4nvFTh3g3s
	tPrik2fzumIc8W9DYGHBJTA==
X-Google-Smtp-Source: AGHT+IEjYa8XAuzaZ3QDjFc+CmwpKb+B2fiaTFJKL46VazLIXLWNGSzFGXrx+jPM3IbTpLMVy06PiFtlUIAyiHMl5Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:2c94:b0:7cc:342:72f9 with
 SMTP id i20-20020a0566022c9400b007cc034272f9mr297570iow.2.1710883200494; Tue,
 19 Mar 2024 14:20:00 -0700 (PDT)
Date: Tue, 19 Mar 2024 21:19:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH8B+mUC/5XNTQ6CMBCG4auQrh1DW5DqynsYF/2ZQhOh2JJGQ
 ri7hZXudPlOJs+3kIjBYSSXYiEBk4vODzn4oSC6k0OL4ExuwkpWlZxWEKcw6HEGE1zCECF6DU/
 te9C9AaNAAxOV5VJJqZQg2RkDWvfaN2733J2Lkw/zPpnodv1HTxQoNKWtTY1N2XB2bb1vH3jMX 2TjE/skxS8ky6SwJ1SWKiPO9Itc1/UNgE518iYBAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710883199; l=2271;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Mdg4v+gVR1XXoJ7LDiKyb/js1DlYqwa9cvruL0+pdyw=; b=Fu5AbgciDR7kyPaRIoo73doyAxlV6sVzOVwcGzj5a0Hjq/yMcTBMrykb+d+ZRRZdAIphvOzje
 LT65OpzS84VCMIjD2l5Sw4sVwE+biQfYsuW0wkHVZ0og9OiNliktfT7
X-Mailer: b4 0.12.3
Message-ID: <20240319-strncpy-drivers-soc-qcom-cmd-db-c-v3-1-aeb5c5180c32@google.com>
Subject: [PATCH v3] soc: qcom: cmd-db: replace deprecated strncpy with strtomem
From: Justin Stitt <justinstitt@google.com>
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is an ambiguous and potentially dangerous interface [1]. We
should prefer more robust and less ambiguous alternatives.

@query is marked as __nonstring and doesn't need to be NUL-terminated.

Since we are doing a string to memory copy, we can use the aptly named
"strtomem" -- specifically, the "pad" variant to also ensure NUL-padding
throughout the destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- Prefer strtomem_pad (thanks Bjorn)
- Reword commit message (thanks Bjorn)
- Carry over Kees' RB as this new version is functionally the same and
  matches the same spirit of v2
- Link to v2: https://lore.kernel.org/r/20240318-strncpy-drivers-soc-qcom-cmd-db-c-v2-1-8f6ebf1bd891@google.com

Changes in v2:
- use strtomem instead of memcpy (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/soc/qcom/cmd-db.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index a5fd68411bed..d51ae99d9c02 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -147,12 +147,7 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 	if (ret)
 		return ret;
 
-	/*
-	 * Pad out query string to same length as in DB. NOTE: the output
-	 * query string is not necessarily '\0' terminated if it bumps up
-	 * against the max size. That's OK and expected.
-	 */
-	strncpy(query, id, sizeof(query));
+	strtomem_pad(query, id, 0);
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];

---
base-commit: fe46a7dd189e25604716c03576d05ac8a5209743
change-id: 20240314-strncpy-drivers-soc-qcom-cmd-db-c-284f3abaabb8

Best regards,
--
Justin Stitt <justinstitt@google.com>


