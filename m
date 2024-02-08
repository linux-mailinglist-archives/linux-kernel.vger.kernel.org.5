Return-Path: <linux-kernel+bounces-58561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64984E80D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435FC1C25E93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43225614;
	Thu,  8 Feb 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YR2iQgLC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14A25770;
	Thu,  8 Feb 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418170; cv=none; b=U2fh1nDrn1Wa8MciCXIfT4EmVZKa4XxL+Xbu8Kj9MaOUnvQC8tyad9+bV1dF4NU9C9KzUOxQYf9/JhqVL7pXNQeGQW54jG3GP85EnLE5f4qhbYcVPbcfWeH4DL/6Jn7Ng1HzvJoaTlE2d1xeIIgPhzKL9kV0/jVS5IqUTTd72GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418170; c=relaxed/simple;
	bh=nKnI1gzZu/2gi1frEJ0pSztmvg8qGxw/QhIDsCZBNC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+XthcE3bfvx8jryQz1dzToyJA8Tgj1sP5pL4RkViZW31DniW0WjA+7S2zLTM+yYtQHIuJCcU02u99/3tSzBHhY4kswkqq0RgGCGeNn6NhrdoBbEvwDdEbEcjk1UVyn3vJCJrsINSbJe84E9RBhIViI/DS3RlD1BNZlgUPvuHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YR2iQgLC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418169; x=1738954169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nKnI1gzZu/2gi1frEJ0pSztmvg8qGxw/QhIDsCZBNC8=;
  b=YR2iQgLCJ17vXbJ5tUT8DwzbJc7qnA+8oqgrLyU0QLDVccwB7NunlQcv
   eZ0Zv/8JtfFKkNqpJyXR0drkZzFI20tRPmhb/sXkLxLKPih7FhAPzwS3W
   q7S1/S/JQd/cJa7S2FmF+6FTL4i6JToyfc4vI1y7WpDEHeJm0Yt5k2n2r
   gtHdPmxEssYZtpjMzmd2WPHOOua/eOrysLaCNvzxmy+fOubf1pfup0MwW
   bg79JPxJaRQN10SY1+ZQxkLCJp8NCIIJpRFXcuMGQlHDChXVQ3QITB2vo
   7Zrm5GwvHwHSUjA3wq9H9s/B2GpaIEuuNs9zT96TI8w2YrN+jQURjMnWi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186095"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215515"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215515"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2DF9786; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [resend, PATCH v1 00/15] auxdisplay: linedisp: Clean up and add new driver
Date: Thu,  8 Feb 2024 20:47:58 +0200
Message-ID: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
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


