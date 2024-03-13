Return-Path: <linux-kernel+bounces-102493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891F987B2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404CB286463
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1D754BFF;
	Wed, 13 Mar 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TTr6cXRj"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CC52F8C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361708; cv=none; b=Y3Cml1zoM5UZqMqaJ084yxcZMkbRJeYnV15A4f8nqgbkodknk/nD8+FqFnhPDfj2FnISMj9mK6WYYL3oFGkMO/r1zryCQtJfRyy7t0TGt1f8kpuJvXOo0FpEG00aElttHqYI0w0/a/oo5YAMOcHgKKffJIS8NvGcu5p/HOYIGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361708; c=relaxed/simple;
	bh=RO3Atsu/XNialExhBez0PULy9EejbFm+wkoV4T1gvWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkPDoRMBmm18OvfXRHebQdx1M71YWA6Z7UMor+SFiPqL64+RICmbE/P2UFE/jrR3y9HMxk7Ahy3wNu6wzBU3h+JoOFi1Y5m4w349ONwrPYujnyB9FLWJyqCulEv6yxdnWbEj8S7dX6j5fBuBKt0eCZYBidOSTEIXOaXEVO3F8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TTr6cXRj; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c356e40ef3so46657b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710361704; x=1710966504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFrOuwbpliv9LxO1khs6y86WYRhC/89pNSbQx+I348g=;
        b=TTr6cXRjhPFeNa5Eb5LsSIF5S7GLWommcCJIQ8aEhaYLK7bR1uOTvWWSbozcuzXzf9
         oL+PcaD0hH0Tz3uM48wn3LQmDkX6mqnOwcsR9j/ngmTeY6MJuwhACBSKcjQvJaggO8AV
         yIUxHYpIJaGW0qjqFQoD9SpPnDc0xvC5Qlhzv7CTLZaTT2qGxRGXLwNolTBCsUdkMNrt
         ZNOSy1H9N4NWWbDPNWSJHgbKNFEH1+BrmTqdQJ4khAgI0z4Dj537avRvyxQYuj1ODW3Y
         G0/86s/8QqY1P/1HxO+tZQOtWSGkvRJFruB0ULNsWlxelXPBuq4WJvUdbIjJs5KydtI/
         tJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361704; x=1710966504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFrOuwbpliv9LxO1khs6y86WYRhC/89pNSbQx+I348g=;
        b=Ci6AUtLbMWyogTrwRWvCzN49PqGJPZBINAqfWDvEKLGtRKuBNki3bQVW2ckrRHVMRM
         AIOX6elPS++9j2VaBYIPncYUJzAO9sAZ7T0aZFAdvNtX1GRqJv+/9MpjCKpsNGA+CAkp
         +80UR1pT0PUtHP5GW0Nwm08cqHFwgh4svNcgFmpHYUkMTPMM+zcVyRW0NXjFES+2Fi8p
         UqXYUWJWqWOYfiyTpiG7DnJYRSCwqFo8N3sCptvHJixNIh47cXHnclPWot68xw56u3qS
         iwb8vNr4jqCaZ9dfXsoDVKxm+OAvs1dWO8F5el4ajYMFezcOxUTAQpe3BT/zlGQgiyxw
         FBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZaoyD5rAX0+KL2yObYQBGchXKXNNCunpC5r8S1ic/UKGFzie7Dv/O3q8VDJEnDR5AlBtkTOQUP+FnkEDRAXErMdF95LA8a8Oa1EIv
X-Gm-Message-State: AOJu0Yx9QcVX5rNPMVUfGVCFCiXtnF3QTRVJ01NfQVr/ZWi0IlPqGSpG
	jJ5tf4hcKtSURyVZ8pODLfBPXuitnDsnqitjn314uQVCMVqb3Q8Xg19xaVmRLOg=
