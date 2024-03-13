Return-Path: <linux-kernel+bounces-101614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459DE87A964
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E871F23C38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B9A46441;
	Wed, 13 Mar 2024 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQxHcnUE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1D33F7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339800; cv=none; b=QdMfFNCZxIAGuY1eKilw6MyTk7B7gPgAuxVCLXEYUZ5HrO5RUUvZ8wrQOGAbXNG4Ovsp0RXJ2iUOczBVzYelp3Sxhg5HPaDlgfW47InT/Yd0ZhhbgMS0F59Cn6KGrScL/VDftovX2zE8i7/uuLafegxSxh+Lxn5fsECghKr35cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339800; c=relaxed/simple;
	bh=Wyu4z0W6k2g6dt5sKU4IQIp5NXtrKnscvInafp6gwmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oj7kUVrEMDHg8iCgQQ0u9Rc6UyYOBQvWmH+pb8JbAn5OlW0Id/lgAWQJMIi/xbaPukw1BZ8anBoUbas7eySlsNuws1OOSAf4Zeon2U8wRoas6I45aX9BSvunOB/qxX99sear/kEld30EeD3YRxIi8c20P4aABW9IyY+AuZCMZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQxHcnUE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710339798; x=1741875798;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Wyu4z0W6k2g6dt5sKU4IQIp5NXtrKnscvInafp6gwmE=;
  b=dQxHcnUEqF3klOmX1cMKPnnM4EiVu17mXzDj1L1vhfVdIg88ITR31i6j
   GWzo9LyCOfwojjiKJXgedh5lNaznogKFUBpdWEdTlLZEB5PdetkHVUHkq
   Pf0b/8s9LyyBM7WccqSUjRNW4qljYpUgorQODNWsWSzs4BnzpSgvwkvJx
   AXqCStkj/qazC9lKovIuAIY2eCdQquk59oWzPt+yL6aaN42E3tarjFOJx
   w8V7KriOcPgdiwknnkdHaju0yUJC0YGiRv11WShclMNpnSTihXb5J0rn1
   D3oDpKT3NRADHj2ewnCf+5W9x/rAkw8tLgi9qtZ21UdyCSSuxxSIdITvL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5230535"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5230535"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="937054193"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="937054193"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2024 07:23:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 75D754EB; Wed, 13 Mar 2024 16:23:14 +0200 (EET)
Date: Wed, 13 Mar 2024 16:23:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [GIT PULL] auxdisplay for 6.9-1
Message-ID: <ZfG20vf2kW1h-xA2@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

First PR from me as a maintainer of auxdisplay subsystem. Miguel retired and
nominated me as a successor (it appears that for the last a couple of years
I am appeared a main contributor to the subsystem), however I have no much time
for that, that's why the update in MAINTAINERS has 'Odd Fixes'. Nevertheless,
Geert agreed to help as the official reviewer. So far so good, the collection
of the code has been in Linux Next for a while with one reported issue that
had been addressed (and also stayed a couple of days in the Linux Next).
Please pull for v6.9-rc1.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.9-1

for you to fetch changes up to 5d9e12972259cd86ae9c3fc0d5338b15831b9929:

  auxdisplay: img-ascii-lcd: Convert to platform remove callback returning void (2024-03-12 17:37:54 +0200)

----------------------------------------------------------------
auxdisplay for v6.9-1

* New driver for GPIO based 7-segment LED display (Chris Packham)
* New driver for Maxim MAX6958/6959 I²C 7-segment LED display controller
* Refactor linedisp library to make the above happen
* Update Holtek HT16k33 driver to follow the linedisp refactoring
* Convert .remove to return void in platform drivers (Uwe Kleine-König)
* Fix DT schemas (Krzysztof Kozlowski)
* Refresh MAINTAINERS database

The following is an automated git shortlog grouped by driver:

Add 7-segment LED display drivers:
 - Add 7-segment LED display driver
 - Add driver for MAX695x 7-segment LED controllers
 - Add 7 and 14 segment mappings to MAINTAINERS

cfag12864bfb:
 -  Convert to platform remove callback returning void

dt-bindings:
 -  auxdisplay: Add bindings for generic 7-segment LED
 -  auxdisplay: Add Maxim MAX6958/6959
 -  auxdisplay: hit,hd44780: use defines for GPIO flags
 -  auxdisplay: adjust example indentation and use generic node names

hd44780:
 -  Convert to platform remove callback returning void

