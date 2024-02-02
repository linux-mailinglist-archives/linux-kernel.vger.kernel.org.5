Return-Path: <linux-kernel+bounces-49851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A55847078
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE71B25677
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EE41FAE;
	Fri,  2 Feb 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtemBZru"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7C15B1;
	Fri,  2 Feb 2024 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877541; cv=none; b=gAHDxO3XTIOStdXsH0TfiGYbUp0I70buzIL0BIRVM9yAzh9GqSpfL6HtZM+FENwAYHSxMBRo59gTGvK4d9UxewIV57Nc5eSDBW7wfFs1mipwY+my+kGuL1rBlFgB15YDQ37T+fiifHWJa2vYyOo1HCDHGLrj5TM01TR8XHk0HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877541; c=relaxed/simple;
	bh=OoPjnrPr8StiPXaPppH3fvGIRnVAs2DNEdph0pRPOO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qx77xmE8mwhIEhwvvn7YYHW3y+FE9timPOUKQa5fQZHh+dLAxgkdDruXdQIz7inY97gYcgGEuzWC1gPw2lP9/xXujxkoFHEt7gqpvE2jMzjFMnFIryv1VJaWZ+EcruP3xKWHKXpmIw4aH0N2KKx+x5aMW2gq7jVKUokyNkx1mHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtemBZru; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706877539; x=1738413539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoPjnrPr8StiPXaPppH3fvGIRnVAs2DNEdph0pRPOO8=;
  b=VtemBZruukhEu1Jgkk5hOGGpB6U8CdgH0XIg3VFI5PYlwEs+A+H/R8xd
   ah9AgSb62z9zCrL85f/0ZvzFfTKTmKK/ZdU2mlUSXoqp1OBGI/hCzBY0O
   WbJXzN9H2c7z+Ij+ypTUlDpz0Kq7nhLpQNgoovWJLusng7POFlveFEm3u
   JK/DcOb0z5LI4E3FGgFUyi37l7J/YcZT+mqQGPs7snws7GdhBKPgvMW8k
   toxK/ncNcrczkTgdW5QEmU79voh2edpZ2Tuglp2+usuQDmb8GPk2vxcLv
   OJk/YP8B1mNb0QMVsM9GRXeZUmfEUOVbh/2yWR/lVHb2jkqbyZv8rYEzU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="64235"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="64235"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 04:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="37500256"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 04:38:55 -0800
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 94F661205D0;
	Fri,  2 Feb 2024 08:40:17 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1rVnDl-000D9R-1r;
	Fri, 02 Feb 2024 08:40:17 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: [PATCH 1/1] media: v4l: Fix link frequency helper's kernel-doc
Date: Fri,  2 Feb 2024 08:40:07 +0200
Message-Id: <20240202064007.50545-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202145412.336db5b2@canb.auug.org.au>
References: <20240202145412.336db5b2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc indentation for v4l2_link_freq_to_bitmap().

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: a68e88e2cf9e ("media: v4l: Add a helper for setting up link-frequencies control")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Thanks for reporting this, Stephen.

 include/media/v4l2-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index cd2163f24f8a..602738f7741e 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -563,7 +563,7 @@ u32 v4l2_fraction_to_interval(u32 numerator, u32 denominator);
  * Return values:
  *	0: Success
  *	-ENOENT: No match found between driver-supported link frequencies and
- *		 those available in firmware.
+ *	those available in firmware.
  *	-ENODATA: No link frequencies were specified in firmware.
  */
 int v4l2_link_freq_to_bitmap(struct device *dev, const u64 *fw_link_freqs,
-- 
2.39.2


