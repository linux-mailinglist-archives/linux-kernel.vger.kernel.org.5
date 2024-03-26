Return-Path: <linux-kernel+bounces-119915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE388CEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A05F1C6602A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246A13E6BE;
	Tue, 26 Mar 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lr6a8ht6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76AD13E407;
	Tue, 26 Mar 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484903; cv=none; b=cbvuhv5G+SYjqkEPPr3zHJp5wBgi41l9h3738G8z+/JygRSzehRk3vBkyg0hamak/HKKmrcgmrIXtijNTm9ZMJqhUHY/Y/K6Yl+uBmsSsR0SIqBnzJwAyVEIjluHrcs65YmA7L/JCsY2yFbh9Xl1M3ZCsbzwtwnZP8qDuq6A+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484903; c=relaxed/simple;
	bh=yz2bxQXVASgdw+2AgTPTnU6jcJ8bKWmuH5fKHFZ3UaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PCUf6tVkbQA0WBGSjo4C6fUtdpC+F+e44mBprOjRfAXqY+3XPJrnpalS5DDHSplRVVDpG4ny3tf2l1v6xpAfa+3Wk7YAvbmHEcEiDHlGoiEFF9hijA5brD6K+Tt7O8sQYhAN4WG8a7nA5UllRMj+3DjRJsf9wlLqDuJXEiuQDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lr6a8ht6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484902; x=1743020902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yz2bxQXVASgdw+2AgTPTnU6jcJ8bKWmuH5fKHFZ3UaA=;
  b=lr6a8ht6108NmVI3+9tLxKudY8YwhSVctOdNpJESSoAOglKtXMhTzFwX
   RZlpbC5XjabyEg+1iz3/V2TpxpqyM5ZWtLce9eKESQm6SZbMO7RAq6EGE
   MEAv6qIqRhCRpPaXhUEJkMxhzFBMGBvs0LGH0qNG4B72/11WaWSGUeEc1
   bIubJx4qOhDXVEGdUJtEohPnJZNDAdPA8HqPpJeCSG7UmK+0C2aNjijqT
   CFzcgOYR4C+Jaa+jJE4kwsy2ePJmxk0LOFTT4kvBs4XN8F3irCT6dT1ql
   auX+xj6EoAjMNoSx2HuZhYJAOIO7hTwMsflwP17XSQ2oCY/xHnHzshEt2
   A==;
X-CSE-ConnectionGUID: IEukNtQXQLCtXlgJu4UkHQ==
X-CSE-MsgGUID: nMBVt8z8Qpy06NExUtbVRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6500459"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6500459"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937073005"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="937073005"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 13:28:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0727CE7; Tue, 26 Mar 2024 22:28:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] media: atomisp: Fix and refactor PMIC I²C discovery
Date: Tue, 26 Mar 2024 22:27:01 +0200
Message-ID: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drop the reference count when detecting PMIC.
Refactor PMIC detection using new API.

Andy Shevchenko (2):
  media: atomisp: Put PMIC device after getting its I²C address
  media: atomisp: Replace open-coded i2c_find_device_by_fwnode()

 .../media/atomisp/pci/atomisp_gmin_platform.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


