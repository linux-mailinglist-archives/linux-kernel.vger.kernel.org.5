Return-Path: <linux-kernel+bounces-61687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB485155D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054771C22175
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04846537;
	Mon, 12 Feb 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6wrJg74"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCC4596F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744432; cv=none; b=dRqaEyfIWhiD1136x7vPxekXYO2ZTV7SC6el3gAQehSUBjnMzu2B6dXXIxYTx5OmJNlHWBtOVdl652I2X4MHw2aCK4UPKnGglgFAByj0NVHV2LdYPO7htPRkZh2JHfm30VSjl7n3Pg7O9YNb5HJDL0xC3NotIsxFvTWzlZCc1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744432; c=relaxed/simple;
	bh=KdUhA6JPzsraxa+FLLgn2QjP5n5dPGsdGvDZjeBfuwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmcDXKDCHUZviohxB1fdkIELcNhy5ie8CLqmtsua7tjHff5QZvYE54NpPMNnlCl9jC9v7/N5j9xOu1+HzPiVlqBqtVj/xO2mEjEuRmjFljRstnrDG6PpPeywjmli3C/7UoG4X+8iUnlkIGe6SS1Y2toQ/oYW0njhI2SYp05ubMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6wrJg74; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707744431; x=1739280431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdUhA6JPzsraxa+FLLgn2QjP5n5dPGsdGvDZjeBfuwk=;
  b=g6wrJg74x3WvY33eLz7BTDSvycyBmBWSYWRYghWTNSg5aE5HSqja7snd
   e7/xvzMU+G9ebLD7FLZaTToLptVEIJN6q0k9lCFktjjx8/XzVGiCRG3qE
   JkZGxIVi1afHYU5km2lW1niRK7OMtp/yCw1zBAqlpiwxYzz1EbBcd+3e7
   S1KsU/EBuH3/c1q13mZXsVbTmO2jgTMKb7H+m91eMO34ORY4r032ZfKPC
   ObgqPfqLyxc+vFrbzI5qGx3p8cIs1jGwTohWMtXZ1FS41xgaANXqYPgMr
   69OeqhHIuC8f8gfDE5HTA7X1jcBkCnziJ617kfUtVoAjetWy9YmaVEYFT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5496490"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5496490"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="935067318"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935067318"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 05:26:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6525EA1; Mon, 12 Feb 2024 15:26:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd Fixes mode
Date: Mon, 12 Feb 2024 15:23:53 +0200
Message-ID: <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have no time for this, but since it looks like I'm the main
contributor for the last few years to the subsystem, I'll take
it for now. Geert agreed to help me with as a designated reviwer.
Let's see how it will go...

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75cf018922a4..e2a804e22c3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3406,8 +3406,10 @@ F:	drivers/base/auxiliary.c
 F:	include/linux/auxiliary_bus.h
 
 AUXILIARY DISPLAY DRIVERS
-M:	Miguel Ojeda <ojeda@kernel.org>
-S:	Maintained
+M:	Andy Shevchenko <andy@kernel.org>
+R:	Geert Uytterhoeven <geert@linux-m68k.org>
+S:	Odd Fixes
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git
 F:	Documentation/devicetree/bindings/auxdisplay/
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
-- 
2.43.0.rc1.1.gbec44491f096


