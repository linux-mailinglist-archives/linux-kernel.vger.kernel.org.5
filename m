Return-Path: <linux-kernel+bounces-117563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F488ACA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F01B300FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11DDDBC;
	Mon, 25 Mar 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cgc56BgI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DAF10A39;
	Mon, 25 Mar 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387090; cv=none; b=ReB++ml/h346P2l5wP/NC1/anbip/VqzQUsF09Ch7fylY2srwfrOBAy9KN+3xvLC6otPAmbnC7KuQifJc5lEW5IYtdD0CPY6H6CRLlqg6O6zXhkmjVP1IBAeVhFWdNirYvf7Avg0wVSiKbSb4I+nJMnFcbzOYnaghMKOn3Fgilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387090; c=relaxed/simple;
	bh=KpkhGTOu+U8kzPp6yqXmWrljw/u7Nr3n1qroNyfHO2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDGrD998gthdPoJoDcSHoAQl60gTrqN9BLn1INFFHXQ9Trp2/mhH+C2emZdiU0ewrumjT38hWuwSQ4U7vFui+CW4nOaQhLH5ohUFc08hIZo8NQMO68UmS4jajUlqzk668G1Tef9AkTZ+rwNiKUA96ZpimJPIlWMzLU5HOL2O/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cgc56BgI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711387090; x=1742923090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KpkhGTOu+U8kzPp6yqXmWrljw/u7Nr3n1qroNyfHO2I=;
  b=Cgc56BgIqxEhpMF6SYTdment1XlTTa88Gi7HUGQav0zH/6k2DG6nDHdG
   v4q7OJSk6Vi8Jfnqh2zffaq5qp2ZDW5dUAvj+ejYNzYSP4BSbEHRs/n3K
   tK/4swAKrLsrRsBBhangEQv5lc9Tt+pjWRtUV+dy4uGguuxbDiH/42aIP
   jQr2y7+6ZnLSDWilQOQcaFTgAmLzq4CbGVjzrs3LeF82SLk7u3MZ+Xf+d
   aHyG3aLvR4L9QAllSQ0zfVlDfFL8MYQqK9aZeH0iZ3agZiDQmbclyO2X5
   mGBkADfax84/gTtBPKJSOU2xIaYZ9HED+MbNV75iHOFjssaxPL8hJKION
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17546538"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17546538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="937070690"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070690"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 10:18:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9546D524; Mon, 25 Mar 2024 19:18:05 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/2] gpiolib: Fix/update messaging
Date: Mon, 25 Mar 2024 19:16:24 +0200
Message-ID: <20240325171804.3375280-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix scary '(null)' in the messages and move to dev_err() in one case.

v4:
- combined 20240320165930.1182653-1-andriy.shevchenko@linux.intel.com
  and 20240322073725.3338266-1-peng.fan@oss.nxp.com (Bart)

Andy Shevchenko (1):
  gpiolib: Fix debug messaging in gpiod_find_and_request()

Peng Fan (1):
  gpiolib: use dev_err() when gpiod_configure_flags failed

 drivers/gpio/gpiolib.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


