Return-Path: <linux-kernel+bounces-52722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3633849BE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F187282905
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E12375B;
	Mon,  5 Feb 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYSpiOUM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863B22EF0;
	Mon,  5 Feb 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140105; cv=none; b=LXS/8d6IzzNCt3ZLEWOHd4V7QvLnWOGNziOUgA3pvKO8yP4FcOjkNnCFuk1FgQ2hP1CxqwgxGE0KihSe02yifIOqzCsXyQzVA13r0F88P3HATGAkIVCabr7lnbtVM6G2rlfQJSKtv+bfNYB6d3hMaw3y7JpwmuID/nBnKmDqyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140105; c=relaxed/simple;
	bh=glQvXjgi/R4lpd69fB1ZMuMar6SxIwlc9URf0IPHVQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FPK6SwMlaXU+UDKGclulCW14tFvz+DZZcBPuSHm7ht5JOhdSNGIvSNbCTlL1ZoS59kPZL16Kls3uey9ETq7ysRQAIeFIewWNz/1xBIbyc+P3YKcg5b3OxV7C/EfRosVx9q411++AEdt6sfK2DZCWPz2jw0nAO2k1QKQ203cpQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYSpiOUM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707140103; x=1738676103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=glQvXjgi/R4lpd69fB1ZMuMar6SxIwlc9URf0IPHVQU=;
  b=WYSpiOUMceEPABq8AMFWOm4p/CU4NrJnYcEF5rs0xpFzK1RB477yxW7m
   HU/mFG3LmCzyAEj9cRHQ+mZFmNFkqjDtG76orP88xhWAufdLTkhwKGnT6
   1B7w5mLy9W1f3EYOc3kTpt9C/YkuH77HdrlBigE8Be8YIgTD5607dCtus
   yV69//cRd493zhsMMtBnWj8FIyCsrwfqU6npbnFUtgLaJYZNPcJlN5nBK
   zMdW+q6kZWwSEZrAtQCBqu8tjv5D+uS0igQ887lx8/FZhBnZ2sKG0KggR
   IpRPa+sQ/5cKNAkocfijJbDdOwyuArDpEdFBv5dlSssE8YgYr2sqeyaEZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="670929"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="670929"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933155174"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933155174"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:35:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] MIPS: Cleanups to PCI related code
Date: Mon,  5 Feb 2024 15:34:46 +0200
Message-Id: <20240205133450.5222-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While auditing PCI config space read/write callbacks, I came across a
few places which were asking for cleanup. Thus, this cleanup series
came to be.

Ilpo Järvinen (4):
  MIPS: lantiq: Remove unused function pointer variables
  MIPS: ath79: Don't return PCIBIOS_* code from pcibios_enable_device()
  MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
  MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE()

 arch/mips/pci/fixup-ath79.c  |  2 +-
 arch/mips/pci/fixup-lantiq.c |  9 ---------
 arch/mips/pci/ops-tx4927.c   | 16 ++++++++++------
 3 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.39.2


