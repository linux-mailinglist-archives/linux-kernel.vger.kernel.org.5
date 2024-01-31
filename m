Return-Path: <linux-kernel+bounces-46335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2C2843E26
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE461C2417A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2956579DA9;
	Wed, 31 Jan 2024 11:17:21 +0000 (UTC)
Received: from mxout013.mail.hostpoint.ch (mxout013.mail.hostpoint.ch [217.26.49.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433A7993A;
	Wed, 31 Jan 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.26.49.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699840; cv=none; b=Fd+52vC21TG4k+C+zianvOSudU7P96yGfrysFXqD1xxkKHMePWxBjdUulvgbqJ0itWvo/I+OPcxdH0BsSMqagqJzNNDyA8zx6t23URyW/YBV3DuGKA+sIpHR4drFGYdqOCJv+X8VARjOVoHHQ7Te7uqqCVg5arGms6e4PNNFwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699840; c=relaxed/simple;
	bh=pJCY8vlQdovHIAKMl/XorVaaAX4PdAyOBYKtKbP5f0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcrRfuTbce7MLt21puFZSYSe1FbnAsy8qmUI2DMxBY02ZbsJazrpabmKGPWFaI+9ZMqywyyWzdqfkE1Fy7o+S8JsotSHl2YUzub81tTWy2ftJTFNsmQB6DtkfLZ7U3ZBgwCkHCp1g9mb3L+DlR+/FyQu5OIHIHBnP+rXkRM4uwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-gloor.ch; spf=pass smtp.mailfrom=stefan-gloor.ch; arc=none smtp.client-ip=217.26.49.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stefan-gloor.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stefan-gloor.ch
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
	by mxout013.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rV8ZB-00000000DVs-0gxz;
	Wed, 31 Jan 2024 12:15:41 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad.localdomain)
	by asmtp014.mail.hostpoint.ch with esmtpa (Exim 4.97.1 (FreeBSD))
	(envelope-from <code@stefan-gloor.ch>)
	id 1rV8ZA-000000009un-3yfk;
	Wed, 31 Jan 2024 12:15:41 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
From: Stefan Gloor <code@stefan-gloor.ch>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefan Gloor <code@stefan-gloor.ch>
Subject: [PATCH v4 0/1] hwmon: (sht3x) read out sensor serial number
Date: Wed, 31 Jan 2024 12:15:11 +0100
Message-ID: <20240131111512.25321-1-code@stefan-gloor.ch>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Vs-State: 0

The temperature/humidity sensors of the STS3x/SHT3x family are
calibrated and factory-programmed with a unique serial number.
For some sensors, this serial number can be used to obtain a calibration
certificate via an API provided by the manufacturer (Sensirion).
Expose the serial number via debugfs.

A "sht3x" debugfs directory is created when loading the driver.
Within this parent directory, another directory is created for each
sensor instantiation which contains the serial number.
The sensor-specific directories are managed by devres, such that
they are cleaned up upon deinstantation or if hwmon registration fails.
The top-level directory is removed when the driver is unloaded.

Changelog
=========

v3 -> v4:
	- Remove debugfs entry with devm_add_action_or_reset()

v2 -> v3:
	- Remove #ifdef for debugfs
	- Add debugfs cleanup
	- Do not expose serial number if read fails

v1 -> v2:
	- Change from sysfs to debugfs
	- Add documentation improvements

Stefan Gloor (1):
  hwmon: (sht3x) read out sensor serial number

 Documentation/hwmon/sht3x.rst | 11 ++++++
 drivers/hwmon/sht3x.c         | 66 ++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.41.0