X-Google-Smtp-Source: AGHT+IE7TvldEJqNRXfH1beQTP1yPS0jaLh9RnYDCTJ0/b3qfVLtpkwjQmyBxKB3ZtpvbhQ/Wedwig==
X-Received: by 2002:a05:6808:1489:b0:3c2:194a:4923 with SMTP id e9-20020a056808148900b003c2194a4923mr382792oiw.14.1710361703775;
        Wed, 13 Mar 2024 13:28:23 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id s8-20020a9d58c8000000b006e4eaa4ba7esm21520oth.61.2024.03.13.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:28:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: iio: new docs for ad7944 driver
Date: Wed, 13 Mar 2024 15:21:52 -0500
Message-ID: <20240313-mainline-ad7944-doc-v1-2-7860416726e4@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
References: <20240313-mainline-ad7944-doc-v1-0-7860416726e4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new page to document how to use the ad7944 ADC driver.

Credit: the basic structure and some of the text is copied from the
adis16475 docs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/iio/ad7944.rst | 227 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 229 insertions(+)

diff --git a/Documentation/iio/ad7944.rst b/Documentation/iio/ad7944.rst
new file mode 100644
index 000000000000..dbe2153b415a
--- /dev/null
+++ b/Documentation/iio/ad7944.rst
@@ -0,0 +1,227 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD7944 driver
+=============
+
+ADC driver for Analog Devices Inc. AD7944 and similar devices. The module name
+is ``ad7944``.
+
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7944 <https://www.analog.com/AD7944>`_
+* `AD7985 <https://www.analog.com/AD7985>`_
+* `AD7986 <https://www.analog.com/AD7986>`_
+
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+The driver currently supports two of the many possible SPI wiring configurations.
+
+CS mode, 3-wire, without busy indicator
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                         +-------------+
+                    +--------------------| CS          |
+                    v                    |             |
+    VIO   +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD7944   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
+
+To select this mode in the device tree, set the ``adi,spi-mode`` property to
+``"single"`` and omit the ``cnv-gpios`` property.
+
+CS mode, 4-wire, without busy indicator
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                         +-------------+
+     +-----------------------------------| CS          |
+     |                                   |             |
+     |              +--------------------| GPIO        |
+     |              v                    |             |
+     |    +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD7944   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
+
+To select this mode in the device tree, omit the ``adi,spi-mode`` property and
+provide the ``cnv-gpios`` property.
+
+Reference voltage
+-----------------
+
+All 3 possible reference voltage sources are supported:
+
+- Internal reference
+- External 1.2V reference and internal buffer
+- External reference
+
+The source is determined by the device tree. If ``ref-supply`` is present, then
+the external reference is used. If ``refin-supply`` is present, then the internal
+buffer is used. If neither is present, then the internal reference is used.
+
+Unimplemented features
+----------------------
+
+- ``BUSY`` indication
+- ``TURBO`` mode
+- Daisy chain mode
+
+
+Device attributes
+=================
+
+Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+where ``X`` is the IIO index of the device. Under these folders reside a set of
+device attribute files, depending on the characteristics and features of the
+hardware device in question. These files are consistently generalized and
+documented in the IIO ABI documentation.
+
+There are two types of ADCs in this family, pseudo-differential and fully
+differential. The channel name is different depending on the type of ADC.
+
+Pseudo-differential ADCs
+------------------------
+
+AD7944 and AD7985 are pseudo-differential ADCs and have the following attributes:
+
++---------------------------------------+--------------------------------------------------------------+
+| Attribute                             | Description                                                  |
++=======================================+==============================================================+
+| ``in_voltage0_raw``                   | Raw ADC voltage value (*IN+* referenced to ground sense).    |
++---------------------------------------+--------------------------------------------------------------+
+| ``in_voltage0_scale``                 | Scale factor to convert raw value to mV.                     |
++---------------------------------------+--------------------------------------------------------------+
+
+Fully-differential ADCs
+-----------------------
+
+AD7986 is a fully-differential ADC and has the following attributes:
+
++---------------------------------------+--------------------------------------------------------------+
+| Attribute                             | Description                                                  |
++=======================================+==============================================================+
+| ``in_voltage0-voltage1_raw``          | Raw ADC voltage value (*IN+* - *IN-*).                       |
++---------------------------------------+--------------------------------------------------------------+
+| ``in_voltage0-voltage1_scale``        | Scale factor to convert raw value to mV.                     |
++---------------------------------------+--------------------------------------------------------------+
+
+Processed values
+----------------
+
+A channel value can be read from its ``_raw`` attribute. The value returned is
+the raw value as reported by the devices. To get the processed value of the
+channel, apply the following formula:
+
+.. code-block::
+
+    processed value (mV) = _raw * _scale
+
+Where ``_raw`` and ``_scale`` are the values read from the corresponding device
+attributes and the result is in millivolts.
+
+For pseudo-differential chips, the processed value is the voltage of the *IN+*
+input referenced to ground. For fully-differential chips, the processed value
+is the voltage difference between the *IN+* and *IN-* inputs.
+
+
+Usage examples
+--------------
+
+Show device name:
+
+.. code-block:: console
+
+    root:/sys/bus/iio/devices/iio:device0# cat name
+    ad7986
+
+Show voltage input channel values:
+
+.. code-block:: console
+
+    root:/sys/bus/iio/devices/iio:device0# cat voltage0-voltage1_raw
+    -101976
+    root:/sys/bus/iio/devices/iio:device0# cat voltage0-voltage1_scale
+    0.038146972
+
+The actual measured voltage between *IN+* and *IN-* is:
+
+.. math:: -101976 \times 0.038146972 \approx -3890.08~\mathrm{mV}
+
+
+Device buffers
+==============
+
+This driver supports IIO triggered buffers.
+
+Usage examples
+--------------
+
+Create a trigger if one doesn't already exist:
+
+.. code-block:: console
+
+    root:/# mkdir /sys/kernel/config/iio/triggers/hrtimer/ad7986-trigger
+
+Set device trigger in current_trigger, if not already set:
+
+.. code-block:: console
+
+    root:/sys/bus/iio/devices/iio:device0# cat trigger/current_trigger
+
+    root:/sys/bus/iio/devices/iio:device0# echo ad7986-trigger > trigger/current_trigger
+    root:/sys/bus/iio/devices/iio:device0# cat trigger/current_trigger
+    ad7986-trigger
+
+Select channels for buffer read:
+
+.. code-block:: console
+
+    root:/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/in_voltage0-voltage1_raw_en
+    root:/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/in_timestamp_en
+
+Set the number of samples to be stored in the buffer:
+
+.. code-block:: console
+
+    root:/sys/bus/iio/devices/iio:device0# echo 4 > buffer0/length
+
+Enable the buffer:
+
+.. code-block:: console
+
+    root:/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/enable
+
+Obtain buffered data:
+
+.. code-block:: console
+
+    root:/# hexdump -C -n 64 /dev/iio\:device0
+    00000000  5a 72 03 00 00 00 00 00  c5 b9 da 3f d1 61 bc 17  |Zr.........?.a..|
+    00000010  14 79 02 00 00 00 00 00  d1 3e 73 40 d1 61 bc 17  |.y.......>s@.a..|
+    00000020  7f 77 02 00 00 00 00 00  63 d7 0b 41 d1 61 bc 17  |.w......c..A.a..|
+    00000030  9b 84 02 00 00 00 00 00  af 70 a4 41 d1 61 bc 17  |.........p.A.a..|
+    00000040
+
+See :doc:`iio_devbuf` for more information about how buffered data is structured.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 30b09eefe75e..fb6f9d743211 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -16,6 +16,7 @@ Industrial I/O Kernel Drivers
 .. toctree::
    :maxdepth: 1
 
+   ad7944
    adis16475
    bno055
    ep93xx_adc
diff --git a/MAINTAINERS b/MAINTAINERS
index fb2377bad376..40813d9ec38f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -448,6 +448,7 @@ R:	David Lechner <dlechner@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
+F:	Documentation/iio/ad7944.rst
 F:	drivers/iio/adc/ad7944.c
 
 ADAFRUIT MINI I2C GAMEPAD

-- 
2.43.2


