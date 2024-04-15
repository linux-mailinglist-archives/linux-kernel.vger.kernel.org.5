Return-Path: <linux-kernel+bounces-144502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508168A472B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56D4B224A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D45F1A716;
	Mon, 15 Apr 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="w/X+IKpI"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAB17BAA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150030; cv=none; b=encAgpXDOJjQP3ybNFkwV5DW0WHqzKXahw4qAhfz7R1ezndM6a3cXr3dMe0v91HjE3JFkgkAnxEUGkqehj9efvpKEqdeqdaiNpO80/OaLOqSh1nDt+Pji13dAsiRWNT7Sg0N17RWUnsbL4/nUF2AE0E83+OGbsuC8CQUgPUJwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150030; c=relaxed/simple;
	bh=BjgjwiwTOGWG+xPSkXwI3sjb6iRi/nRVM8AcokneUlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UThIx+iLoyaE9Y1wd667vIhbD877IEfFhUjf6a5Nv0CJ4hAjTbl7itkwT7ExJaLAvIYvebmSqRFMnNzHnG7zOsmf98c8+i14v9fH8WTPOnjWZsk3j1ZjRwqnmZ/P/y7QP/Cr3Eh4HQ8IEapb6v8FFLJcErjn1RX47SQbyJnG1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=w/X+IKpI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so13342805ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713150028; x=1713754828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=phl9hzL9EcvJ0qziMq/7xrI3olLgb+5Dt8L13eeVivQ=;
        b=w/X+IKpIm+RyVxACbsgM6y182FtjoZMeSVXFDYMRMH48RqfQaZmVm+0pWHPXf9DKxU
         DzFcQtd0SwxzeRpMLMQ9EtzqiYPtRnbhElCjiVOddJj6clfAYtafWlw3S19+cqEKQLCA
         Tjaz0wBMzjhcxRhlY3HK3bZ5mDMCSiy9BEgQ7k+gKXxL7CB8vpYUCw0BchM4pTjGjhxh
         RoJNdrW4840Yw2rOVPpVybBJ3NRZaZ4X6ttudolqXeB7HG6bSV4Ac7bkfgz4WvVCHAJy
         Z3UqASTtoxYBuK8wDMAFGnhK6JNRUyEoWJVYBfSofm0HCjo5JpgW44odUHGMK0rnMZxN
         A2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713150028; x=1713754828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phl9hzL9EcvJ0qziMq/7xrI3olLgb+5Dt8L13eeVivQ=;
        b=Hd5gaZISvHyLFTuaq4htlDAbCUYeStZVh4e+XmnOYVOpipgIYcjYvZ6N4PO1UFbKix
         MAE5VrN1sXsh1cT7vn5R8jWcCrywkRDAiCCx2dD9L5WRMP7fcrKBFiV/zqzCZkomkzH7
         +UQy1EYWOfiHdXT071jGh37bnpbdlBrY7besImI5UZu9JK2pV1rPEfc+p+FDAqPOjRi+
         SV6ZxlCjlc7/UjNtZ0Zj7YZpqw5PCGE7gBj8NDK5RNMfjj4LQjPEFnL8s/gFRKt4BWBi
         ymO2l/M+rXEBdsvaUOq9tBMGzh2Fmn4rC2aG/r71T2j3UYt2IWwDJ/vsQR/HudxiZeAD
         mVyg==
X-Forwarded-Encrypted: i=1; AJvYcCU+VuGeitAbLe0GTU+XwyZLUbKIzc7mdRpXoVAyG3U9VftNYqFOoo1rI9DN15DWWvcHlyyWQc0wnUN/YHiuyXLMSbj2wVInpNu6uVHQ
X-Gm-Message-State: AOJu0YzKeKh3+ZayP73IRHtD1zOINXMFRmiBhV3vmU7EGRcz1ReABaP8
	xjMGbHJhTJevBO3wfXr0J0EQax2S+o7La+IhIM2PRoITptCXYXVBCVrQ7bfjdH4=
X-Google-Smtp-Source: AGHT+IEoRdkGi0QPinjL0IBp7+rPaOoXKbnufXQ/2Gc3s2DRJUPJRnr7oEbA//Fogow5YFLmx8Q86w==
X-Received: by 2002:a17:902:6546:b0:1e4:59a2:d7c1 with SMTP id d6-20020a170902654600b001e459a2d7c1mr12713671pln.33.1713150027442;
        Sun, 14 Apr 2024 20:00:27 -0700 (PDT)
Received: from localhost.localdomain ([8.210.91.195])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170903110d00b001e604438791sm3133866plh.156.2024.04.14.20.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 20:00:27 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/tsc: print some log if calibrated tsc freq deviates from original too much
Date: Sun, 14 Apr 2024 23:00:18 -0400
Message-ID: <20240415030019.2220750-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
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
Suggested-by: Ingo Molnar <mingo@kernel.org>

---
Changes from v1:
https://lore.kernel.org/all/20240408100607.1732600-1-lei.chen@smartx.com/
 1. s/deviates too much from/deviates by more than 1%% from
 2. Use pr_info instead of pr_warning

 arch/x86/kernel/tsc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..06c6583aa8fb 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1435,8 +1435,15 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	}
 
 	/* Make sure we're within 1% */
-	if (abs(tsc_khz - freq) > tsc_khz/100)
+	if (abs(tsc_khz - freq) > tsc_khz/100) {
+		pr_info("TSC freq calibrated by [%s]: %lu.%03lu MHz deviates by more than 1%% from original freq: %lu.%03lu MHz\n",
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
2.44.0


