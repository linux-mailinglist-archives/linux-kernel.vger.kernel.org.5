Return-Path: <linux-kernel+bounces-118632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1F88BD89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9731C379AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A34CB3D;
	Tue, 26 Mar 2024 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qz/QSTNt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BF45978;
	Tue, 26 Mar 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444839; cv=none; b=XdIbIYeWfGKhb9S6zE+7uA5Epdj4DzRoxTPCqIstjTNvoeeioSGecUDPWEXDFQr0vzJXdg9IHKJtCFwI2wHzcBabDH9kjOGACF6yZcMI9S2UlSB4ij4axvxggnW6NYfnWQA5QvrrgE63MnPO+a3tZqLmDTgDGHfxHsc9DVkNHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444839; c=relaxed/simple;
	bh=ZRw5HW3vx3O6hI9fyvWhe7T/sssosg/zjSWpKw5oUQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L89mFeQyIzrFLc1CJap/dcwuJQ+zidQQatRon7yadpJh9qTQ5QCLQyhR9RLNfx2JSrQVVGBcl2OA2SXG1iStsjv0zSbI0DhKOJetKLSPFfuQL0C/0dW19xlR6VkvUfsajHbybDZlOxj3Xhq6BCEEyWQvxTSyiR4P+sc4EMMm65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qz/QSTNt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444837; x=1742980837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZRw5HW3vx3O6hI9fyvWhe7T/sssosg/zjSWpKw5oUQs=;
  b=Qz/QSTNtoh+DnzbECKIc4jH5sG7aX8OTTDtV5NPlz+IQX/KH1MviDSmK
   vX7Rqgy835KVqyDBLuxKAbzGwTpVKr50NyWOFmyq5++XTizrAaQWEipmp
   UvcwZYF0AMMa6UgXLWNu9PdWuI3+Nu/G+QuVU2AKUT1UEI1B08PoWuXAU
   cbFD1blaEYBaLQRSBvSCqS7QPMEXujD17BfBkx25gfxjR8Ily7MHyXa+9
   KW0qvDE02Akfvo9klUNk5sXRsqD8L0NfqvWapAeIvCfdYEAPclsfyqleo
   T/CZlYNN+56nDJMraxB3pbRiWGd4L6h4zsmCYLIGgY7J6XWbLE4QqgKqD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350332"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350332"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293257"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 0/7] soundwire: add support for link clock source selection
Date: Tue, 26 Mar 2024 09:20:23 +0000
Message-Id: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since CannonLake, we've been using the XTAL oscillator as the link clock
source, but since MeteorLake the hardware offers two additional sources:
the audio cardinal clock and the internal audio PLL.

This series adds support for link clock source selection.

Pierre-Louis Bossart (7):
  soundwire: cadence: show the bus frequency and frame shape
  soundwire: bus: extend base clock checks to 96 MHz
  soundwire: intel: add more values for SYNCPRD
  soundwire: intel: add support for MeteorLake additional clocks
  soundwire: intel_ace2x: move and extend clock selection
  soundwire: intel_ace2.x: power-up first before setting SYNCPRD
  soundwire: intel_ace2x: set the clock source

 drivers/soundwire/bus.c             | 12 +++----
 drivers/soundwire/cadence_master.c  |  6 ++++
 drivers/soundwire/intel.c           | 43 +++++++++++++++++++----
 drivers/soundwire/intel_ace2x.c     | 53 +++++++++++++++++++++--------
 include/linux/soundwire/sdw_intel.h | 11 ++++--
 5 files changed, 96 insertions(+), 29 deletions(-)

-- 
2.34.1


