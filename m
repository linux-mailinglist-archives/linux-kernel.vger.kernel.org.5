Return-Path: <linux-kernel+bounces-61683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC76851557
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4111F220D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EFA3BB2E;
	Mon, 12 Feb 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbTI6Gjh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBDD3B1AB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744429; cv=none; b=YdPrTFeDZEW6kpWlzq4NNv/aXCED58NrpbRsk7vDddrluM93HZy+tPyt0BowXrzjWOcvxHSzCIAKid89lh4hL5dQTIo3QJLN4OUJiSmuAXYQ8KizodgPK/Q7I23u/tv9hrhYmi8rOgBo0cS/SPesW8iDEoFmBlvWgyuX/O9H2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744429; c=relaxed/simple;
	bh=lTPAzQsGc/1ML8Nowvg3JHvpwoPMMDUTqMEFsPGXKMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMoZIyK2a5Ln0fq6yoWMVZ2tmdzRLRX2OprUv51w7cLhFaxpGb8wtpib1mPlxT/oHsT0uMqPGoOrg+OTzdKXuTNV96qmxU3LH1T2QHDj7WPX000cqeS+0EJTLoj1iyZi7gV/slaH3yUOSil1O185+9gR/OqWwLoA9Xhkc1unauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbTI6Gjh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707744427; x=1739280427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lTPAzQsGc/1ML8Nowvg3JHvpwoPMMDUTqMEFsPGXKMs=;
  b=GbTI6GjhNeSd31Z56ACAHn7EfBIFnopQyu6RuBhyMpM9jsPJfUgQrTMK
   MUjquJGZrX+qX/Vxtx3JrR3/051WDu55J5AKRnUN92L4G1KcW6gDUserW
   RIsPj37CqKBl3DkWtfI2cXBE587A0zd9TxRipGDieVHkQ8oQFcx9jgvcB
   0vPeOf70WMNcmcQuWMdZSbEfNKYKL8SqfyfjZP2RFZYshZSlUzqlvpNyh
   VQ6/1fHmfzGnA12kaai50iG3uTA/BbXd7B3nrRglLzR0vzCSuOQ99oz0N
   rBfP6HyCSyWJ/1aGjkN5QMTPN7zS7uFcR9oeESjLw1TmqwKOsWAeoJbjl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5496472"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5496472"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:26:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935067319"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935067319"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 05:26:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 56F2FF7; Mon, 12 Feb 2024 15:26:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/3] auxdisplay: Refresh MAINTAINERS for the subsystem
Date: Mon, 12 Feb 2024 15:23:52 +0200
Message-ID: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update MAINTAINERS for AUXDISPLAY subsystem in accordance to the last
(administrative) changes.

In v2:
- included Geert as Reviewer and added Git tree 
- added two more patches that are related to MAINTAINERS

Andy Shevchenko (3):
  auxdisplay: Take over maintainership, but in Odd Fixes mode
  auxdisplay: Move cfag12864b.h to the subsystem folder
  auxdisplay: Add 7 and 14 segment mappings to MAINTAINERS

 MAINTAINERS                                        | 11 ++++++-----
 drivers/auxdisplay/cfag12864b.c                    |  2 +-
 {include/linux => drivers/auxdisplay}/cfag12864b.h |  0
 drivers/auxdisplay/cfag12864bfb.c                  |  3 ++-
 4 files changed, 9 insertions(+), 7 deletions(-)
 rename {include/linux => drivers/auxdisplay}/cfag12864b.h (100%)

-- 
2.43.0.rc1.1.gbec44491f096


