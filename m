Return-Path: <linux-kernel+bounces-95566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB4874F91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A19FB224E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6212BEB4;
	Thu,  7 Mar 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gS8ocZJF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6A12BEBA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816676; cv=none; b=EbX41gtw5cmk3V+/miyuhLc5OWaBbqtwSL0cdBDlvicK+VJSvX4AQ+8O1n86pT80hn7xPAiSMA5ckmX/JBz6g0AhmV3DM0nYLbz09kOcqyuY16mfDcjfl2eQ4a4UXnV/4Fb4mwdSeWekRivHjwALUo5VFYUt4fd/2wt/6Wo4y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816676; c=relaxed/simple;
	bh=N+eRZXxN2eytANgfSbyduqZhkAXglYBQyinbb8Xem8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPh7IZcPxJfjitVpJ2LZYojZAt1zXfHmw7+u31KKv8z3or+ODz+Um6OpDQjXluXkM5i+1jAL8t4SRFHANXk8gc2sQOycxOvkUzfPokhi7GKVjjX+Wl6+ieddxRfWmqkOwODbpqsbRv6kIL//VtvpjdOymG+166xGktr+Pk8uD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gS8ocZJF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709816674; x=1741352674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N+eRZXxN2eytANgfSbyduqZhkAXglYBQyinbb8Xem8k=;
  b=gS8ocZJF1fek3UhKX+lKD/XOXz5j777kBii1V75aRVpzuz9ELVH+rxaG
   tqLWgfza1FLrvdlhL4Nla87E1MYx5q+3aYAo+xgDNZ1u/jU/Kpmu4/i/k
   3jVTtdFHvjolKKiDBP8HynySLyif2GQ4lDx6EPl8Lq8HdJd8MHqhb3cHQ
   kVeC0jVXMQXK+Xd461IihShFc9buCMBvq0P6n8GguUHvTT3+Nn4G3BjZk
   q8gpDNeihGHiTfxTOznUen0lKfUbJ0Wzivp3hBtfqIW0IssV8n2mrtFZ+
   Ye7+MC4fxW7UvjQCWWQmIbZh+MztbrTrwoifpSua4PD3INjokjrKLq7Qf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="5068053"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="5068053"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="14592300"
Received: from unknown (HELO localhost) ([10.237.72.159])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:04:31 -0800
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Subject: [PATCH 0/2] mtd: core: Handle unsupported OTP operations
Date: Thu,  7 Mar 2024 15:04:16 +0200
Message-ID: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make MTD core tolerate SPI controllers without OTP support and report
an error from MTD core if OTP initialization fails early.

These changes address the issue that occurs when an OTP capable
SPI NOR device is initialized with the Intel SPI controller. The limited
supported opcode set of the SPI controller leads to failure in the OTP
initialization, which in turn fails the probe for the MTD device. By
allowing the MTD core to tolerate unsupported OTP, the rest of the MTD
functionality remains intact even if OTP initialization is unsupported.

Aapo Vienamo (2):
  mtd: core: Report error if first mtd_otp_size() call fails in
    mtd_otp_nvmem_add()
  mtd: core: Don't fail mtd_device_parse_register() if OTP is
    unsupported

 drivers/mtd/mtdcore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.41.0


