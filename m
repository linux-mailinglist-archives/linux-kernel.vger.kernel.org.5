Return-Path: <linux-kernel+bounces-30921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669718325EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FBC1C22AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595124B36;
	Fri, 19 Jan 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liU1URIE"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2B241F0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705653819; cv=none; b=kCkAf6jgJ24Q9Cb5usb96XAvuMWz6mXD1hstFSD2rKCk+mfilONJ99r76fmaxrwQRBczUZbJrpmbEhcYPgNtX44kWW6kS0rLj7PRX1SwkltHQETYdoBCQAsKt1FMAFPyPgF12NiyJwaSh5mvY/Nd2GXVAYt+OFrKUxnf9lj7yZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705653819; c=relaxed/simple;
	bh=osSLkFHxCEi9lg/snRlEZT8CPmmDwFp84neEb75c09c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLfzWtQ/tsCgzFLPyiYijLIlGwMGdulctNy59fherJ1J3Cp0j66agizbOnK+krXCH0bAsRJZGmJeGcMaMoA/tTOd3vMyiaB/nptM6gIRnOfX2o9hLN5K+bFkemvQ7xVZjkU77Lcoq5y+xUEs7owDiZvF/VGTwKREhu/2ulz/zyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=liU1URIE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso619581e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705653816; x=1706258616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LriL7tXJHljhDBH+IF5gAskdccX7dSP4qzgOWwB59VY=;
        b=liU1URIEnmIUaeQuwkkVRL7XCuG6KJdqt2XTiv8U90rzJcwqn/TbJpETHliTG/FX+4
         BTpSrXr9/suHqw+dEcPqOmatS3aMaQtHGkYa7iuTr72EqeiviZ2cSLf8SpikDQ8TPSuX
         mFcSza51J5ASTDsnJKK2/QIVmdOcMhx2odcpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705653816; x=1706258616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LriL7tXJHljhDBH+IF5gAskdccX7dSP4qzgOWwB59VY=;
        b=UKdtTx+blLJMreAJmFVFdVnoCUQ+nmSovZxsagQCWQDopbZcOtg4rRsrqu8UH/j/5g
         CA3pnpW/6Cd+NR1W8ITGsAMGNRa/c4+5mDzImLead2VlFUAGk1rXYkn9Hl5ufe70qT27
         2a5SMmFVn1AAhV4G6cZufeIKvoVlXIKZFkvE4KOGi00d/BtkThbErWKYPpytPyoJPzcV
         aZctTXozIYDk+Z9I1iNXbHyCnig9ZtNi6u6oBSeK/SthkCPJk/uNrdnTahwa07gp5Tyc
         aXOsAVxdrnQ/AUU37M3dku4qJl6KKl0CTYzsutMijP8wcVS57cZp3+syqhHFfKA6xvOo
         veXg==
X-Gm-Message-State: AOJu0YyC7+sCrfwSfY7uzreZqj9+cKveYLd7TgrKZDe+qZPvtTUDpRei
	ilV0R9OKM9JRg585WkmKTAZIFeuH4Wiu76YBwi53892H4D4nJ8bJ9E8leaJX+g==
X-Google-Smtp-Source: AGHT+IFTIsShTsLVt2WoGAE/70+F7JfM4Qy0jMxOp/f9e/N031wHAWuBBM0NHSRyhAcB1H6QiaSrng==
X-Received: by 2002:ac2:5627:0:b0:50e:7410:d293 with SMTP id b7-20020ac25627000000b0050e7410d293mr464015lff.135.1705653816543;
        Fri, 19 Jan 2024 00:43:36 -0800 (PST)
Received: from cracow.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id q23-20020ac246f7000000b0050e6aff6630sm905591lfo.152.2024.01.19.00.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:43:36 -0800 (PST)
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
Subject: [PATCH v3 3/3] mfd: cros_ec: Register EC-based watchdog subdevice
Date: Fri, 19 Jan 2024 08:43:27 +0000
Message-ID: <20240119084328.3135503-4-lma@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119084328.3135503-1-lma@chromium.org>
References: <20240119084328.3135503-1-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ChromeOS EC-based watchdog as EC subdevice.

Signed-off-by: Lukasz Majczak <lma@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 603b1cd52785..4996220ce64b 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -91,6 +91,10 @@ static const struct mfd_cell cros_usbpd_notify_cells[] = {
 	{ .name = "cros-usbpd-notify", },
 };
 
+static const struct mfd_cell cros_ec_wdt_cells[] = {
+	{ .name = "cros-ec-wdt", }
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -107,6 +111,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_usbpd_charger_cells,
 		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
 	},
+	{
+		.id		= EC_FEATURE_HANG_DETECT,
+		.mfd_cells	= cros_ec_wdt_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_wdt_cells),
+	},
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
-- 
2.43.0.429.g432eaa2c6b-goog


