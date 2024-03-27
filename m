Return-Path: <linux-kernel+bounces-122156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5B988F2CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B1429CAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6D154C06;
	Wed, 27 Mar 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ABVGfHH"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256D154BF3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581545; cv=none; b=eTcw2QANvzz+y4SDlnWEcysQcf7O0U/+oCRmmM2hEGuiSJzbloTfJ6RYzCG4rUY/38pU3cHdS95KiWQcNhyuX/yhCgywMioR+i3dH824pm1nTJ1CtB/IrocP4IZXlDtb1FGFAE/TvUODWGAPeaLu5ihtL/u3FtUbISgJXD/HYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581545; c=relaxed/simple;
	bh=Oin5ojSwy2humzjzfHVDPNnW4ZK/nwUgFx0t+HKuAB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuSi+qm3Aft1Sj72yyfwmAi54i4evucS31QGS9G7yw6ZiAg9UbpMltmxr8fAFBNtKOmtFwR4LCzYSjT+ZKDsXbDa47xL401txgPHqhTq36BfDw0CR/KoiXANpwyzFC1WxTAVnGJLDoMyDFkhW4aXJ9SxdZy3eThGVBC5ibT/DUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0ABVGfHH; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2218a0f55e1so216994fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711581542; x=1712186342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNmxlM+zWytQQYi7ZtjQVmkQiumnd7DNMgYQxgBRWM8=;
        b=0ABVGfHHvyHnYF5hd1OqQl1iZYDFAsoTAnFoz9PQIRq/QP3Nn5kLjbP9koIqKf69et
         BhjAm6OlMQkGbOryPs6WYrzUeqNPdYbOf0WbFbT99DvCHlwQDRnLpG8lyNXp42l778Bp
         I3+i+Rap1zbQuxQ+uLiaD6XlVBJ6BJBonKyRM9jZSc3k8WtzomIlXGCJq44eSDRHvDgQ
         uzXz4NaYW3l0S7fReJSm0W/iYRV7pbWxmgIKYRXJjt3ADDYsLxMoRTM84X1yD6zxRBPW
         T7YI6wmOxIBqyTAcJlFCBcB4MRMdK4VNOZJM+FW3by4lx/R8/6VNoNblqlBuPCAB48/i
         OdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581542; x=1712186342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNmxlM+zWytQQYi7ZtjQVmkQiumnd7DNMgYQxgBRWM8=;
        b=Nc88clWzy3nblMu54IR86rqzxYEsn//Z9RMZbtUtox0r9n7vikZiZUKoJLGq3qAi9/
         p1KmALEEdPhTHjpbrpSHFkK06yoaq4RnSaR+oek/JHTOGHZCAzyr3VYHYkEKE8JY4LwT
         gFSYLKzeIszSlAFdxDCXUg8RTG9X0Y0w5W5cP72rQdTHsixbCC/tnkqKqt1Cy4X/anIA
         QwjrMLMrTzpRqZuayoPPLy3HvVxLUQBMDHo1/ei9Bsu0X9hDxEGjT7IY4M1TAQOIou3q
         0p30wbNcAdIYXkx+VryhU+Eoz8MMrOQEn1xx4e8qyu1Iyu85MNcdvH6hwpRMnZ8yDafs
         Z7xg==
X-Forwarded-Encrypted: i=1; AJvYcCXYTk8VIi8psNVVqB/IP8/hV4AdiFxxGEX38UrFC8iOwromdig/ozJkj7UReZSoFaNugaxuHKFlyN0w8+HlYNfaoBHhwVA/wyLGpB1f
X-Gm-Message-State: AOJu0YzYLaxem5SP9Hg8RRbOMIP4oFLuarXFzQtTc37xYNCf1PpcpN9M
	8LwFCeGO+UJqNrLjbesZkMgZEJye5TITtiL/4dUeDhAqEOWNnPsX7kIkDwD8MKg=
X-Google-Smtp-Source: AGHT+IH0jcJOIn91SYG/gvmxB532Ey13hS1+uAizEDZdhgZnM4KKp+HBnfwPVKzM9sb2VsY2xY892g==
X-Received: by 2002:a05:6871:2b2a:b0:22a:55bd:a048 with SMTP id dr42-20020a0568712b2a00b0022a55bda048mr1167094oac.5.1711581542433;
        Wed, 27 Mar 2024 16:19:02 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id js3-20020a056870bac300b0022a0519183csm81381oab.2.2024.03.27.16.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:19:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: [PATCH RFC 0/7] regulator: new APIs for voltage reference supplies
Date: Wed, 27 Mar 2024 18:18:49 -0500
Message-ID: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the IIO subsystem, we noticed a pattern in many drivers where we need
to get, enable and get the voltage of a supply that provides a reference
voltage. In these cases, we only need the voltage and not a handle to
the regulator. Another common pattern is for chips to have an internal
reference voltage that is used when an external reference is not
available. There are also a few drivers outside of IIO that do the same.

So we would like to propose a couple of new regulator consumer APIs to
handle these specific cases to avoid repeating the same boilerplate code
in multiple drivers.

As an example of how these functions are used, I have included a few
patches to consumer drivers. But to avoid a giant patch bomb, I have
omitted the iio/adc and iio/dac patches I have prepared from this
series. I will send those separately but these will add 12 more users
of devm_regulator_get_enable_get_voltage() and 24 more users of
devm_regulator_get_optional_enable_get_voltage(). In total, this will
eliminate nearly 1000 lines of similar code.

---
David Lechner (7):
      regulator: devres: add APIs for reference supplies
      hwmon: (adc128d818) Use devm_regulator_get_optional_enable_get_voltage()
      hwmon: (da9052) Use devm_regulator_get_enable_get_voltage()
      iio: addac: ad74115: Use devm_regulator_get_enable_get_voltage()
      iio: frequency: admv1013: Use devm_regulator_get_enable_get_voltage()
      staging: iio: impedance-analyzer: admv1013: Use devm_regulator_get_enable_get_voltage()
      Input: mpr121: Use devm_regulator_get_enable_get_voltage()

 Documentation/driver-api/driver-model/devres.rst |  2 +
 drivers/hwmon/adc128d818.c                       | 55 +++++-----------
 drivers/hwmon/da9052-hwmon.c                     | 33 ++--------
 drivers/iio/addac/ad74115.c                      | 28 +-------
 drivers/iio/frequency/admv1013.c                 | 37 +++--------
 drivers/input/keyboard/mpr121_touchkey.c         | 45 +------------
 drivers/regulator/devres.c                       | 83 ++++++++++++++++++++++++
 drivers/staging/iio/impedance-analyzer/ad5933.c  | 24 +------
 include/linux/regulator/consumer.h               | 14 ++++
 9 files changed, 138 insertions(+), 183 deletions(-)
---
base-commit: c5b2db5859957150ac6ed305ab41a4a92ca40cfb
change-id: 20240326-regulator-get-enable-get-votlage-5dedf40ff338

