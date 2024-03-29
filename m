Return-Path: <linux-kernel+bounces-125132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A2892078
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5671C29884
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014C1C0DD7;
	Fri, 29 Mar 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tsDzz/ct"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79171CAA6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726297; cv=none; b=k6k2VlGeMXNMtZAYa5NpKTcD1kSvbCuLEXuqMusqCagbop+Sh0vF+J6Uuf3Wr7z8v13+xoEHXUOK1HUG8kQRJrla8TljcU+PFDIdwk8gq8LPMiGjKhwvSOfA6WjTorykP3iJfpsZft4WXMBlBMWU7Gga3FikMRuAhvt4IIOlM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726297; c=relaxed/simple;
	bh=e+BQtyz+R/vmvwkltCBHxspJxIr8Y1jFRmEMtkh4+zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9dL5y+hD1oQYVzhL8Yp4y38wBonfrBGrLP9ABqtHgNckjy0xjrbPsnrbSnXTjTcxs4dbBCFUg7rDmvQwBsIMZXs38jBjJhNKC+hGQhNXB4VtKZcj8JSBwR5lNQqIf9x9Y9DLFP1OPWtcGK4PG9IbaZg8AFfUGRzmJvblfrLdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tsDzz/ct; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4154614b47eso9307345e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711726292; x=1712331092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m258F6KAkYv5whie4zvIuYfAIKK7ihN/LQFSFmJvAXE=;
        b=tsDzz/ctbicTBC2clp3aJjyRpB8jD4MGMAz+WefIrRl3H0KoPVjUcfKg7NKNPQWxxm
         1Skhaz9VSCAhKj6k5hSowE2V1lsLtg0RCRIXtOAdWNjyAQFx5wjr2nnAlldy8TJGf2bb
         YxHOyT+P93fg9MF60tEgiIn9/mz1VoVR6qh+y3ThdnyNXpkq5+f+IE2KrcjHfCk152Zi
         GIXkEGiIz1h2pDp5eNZ2CzDnE/LsGRiOz4lirpXKaSAYWl4V8HaD0tbAH0GZowQCoftV
         q2hz8Y/ozopHAL43C4hKZ1u7noyyZffNOGTUP/FxHK8ihvu4JGHc92xBxyY5FzLQdYSF
         H+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726292; x=1712331092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m258F6KAkYv5whie4zvIuYfAIKK7ihN/LQFSFmJvAXE=;
        b=aRL9tGM0qYJjTEr+pWUFhf1N1S1Evb9jRfvDMPLM+HuBSZHUWtu9g0830lOa9VDLSv
         hAEk+5OccxPhRhhnbdn07+n40GgUuWrGUD1T0mxrzxTZ4qFCXn/uT3SLwKZq5ql1U6ly
         LK6WLjoyFdqcxlpwCgop6olpE1hRq5lqS8f0W7EYFGAV5ywj0tSjeDAb1iPChG3nEdlI
         b7euafCPCif4qZXPrYCf0OsszVBzHmFKbUgJtTO/hxO7cmovv9bkygKEMgqmiBoB0yTg
         999XtLZkThH+M8azQpbEc6+XlxVtoRQXQbVXjhH258P+r2F6fh6dLlQqkaVRCsBO+8k6
         Le+A==
X-Gm-Message-State: AOJu0Yx0p1Ib4eRgZRBZWoVDPyam76SigxG9iUW/MqDJwiOEDrL07kma
	QplAn4JdVof2668FP3vj0A+SN7ytJ/qQ5Urp9cJSCdh7ff46fGicR4TC5b1V/6g=
X-Google-Smtp-Source: AGHT+IFnFtyz7M0SRCkWW+kdv83i6HZ+Advv4U3i9XwfB4T4hrtqb5rQL5fWiVK95vkYvZTzzDFW9Q==
X-Received: by 2002:a05:600c:1caa:b0:414:8ffb:a6bf with SMTP id k42-20020a05600c1caa00b004148ffba6bfmr4841008wms.18.1711726292181;
        Fri, 29 Mar 2024 08:31:32 -0700 (PDT)
Received: from ph18.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b004140d326399sm7020791wms.1.2024.03.29.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:31:31 -0700 (PDT)
From: =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To: platform-driver-x86@vger.kernel.org,
	jlee@suse.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	onenowy@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: acer-wmi: Add support for Acer PH18-71
Date: Fri, 29 Mar 2024 16:28:00 +0100
Message-ID: <20240329152800.29393-1-bero@baylibre.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Acer Predator PH18-71 to acer_quirks with predator_v4
to support mode button and fan speed sensor.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 drivers/platform/x86/acer-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index ee2e164f86b9c..38c932df6446a 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -597,6 +597,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_predator_v4,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PH18-71",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH18-71"),
+		},
+		.driver_data = &quirk_acer_predator_v4,
+	},
 	{
 		.callback = set_force_caps,
 		.ident = "Acer Aspire Switch 10E SW3-016",
-- 
2.44.0


