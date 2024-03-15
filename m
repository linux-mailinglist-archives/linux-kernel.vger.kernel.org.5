Return-Path: <linux-kernel+bounces-104810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F787D405
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEFF1C230AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1EA53802;
	Fri, 15 Mar 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9hVQkrS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0D535BF;
	Fri, 15 Mar 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528607; cv=none; b=XFbgGuIoOjaFConX3LHAyvHYKD6GR66rpL7xq1R4sThaKGbpKuuOJ3gS42t7q6WziAxL0XDOuw8s4mQB8vE0Yp440HKTaNqluTOgV4OgSwk5P1TdIm5xu13/FfP6wLfkv65LuCww9v+pHAUeGVeDONY/ooNgHIcPa+XZUtc2Q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528607; c=relaxed/simple;
	bh=HKO1HfQMaGl/CCeE/Ln6SsQv/qM6IwNciXbv0btirr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry6uy2SDLkPctarVEVRimsNQQeww2aQJRyPKBwgE3R6MyGAjWIPy9j7xu0sH19KoIIwYHBApI0f3+aUhyNME2D7vvuA5bSTcUCHbT+AxtxCbmFazNDg/n00yUk0YJoRKIvIDbvxkPRxrf/DGD4QUG22rkSEXv0FidmljuvA53Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9hVQkrS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so1251623b3a.2;
        Fri, 15 Mar 2024 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528602; x=1711133402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRqivYuE7DcmOFFhwyqSkRwN4XtrqdDpfy8FtThn+Dk=;
        b=b9hVQkrSu/NrMhqToThWIFikGzZR38NsaYglJ8YgDHHuFzVDv7wfUAeJ3IiXzZSEF2
         R6WdLUAUuPNHpi3e24Us21T6WhdYd1l4x3+AQt/8XN6caSFr8M9y8j3XvfWE4MbSXdLe
         RtAi4DWATZKZhouAWSFYF3TZJcr4OztNiKbhvWwdWWLLeFSFW4OCAcjXmY1FsnFPHIZj
         h+I72yeZSdvTW32LW6WjTxJzjv+i3nJFpO26qRZSz/FIUabg0ovhtkR2OrwV5paOSYol
         VjwhfD/OP1k2gxSvY5y7u2wT64w75tIVZIlugXc6MhHwaKs5BNeV6rv3QS6iF3AEtC1x
         WrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528602; x=1711133402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRqivYuE7DcmOFFhwyqSkRwN4XtrqdDpfy8FtThn+Dk=;
        b=DY2j9jcIXe9qBKfxtgTM3xd2FfX7AId3jNtukldBYssYueYlTlQy+AUw3cZ0uNfqAj
         EC4SpAKca6Jt2oGg+xdAolAPkyoOlzJbdBjOW03bhe/u8Nrk1WaFOOxgnrW1+FhAs0Qe
         Fud5eKllt0UNENjwi2e1YDTeQ5m3uq+A7R2q+3MJipfArSsyuCODVKB+T8IsaWsueKxQ
         5c/oq9NJ6A0Sw5d2Gte2K92+ZcHFlKIGwj8cVrJBO3QLzySeDV3ei/9sMegN484oVJLN
         MpOXEIQ+lV2PGomDcfEPIEnaKsThrBmk08UXydqPxENfbnnmGyHAj28Z1KeyuPIJjT1u
         PkYg==
X-Forwarded-Encrypted: i=1; AJvYcCUAv3e5yL9tfsbqwb9F0MiB0lgngBDKxys1vc8aEcag5Wm2Shaqds30aOQIqqDvk/yAPE0Hl/f6CbWgeYglrSxrRcrfW/g195kFUXBx+/utk02Y/wOzVBl1nWZaSwUyv/Gpyu4YKx1B9PQ2Yd10oG1sLlxcNe0SSwrdVCZIfAdV2A61Qg==
X-Gm-Message-State: AOJu0YwA4rPX8S9VUK2c1cHd6ejwAfqphDd0yv0fvgHInch+7ZFnsA3X
	cYt8BZFgeOs8f+LK7yDH8N0ls0TEomgpyoZonhbUycCkDf85lV5e+kxdzrLSj9u2tA==
X-Google-Smtp-Source: AGHT+IHQbXiA7SVlIsgBVryvm0PGS1QFL0t3DlqmYIaIG83GvhramGbGJdZlO3EHZsPjHP3Bdwk5+g==
X-Received: by 2002:a05:6a20:7d9c:b0:1a3:53a0:da1f with SMTP id v28-20020a056a207d9c00b001a353a0da1fmr1195976pzj.12.1710528602430;
        Fri, 15 Mar 2024 11:50:02 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:50:02 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vaishnav M A <vaishnav@beagleboard.org>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	Ayush Singh <ayushdevel1325@gmail.com>
Subject: [PATCH v3 4/8] serdev: add of_ helper to get serdev controller
Date: Sat, 16 Mar 2024 00:19:02 +0530
Message-ID: <20240315184908.500352-5-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vaishnav M A <vaishnav@beagleboard.org>

add of_find_serdev_controller_by_node to obtain a
serdev_controller from the device_node, which
can help if the serdev_device is not described
over device tree and instantiation of the device
happens from a different driver, for the same purpose
an option to not delete an empty serdev controller
is added.

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/tty/serdev/core.c | 19 +++++++++++++++++++
 include/linux/serdev.h    |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 613cb356b918..5b5b3f2b2e42 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -555,6 +555,19 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
+{
+	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
+
+	if (!dev)
+		return NULL;
+
+	return (dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
+}
+EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
+#endif
+
 #ifdef CONFIG_ACPI
 
 #define SERDEV_ACPI_MAX_SCAN_DEPTH 32
@@ -785,6 +798,12 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 
 	pm_runtime_enable(&ctrl->dev);
 
+	/* provide option to not delete a serdev controller without devices
+	 * if property is present
+	 */
+	if (device_property_present(&ctrl->dev, "force-empty-serdev-controller"))
+		return 0;
+
 	ret_of = of_serdev_register_devices(ctrl);
 	ret_acpi = acpi_serdev_register_devices(ctrl);
 	if (ret_of && ret_acpi) {
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index ff78efc1f60d..287d7b9bc10a 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -117,6 +117,10 @@ static inline struct serdev_controller *to_serdev_controller(struct device *d)
 	return container_of(d, struct serdev_controller, dev);
 }
 
+#if defined(CONFIG_OF)
+struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
+#endif
+
 static inline void *serdev_device_get_drvdata(const struct serdev_device *serdev)
 {
 	return dev_get_drvdata(&serdev->dev);
-- 
2.44.0


