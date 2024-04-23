Return-Path: <linux-kernel+bounces-155269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A78AE7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A8B28DF18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62613699A;
	Tue, 23 Apr 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJS7xa4d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7F135416;
	Tue, 23 Apr 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878431; cv=none; b=ald1zdZVuFdKvHEC3QCbe/AR7eg57pAT6+UTJgtTnGLsQby8QmrqdyMUG7+Il9Pg6XWJznCVSF9XYxm10MDD7ldcgUD8flieR5na1tbTBSijSpFX60fRDZxvThLiVNstEyyC4PpZev+0XAYA1wn73Mc01ZNo303wmFysrceyQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878431; c=relaxed/simple;
	bh=i5MXpWGoHGE2Xj6A1L0V/VFM6UTM7zUlHxVZGvJnQlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROjhqKV58/nF6Qf+ofadFEqF69wVNgEdTWtmrUAdYcdYlTxfNY7PXg6iVk9qdtrH4FGvO00zvhWXFI7fQqvH158B0pXGoQW1Mn/z/FJXkOKfgvzAXLSmmhAeeRKrS/77gy3NQWmUa7Q3TFAOFw4dhpr4gyd9YipEK3Hn5enrBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJS7xa4d; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713878430; x=1745414430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i5MXpWGoHGE2Xj6A1L0V/VFM6UTM7zUlHxVZGvJnQlE=;
  b=nJS7xa4dZm52Zu8QzTr+q/GMEur1FqYZS4kdBI+aimxGxCN17qP2PCos
   VS9lhvcwy2DMzQgzfOkUMY7eA4RFIYNydttTC/K/prN/NIOoJJ62TU861
   2q9Y18Hg7aI4u9jTa6G2Os+Ml3BRW375FPpbnVKd38P5jDypx8GItO4a+
   CPVeuIkoMzCBVk/vP3VjEbZb9Z1U9blCwM4o8qzLSVWb/bVWV/F4H0MfH
   z35D0kS1PIb6/eYhkbqMm9FlMVZee5xSwsym3Q7S6sM1xu/V/9djiA+4T
   hiCeIYEx66sXUbLPObYm6YjGYBKPVLNj8UiH3PpTSpEC6UyXJO7PY4aDK
   w==;
X-CSE-ConnectionGUID: u6alkEM9Qc2aPNZ3NY4N8A==
X-CSE-MsgGUID: iDP8wLF0QeuzwuBXmb0e1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9630381"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9630381"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:20:28 -0700
X-CSE-ConnectionGUID: KbAuRj8mQ1KYaVkF7aXzpw==
X-CSE-MsgGUID: hkT2RY+UR5G+LvXP9b8ymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24348996"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 23 Apr 2024 06:20:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3289044E; Tue, 23 Apr 2024 16:20:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 0/2] Documentation: process: Clarify use of Cc:
Date: Tue, 23 Apr 2024 16:19:36 +0300
Message-ID: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a couple of recommendations on how to utilise Cc header in
environment friendly way.

Andy Shevchenko (2):
  Documentation: process: Avoid unneeded Cc: tags
  Documentation: process: Recommend to put Cc: tags after cutter '---'
    line

 Documentation/process/5.Posting.rst          |  8 +++++++-
 Documentation/process/submitting-patches.rst | 10 +++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


