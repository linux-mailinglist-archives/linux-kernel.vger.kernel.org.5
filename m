Return-Path: <linux-kernel+bounces-80692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C875D866B55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350F3286799
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB81C29C;
	Mon, 26 Feb 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjJ+FGAj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DE1BF31;
	Mon, 26 Feb 2024 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933731; cv=none; b=XEtiCnTaB/oFUZJNiVM1hkRLNO/yBHsvK2MNMbKAcoSgOMG+r5bHSKHbAv5grcG5ABeUfpERZlHA3b+crlg0rICE1qCMIadGv/GDT4lfx3eT0yEkKh+y2F4N4BP6K4XcJtCgmsU4JdC5K6j8NuuRG0X6GBW9kM0PRTxWokfl398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933731; c=relaxed/simple;
	bh=PFCX+psKPyMBHPeR5ppV9yu0fZYBi5SxEA057Wc/M/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WfYI/SmlP7Z6C0fmBuT69yhQWmgZGCKIzyQjr2fhAYE/UdwHBJLjjiLh9erVC81g0F3brx1LEbovTak5LIuWOcNZ2/d2XzC+z+hh67eUhsjyNF649cq0ee1iJM3vCPNVLSFTcUw1B99wu7U/geBvkanxWPZR/oOSikVdo33pcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjJ+FGAj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a87f0d8eso466455e9.2;
        Sun, 25 Feb 2024 23:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708933728; x=1709538528; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HqQvE+FIcyUadHgmZr58h0Sz29nDm7hjlZzXPmEulQE=;
        b=EjJ+FGAjs1hSdYHQC35xjDHZgfugRcEsOGTFQ5E6n5K4lw1FnLfb0F27IQTMPHb9E5
         ug2DZ2oH39mOQwXFjO8Ny0TIk3ntv8I4002ej4HGNN1cc9nUt5xI7BQkaesJVlSozyFm
         AcO6rbrNrdW1CfRljdgCCMHtsAkVn0d/5yH0uOXCiJif9uBatusa3bjVRSObY72ZuEsW
         j68W98t3E7g8uyvfz4RFKCrSPONoXvXjeylp+K3DPO7PyOZa7Re8fDuRU/qx2dK2DKZP
         qAalynRHRehXuzn0Xlu5rzuH3kVpmfC8+vv7ee+Da65Cd02A3uuO5hXc2Gm5iqsZ5Mp6
         z+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708933728; x=1709538528;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqQvE+FIcyUadHgmZr58h0Sz29nDm7hjlZzXPmEulQE=;
        b=tSfGrHMifgMYYBQBJOISYk0SeG3yJEkLW3pD7ycn9i//ITrEktnkNeZmn9NV222Wqi
         p4T9t6C+t3L1wQ2ABGGE2+l3fC0Hfq1zOqTvz/gq0QlmzaUlL8rkLJkCpS/nhBlGhXwy
         2Mvs/WkAduPUfWaQZLG8tHOXzOR+i6Ia4HuJFwUAMj+sn0qAmkwhSYsd5LQ6obbZQ5YK
         kZMDFCzc88MKeAK3x41IGhcllTiW3haN0aSAE40mBh2lWeXI7PxE0nOorzEnXaT/J+jy
         5VCnvXICsLv4UNG+7pwab8DKn6fLYXN1MwkebfOYiZuGyetMKJJqQuFaK8k2m1Y5sZmY
         DL0A==
X-Forwarded-Encrypted: i=1; AJvYcCU+xtyEEg09JdWrUgucRUQ/t/K1KlWZWuWkOF5KKtBJeuY9vD1GBJp3JXK35o23mFqtW6Fo2b6F0KskQ4VS3Kds9MgP+5s5dVStsERaXPXLD9akIggmwRTDwajyJ0zrw6v+UvS8YSYAKw==
X-Gm-Message-State: AOJu0YyLD04kJCK5JRUrR9XyeUhX2EG+nlWw3HcefdPEOBWm2hyNImYd
	2xZewikt8mXPQrig509BhKFT96jmRKG3U6G8/1Nxj1VSsE9iYIvi
X-Google-Smtp-Source: AGHT+IHc0CtK0sG6FMH/QvZFvD6vHXweFp3uv9SCDGrhT9OnD2sx7OTNoXF8fRQH5jTmgWWvK5/jAw==
X-Received: by 2002:a05:600c:46cb:b0:412:10a1:25ed with SMTP id q11-20020a05600c46cb00b0041210a125edmr5352886wmo.33.1708933728607;
        Sun, 25 Feb 2024 23:48:48 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b00412a482cd90sm2728024wmg.25.2024.02.25.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 23:48:48 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH 0/2] Update st,stih407-thermal device
Date: Mon, 26 Feb 2024 08:48:37 +0100
Message-Id: <20240226-thermal-v1-0-8b03589ece73@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVC3GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNT3ZKM1KLcxBxdi+QUg6RE8zQTU6MkJaDqgqLUtMwKsEnRsbW1APf
 VSj1ZAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0

Those two patches update the thermal device by converting the deprecated
txt documentation file to DT schema, and adding a required property in
the device tree where it is needed.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Raphael Gallais-Pou (2):
      dt-bindings: thermal: convert st,stih407-thermal to DT schema
      ARM: dts: st: add thermal property on stih410.dtsi and stih418.dtsi

 .../bindings/thermal/st,stih407-thermal.yaml       | 61 ++++++++++++++++++++++
 .../devicetree/bindings/thermal/st-thermal.txt     | 32 ------------
 arch/arm/boot/dts/st/stih410.dtsi                  |  1 +
 arch/arm/boot/dts/st/stih418.dtsi                  |  1 +
 4 files changed, 63 insertions(+), 32 deletions(-)
---
base-commit: b6d69282db550689ab5980e06eedd23b64584a73
change-id: 20240225-thermal-8cd0ba7f452b

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


