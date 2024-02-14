Return-Path: <linux-kernel+bounces-65618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7350854F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8356B1F22C75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95860BAE;
	Wed, 14 Feb 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ph1k09V2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6999C5C913;
	Wed, 14 Feb 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930653; cv=none; b=klgZlVqAPxqJN8V4bWHxYrlWTwwlm+AHTaqF/c0w772yWh7A0wgVLDhK1IsL7AfsxwB6W27/QULRUJNb+u9z//Rmh9eFJJ8uNT3I2wI7CExWTadXPYBhbm1rIyIomEejteC2XSOiaF8LaFu3mc4aCpY9nmX0qXy6thN+j4NB9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930653; c=relaxed/simple;
	bh=8GfvwSh+N6mxrWm0DNjZ4B1zEOtjColCP5+gz3Atp9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8szbi2atgiSYrm8+MnTUr2S8BC86sDh4eiNdM3mCS7AvyuIHlZ+NrbLfE1v3pnzvcwq0hbPPivquyYOgT9ZK37M6EwTFN7zgzlIkx4WVzh8U1bD6Mjz2ZXu/90nVsheZ5GTjSwcwNB5ey/CDIWdqkjnZjTTFr8NGSlImDaTpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ph1k09V2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930653; x=1739466653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8GfvwSh+N6mxrWm0DNjZ4B1zEOtjColCP5+gz3Atp9s=;
  b=Ph1k09V2/OIgIIcmi20X6qH8z8q57rEyv6+rolXPchJqkIvLeAOhGrD7
   BxIbR1PMLQW6vDMpSCec0/uwlqaDJgVb47r0pFuZPEXAeJKxQ0zkVYgpv
   Tzx2eJS/O+hOI9cNyVcdx+cCI+WXX5Z8Bc2ho6cAD1TCz+KaDDHLArKmT
   dwHn/ln6jWWp2mkKdOJVmVI65DKbfcxQDV3MQ4dWGVDTAa9YtCrtYP6T+
   ElLnkXNEuqWE4d/uLD/daT4G0HAzScua1abicgVV8dmHIdKkZ0hGP7vHr
   iLoTFPBWI2wgfNNi/jwJreUfZ9N2lA50faRx1Kd3lZnuYUSU5MEQ3mYP2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24458016"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24458016"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617215"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617215"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 09:10:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B0BD204; Wed, 14 Feb 2024 19:10:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] serial: 8250_exar: A few updates to the driver
Date: Wed, 14 Feb 2024 19:09:33 +0200
Message-ID: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few updates to the 8250 Exar driver as per new in-kernel APIs
appeared.

Andy Shevchenko (5):
  serial: 8250_exar: Clear interrupts before registering handler
  serial: 8250_exar: Use generic function to set firmware node
  serial: 8250_exar: switch to DEFINE_SIMPLE_DEV_PM_OPS()
  serial: 8250_exar: Use 8250 PCI library to map and assign resources
  serial: 8250_exar: Don't use "proxy" headers

 drivers/tty/serial/8250/8250_exar.c | 43 ++++++++++++++++-------------
 drivers/tty/serial/8250/Kconfig     |  1 +
 2 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


