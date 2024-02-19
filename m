Return-Path: <linux-kernel+bounces-71727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB385A98B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD2E1C22AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02107446D3;
	Mon, 19 Feb 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDHvQHBB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80744391;
	Mon, 19 Feb 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362229; cv=none; b=DOprOZXTlEsdktxwqtABzu/b3VxWbeRF5eIsyKD8JOk4Q/Ubq+uOHsu5JLKeELJN7E75zYzk3S1QQJd5ln7mWzw0TPJepN5APIWo+gwqTwrzylTD/qqzn9pfge4ZZz3aj6GrGTH3HG7K1u/0SPNqLk8+kV3zer68atvDrkiDwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362229; c=relaxed/simple;
	bh=kDh4WLiNwWNPYGC9OYUv0pS6W7fpqiiqCez/hH4DIYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHV/KUShLU43JJQV64M/XDKWVjBGVq3VsQ94YdFTTGmEa75Vcy3JMOORoiE8b8JYNT9SkoHjmc+pftIDg/o107c3RKLq5IVFa022eN2J0YJFjKKytC9HSFcbql20QT1phLpBZ214DK4J0tl5hooK4V8od+px/gNatXQkLVmMZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDHvQHBB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362228; x=1739898228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kDh4WLiNwWNPYGC9OYUv0pS6W7fpqiiqCez/hH4DIYQ=;
  b=MDHvQHBBNpH1X/+C8jZQ7BxRKujyONPZhRbvOvFE2zTmvIQo4LjL6yW+
   HFUAbplS2GDqScxeY0mZ92QQK+yukQyUJ0jhPTt4eTJh9259SkLsMk1dR
   Glvj3N9gr+xzPAcHjI0z78pVwWSMM6cyR6V+54xGLr7t0CuI0Jaj4bYvE
   yhehBweD3tgtC4Mufl+zmOPE7WdPqje2E28S6OB7WmAVoCgrVspeijUOs
   sKR/6y3p59cCyNE9ghhkdFArXeefDqosJ74sGrexjA9e2qAKysJx5bkOa
   sDCOQx7Xs6Ly3hCBftPPRbCRkI1WD8hGB63m19wwza0/2lUXDdfR3FgyK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577400"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577400"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315352"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315352"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1E99D2CB; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v3 0/9] auxdisplay: linedisp: Clean up and add new driver
Date: Mon, 19 Feb 2024 18:57:59 +0200
Message-ID: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new initial driver for Maxim MAX6958/6959 chips.
While developing that driver I realised that there is a lot
of duplication between ht16k33 and a new one. Hence set of
cleanups and refactorings.

Note, the new driver has minimum support of the hardware and
I have plans to cover more features in the future.

In v3:
- dropped applied patches
- fixed compilation error (Geert)
- dragging back and force added memory allocation for the character buffer
- dropped 'with keyscan' in new driver (Geert)
- rephrased a bit description in DT bindings for new driver (Geert)
- added tags to the (almost) unchanged patches (Geert, Krzysztof, Robin)

In v2:
- updated DT bindings to follow specifications and requirements (Krzysztof)
- unified return code variable (err everywhere)
- left patches 10 and 13 untouched, we may amend later on (Robin)

Andy Shevchenko (9):
  auxdisplay: linedisp: Group display drivers together
  auxdisplay: linedisp: Allocate buffer for the string
  auxdisplay: ht16k33: Add default to switch-cases
  auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
  auxdisplay: ht16k33: Define a few helper macros
  auxdisplay: ht16k33: Switch to use line display character mapping
  auxdisplay: ht16k33: Drop struct ht16k33_seg
  dt-bindings: auxdisplay: Add Maxim MAX6958/6959
  auxdisplay: Add driver for MAX695x 7-segment LED controllers

 .../bindings/auxdisplay/maxim,max6959.yaml    |  44 +++
 drivers/auxdisplay/Kconfig                    | 306 ++++++++++--------
 drivers/auxdisplay/Makefile                   |  16 +-
 drivers/auxdisplay/ht16k33.c                  | 177 ++++------
 drivers/auxdisplay/img-ascii-lcd.c            |  17 +-
 drivers/auxdisplay/line-display.c             |  11 +-
 drivers/auxdisplay/line-display.h             |   3 +-
 drivers/auxdisplay/max6959.c                  | 194 +++++++++++
 8 files changed, 496 insertions(+), 272 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
 create mode 100644 drivers/auxdisplay/max6959.c

-- 
2.43.0.rc1.1.gbec44491f096


