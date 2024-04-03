Return-Path: <linux-kernel+bounces-130559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2FF8979EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204232843B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A715665D;
	Wed,  3 Apr 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C1/QtN1X"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E541156641;
	Wed,  3 Apr 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176618; cv=none; b=POognCzb/osskSx2mwc0usCaraG+hnDBWSZ4jyU4Et1oiOaKOrzTIGV6wwtzdEyr/mthK1G/WPtmfiwDVgsHAM6NZlvezq4DZdwzCT8+S+QWXMcU5vgFkZForljF0d/fLuI7ENqkdPDY4w4vChXLKIiYatAOYgeYM9EbdYPDZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176618; c=relaxed/simple;
	bh=xeEjJBRwdbnoHELe+JmZTnon7hCJd2P9sODhxzR8Fnk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C+lLMj18pLOrB/ehoEUhZLwUUtwAQRiQT4U5bWP4G5CASqIjrc29HQJ+9bc8BIn3biy/umy2eAEOD/taJ0K6VEls1IrRNL2WD4vWSWL81fWNijSS9LYB/HkpIjfyUt1g+Bj5tw8ZRpBquOLyz0QUI4TC3viyRQFAT7tbi2U2S/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C1/QtN1X; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KaZD5076287;
	Wed, 3 Apr 2024 15:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176595;
	bh=/7zAIRf6EU6IdqEwtDVY3sRloUvgBjYsBrYpheRGSSI=;
	h=From:To:CC:Subject:Date;
	b=C1/QtN1Xk3jOpxuH6ZXfuGnWr4L/vAUsOBlUl7NKqr2Yc/4ZbMD86bDB4y2MgGgjn
	 0CY7+XLUCj7wmlgwT/KCFMul5Bu1sqzV0GOSRTpzsE9W5lc+xdOl7dbi7Z7xd7JTkK
	 v1+RuGoocn/nN+aYTTaL0Nasfz2SRBVh1AhX1ZlU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaZWC000483
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:35 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:34 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFf080324;
	Wed, 3 Apr 2024 15:36:34 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 00/31] Remove use of i2c_match_id in HWMON
Date: Wed, 3 Apr 2024 15:36:02 -0500
Message-ID: <20240403203633.914389-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

Goal here is to remove the i2c_match_id() function from all drivers.
Using i2c_get_match_data() can simplify code and has some other
benefits described in the patches.

There are not many users left in kernel, most remaining users
are here in HWMON, so let's clear those out here.

I don't have most of this hardware, so testing is very welcome :)

Thanks,
Andrew

Andrew Davis (31):
  hwmon: (ad7418) Remove use of i2c_match_id()
  hwmon: (adm1021) Remove use of i2c_match_id()
  hwmon: (adm1031) Remove use of i2c_match_id()
  hwmon: (ads7828) Remove use of i2c_match_id()
  hwmon: (adt7475) Remove use of i2c_match_id()
  hwmon: (aht10) Remove use of i2c_match_id()
  hwmon: (dme1737) Remove use of i2c_match_id()
  hwmon: (ds1621) Remove use of i2c_match_id()
  hwmon: (f75375s) Remove use of i2c_match_id()
  hwmon: (fschmd) Remove use of i2c_match_id()
  hwmon: (ina2xx) Remove use of i2c_match_id()
  hwmon: (lm63) Remove use of i2c_match_id()
  hwmon: (lm75) Remove use of i2c_match_id()
  hwmon: (lm78) Remove use of i2c_match_id()
  hwmon: (lm83) Remove use of i2c_match_id()
  hwmon: (lm85) Remove use of i2c_match_id()
  hwmon: (lm90) Remove use of i2c_match_id()
  hwmon: (lm95234) Remove use of i2c_match_id()
  hwmon: (max16065) Remove use of i2c_match_id()
  hwmon: (max1668) Remove use of i2c_match_id()
  hwmon: (max6697) Remove use of i2c_match_id()
  hwmon: (mcp3021) Remove use of i2c_match_id()
  hwmon: (powr1220) Remove use of i2c_match_id()
  hwmon: (sht3x) Remove use of i2c_match_id()
  hwmon: (shtc1) Remove use of i2c_match_id()
  hwmon: (thmc50) Remove use of i2c_match_id()
  hwmon: (tmp401) Remove use of i2c_match_id()
  hwmon: (tmp421) Remove use of i2c_match_id()
  hwmon: (tmp464) Remove use of i2c_match_id()
  hwmon: (w83781d) Remove use of i2c_match_id()
  hwmon: (w83795): Remove use of i2c_match_id()

 drivers/hwmon/ad7418.c   |  7 +-----
 drivers/hwmon/adm1021.c  |  4 +---
 drivers/hwmon/adm1031.c  |  4 +---
 drivers/hwmon/ads7828.c  |  7 +-----
 drivers/hwmon/adt7475.c  | 16 ++++++--------
 drivers/hwmon/aht10.c    |  3 +--
 drivers/hwmon/dme1737.c  |  4 +---
 drivers/hwmon/ds1621.c   |  4 +---
 drivers/hwmon/f75375s.c  | 46 +++++++++++++++++-----------------------
 drivers/hwmon/fschmd.c   |  2 +-
 drivers/hwmon/ina2xx.c   |  7 +-----
 drivers/hwmon/lm63.c     |  5 +----
 drivers/hwmon/lm75.c     | 10 +--------
 drivers/hwmon/lm78.c     |  4 +---
 drivers/hwmon/lm83.c     | 16 +++++++-------
 drivers/hwmon/lm85.c     |  7 +-----
 drivers/hwmon/lm90.c     |  5 +----
 drivers/hwmon/lm95234.c  |  5 ++---
 drivers/hwmon/max16065.c | 10 ++++-----
 drivers/hwmon/max1668.c  |  4 +---
 drivers/hwmon/max6697.c  |  7 +-----
 drivers/hwmon/mcp3021.c  |  6 +++---
 drivers/hwmon/powr1220.c |  6 +++---
 drivers/hwmon/sht3x.c    | 20 ++++++++---------
 drivers/hwmon/shtc1.c    |  4 +---
 drivers/hwmon/thmc50.c   |  4 +---
 drivers/hwmon/tmp401.c   |  2 +-
 drivers/hwmon/tmp421.c   |  6 +-----
 drivers/hwmon/tmp464.c   |  5 +----
 drivers/hwmon/w83781d.c  |  4 +---
 drivers/hwmon/w83795.c   |  4 +---
 31 files changed, 79 insertions(+), 159 deletions(-)

-- 
2.39.2


