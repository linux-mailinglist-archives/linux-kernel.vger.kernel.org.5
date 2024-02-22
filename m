Return-Path: <linux-kernel+bounces-75838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B385EFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A241C20E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7A171A5;
	Thu, 22 Feb 2024 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UuXHtPOh"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834528EF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571554; cv=none; b=TK8ePBMrTHsT8ogNoSN1V2w1Bt38EwLwr4KayQAGlSfPAnk+y1nHrF5H+4u/Aw8z1K0UB1QVgLW54T8IqBJQLM0qVR7ypt3eHrGoQBMQp3TH3feOZ24tRXKyVhYBHg3uRQZN0L+VXWdeCN7Q8hYNt1MQ62p6KEiSFTd/lLAbFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571554; c=relaxed/simple;
	bh=t76bTeaY1oO0hKMH63CgusnsVSDq295EZx6khFeKZZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6DUT317etZVAhfoU2u1NEOL2mFyFaLZlNyunV4u9ab/0KuzCTL+VrpKcTelyRYZw6RDpsZlO5HAFjP8EsnUP275HiaPcFBhNqqzmYeHbluVFU83OES4y8vC5GI6YU7xVenUrQZIX5Q+P6f81hNFvSczWEuGZkoaPzTG24NRW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UuXHtPOh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7431e702dso73061175ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708571552; x=1709176352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXAtKGBTQphe1VTUrO0UL5mNNpHbTJAM2XNak4iATx8=;
        b=UuXHtPOh0BSgimPRIDsWSy2sEQyjESzOs472eclYKRULmarc3uOHh7gRVMA2KXM/6n
         qp5hx2sW/RPbEcxG0T9i+ZcftHAfcbdJrV5Pbm+tY+BKxVxW3o49tP1MOpZb8MJWGcHp
         qTEU7FIgXy6gRbg66iFyHQ5rZRcB9+u+dH1gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571552; x=1709176352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXAtKGBTQphe1VTUrO0UL5mNNpHbTJAM2XNak4iATx8=;
        b=VaoCwPnIk6ch6Hm3iwExc/IpGFoMPvfnkqGBn6yLnrMckJ7LTm6aDrfqRaftaRv0Qd
         cE9tAgO98W8lOkWb57NT5pahRPap6aPgtOCbLU5Hl0qow6ZQgR4xT76ceJynmJHH4hDx
         jnxU35yQU2IhHMMK4zrUDIhCEO/AJLPPAK1n/iGgWB3E9EkVm2XhnEe8UhMf3rIivQ1c
         tUWZab3ImC6lPtivZ8JCEwTsv8bnyKHDXj6AguChU+1UTNwsIux7BNlZSvYPb+toquoa
         H63AvdP2ND30plDwtPsx/gvBu2DPYuFlJQC3HxHCNmGFeRCM/yJYmONULCvJn2BFLmt2
         HM3w==
X-Forwarded-Encrypted: i=1; AJvYcCW7Tmyx7iHP2msVlFMnSNqsWbQDJ37mh1DodKnBlIejaYz1LAmhAsL5Zj/tLCstO1avfiLRaxCLPXyjVjphgrsoukWbDerv2KIhbncd
X-Gm-Message-State: AOJu0YwxPYjA6oxslHoFB7qkkIHZOmvihnMnkC9NMGcEJF+r9pRice7+
	YTDqFZ2Agxhp2wSlXNZIbVF/vt/BwykrxH71XG+t2oNfDdbQFzIL1LO//RCeTQ==
X-Google-Smtp-Source: AGHT+IHDHQmJBofzH26P/NRGNfPQs2RH2p1YdtpUAqVIJqQ503WaN981yxMspFGWB6Z/NTQhlMFhMA==
X-Received: by 2002:a17:902:da87:b0:1d9:ce46:6ebd with SMTP id j7-20020a170902da8700b001d9ce466ebdmr22324866plx.16.1708571551721;
        Wed, 21 Feb 2024 19:12:31 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:480:9ded:eece:6cb3])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f2d200b001db579a146csm8846084plc.241.2024.02.21.19.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 19:12:31 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] kconfig: add some Kconfig env variables to make help
Date: Thu, 22 Feb 2024 12:12:13 +0900
Message-ID: <20240222031226.493692-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new section "Configuration environment variables" to
`make help` output in order to make it easier for people to
discover KCONFIG_WERRROR, etc.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 scripts/kconfig/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ea1bf3b3dbde..109e28fd6209 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -158,6 +158,10 @@ help:
 		if help=$$(grep -m1 '^# Help: ' $(f)); then \
 			printf '  %-25s - %s\n' '$(notdir $(f))' "$${help#*: }"; \
 		fi;)
+	@echo  ''
+	@echo  'Configuration environment variables:'
+	@echo  '  KCONFIG_WERROR                 - Turn some Kconfig warnings into error conditions'
+	@echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfing warn about all unrecognized config symbols'
 
 # ===========================================================================
 # object files used by all kconfig flavours
-- 
2.44.0.rc0.258.g7320e95886-goog


