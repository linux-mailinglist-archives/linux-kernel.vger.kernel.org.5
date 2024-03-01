Return-Path: <linux-kernel+bounces-87876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BF86DA44
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC06B23CB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE964EB23;
	Fri,  1 Mar 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="n4dYeRjg"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104804EB3A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264276; cv=none; b=SoiEzF2kz4K6Lfuj+3avjRxy4mjZb7prmITXrINLdf+EFs/v/BmBHPXHlV++ZwBcMm1CLoxZ0RNuCUR6xGXQOtYy9irzGESML2Ui5Rozp22BwqPAVeXlvrkpDhPobg1x+eY1gKR+rAq7VoEfhRLWsAiDR5pl+MISk/zVgQ8xgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264276; c=relaxed/simple;
	bh=OWjOUeXIrnaIZjrBhzUDk1/hM5siEVz3QO+rz/2I9uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkbabb3LCXPbOyRuB2YSJ49EUCDinrLs1KFDBHs9fixniK5XEO+Ty46M2+1RYRIJJ3O5xEVvIFE+LGerNXuLfzh88l5glW+yqmWqt/ilKXplYqerXvf5cD/6AfOlnkrDJTb+mvY+d0+6YLNcEtHJAAaZU6TU3kZaOo/tIfW7nxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=n4dYeRjg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so1036693b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709264273; x=1709869073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGbzLc9+NihC81SvsTEjc+SAK4C+iurz3FRNgEJKaNQ=;
        b=n4dYeRjg4d5bnqwsfJDa2H7gxENGSmaTmFZIClv/flA/T+Hs9dvxLkGL1D6psCzb8y
         WNztgwqJj7qHAsvPs30yHd7cgEABieMNWxuloRqfPS5lwq6J9xs/Z13FUu52i6hdfK8H
         I6u0cEptVyJWRbKjT78Djebd+nwNnmnskmAjzp1VkGoFw8MCFjzW1y1U5ZbUW1GfnpDP
         9FfssXkMkB2t3cO5B1/zWijm9DjBbfbGBQLi40aNus/6BMW+aoa36l0QPnbOis5VNq4P
         WKviT3rVlc1hWGk0z/poHz4JesIHPeJjh+Mgzb1sIOvV/4E3uLVD5NRbENWoa8FKlR40
         4iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264273; x=1709869073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGbzLc9+NihC81SvsTEjc+SAK4C+iurz3FRNgEJKaNQ=;
        b=trusih1KM8EoiVWka0IfbVwytc2K+qZUUsPf2WRKyiHo3Q4zT4NWzgX5+sRQdkvIdN
         q8Qn1+0pD72nlutI4fyfI+0QCofNdR4+Lek8D6snfC9mnHqjc6+fKFjLq64linQ9W+Ti
         SsNawth+SXFyfuKYrWHLg0t3kvah7+H+nyzls3INap33KHjUAXTy73FECbXK/rBLjH1l
         WHpaNYb8osuyKDuwk+e+T0dnUXiHi9DG4BEgBRXC/HcwvIsrv3EV1P4NwQ+PwskPgwrX
         k4sOFGMRFl9qM9a+xNpC79+Wfs8tzwCdx/BSHDNz2yGdp52vKA2B2eOHXDF0Y+Z0QbLu
         L87g==
X-Forwarded-Encrypted: i=1; AJvYcCU8KecU6Aev4Kex35V3bi/+vYsEnsFJd2QnhaQu6OQxw7ZdNmUE6peIUBebHwuC2Ve3RYLI1MertoGoClEigrqTovDJkh/5CDMKQHvA
X-Gm-Message-State: AOJu0YwCu6EBZ+Wr7UhUfHyxAXAMT+JHbvyyybp7N8grMMaD7z+eWTst
	IMjqDsrq93NOz0gWWujWTo2aXpNImszHfyktpIXTSEZ6KVUaBR6TpDUaaSOBtnE=
X-Google-Smtp-Source: AGHT+IEK2/PAlK9kqmp6fNrTn+soSHmHxhZtjy2AdY3IKLoSrBlWZPjKCFzGTcFbwpboqZAyWuP0KQ==
X-Received: by 2002:aa7:88cd:0:b0:6e5:58a5:ceb2 with SMTP id k13-20020aa788cd000000b006e558a5ceb2mr722202pff.29.1709264272912;
        Thu, 29 Feb 2024 19:37:52 -0800 (PST)
Received: from localhost.localdomain ([8.210.91.195])
        by smtp.googlemail.com with ESMTPSA id t34-20020a056a0013a200b006e554f91e66sm1980995pfg.49.2024.02.29.19.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 19:37:52 -0800 (PST)
From: Lei Chen <lei.chen@smartx.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tsc: print some log if calibrated tsc freq deviates from original too much
Date: Thu, 29 Feb 2024 22:36:09 -0500
Message-ID: <20240301033610.1719052-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In most cases, tsc_khz is refined by hpet on boot. But in a few
production-level nodes, the refinement fails because calibrated
freq diviates from origin tsc freq more than 1%. Printing some
logs will help get this info.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 arch/x86/kernel/tsc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..a68b16e72df1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1435,8 +1435,15 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	}
 
 	/* Make sure we're within 1% */
-	if (abs(tsc_khz - freq) > tsc_khz/100)
+	if (abs(tsc_khz - freq) > tsc_khz/100) {
+		pr_warn("Warning: TSC freq calibrated by [%s]: %lu.%03lu MHz deviates too much from original freq: %lu.%03lu MHz\n",
+			hpet ? "HPET" : "PM_TIMER",
+			(unsigned long)freq / 1000,
+			(unsigned long)freq % 1000,
+			(unsigned long)tsc_khz / 1000,
+			(unsigned long)tsc_khz % 1000);
 		goto out;
+	}
 
 	tsc_khz = freq;
 	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
-- 
2.43.0


