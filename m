Return-Path: <linux-kernel+bounces-61255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC5B850FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF133282D29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93317BB7;
	Mon, 12 Feb 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIs3HW56"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B717BA8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731186; cv=none; b=Putb+Pj0Ye1PFuIdngZ5uChG9aHd7CinKmS0nSUOYX9ILpxO7YL39mcUiO5ctV0ucn1iOfARqiqXsX8UWdQJqgRRvMaohbMsSRT71TKuVZgXd00med4IuwV/LpMlnRkx8LQU/4bj0OfReuLJFwdmDombQKJQeBhLP4/1fgf0RPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731186; c=relaxed/simple;
	bh=h5gYrH/ws8FrpMWJe8FAI2E4iZamVDZXdp6p7sFZnQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aaAzUYlznATpQHYrnTI0kfVstzYN6Gbpv3x01QH4GAA3b/sZ6q2ffaAOThzgqcdgb7ItjDDwUp/sQcjZ/2Gpce8Xq1UO/Xe5aCTytD7u9pBewywYM208NxMozwswhOXSLeATDoKOh9oalZ3jvW3rRyTJRE3a6mNbpmftFuVO0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIs3HW56; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707731185; x=1739267185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h5gYrH/ws8FrpMWJe8FAI2E4iZamVDZXdp6p7sFZnQY=;
  b=nIs3HW56WbLfYWBxnpOhc2c1NWPltX8dQHm4mSWLMq/LFIVhmIzQElN/
   kJ3XNdr0+FAM2rp+vb2xR/akvoeGfueuioY5IVhgE9ErPo2dam/w3jQGI
   +bmJNKJNo/7SOs/vWX6mnNmvpCZLrOzRiZj2EmNZjRdWM0XXXp1UtyOhd
   XtHbw0KpzGZfEyL+FjwxCj8mw91LqD3xIpWu1WO3Fs3ioZVaQT+xaR3FX
   DUjhZZCk+cnR9oa9QpYG7cY8+6jRfzxkF+PMWaXQQFcCGYAUSRFBkkfyM
   G6L6NbLTSioIDaurbAAgHeR/xgh7agilmepLDFUoG/E9AY5vtw3RlVKeG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12335871"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12335871"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2502527"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:22 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C956611F86A;
	Mon, 12 Feb 2024 11:46:18 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/3] MEI VSC fixes and cleanups
Date: Mon, 12 Feb 2024 11:46:15 +0200
Message-Id: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

These patches address sleeping in atomic context. It wasn't obvious at
first this was taking place since the callback sleeps while the caller (a
different driver) called it in a threaded IRQ handler.

Sakari Ailus (3):
  mei: vsc: Call wake_up() and event handler in a workqueue
  mei: vsc: Don't use sleeping condition in wait_event_timeout()
  mei: vsc: Assign pinfo fields in variable declaration

 drivers/misc/mei/vsc-tp.c | 64 ++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-- 
2.39.2


