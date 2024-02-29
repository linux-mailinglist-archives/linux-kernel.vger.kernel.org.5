Return-Path: <linux-kernel+bounces-87116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B4886CFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58C91F24344
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD2813442E;
	Thu, 29 Feb 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMPu/+c3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694B7B3E9;
	Thu, 29 Feb 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225644; cv=none; b=aBg9zTBonxZeXg63zeCmRABOJW2e2zP39G4upUd3zxRtoDXhfLi3LSi3l5clv0tlmFP42v0/WXAKBLIzsthO863VcURwhLq1n8zRLye/K6aMO43wxbonyf1GhkqxvqVHWOwkt8qL17AcWMYmkm7jgMj9+z34idgBaIbLWyDyUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225644; c=relaxed/simple;
	bh=/6ZrMp4uzS6/sddTB8TYpGu6V+UXVOxVryZJevlr6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyIaa8SGxhwR7CZ5NNW1DA4f30X268bFiPQkIY8clwQgf6XXtPEEhvFi7OXdBYQ/w+vrnBmqtnnY+3hfBkZFlDudjxQnArBc5YYU8X/nAgsKKxbjJJsfBJnCMH+R0sEEQ/YSLtcx+QhEGeJgE16Fcr9U61XYQhDBq94rZTg3nPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMPu/+c3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5131c0691feso1406149e87.1;
        Thu, 29 Feb 2024 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225640; x=1709830440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0tbIWxrF3a7jfvPwD7Gc/OLDO0heS4wTMG6zodSI4U=;
        b=CMPu/+c3j0rhHryzkzcRfMfxurn2nWOOmdw5ntb0SDZ0ZkaQU0obRORGxAZMKM51Go
         wmrdOris1dRvDJeojqRSw4lfjDVKzocc8FGTsCPuM2hRI0diog1FpUgWbVkrD2IsH+7X
         3JMq8bnBDLOEFOyDtRzM6MM31Ir1ZP40LlmXc3FXsjn2ZXXck3BxbcdbRrf7135LZ8oc
         o1eK1tKTvyxkB+pHAv2vn9CsjaCsKh/SFEsDFB6nQ0c2IWoFDLi91/RUXWaRhmywwWr5
         dNnx+4l7b08GCM3mXSgfwk9L3IzTIS5wRO5gNOqXTLfyA5MpP6pOyvlFO2O9QzOQS4iX
         87zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225640; x=1709830440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0tbIWxrF3a7jfvPwD7Gc/OLDO0heS4wTMG6zodSI4U=;
        b=pmqCcJhHqPewLuFYwl+GMJoyuui34e2KnOLZGovYV3B3ShCtvFmtvXBq++DDt7L/yD
         RZH6cm2OgEtbq6McDJRqGjve4JZaOTRmmEZVkQZyF4/OZ3MmJQT5ZF3GNr1Ebkznne4k
         38H4WdF9uObJz21GBT19pv5AJ3Fff5WPmA3zTJG2/Euk5PnkCzsdTyrsHr4x55wuddXX
         J+AWm+XfozXaZO3LrWG9fQepxYNCPlaHbxMncBvqf5+SmfUDk5sK0oz0mFdFAUBuzLjN
         Z7hni880rhCBwgPQX47yKpafF1FM9ADLPX8ehu9Pf7Bon1IaZa5FqadWzpjHsGjRtY4S
         yuag==
X-Forwarded-Encrypted: i=1; AJvYcCWHppq7LB0qoMEklBuhBJyInRDpRRM7Shcz6+n+hiuOFU+1OSCBLkK5OMHnaCtpaRnSZhOzzGcT5zmOORaNHTs2w2EUkkXheDQcgfpd
X-Gm-Message-State: AOJu0YxLdZaj0vNK7PbEKiXgX0Jt1Wncei8+cs50txoQIh2Dby/6VBU0
	c5qJSw6IYgeOo8JVfkJ2RsXPcQVjmPUG1iYRJj5H8HZ3L+zef5xqsmI4gP5YN40=
X-Google-Smtp-Source: AGHT+IGVDx2+Lu4pZQV3CxmS3/SmgfUo6bBVsUFQCuTckBRAnKuf6FhpfcLNukpklCbptNEzxcgdsQ==
X-Received: by 2002:a05:6512:7c:b0:513:2040:d5df with SMTP id i28-20020a056512007c00b005132040d5dfmr1675126lfo.1.1709225640196;
        Thu, 29 Feb 2024 08:54:00 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id h26-20020ac24dba000000b0051317eb0bcdsm306660lfe.245.2024.02.29.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:59 -0800 (PST)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v3 10/20] media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
Date: Thu, 29 Feb 2024 19:53:23 +0300
Message-ID: <20240229165333.227484-11-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max_fps field of struct ov4689_mode is unused in this driver, so
remove it.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 2354397ab34c..45f055c57436 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -60,7 +60,6 @@ struct ov4689_mode {
 	enum ov4689_mode_id id;
 	u32 width;
 	u32 height;
-	u32 max_fps;
 	u32 hts_def;
 	u32 vts_def;
 	u32 exp_def;
@@ -237,7 +236,6 @@ static const struct ov4689_mode supported_modes[] = {
 		.sensor_height = 1536,
 		.crop_top = 8,
 		.crop_left = 16,
-		.max_fps = 30,
 		.exp_def = 1536,
 		.hts_def = 4 * 2574,
 		.vts_def = 1554,
-- 
2.43.0


