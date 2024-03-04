Return-Path: <linux-kernel+bounces-91060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDECF870918
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A36C2862A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518E62140;
	Mon,  4 Mar 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dp86vxcX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAF26293
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575662; cv=none; b=GLvLzGVakn7p389xXtju2ZmUJ677tpw50bFmdoGXW69VtleBDDqUDSJznXbqjOyPuNRYqnvwuKBvv4IoE/EY/2KWyAw02Phgva8QfY4hxIOjF4RSAHUro5gboUr9CBnIhFH9L2PY1heVBMEyoe3c9x5BwcrZOm4v6us+AFP/9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575662; c=relaxed/simple;
	bh=v48GPHT6iH23Lx0u4Kbz6h4B6pXlWLrFYViS3DG9Llk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8sBs13LcHVcsR/6rVfPX4/R8wnNLXKFkDoI8q0sfyO7X+9c1drBt08AVvXzg2sxa8qz0uhBTFibh5iP84DBXemAr0UGTqBciOEQuoQkRnPFHXpQgTZwVaCL1Ze/QdXAJV/tje1vceicDxX6Ab8xZdJHpoyc5ieDy0rFrmkFkaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dp86vxcX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575661; x=1741111661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v48GPHT6iH23Lx0u4Kbz6h4B6pXlWLrFYViS3DG9Llk=;
  b=dp86vxcX1k2YQT8pAvo+Kx6l4wS6sSEGybbxt+MTBG+7Q3io275wGZMU
   paYTb87PWVfAG0OzD3ZdWb7AcJjYxIbYze/P1Y8CoJfhSrB2YI8AcLEN2
   n7jf4qQ6ZKs3UvO+hN9V1e0bqmZhaDT8GVaSACX5rSR6nQmqGr1MHk0Th
   Wi0aI9Gm+iG2yDSVMAV9PJS8sevkCIX2K60gIlLlJswf1LVLRKXRjNuv4
   wg7kIR0Oxb8vqloFM5TnPhEG9noFmGkzMoagVCRG3MEOIuuugkSVmiQii
   oaykyLhDW94woXNRWch7r+2tsA229TM2BrBeHMuHx6R+SqsCyRfu27Kxf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7855567"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7855567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040918"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040918"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 10:07:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 01FAC15C; Mon,  4 Mar 2024 20:07:37 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] misc: hi6421-spmi-pmic: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 20:07:37 +0200
Message-ID: <20240304180737.1201566-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/hi6421v600-irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index b075d803a2c2..69ee4f39af2a 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -11,7 +11,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/irqdomain.h>
-- 
2.43.0.rc1.1.gbec44491f096


