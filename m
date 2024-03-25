Return-Path: <linux-kernel+bounces-117290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFCE88A9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E37B1F61333
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C92915219F;
	Mon, 25 Mar 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f90HVDVW"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AF21422BB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378229; cv=none; b=Y4+7wruhw3r6DHbrk+y4WAhdckEAhp4hFzM/Bza9k+g+5pN2jfB0VWvtIj7Km25/l1CY+uCvV+dnJQjyqOpeHIRPauYd6J6CMJjD+Rq9LXCVXBVmgXAwfAwyUbEJR7TcXOs98lY2GWyabMlpzBXZG+4+kY+d78sQ2SdLFqPnP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378229; c=relaxed/simple;
	bh=2dAG+Jyz81+oh8AF6DeyE+UyRu22SiDEL635nHH+73Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNO7sqdoWjpyCE3CnY3aW83X4yR3mjq6GWCdBiraoIIWldBJbyRQTiP8cn+RMrInWoplMmCP7sBc+rzexxy0V27RpzD+5rv/w/URSTQQYoVVvwvhSPSrsycIxe7XOxHndQufukQRDTwHc+spFyJd9uAmW7jMUYnVLgfmts952Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f90HVDVW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430c4e67d40so30283201cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711378226; x=1711983026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8QTboKNFlxJkYJ1An2aW3V7umhSjhO/WM5O6LoVCcU=;
        b=f90HVDVWIxhJ7GoJusxCrJ9iTy5AMaJgTUni/n8c/Ks0jIMz1mBBGdoUBs/ohlsoDa
         c+MOFkqHdK9DW+6OA4giAJZpyDSuNwBYd3cNvhoxLloVVwK/KLqIvFL0eZAxyPc2gKt0
         GKCwxL4Nev4UPsS/0phJ5oUeHL7adk+sahEfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378226; x=1711983026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8QTboKNFlxJkYJ1An2aW3V7umhSjhO/WM5O6LoVCcU=;
        b=apPcRUUrOWZl4XQXmiCIg3qabKHv3EQYiQSwcTKLgxTnK2GqAuZ/CIowQvFDQiaeHU
         H+JWRcz6ylnBZcnfTXxhGQvipaoTmZNp8yzAmpeM/JwoNUX8SjXof1YhLklseKS15517
         NReHLSMHOWypK5Xo7WYz/uvUFR50ZNWmD68ukoHdc3cN/KczdMPfKXAs+8mBPW510HKb
         GaYTqEe+gGxNcBMo+wcx0RjxoGxV+pygSi6kzPwyPPhDR30yhO2lnh38dLSxuESgnTm+
         ybaIS3wu9HkWjuPewz7gaH1lEj0jSbFALNPm9kuezsB7bwCISAHcTo+DFsB4Fj9/SnhD
         1lvw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ktap6+zizfNPlYZOmj50rUi34ll+4udSujHOShO1npWSoj9Z/jI9H2+/YQKLvr7GQtglJyuAKGh2EZZnBRttrQEVKjC7NjojpH5t
X-Gm-Message-State: AOJu0YxsFnnWmF27J98LMLvYMsgd7nXKlMb4mtN9t8wAg14JADRSka89
	ez1+ZhsV2DPgsxVMZ5FQWAKc03nwDq58CZ9uzzGDp61phHPFjSjeV2WnhDhG9A==
X-Google-Smtp-Source: AGHT+IEqb/RgrM1Zmsk/Hg4wuXRP1MFf283Gr9y7uqBgTIorav1xkqxxl139xGt4TwsfJtE9o1cPMg==
X-Received: by 2002:ac8:5d10:0:b0:431:38a4:ef47 with SMTP id f16-20020ac85d10000000b0043138a4ef47mr9187432qtx.48.1711378226517;
        Mon, 25 Mar 2024 07:50:26 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id eq17-20020a05622a5e1100b004313f54aaa9sm2491449qtb.5.2024.03.25.07.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:50:25 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 14:50:24 +0000
Subject: [PATCH v3 2/3] media: radio-shark2: Avoid led_names truncations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240325-gcc-arm-warnings-v3-2-81b8c10dc18a@chromium.org>
References: <20240325-gcc-arm-warnings-v3-0-81b8c10dc18a@chromium.org>
In-Reply-To: <20240325-gcc-arm-warnings-v3-0-81b8c10dc18a@chromium.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Increase the size of led_names so it can fit any valid v4l2 device name.

Fixes:
drivers/media/radio/radio-shark2.c:197:17: warning: ‘%s’ directive output may be truncated writing up to 35 bytes into a region of size 32 [-Wformat-truncation=]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/radio/radio-shark2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index f1c5c0a6a335c..e3e6aa87fe081 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -62,7 +62,7 @@ struct shark_device {
 #ifdef SHARK_USE_LEDS
 	struct work_struct led_work;
 	struct led_classdev leds[NO_LEDS];
-	char led_names[NO_LEDS][32];
+	char led_names[NO_LEDS][64];
 	atomic_t brightness[NO_LEDS];
 	unsigned long brightness_new;
 #endif

-- 
2.44.0.396.g6e790dbe36-goog


