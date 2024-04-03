Return-Path: <linux-kernel+bounces-129996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E638972FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE92128C73A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F11494CB;
	Wed,  3 Apr 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWvIwh7D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2C3D96B;
	Wed,  3 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155656; cv=none; b=ai4e4uvxEhHJgDuxVrNYhURLIhLqv6dMTs8LXJvR4uuRS1bNWjAWRQGy1F/SA1eXZzazYOWKv2lmRAUig459ZBoAEcKr5L134lc331VT5RSty+RPGpZsRo8HLB4DxWQWXAJnMBOwZsHFd/PjxOCxpKNdVqCqEJhZ0r/t6+0OIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155656; c=relaxed/simple;
	bh=j+j9gJh9AR/K/6EMcCGKCzoxFBSWKneuP7FZVAR7urU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdKGFI3KsVuvDMQtFnQwhv8e/SGB6Yj9ikxTQ6NarrzVpcyQBgq2EwBkQFSxz1sRcLdb2I8th+t4cyAmUhYmz6tDeeQobwgSRT45nXkqscJoHN39YKTdpQIZbL0WJy1YPAbgibMMNGXt/BP4IYL3cHeh3DsJuwwD4txQ8FnpbNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWvIwh7D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712155654; x=1743691654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j+j9gJh9AR/K/6EMcCGKCzoxFBSWKneuP7FZVAR7urU=;
  b=jWvIwh7DnRfiwX9a2vuBmCBqryAhx9PIfgH7zBme+QceQnEc5h7LTmVa
   n/LjIrBRdGZsQZCA9Bc924ezWH9EHIZ274kwuVjGtqqL4WLiA175rCn16
   dXZBv9uSLF8yPDPuDtQnjM/03OMSRRwI89LJPayFeplwmKrpWy3Jpq7C+
   sxzZTgJU0pqkE5k2GnMgqGX30WVRiHFZcKuCQUStuJ7RLXjyY5ovIkUyC
   9DomxX5nvtgHFpRWtMEhsXJsH14N5BZsBr6ScfnBJv5wM0mi7IlZ/r2BI
   v6fIHRvLIxbg7PWJGJAkUZlXsRm2pDm7wJgelZeXKEqr7MiZiecMEYYQu
   A==;
X-CSE-ConnectionGUID: phmBKf7YTNKx0ywafCQeAQ==
X-CSE-MsgGUID: wY+wciF7Rh2ZiXfiviVLpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="17963778"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="17963778"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085162"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085162"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 07:47:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D332057D; Wed,  3 Apr 2024 17:47:28 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] serial: Do not count XON/XOFF in the statistics
Date: Wed,  3 Apr 2024 17:46:14 +0300
Message-ID: <20240403144722.860258-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers count XON/XOFF in the Tx statistics, some do not.
I actually a bit uncertain, but I _think_ the correct way is not
to count them, hence this series.

Andy Shevchenko (3):
  serial: core: Don't count XON/XOFF in the statistics
  serial: fsl_lpuart: Don't count XON/XOFF in the statistics
  serial: sprd: Don't count XON/XOFF in the statistics

 drivers/tty/serial/fsl_lpuart.c  | 1 -
 drivers/tty/serial/sprd_serial.c | 1 -
 include/linux/serial_core.h      | 4 ++--
 3 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