ht16k33:
 -  Drop struct ht16k33_seg
 -  Switch to use line display character mapping
 -  Define a few helper macros
 -  Move ht16k33_linedisp_ops down
 -  Add default to switch-cases

img-ascii-lcd:
 -  Convert to platform remove callback returning void
 -  Make container_of() no-op for struct linedisp

linedisp:
 -  Allocate buffer for the string
 -  Add support for overriding character mapping
 -  Provide struct linedisp_ops for future extension
 -  Move exported symbols to a namespace
 -  Add missing header(s)
 -  Unshadow error codes in ->store()
 -  Use unique number for id
 -  Free allocated resources in ->release()

panel:
 -  Switch to use module_parport_driver()

seg-led-gpio:
 -  Import linedisp namespace

----------------------------------------------------------------
Andy Shevchenko (19):
      auxdisplay: Take over maintainership, but in Odd Fixes mode
      auxdisplay: Add 7 and 14 segment mappings to MAINTAINERS
      auxdisplay: panel: Switch to use module_parport_driver()
      auxdisplay: img-ascii-lcd: Make container_of() no-op for struct linedisp
      auxdisplay: linedisp: Free allocated resources in ->release()
      auxdisplay: linedisp: Use unique number for id
      auxdisplay: linedisp: Unshadow error codes in ->store()
      auxdisplay: linedisp: Add missing header(s)
      auxdisplay: linedisp: Move exported symbols to a namespace
      auxdisplay: linedisp: Provide struct linedisp_ops for future extension
      auxdisplay: linedisp: Add support for overriding character mapping
      auxdisplay: linedisp: Allocate buffer for the string
      auxdisplay: ht16k33: Add default to switch-cases
      auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
      auxdisplay: ht16k33: Define a few helper macros
      auxdisplay: ht16k33: Switch to use line display character mapping
      auxdisplay: ht16k33: Drop struct ht16k33_seg
      dt-bindings: auxdisplay: Add Maxim MAX6958/6959
      auxdisplay: Add driver for MAX695x 7-segment LED controllers

Chris Packham (3):
      auxdisplay: Add 7-segment LED display driver
      dt-bindings: auxdisplay: Add bindings for generic 7-segment LED
      auxdisplay: seg-led-gpio: Import linedisp namespace

Krzysztof Kozlowski (2):
      dt-bindings: auxdisplay: adjust example indentation and use generic node names
      dt-bindings: auxdisplay: hit,hd44780: use defines for GPIO flags

Uwe Kleine-König (3):
      auxdisplay: cfag12864bfb: Convert to platform remove callback returning void
      auxdisplay: hd44780: Convert to platform remove callback returning void
      auxdisplay: img-ascii-lcd: Convert to platform remove callback returning void

 .../bindings/auxdisplay/arm,versatile-lcd.yaml     |   4 +-
 .../bindings/auxdisplay/gpio-7-segment.yaml        |  55 ++++++
 .../bindings/auxdisplay/hit,hd44780.yaml           |  62 +++---
 .../bindings/auxdisplay/holtek,ht16k33.yaml        |  50 ++---
 .../bindings/auxdisplay/img,ascii-lcd.yaml         |   4 +-
 .../bindings/auxdisplay/maxim,max6959.yaml         |  44 +++++
 MAINTAINERS                                        |   8 +-
 drivers/auxdisplay/Kconfig                         |  25 +++
 drivers/auxdisplay/Makefile                        |   2 +
 drivers/auxdisplay/cfag12864bfb.c                  |   6 +-
 drivers/auxdisplay/hd44780.c                       |   5 +-
 drivers/auxdisplay/ht16k33.c                       | 174 +++++++----------
 drivers/auxdisplay/img-ascii-lcd.c                 |  45 ++---
 drivers/auxdisplay/line-display.c                  | 166 ++++++++++++++--
 drivers/auxdisplay/line-display.h                  |  53 ++++-
 drivers/auxdisplay/max6959.c                       | 194 ++++++++++++++++++
 drivers/auxdisplay/panel.c                         | 216 +++++++++------------
 drivers/auxdisplay/seg-led-gpio.c                  | 113 +++++++++++
 18 files changed, 888 insertions(+), 338 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
 create mode 100644 drivers/auxdisplay/max6959.c
 create mode 100644 drivers/auxdisplay/seg-led-gpio.c

-- 
With Best Regards,
Andy Shevchenko



