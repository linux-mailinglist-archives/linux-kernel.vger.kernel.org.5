Return-Path: <linux-kernel+bounces-75846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CBE85EFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BB01F23B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C343017560;
	Thu, 22 Feb 2024 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PtNW7RHd"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88CA17553
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572368; cv=none; b=i6h0zUpzpDqFm0H+GYOSL4sNWb25edrZsvM3CWSHbvaJyifa8q/dWxfWu+BIZ2sOaY0mimbHj+pHdPRUr88c8Rr4FACp9mUGJ7hFl5vGmMuQZ8crxMnvrOC0YiRnOIzBBtnOqovECDAN2XmavAq3rq1ljTUjlUnYFmhb0rNms1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572368; c=relaxed/simple;
	bh=bzZ3fX2DEFw0nOMx3kh5bVpyXkZ4XTMyHUYzy2/dFvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6rC/sPag/KO1d8/aQeQ/5tEpZ9wF3L4/3ANW8Q/7wfTPWhjTvwTQtrt9T7bUUewliuafmnPiNFH4CMJdQsohu+xY8WBwEhMYwaxUHV11PEbLGDWrtCjgA0VOgNtCnamloocvjVPxN4SH7cKd64LLl7jMN9S6rVAVYJDEZEFpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PtNW7RHd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc29f1956cso10342805ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708572366; x=1709177166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSw2XZua5CqiB9gf2+U2cFgOtZgxjplbw5UzRI5t8LU=;
        b=PtNW7RHdSMdHfUYrTsy76NtBVVgA8/SHqYhhQXDHUy+3s1RGfxVBTDkUnK0a0Dz3s9
         i2Ej0BBZ36oH61+7st7Of3JSYygAq6ifRdVKOej0UAsrflrZ5t9ws1ZeTq3wGkq1CnoH
         FkaT7hFwiJu/eNpJPJgpVHO4jk5t1dVueqPno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708572366; x=1709177166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSw2XZua5CqiB9gf2+U2cFgOtZgxjplbw5UzRI5t8LU=;
        b=XkOAyevRTyZrBdh67JYxOEc7IdiG/IwY6CIGwohQHCJJrlgYNJXf9Zgj4AgJIgiISp
         o/uHViaQyVrlH2+59s99jhuVJFsVc//yQvzg5J4rJLniNQS+hoNgVNv/NbIsAwFJrjzZ
         TVQ/MSG30kyS+87E3Vo9R+ooV5PPMyxKPfSjhnSz1j4fd+Cq2pc0Ivr0W3S2q4SSmDTM
         DNsgKVvliepXeeySPA8ygCxywUelgFkOimPZLf1UKfXh/I2V+L4inIg/CpISOh+VDa/A
         jdxZqUJVJGNCF4ofG0R1d2f6XPH75MPBKFgyH5tvBL8jO3UtJAmE29x39FySkSj6nNVX
         y/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHYS5g+64AYHXh9VxopKpnXGWXHDmi7Tn8ykioBPMaQxuQrKkG8NTVyMCUgl+YJXAap7BPvEL2c+8hMLj4tswzAHgqDoPm3PVa8IjL
X-Gm-Message-State: AOJu0Yw0i4m8vyUAWOiJN6HW2IAFukK7K0RoXWIX058pVWKdFelu7C3Q
	AEm577NHArr10EYaheTqWbpCOo27GOVJMyZLtWsNSlpVNfayTDYiSQhQPxszwg==
X-Google-Smtp-Source: AGHT+IGOe3WWge9cSMFBSWmiMSAx9ofR2X6nwTUk1YuqlzcKU1YRsNpuiCLjQXeKqRqct+Nd87AuhA==
X-Received: by 2002:a17:902:d2ca:b0:1db:e1f4:d483 with SMTP id n10-20020a170902d2ca00b001dbe1f4d483mr13653262plc.12.1708572365981;
        Wed, 21 Feb 2024 19:26:05 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:480:9ded:eece:6cb3])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b001d937bc5602sm8818337pla.227.2024.02.21.19.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 19:26:05 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] kconfig: add some Kconfig env variables to make help
Date: Thu, 22 Feb 2024 12:25:31 +0900
Message-ID: <20240222032559.496127-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222031801.GG11472@google.com>
References: <20240222031801.GG11472@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section "Configuration environment variables" to
`make help` output in order to make it easier for people to
discover KCONFIG_WERROR, etc.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 scripts/kconfig/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ea1bf3b3dbde..0044d49e149c 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -158,6 +158,10 @@ help:
 		if help=$$(grep -m1 '^# Help: ' $(f)); then \
 			printf '  %-25s - %s\n' '$(notdir $(f))' "$${help#*: }"; \
 		fi;)
+	@echo  ''
+	@echo  'Configuration environment variables:'
+	@echo  '  KCONFIG_WERROR                 - Turn some Kconfig warnings into error conditions'
+	@echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfig warn about all unrecognized config symbols'
 
 # ===========================================================================
 # object files used by all kconfig flavours
-- 
2.44.0.rc0.258.g7320e95886-goog


