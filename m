Return-Path: <linux-kernel+bounces-30918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3C8325E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28824B22A63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50238208D5;
	Fri, 19 Jan 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B8609PWG"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577A1D690
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653816; cv=none; b=bQIRF9xK9X1PetheUBpjwQqb9i2zXllt1W2NeFUX3W46zOnJej8QuU74A52wfyB+UCavl54WcHuYqTfcwAk0EECDq7y5+KknJgIV2cCByqLvWZxcmAysggzfHQzspjqo5qMGT3y15JC31gC3rcvPBZ5Z0RJ7C9XC+Nn6X02C44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653816; c=relaxed/simple;
	bh=89c/E1WE9Dqz+FNJvgcC0QqVkf88/Uc2d4rfA4sgVJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNqzEwAgEz/ZvXJlSx3ALbbRAnrK4VUVjmn+UIenxZ7z8sa4siaOFkkdJQs3NiX7RR3VyfRolrpP5L+L7/lm5UgVf+7azzqoBpIgACqbk6NYx6hLhpvNp6QXGstb/TmqHYaodkXe+xuEVSXT1nRjSMo2fe/gAoZj7QeKAa9QR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B8609PWG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so571775e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705653812; x=1706258612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NipyPWLmE/gRh6MB2S3xsZHlrOKnabjbF4D7HyjLfJo=;
        b=B8609PWGhWhC6ZRA0wWNnvCjRSaXWp9+JBfWgltZQkfwaQeAobKu4Nv8aBkO6CaloJ
         ai/I9/7c69Y5ZYm2TqsB7T1GA5SKECSBx78CSJnjjFxAldvZ/7/3qLtdrErnchDvB+1R
         r4zE1DC8TUDR1Muue+E0Yw53ULu9dOADD8bHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653812; x=1706258612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NipyPWLmE/gRh6MB2S3xsZHlrOKnabjbF4D7HyjLfJo=;
        b=AutAc0q6nqm9geFWA2qqZhpgmpw/vHAq5cb30v6RRAapOBkZ9klc5Pjta3m+s605dB
         XOOwmiMIIbr5vjlD3+i1iadpDmB9Ic764nxgqrRRxM3nXJ/dge3Oya289y1PnMsa7/JE
         uRjSWDO17Ui5hqEac0Xm1qKOxvWGjPcz2b24aU1gX18Yt6fr0y5MALa3pXFJozUQSFTF
         U+hu0k7MYV+oMcZRz+q+xtLK7HAlM9pt1CLb8JQfM6LsO3bOWItuuCcLwQmrvEp8BJtq
         VQO6kKTClBk44hEM9MxyxuQ9CoVSVovwl0D10YvzO5jjD5gwzzjePhPx3IkT48KVbutH
         6epg==
X-Gm-Message-State: AOJu0YykKp59Wu1Nh+rnuNPwqAMBkDfW0H8w2ekk3IHaz0Tkep36+USu
	NsMEVYRiLyBP3vHFMw+yBaqaTEORsfpGqOE/X05DmsGIbYW3JOQA33Nikfr47A==
X-Google-Smtp-Source: AGHT+IE1FyC3NQ9gESEcnrvEJTYihiwykuX4jenP0Fk3IRgGkqirbCwDO6Yg7zBJ7psoJRM2hI6NmQ==
X-Received: by 2002:ac2:5627:0:b0:50e:7410:d293 with SMTP id b7-20020ac25627000000b0050e7410d293mr463966lff.135.1705653812166;
        Fri, 19 Jan 2024 00:43:32 -0800 (PST)
Received: from cracow.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id q23-20020ac246f7000000b0050e6aff6630sm905591lfo.152.2024.01.19.00.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:43:31 -0800 (PST)
From: Lukasz Majczak <lma@chromium.org>
To: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Lukasz Majczak <lma@chromium.org>
Subject: [PATCH v3 0/3] Introduce EC-based watchdog
Date: Fri, 19 Jan 2024 08:43:24 +0000
Message-ID: <20240119084328.3135503-1-lma@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Chromeos devices are equipped with the embedded controller (EC)
that can be used as a watchdog. The following patches
updates the structures and definitions required to
communicate with EC-based watchdog and implements the
driver itself.

The previous version of this patch was sent here:
https://patchwork.kernel.org/project/linux-watchdog/list/?series=817925

Changelog
V2->V3:
* drop "-drv" from driver name
* use format #define<space>NAME<tab>value

Best regards,
Lukasz

Lukasz Majczak (3):
  platform/chrome: Update binary interface for EC-based watchdog
  watchdog: Add ChromeOS EC-based watchdog driver
  mfd: cros_ec: Register EC-based watchdog subdevice

 MAINTAINERS                                   |   6 +
 drivers/mfd/cros_ec_dev.c                     |   9 +
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/cros_ec_wdt.c                | 202 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  78 +++----
 6 files changed, 264 insertions(+), 43 deletions(-)
 create mode 100644 drivers/watchdog/cros_ec_wdt.c

-- 
2.43.0.429.g432eaa2c6b-goog


