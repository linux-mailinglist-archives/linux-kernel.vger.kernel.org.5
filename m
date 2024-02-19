Return-Path: <linux-kernel+bounces-71931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A45685ACAC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA565284C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958351C49;
	Mon, 19 Feb 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na7X5bRo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC351036
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372698; cv=none; b=SOf/ezHV2/HmUJEZHy8JFKfGVyDMQ0hI/YVrbBsgHZet4PGMazxKDr3+RYy269jDreucFFA7qnbYbCc24SOtLyKlKCC7LTYzD4VOANzKI4I1foC30TogtykFQwRXI9JTDHtBlBgXaxiTd4ZnGW+seC84qIxg67ULe0qXbhO8P30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372698; c=relaxed/simple;
	bh=3AjS5mgJP6xfMQ57w4YOPhZnkOghp2UZKyNImyNi5UA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hw2Fl4vRX9GHAUCRr0o+6OnZXtA1KfjvUJAxffLyx/uoa8lvhM3iw9HINMI+sQ1lddkyeRnABlftIhptff2ryRWCi0V2tseksFZkV4APvB0ecIYaYxyT6zS2Mv6fZ0i5uAd21u0i/3QHsWXFNSPqI7PB1XRPEaMtg3uXMkdVzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na7X5bRo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708372697; x=1739908697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3AjS5mgJP6xfMQ57w4YOPhZnkOghp2UZKyNImyNi5UA=;
  b=na7X5bRogJCKR7Z3ekZWGjCZ9YbJUMb/CzY8hfZKL+ElcYFNauLKXOIl
   HHvlUGnovalGpVWJrUXJrHfU0MnM/5zToX9AvawRlNbaNLg0gZ22nr+kx
   I+P/JWUPwmsK0W+YrSclZ9SVBGkyXpTmRvo+KoNzi8wxzXVNspvpfXoRG
   PIYl8VwNiAbOvZJkkH1gZbUsedRLXLimq6QNwmFNk3Npx5eZ5Yj/gbmGm
   AIoplgiJff9IWWxao3+mZAIIHRttF3huuKLX+C/vJ0NvxG7AFaXHJ0Yjm
   6jOtM1KN2NDxTrOvhZpq21ye75/gqaZFQWhtAsJINQXyx9J1UTyPX7eSH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="19893438"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19893438"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9239471"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:13 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1690F11F819;
	Mon, 19 Feb 2024 21:58:08 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/3] MEI VSC fixes and cleanups
Date: Mon, 19 Feb 2024 21:58:04 +0200
Message-Id: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
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

since v1:

- Rework patch 1. Moving wake_up() to the threaded handler is enough as
  sleeping is allowed in the threaded handler.

Sakari Ailus (3):
  mei: vsc: Call wake_up() in the threaded IRQ handler
  mei: vsc: Don't use sleeping condition in wait_event_timeout()
  mei: vsc: Assign pinfo fields in variable declaration

 drivers/misc/mei/vsc-tp.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

-- 
2.39.2


