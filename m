Return-Path: <linux-kernel+bounces-130416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B229F8977C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA7C287CDA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3515445F;
	Wed,  3 Apr 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzwxB1a3"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939E153580
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167526; cv=none; b=rLFn1NydRRCcb49dhvUPWjiEnz0qvogv7RtqCbop5eGjvVt1810ZUelrIEyYWvpiblN8RCm9CxkApaYqAtT5BsBL0DKy5mD+9Gf6axxlJ445lHot1F/4Xo2ZU9iCYKqCPBZffXHg9Le9DUnOyMUWLZr4fgG4fRxV6UYU3zXwZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167526; c=relaxed/simple;
	bh=KHbE4qgF9Pb8RzBagVrV0DIGGkTehwaPNOTTLF55LQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D30hMc03f3dcDzKMEmeBQ7lwoa1prTapFLWPhn8N/FoLpZiIX//oUXqu5MOht52lEJN5II0V9e9XzwvvJVZM3pl99KKIODFISol/rDxNQOAgnuCPpKick+Vko1Xks8CNfj+Jf+xNwkprD2fVdb+vzhmpAb6iDot/n40pZKqUQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hzwxB1a3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecbe6dc8c6so68489b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712167524; x=1712772324; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73jxnSRwixN39ko5uxG2odEHWmCrsBBH9PbGB0SZNXo=;
        b=hzwxB1a3Q7HZeuSy3E+2kdl13TGReqWfwY5tM1HtYBUE4OzbofNbRL8/tkRkDcjqcx
         4bh9GLDh6sT8VKhRhJO4yR65+bF2NizAX9988NbY7aY0WOKIRSeJyAC8s0TPprTN5ClN
         UbrBZa3bcJ/ut6V7B4aSCuXe0kYu3M/AMutsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167524; x=1712772324;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73jxnSRwixN39ko5uxG2odEHWmCrsBBH9PbGB0SZNXo=;
        b=DBMoJdA3K7OhBAfrXXglyajdcLwVoAutgUhWnyvZHda4bv7NPBlCWRGi8DDR1GLn7+
         p8vpNBEMRtxy5jvEZ7TMS4vBapSoIyPf32Ox4ol3Mf536atBBKlVT7RxPot9UYYlwjCI
         7PZmQ12FMur274TvwLEAh9onyLwUU4Lli7wgkkByJaPDiVtUpTCk3Jsr1u/RWE4tQGVi
         5qog4tvzOw81txfbnrDvVZ1ZxTpN1NfpemOnjqzQ1Qxp8L+iQWQjTdGdUvRLjH0dAZrc
         bjikEx4ZgeeUEd33PKMfjch6MJ/Sg1M0fYzPGz+6bo+yAGXocw6YJQHgpq3CCB03Xvnp
         grHA==
X-Gm-Message-State: AOJu0YzYR9Jn/97x/DLrkRda/PUi9W7oCcVBL4Y4OcPzWIIuYVRUKcU0
	C2Etl7F1dxQS4VuyLSOZLetQ0g91m5V0MVAkqaIdOmoJZyDarPKLsPWAbSJDpg==
X-Google-Smtp-Source: AGHT+IFhHOx2SSYuRWdbtlNPDL2p7UNMawQSaLN6WdK2MAd2O6Z8hzrzzTKXzbOLl8iJ9hjBhYqUcQ==
X-Received: by 2002:a05:6a00:1a93:b0:6ea:ab08:683c with SMTP id e19-20020a056a001a9300b006eaab08683cmr290050pfv.1.1712167524078;
        Wed, 03 Apr 2024 11:05:24 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79850000000b006e64ddfa71asm12359162pfq.170.2024.04.03.11.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:05:23 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Subject: [PATCH v3 0/2] usb: typec: Implement UCSI driver for ChromeOS
Date: Wed, 03 Apr 2024 18:05:20 +0000
Message-Id: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGCaDWYC/33MQQ6CMBCF4auQrq1pC5TqynsYF2UY6SRCSSuNh
 nB3C0sTXf4ved/CIgbCyM7FwgImiuTHHOWhYODs2COnLjdTQlWiVDWf5vZBwGeIxB0vERArKbS
 tDcufKeCdXrt3veV2FJ8+vHc+yW39JSXJBW+gQWMMdiDsBVzwA83D0YeebVhSfwGVAau7RuqTN
 m0rv4B1XT9lsBgm7gAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 chrome-platform@lists.linux.dev, Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

This series implements a UCSI ChromeOS EC transport driver.
The ChromeOS EC is expected to implement a UCSI PPM.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
Changes in v3:
- Moved driver from platform/chrome to usb/typec/ucsi.
- Used id_table instead of MODULE_ALIAS.
- Split EC header changes into seperate commit.
- Fixes from additional internal reviews and kernel bot warnings.
- Link to v2: https://lore.kernel.org/r/20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org

Changes in v2:
- No code or commit message changes.
- Added drivers/platform/chrome maintainers for review.
- Link to v1: https://lore.kernel.org/r/20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org

---
Pavan Holla (2):
      platform/chrome: Update ChromeOS EC header for UCSI
      usb: typec: ucsi: Implement ChromeOS UCSI driver

 drivers/usb/typec/ucsi/Kconfig                 |  13 ++
 drivers/usb/typec/ucsi/Makefile                |   1 +
 drivers/usb/typec/ucsi/cros_ec_ucsi.c          | 245 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  20 ++
 4 files changed, 279 insertions(+)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-public-ucsi-h-3ecee4106a58

Best regards,
-- 
Pavan Holla <pholla@chromium.org>


