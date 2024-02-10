Return-Path: <linux-kernel+bounces-60527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599D85061D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACA21C20FF2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3855F570;
	Sat, 10 Feb 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnQAerpi"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5380D210EE;
	Sat, 10 Feb 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707593387; cv=none; b=Mz6v3YK1CS0zFvbEqSgjKX/9vFfwIp8f434R5sJsIofg3t/u2s7O8s+L4SWXmTTMcRgu0cfFQu6gA/jFLSLfXzgue4Z5tAtBj1Mp2VawHNFuIt1rllTjwTgwI21hXWuOSMUyqkuuhe/kPezv90QkhjIKYijlqxeK3HPAorp9Mgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707593387; c=relaxed/simple;
	bh=KU+LyuoLoBParnVjDFENTlgWEKKyx/4rdYR/ilGeQTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bzyScLzbjT6j8IFl8n62Z+1Ou+L0xO+/8eaoEp2XqV97OR9ecOjt3kuhAG073/mZQTOETFT/30h8k3yv/VGv/L/Evsoh0iWEGZIRtDJytdj8PaVSJFR96Z9mfPiGyAj2oeTQSeaX28Es3r2vxjTpOqXKOXDfx44UcdY47eUfTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnQAerpi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41068e36cbbso13893515e9.2;
        Sat, 10 Feb 2024 11:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707593384; x=1708198184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7y4YKyttMpKUVwZxQNCkTT0b17KqO06VPlIQug/wxEY=;
        b=EnQAerpiFoUlHT1n6ln87exc/S6VjACkLupzzSoZeVrTbG+T9Pgj2MrSRGXJO2E9yN
         ExDdmpsbN2itraXPkiEZPPwwMoVecnGtiOTXFbcuwCjix3KjzzLHTIzVQ0YPvBnPhjYX
         NOQ5hpr8cxFyT9XQoS1omC5pXe4fSE5nLMhfJSt4P8xNuYHz/Tc4kFqlMar/Mj0EAl1i
         V+GTQWn9iOAPXh2PN3vxnruRP7Oo3opELpwTWWgBTZybTnaXzw/DnWAt7Y5FI7qZzmae
         7sDxbfiTED+77zMsxfzaKIbLE/oHCSYVf46VQn1vxC+709GkISqOlk7q9yPS0iHplHU7
         r44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707593384; x=1708198184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7y4YKyttMpKUVwZxQNCkTT0b17KqO06VPlIQug/wxEY=;
        b=qgC3iRbW6YNFm6rv0vllulxbaPP2unFbGcBe+9MFAXPjomaj1JjvVq+Z6/9e+4gOwz
         6EWZMJ50oGdC3hQ12rDepaGq/JwhzFKAif4aon45VQdtTZirQBlnhU2Nlz9ncfScVTQk
         /r7/bXaYTV9JLOwsc1ECaTZF5Wquw+ZflCohB7ZQMBY/AUAC1hjUhndHPnxW8mWVTqVc
         oKDw7tEAQTZwPg/nMTzNBRwBf9Fv2VOuAPjTImbewMmJ6mmlKjcO3nwJKxKc+TxB/DLg
         zbTuLYq6lSCeqhDs0dWqgVX+ZdD5koPiPgwYaT/aGEQLd9KbJz5aWczDzDYVbyj3TfTW
         mOYg==
X-Gm-Message-State: AOJu0YzPJNSl9K3blHOvNoGJEVB5Pw5/XYgyEUU4r+E79TTX6QDFZjVS
	Lo6Pdr4X/DS6q3HGvTocp5UwG+FUUVN8shmfQ4AP8N888diNDLaWznYh3aHyd94=
X-Google-Smtp-Source: AGHT+IEtRN8jWq3itereeY01awfCLrbkLiagfMM/5xvfb7PW1whrXNrqYPeqjs++vG+UKqHtE/ZKTw==
X-Received: by 2002:a05:600c:6007:b0:410:9ce0:2001 with SMTP id az7-20020a05600c600700b004109ce02001mr1446644wmb.38.1707593384317;
        Sat, 10 Feb 2024 11:29:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0ei8tZOc+SDcJw4EIEbkfPdJUW2RN78ZjruBoQfB8ky8n2his3bxu8rYaan0WfPPEgxK8no+YLecaEzzH/KpXS9nXlQ0YgD/xbsgHqi9G6PoyffJDpVxdZk3tCWyYyW0HtS2aFdwNjAWD+v6PTDmAEHq0qQG/BgAPVmpYUkdUhlj36o1S4tbw+GP5ZYJqIF6KzmJTJDI+MI57QgvH
Received: from Attila-PC.. ([188.24.48.22])
        by smtp.gmail.com with ESMTPSA id bv15-20020a0560001f0f00b0033b48190e5esm2540372wrb.67.2024.02.10.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 11:29:44 -0800 (PST)
From: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU
Date: Sat, 10 Feb 2024 21:29:34 +0200
Message-Id: <20240210192934.143491-1-attitokes@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Like many other models, the Lenovo 82UU (Yoga Slim 7 Pro 14ARH7)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Attila Tőkés <attitokes@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 23d44a50d815..864976a81393 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -234,6 +234,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82UG"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82UU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.34.1


