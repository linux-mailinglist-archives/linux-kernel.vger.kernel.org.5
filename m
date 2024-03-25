Return-Path: <linux-kernel+bounces-118176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5FB88B57A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900631C37DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11B84D2D;
	Mon, 25 Mar 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YqVRToWf"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4C6E5E1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410148; cv=none; b=G2LN7tjbYJkPSY8r2hlAOCSTuBr8zA6UJutudWg0a/6U40LjzElDxGVkH5cOfYqVGAmV7L0riwRnGAY8erjV/rtFnw5ecNxEOZRZUfhuFe9TF/NmnVSFxGPsrkYvOpEM9YOHn8zRInasMUxHJfaSeKP6Qmj9My1XM/mIM7yn9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410148; c=relaxed/simple;
	bh=1hd7YpQ7hQwnxXcI9b5Po9F83x/ePee1k7tMWUZlawY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g7qN8uz3UWwRgiUFb6/D991UYtUyexuba/Rcc0IRhq0aZU8hufdJsqUVZkxBwYscs5c3NkiQftHLLAaoEfgAsh+fLep/igwWcwOzWaphFTUMly7jopP8p0pDnayRGfGY3imO7Com1ONdrRCmaSvZZg7dk2dyhZHxlnDAbBPKjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YqVRToWf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso3168759b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711410146; x=1712014946; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwaCyJsz17AgoLSOr3XyXPNKuRaqFxfz3ir5v+CFYwU=;
        b=YqVRToWfDwKdMtfFJfUJu2PD3qnoBNP0vxcDZ/ts3E4a58N+dUeMMLRwefrdKudZUh
         1AtJ5t3emRlORTioTnkZ9rMtd7HAy71A8DORKZnFynmOb0hDGFaN/Laba79QV6AWAV3I
         BWg+/kkAt6UTkMGijv/hWrISX+gBysNmEIGy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410146; x=1712014946;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwaCyJsz17AgoLSOr3XyXPNKuRaqFxfz3ir5v+CFYwU=;
        b=P/d3scdBc5HhfAowdB7iaxDen80uEBpqbFxwTXvgaoG+p+GTWvTkxYx5IGEpPw8waA
         9WwMfXxF4QiKYvoJUdjXnu5CwJo4B3DY9qm5W9MhrpPpK027UpMEjgBYmwZVWGYnJ6LJ
         M8SALj8wI+270p/s5rNjWEzAh9fIZAHhrHkOU8JF922GYdQ7TkLE380OTlNDCul7XojI
         ng/V83X9dBPcqVoiiAI3uuSPh+qIrDKukTsUX7SHoyt7ZFmwc8IaGbHky1lm84ZzfrUP
         OtFo2Y9onuso5viDLQWUtdiFYZVCEMZXoLipZBXah2cifNs0kXxFx+RydyPjMrHWydHY
         RgDw==
X-Gm-Message-State: AOJu0YyQwP/rOVO/BUnW3aknEAFqNOllURTvDT72DdOVrE70/aNHcBqe
	6oobH84hgaFaw9wXIvlGlWPBzaTYtlPhFFkrSDs1HsPA512p0gST8CTdlrvP6g==
X-Google-Smtp-Source: AGHT+IHcXRhOkEXvObxQ0tQ+Vis8HUcWqaWZDTWLrnQuWAKccLbAZLusm/dPdM5IveoBuuJ72krrXw==
X-Received: by 2002:a05:6a00:986:b0:6e6:5396:ce43 with SMTP id u6-20020a056a00098600b006e65396ce43mr10909343pfg.7.1711410146625;
        Mon, 25 Mar 2024 16:42:26 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id e12-20020aa7824c000000b006e5f754646csm4705250pfn.139.2024.03.25.16.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 16:42:26 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Subject: [PATCH v2 0/3] usb: typec: Implement UCSI driver for ChromeOS
Date: Mon, 25 Mar 2024 23:42:24 +0000
Message-Id: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOALAmYC/3XMQQ6CMBCF4auQWTumLSCNK+5hWOAw0kmEklYaD
 eHuVvYu/5e8b4PIQTjCtdggcJIofs5hTgWQ6+eRUYbcYJSpVGlqXNb7UwhXioIOSybmSqtLX1v
 InyXwQ96Hd+tyO4kvHz4Hn/Rv/ScljQobathaywOpviUX/CTrdPZhhG7f9y9pFmlVrQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 chrome-platform@lists.linux.dev, Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

We are developing a UCSI ChromeOS EC transport driver. The ChromeOS EC
implements a UCSI PPM. This driver is being developed in
drivers/platform/chrome since

1) Most other drivers which depend on ChromeOS EC reside there.

2) Our architecture might undergo a few revisions rapidly, so
   platform/chrome seems like a good place while we finalize our
   design.

This patch series creates a public include/usb/ucsi.h that can be used
by transport drivers outside drivers/usb/typec/ucsi. Then, we use this
interface and ChromeOS EC host commands to send UCSI commands in
drivers/platform/chrome/cros_ec_ucsi.c.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
Changes in v2:
- No code or commit message changes.
- Added drivers/platform/chrome maintainers for review.
- Link to v1: https://lore.kernel.org/r/20240325-public-ucsi-h-v1-0-7c7e888edc0a@chromium.org

---
Pavan Holla (3):
      usb: typec: ucsi: Provide interface for UCSI transport
      usb: typec: ucsi: Import interface for UCSI transport
      platform/chrome: cros_ec_ucsi: Implement UCSI PDC driver

 MAINTAINERS                                    |   1 +
 drivers/platform/chrome/Kconfig                |  14 ++
 drivers/platform/chrome/Makefile               |   1 +
 drivers/platform/chrome/cros_ec_ucsi.c         | 247 +++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h                  |  54 +-----
 include/linux/platform_data/cros_ec_commands.h |  19 ++
 include/linux/usb/ucsi.h                       |  66 +++++++
 7 files changed, 349 insertions(+), 53 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-public-ucsi-h-3ecee4106a58

Best regards,
-- 
Pavan Holla <pholla@chromium.org>


