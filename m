Return-Path: <linux-kernel+bounces-70461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2C985983A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B49C1C209ED
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B866F074;
	Sun, 18 Feb 2024 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EaoRL1ue"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A325777
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278119; cv=none; b=VebhZNCQlGPvzKf8Dij0ZE1CDAbEFM/w0C/SX5UE7FZrrJWzr20R9umyE9S/VSCeQQ5p2rjG0f8fSfxYm9KiT/6r8DeUtrsQYPMc4L/dhPTiaqr3G5yLnRxFY66szXVapu6GizGIud858GgyLQOJM+M1rSPn0WsJqILnS6yW3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278119; c=relaxed/simple;
	bh=9JKkB9Yj8dy244I0oL0qNyEe77jaJB0G5W0EqyXroeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIDVBbgiu+wI4dQFuCslK4jdvXONvZqoqJU/a4pII5bzUD9JchNjfJ2n6g6QOfMsfhtPm0yJ3MVToVGe15HLtSg/fbtRuf0OLtjYG1UeM6guxS+w86+pgbTLK50UllAHACFKS5ZjGngUozoPXE9z7q51SBP+3b10H+qxmhmQTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EaoRL1ue; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso2478579a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708278116; x=1708882916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzWEspu2HplkFu6tE3sVyn+412Gf0v6f/fBl/plDgWc=;
        b=EaoRL1ueOrttnwQvGzBfSw7OyJFyENXlSGE8TR8BVWv4d0Jdh9AJfuoKyuXVQfQWuo
         2aqA8nkj0oFm1TcIVZeM45H4zp5PXGrO7zWfeqU57Dhlrd8E4lafJG3zqZW5cuaD7srD
         gZoPI/fMGkngK5otOPH/rz0qlKtw3/oeTGMq5E29eIX2S0Ws3xnzkw0fgA7babW9tkv5
         VDhp9zt1Cb9z/pAeuQSmrlQmNXxVDLAoECae31GsBxUBsOODKH+j6Ag8fuYVtOzb8vgB
         PVSd0PEYQGXPPmVsJv3zq9HpalHeL/dfYsbBSfIARapXP6+9ubG63Ec8F1EdPQdfBvaH
         WzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708278116; x=1708882916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzWEspu2HplkFu6tE3sVyn+412Gf0v6f/fBl/plDgWc=;
        b=gXP8bgNFhr1oPaLW+IBBkYiZGzzf90DsiYCO/OECJaiI8DJYLBrNuxAsTBOOk+kKP6
         oWQHfUz4/dv6Hy03MCcI8vXg0iAtCKt6mesqwXQ2euYhbcWz4bRdGbE2OfJ77Zv24xFI
         Av9XUoPIzqwFph7yOrAIXVrzLL6Wb939WqFxhwMcdiHzYNr2gMRlJUtVLtgh/ipLS36+
         w3BkYWQuWbQbcfi8RX2NlvuygT75qwCck9ExxNndt43OgVFZDzLkAOvp950mZXi0YxfM
         SeHoJZIYjEWHGFcz76JShweie8chqCqpsE6kWtpin35VywUKZ51eNCJOZDifJt46hzKp
         SDjw==
X-Gm-Message-State: AOJu0Yy4G4gk0AqC7spIjaQ+O/u3ON1DPa6C2IYyd9Jde/I4kx6cjBUK
	2uRZcl0P2EN+hS1+b9xRLwD0KE9jGPQkUJ/bLg4wtoPHeRHlgTJzbEn77RfX
X-Google-Smtp-Source: AGHT+IGhNTsQBS4dMPJuRFOWLIXIEcTc2ZKSxvfkFHLmVfFYQocsVvaDpg5phoZGKWdM8xJAHhMbDg==
X-Received: by 2002:a17:906:7196:b0:a3d:1899:ec3 with SMTP id h22-20020a170906719600b00a3d18990ec3mr7343762ejk.35.1708278116629;
        Sun, 18 Feb 2024 09:41:56 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b37-4900-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b37:4900::e63])
        by smtp.googlemail.com with ESMTPSA id r16-20020a1709067fd000b00a3e88f99cf1sm412710ejs.149.2024.02.18.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 09:41:56 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andrea.merello@gmail.com,
	patrice.chotard@foss.st.com,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/2] clocksource/drivers/arm_global_timer: Fix maximum prescaler value
Date: Sun, 18 Feb 2024 18:41:37 +0100
Message-ID: <20240218174138.1942418-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
References: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prescaler in the "Global Timer Control Register bit assignments" is
documented to use bits [15:8], which means that the maximum prescaler
register value is 0xff.

Fixes: 171b45a4a70e ("clocksource/drivers/arm_global_timer: Implement rate compensation whenever source clock changes")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 44a61dc6f932..e1c773bb5535 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -32,7 +32,7 @@
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
 #define GT_CONTROL_PRESCALER_SHIFT      8
-#define GT_CONTROL_PRESCALER_MAX        0xF
+#define GT_CONTROL_PRESCALER_MAX        0xFF
 #define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
 					 GT_CONTROL_PRESCALER_SHIFT)
 
-- 
2.43.2


