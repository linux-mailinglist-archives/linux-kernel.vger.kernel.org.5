Return-Path: <linux-kernel+bounces-58436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D364684E682
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D041C2441B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7A85C55;
	Thu,  8 Feb 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaNW+zAF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46C823D2;
	Thu,  8 Feb 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412654; cv=none; b=Ff00ga5sVIFC2dXj1R1p8N5lNMFf3nTfG/ZgWRF9zgffT3MOXvbagotPFwMeIrIzB22fLfVCcHfbFaHtkfWyVDWEZSDQvw2utJXBrE9BLulH9KXBV6HiwcSI1K1luJwzJBzTaky1RC9sm+jBkaQV2dR+FQQeT+ewfvgBnU0ksNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412654; c=relaxed/simple;
	bh=nKnI1gzZu/2gi1frEJ0pSztmvg8qGxw/QhIDsCZBNC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQBdxBYh8B+ljwBMWOjCyPRXDkr9Tg3PKFIj/5V2UaY7XE6JWFPoVAhMmtHGt4SXWmntaz+/RVQGeg0X3ymWcvKMbw3/tliOph+Fm9KcpLny3da84cQRp8G274pTV+X+85QGTn4+UI/yCWjQgdV1FFOQg1rCboB2e/QcJoQNrhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaNW+zAF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412653; x=1738948653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nKnI1gzZu/2gi1frEJ0pSztmvg8qGxw/QhIDsCZBNC8=;
  b=SaNW+zAF5ZtVGFI7w36idtmlP75RcwW6ykKU29RNCBMnCSibhdB+SY92
   NC3oxDBMrj4EySKlTkKdPvvDED1IxhTLqytvIMffCfWCai6L+AbLwo+Cw
   AZvOhaIuiXcuTDYgc0oeFyyrwymQoWBD20ef7dFsEqRKQI8ZKp27MSCac
   KS/wp65O3QaTAR2pxcLrwro5qJKgvEIpL120nDUjoW+QBQRthuRPKc7uu
   8bPNU2A0xF7xUV2TZaHMYVNmkmM678Z8tN7zSlFGrQJp3zPpjLvaQPb+U
   ZiRjlRndDWo8eEOToQ2vh9BwlFJaXhctDS+9D8Pqhb+HNv4AyZ3YNMO+X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565656"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565656"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195369"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195369"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F1C88130F; Thu,  8 Feb 2024 18:59:40 +0200 (EET)
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
Subject: [PATCH v1 00/15] auxdisplay: linedisp: Clean up and add new driver
Date: Thu,  8 Feb 2024 18:58:43 +0200
Message-ID: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
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


