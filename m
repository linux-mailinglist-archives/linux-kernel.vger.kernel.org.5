Return-Path: <linux-kernel+bounces-4353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75850817BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123DE1F24648
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29FD73469;
	Mon, 18 Dec 2023 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpuLTnA0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC561E507;
	Mon, 18 Dec 2023 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702931438; x=1734467438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vBRy/F1FlRt2LyVGjkP66CWb8YxWMvP6DoXKEcG+sAQ=;
  b=WpuLTnA03LP8K0SIbfcJs/Le1byjQn0vnjMhOmipC3UkPaBfyZ9+6urP
   wbT2f8VezLHhhphbUrRc2sbfob0gXetdL0hoiFqzlFsT8MwDB1iSJHqSb
   BfUBMSNGCBh0VBsuR5NKhbugqP6YMzL2In1HudWPyidNt6lXgc8tZkdJV
   Pgi1KwOpJuNzhAPY95PcsDhClRdwvBGqvHm5Iqv1fB3meyEJqsa8wyLGJ
   abWifgIO9RoTw2R4ZUvq+h9Q5suJ8tzAtsu0Xt7xTLlW3JeAMkDZWMdFz
   m+xDxg6YQr47Y/mrhq9BYWaPOz/4f1KyBPImcrwCU5I+lpDWcE80SB3nM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="395289742"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="395289742"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="751879650"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="751879650"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2023 12:30:36 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] Add support of color temperature and chromaticity
Date: Mon, 18 Dec 2023 12:30:23 -0800
Message-Id: <20231218203026.1156375-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original series submitted to 6.7 (before revert) is modified to
solve regression issues on several platforms. There is one change
introduced before adding support for new features to allow dynamic
addition of channels.

This series is for the kernel version 6.8+.

v2:
New change to add channels dynamically
Modified color temperature and chromaticity to skip in case
of failures

Basavaraj Natikar (2):
  iio: hid-sensor-als: Add light color temperature support
  iio: hid-sensor-als: Add light chromaticity support

Srinivas Pandruvada (1):
  iio: hid-sensor-als: Allocate channels dynamically

 drivers/iio/light/hid-sensor-als.c | 164 ++++++++++++++++++++++++-----
 include/linux/hid-sensor-ids.h     |   4 +
 2 files changed, 144 insertions(+), 24 deletions(-)

-- 
2.43.0


