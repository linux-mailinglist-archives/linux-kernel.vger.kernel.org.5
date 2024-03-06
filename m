Return-Path: <linux-kernel+bounces-94217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418C1873B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BFCB24FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E575413F447;
	Wed,  6 Mar 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pcm9suVH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0313EFFF;
	Wed,  6 Mar 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740887; cv=none; b=h3VU3HxdjlufXPHbxflcJlrJOJ95SIPnJ4cOzC1GX/dfG5kOiJLGhYEascGFK7rsjSUIgGmEEKiYmWH4kYgZ4RRjzIeK/Lvk0/EdAUaePKsMgS07knp2nj8th8LynYeLgjc2z2kbWqZvVsCL00/LcsJpbZqpAHo9lNel1uUJRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740887; c=relaxed/simple;
	bh=JgNsQYffeAPFhqpAXR80mJ0AYUtXctFXfZUcz7aSB8Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mtSjqQTvTaOKxtpoCw1k9+xVbaDtVtRulwRJWT0k4VpUlgUItF8DBxHzSBj5P8+ayvIXEjUZ8WKP+4kVai4FKe64q7yxdmHSmeNoLcbaW1KId45FzflU/L+XcvdYifSQ0c7Qo8Ci0pNhMVULQdpWXnZbAjkXHeFkp6fb4KhZ1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pcm9suVH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709740886; x=1741276886;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JgNsQYffeAPFhqpAXR80mJ0AYUtXctFXfZUcz7aSB8Y=;
  b=Pcm9suVHdi4mb/5i8bJOLqfXxSWqIG6EmWu09ptdB2YE4IRE/KOqmTUh
   VhAPfdUy7QMJwqYFIcGu5Dej1U670Mjgg3pu/pSeUnDOG7r1OG3uzxV1A
   sGhhMMGoSseh937DN5qI0VAxItUNyldou1XyzxOWIEAoP8OiYar9vP0TG
   giOt3xbQH+bLL3sWKbwRunEhU5ts2O1aifUUsF1I/6+edVAXS9nv0t2sA
   RgLSG2BPgcTDWJhJkmVNeYGCyiQe5X3d3vZ4yJCLWmQIXIyr6arjqWT+P
   HCSkxNjbtQJqDeAAfBDwoE4HvrbhYuvfD3trIAJ2DxZXb3+qPCmpE49SM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15504030"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="15504030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 08:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045129"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="937045129"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2024 08:01:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 61996184; Wed,  6 Mar 2024 18:01:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] spi: CS code, variables and comments clarification
Date: Wed,  6 Mar 2024 17:59:39 +0200
Message-ID: <20240306160114.3471398-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few duplicated code pieces, inconsitent types and comments
regarding to Chip Select pins. Refactor and clarify that.

Andy Shevchenko (3):
  spi: Exctract spi_set_all_cs_unused() helper
  spi: Exctract spi_dev_check_cs() helper
  spi: Fix multiple issues with Chip Select variables and comments

 drivers/spi/spi.c       | 173 +++++++++++++++++-----------------------
 include/linux/spi/spi.h |  15 ++--
 2 files changed, 82 insertions(+), 106 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


