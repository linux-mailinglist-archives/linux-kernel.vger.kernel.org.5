Return-Path: <linux-kernel+bounces-83790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4482E869E77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D9928576D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90E1487D7;
	Tue, 27 Feb 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PG4AfHhe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FE4F5EC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056764; cv=none; b=HYcGPD5iAWIy8DbpJVu713j9qabRAGndvJiUyXvIrHPO80PcH21b+/xU6mnRikerWKtYBzFIfPivXdF23frmlvu500jWsvRWiZ3hr54maMVKjvLb6qCJZoYYn+KYauk7OnOV6nQK147vWbOkEt1Xn0QCT+XqZXGzWXXfASFdVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056764; c=relaxed/simple;
	bh=akZVloetQlgvAMqV+V6DLoLSCIAxumBQdN79IiZsIc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnxr1/63H7RsEPeanvotiaM03pEywZUNyDeacH/u1fcFgJ6kCDZcAxnmeMAr4yPx/ec3hcB8HULPu4W6nymj1Vpl7sdkdlbEuXeQEvUJGpV5tmC4sYcAX53vYcDT5c5kGBJM8GIXGk3PAxdXVstED2cDnsJzMAZ+LTxzE4O3MoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PG4AfHhe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709056763; x=1740592763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=akZVloetQlgvAMqV+V6DLoLSCIAxumBQdN79IiZsIc8=;
  b=PG4AfHheRg9qAoKkkOrDtiKrZwyOOkU8X1iqK2PiC75mFXNn2GDJDvJb
   0R4tfEKa1LTa6iDMJ7UHrCdaSjakMHp0/FIkSSm1MmEcS4z7g8qwuvLe6
   ZSnmAcFC8xWPh4usiIvFpndQHYl4A8ApVTMO19C2MIgk8nL7bYmq1fP0M
   mlsNzPyYQEWRGLy1r2Tm2Ww2U4xBJmfVAyTQU/4K87fStuDmus+fRoy1V
   VPE4bs9bVXBbAUU622Oog1eKz5/hJiEjO8wk2dGghpjiyGEQiNSJ781gT
   PUqilTgjtc/1AwdX5GwT5UVfLfrutmoHGfoxiFpBb5OWMpYBS7b0oRdV/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20962777"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20962777"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 09:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032679"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032679"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 09:59:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F35D7284; Tue, 27 Feb 2024 19:59:15 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 0/2] devres: A couple of cleanups
Date: Tue, 27 Feb 2024 19:58:33 +0200
Message-ID: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of ad-hoc cleanups. No functional changes intended.

Andy Shevchenko (2):
  devres: Switch to use dev_err_probe() for unification
  devres: Don't use "proxy" headers

 lib/devres.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


