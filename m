Return-Path: <linux-kernel+bounces-62040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22875851AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5641F283D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4923FB35;
	Mon, 12 Feb 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BqoQBjpx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CC3F9EC;
	Mon, 12 Feb 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757488; cv=none; b=MBHxyHedKBWlphXPNxljicW1RVev+wLoWZQJ6ukjOc93MKqhLlMb8Kq0cbV6kpn2Cxf7lMz9z2e3c9tmmRQxpzQjLHDSfRw+nIxNdh5Wpwt7sPeycNXR3K74qIxng2ZIAXj1DlJoi8I7OGJk2dGU7Qm/ufSzKl0lBSG2bRNj3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757488; c=relaxed/simple;
	bh=sx3KCnAxxS/1z9NLbOZFyEHW1jrQXTW0YVfX+eUGbSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzWDkNKoDo33HrfRt+4pp5bfcwWAGBIPA32BHtz9qTBJNp42g8B61UIdXhM+amBVjDfrJePaIRKTxCVnzF4o4PJi00MvKyczst9DQClmRAFZVw4ItEUV4OoXZ4aspWME3y3vAQb6BQ0xZ8op581o292fy3JDxV62riRuTYZMv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BqoQBjpx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757487; x=1739293487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sx3KCnAxxS/1z9NLbOZFyEHW1jrQXTW0YVfX+eUGbSA=;
  b=BqoQBjpx50bNBwcZbmwkK0yoltTQes4QLFepALrRIXPhYWNZIFNT3rz/
   7gGMxAZwKhOpX3h/Dq4NJdICY6T0Vt2HwlTHhzHx899UBe+4skgLcP86C
   pCffbxtRZPL4kmkXaVmWxGJ6Tm0aV1uXL/A4NuygqycIAUB3u7ztbNrLv
   qiuWopepqEKPLoRyyR+28xek1uU2cqLz9iTR0vg9AjEtDnqmt0X/Hgpa2
   ESyHcu48NYGGg2MuCUbcaN4W9rsaFuRN3qP+VXqVD7MxkA3naVeL8KiFm
   eayBmXeHGQ6qeKu2Zj0M7Nc20eDDB1gQtzyFK4gD9gKYJSFB0qSGsM0fq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153165"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153165"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116807"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116807"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7B37DF7; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 00/15] auxdisplay: linedisp: Clean up and add new driver
Date: Mon, 12 Feb 2024 19:01:33 +0200
Message-ID: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new initial driver for Maxim MAX6958/6959 chips.
While developing that driver I realised that there is a lot
of duplication between ht16k33 and a new one. Hence set of
cleanups and refactorings.

Note, the new driver has minimum support of the hardware and
I have plans to cover more features in the future.

In v2:
- updated DT bindings to follow specifications and requirements (Krzysztof)
- unified return code variable (err everywhere)
- left patches 10 and 13 untouched, we may amend later on (Robin)

Andy Shevchenko (15):
  auxdisplay: img-ascii-lcd: Make container_of() no-op for struct
    linedisp
  auxdisplay: linedisp: Free allocated resources in ->release()
  auxdisplay: linedisp: Use unique number for id
  auxdisplay: linedisp: Unshadow error codes in ->store()
  auxdisplay: linedisp: Add missing header(s)
  auxdisplay: linedisp: Move exported symbols to a namespace
  auxdisplay: linedisp: Group line display drivers together
  auxdisplay: linedisp: Provide struct linedisp_ops for future extension
  auxdisplay: linedisp: Add support for overriding character mapping
  auxdisplay: linedisp: Provide a small buffer in the struct linedisp
  auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
  auxdisplay: ht16k33: Switch to use line display character mapping
  auxdisplay: ht16k33: Use buffer from struct linedisp
  dt-bindings: auxdisplay: Add Maxim MAX6958/6959
  auxdisplay: Add driver for MAX695x 7-segment LED controllers

 .../bindings/auxdisplay/maxim,max6959.yaml    |  35 +++
 drivers/auxdisplay/Kconfig                    |  40 ++--
 drivers/auxdisplay/Makefile                   |  13 +-
 drivers/auxdisplay/ht16k33.c                  | 145 +++++--------
 drivers/auxdisplay/img-ascii-lcd.c            |  24 ++-
 drivers/auxdisplay/line-display.c             | 162 ++++++++++++--
 drivers/auxdisplay/line-display.h             |  57 ++++-
 drivers/auxdisplay/max6959.c                  | 200 ++++++++++++++++++
 8 files changed, 530 insertions(+), 146 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
 create mode 100644 drivers/auxdisplay/max6959.c

-- 
2.43.0.rc1.1.gbec44491f096


