Return-Path: <linux-kernel+bounces-85150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3393686B124
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE65A288B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94414EFF5;
	Wed, 28 Feb 2024 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZBoBpj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F0153509;
	Wed, 28 Feb 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128927; cv=none; b=Lc0uNjoOyvQhj3iiL0KfSIupofmtfestWrdbubBQHA+Y/nH2SkpOFXAwTb7fyErX8V4T6XwrANfM/GfKLhEHUs23vTEdSxV4JAUUPct1fH2Z4RrbyVhTUWdsIrczp6Z+vBX82KaKZf4HC5CcNHMRpJTIgPCfXtO9qEkhDQCC0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128927; c=relaxed/simple;
	bh=v8piWjx7eAY0lLoFwqlEm66435Li26xyEz8YoqwyhTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iq9v7toUprYqnLGkT58ueoMcGEi3VQMTEulX5KfW/e4hLEvCKZjXA0VjBOygl0Yotp8QvTrwqDKev5y0WJzL66A6uUaE1jgO+EmFMWTf+scxDfsg35sBqdLJFNEImUfqh3wx1904ZrUbBBl0ctiMA1KE2z96D9cEAYgf2MWspVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZBoBpj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A7EC433C7;
	Wed, 28 Feb 2024 14:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709128926;
	bh=v8piWjx7eAY0lLoFwqlEm66435Li26xyEz8YoqwyhTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JZBoBpj1/3w8VbLj0n2spVtSh9Dn90lTiUjQBWPhL/llNwsZWE4FEIKZ1O+aK9EmG
	 QUioOYYCKmXIVuqLd+ypwjYC0LVp6d/ERGta+GreOP2rrS8vHWLhWyxPFX5DAbWwbB
	 UPx+2kzf9c3nvuCjJ6ldRRPAtAU8cL0l2mlKAqJnM8eyJAeuZMuD5w/GxDY4JcnmC2
	 0ELr6yF4y7gnIT4Crly95B3nVW+ABTy42C7VsM098zO682kt34TyQ23PWoVnOINgmI
	 +oLRC5b+LE+IGNPHo8/r/aVWzg/+BhY+jKYt/5jmW/9kBOk/Z8kA+q+DhtiV8Ms4G1
	 NVlMMJx5m9ikQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ALSA: asihpi: work around clang-17+ false positive fortify-string warning
Date: Wed, 28 Feb 2024 15:01:45 +0100
Message-Id: <20240228140152.1824901-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

One of the memory copies in this driver triggers a warning about a
possible out of range access:

In file included from /home/arnd/arm-soc/sound/pci/asihpi/hpimsgx.c:13:
/home/arnd/arm-soc/include/linux/fortify-string.h:553:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
  553 |                         __write_overflow_field(p_size_field, size);
      |                         ^

Adding a range check avoids the problem, though I don't quite see
why it warns in the first place if clang has no knowledge of the
actual range of the type, or why I never saw the warning in previous
randconfig tests.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/asihpi/hpimsgx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index d0caef299481..4f245c3956b1 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -576,6 +576,9 @@ static u16 adapter_prepare(u16 adapter)
 	/* Open the adapter and streams */
 	u16 i;
 
+	if (adapter >= ARRAY_SIZE(rESP_HPI_ADAPTER_OPEN))
+		return 0;
+
 	/* call to HPI_ADAPTER_OPEN */
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
 		HPI_ADAPTER_OPEN);
-- 
2.39.2


