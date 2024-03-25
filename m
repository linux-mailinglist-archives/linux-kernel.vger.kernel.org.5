Return-Path: <linux-kernel+bounces-116896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8688A4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A352B1F3D671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172A17A37C;
	Mon, 25 Mar 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CLzj6vyl"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD97219F529
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364101; cv=none; b=on4vzZu6k21hN16er2t+QTGKgv+sH44zozixrBg6flBrL6D8RiO5ph+eZBH45fDzInCjtXMcIoXW9TbPvRTlUsiPMwFG3a3jPD0g3OyJQ8751pmP1kW3HZQy82PZCfY3Xl/fc4TLVsnTtq6CvAaG6PYXPmXyjHolkhiArG0FXyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364101; c=relaxed/simple;
	bh=UzyidwSIDUNATQV9Wm0Ut6BdNvIpkTtmBKV1epvsvH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ivkjpln6v7wpUhDYRVB3Yfb9bc1Sx39Ty4oRaBFh/gcCUt2n1khpWmNOuLI789FR2BX163N5vf9Ndf0PXz/vX2hLxYoVHAtbMdm2cp1oC3mME9aJuvCj3tuyX3LxB1A7wVIHvYeflfzN4T26ekhtEioiEQsUpUPf79LJbOOMbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CLzj6vyl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so5702712e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711364097; x=1711968897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTAS3N78+eEvzc9y/KOpFGYpe/3uK9ebe/5f/RJ6Ot8=;
        b=CLzj6vyloG1wzskVblbWnm3ddVKrzzEfekNOkbnHvQ0+wq54cCVysq1glE35VPbjcF
         Bevhgl/e7ZYRm5avjTkUPoUDF6EnhC7jhOM66xqiNXV6JDMHSSOpcyzIi5a1HerqNkN/
         OZw6bdwhflAYASQ6McGlT5so2faD4jDG5D79E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364097; x=1711968897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTAS3N78+eEvzc9y/KOpFGYpe/3uK9ebe/5f/RJ6Ot8=;
        b=SRRWyguGvr63oA+n6fC0YmMcW2ycGNrWavHOQEJAjlk3WBYZs5Xos19iMNqL9LLhUr
         aFJFFntBxHHKaHe0noF6YXe2ge9fyyF48akm1joqxajLjq89Dc6Qde4JQ0BcufQe84UM
         aGzMphMPpKatJi1jL3PfxJlullBarMEqWqwKFRhHlwmmNQkau4TowW9SHNl5NJyHnb1A
         bSj3aVPMoSiCEdJYtUa/FV+tEIhIRSVlooaYphRejmejslTOqIisRPqxTwn07JY810QO
         D474gJpBgvMjFt9kWjDdGjpGDG5nJds4mzGLK+8r18NEoQzOSYHng4G3O3GG1cT9IOOD
         LdHw==
X-Forwarded-Encrypted: i=1; AJvYcCU5pfVzHYlLgwPydS7b++xHdzRd4hN5eeM5p7y8hOwJhGoElSFMZD7NhCnvMb88maIyHJuWZVSMWf0Eylo09Eo4DlXu2vLEoKCvHURl
X-Gm-Message-State: AOJu0YyA8rAd70fizocT0Z09SF+tnr+x1kuwT/Hk6kOPLiFmaVXGGUgA
	lG0tmXcNV+te89lQlHV1/i76S7UDegLkzYggb+euJ45EFQmiyMrL6Yx7f2O5HQ==
X-Google-Smtp-Source: AGHT+IHVwSUZiFYY4NBhuItMUBGjJl/jpX/5a9saFTj0ty03NNDiNEz6BwkZcnHA9EP2utUK7LjgQw==
X-Received: by 2002:a19:4312:0:b0:513:cb74:9ffe with SMTP id q18-20020a194312000000b00513cb749ffemr4230298lfa.50.1711364096852;
        Mon, 25 Mar 2024 03:54:56 -0700 (PDT)
Received: from cracow.c.googlers.com.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id f20-20020a05651232d400b00515b08c7397sm93489lfg.67.2024.03.25.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:54:56 -0700 (PDT)
From: Lukasz Majczak <lma@chromium.org>
To: Jiri Kosina <jikos@kernel.org>,
	Dmitry Torokhov <dtor@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lukasz Majczak <lma@chromium.org>,
	Radoslaw Biernacki <rad@chromium.org>
Subject: [PATCH] HID: i2c-hid: wait for i2c touchpad deep-sleep to power-up transition
Date: Mon, 25 Mar 2024 10:54:52 +0000
Message-ID: <20240325105452.529921-1-lma@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends the early bailout for probing procedure introduced in
commit: b3a81b6c4fc6730ac49e20d789a93c0faabafc98, in order to cover devices
based on STM microcontrollers. For touchpads based on STM uC,
the probe sequence needs to take into account the increased response time
for i2c transaction if the device already entered a deep power state.
STM specify the wakeup time as 400us between positive strobe of
the clock line. Deep sleep is controlled by Touchpad FW,
though some devices enter it pretty early to conserve power
in case of lack of activity on the i2c bus.
Failing to follow this requirement will result in touchpad device not being
detected due initial transaction being dropped by STM i2c slave controller.
By adding additional try, first transaction will wake up the touchpad
STM controller, and the second will produce proper detection response.

Signed-off-by: Lukasz Majczak <lma@chromium.org>
Signed-off-by: Radoslaw Biernacki <rad@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 2df1ab3c31cc..69af0fad4f41 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1013,9 +1013,15 @@ static int __i2c_hid_core_probe(struct i2c_hid *ihid)
 	struct i2c_client *client = ihid->client;
 	struct hid_device *hid = ihid->hid;
 	int ret;
+	int tries = 2;
+
+	do {
+		/* Make sure there is something at this address */
+		ret = i2c_smbus_read_byte(client);
+		if (tries > 0 && ret < 0)
+			usleep_range(400, 400);
+	} while (tries-- > 0 && ret < 0);
 
-	/* Make sure there is something at this address */
-	ret = i2c_smbus_read_byte(client);
 	if (ret < 0) {
 		i2c_hid_dbg(ihid, "nothing at this address: %d\n", ret);
 		return -ENXIO;
-- 
2.44.0.396.g6e790dbe36-goog


