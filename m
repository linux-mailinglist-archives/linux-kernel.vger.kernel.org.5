Return-Path: <linux-kernel+bounces-139672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD858A0657
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCFD61C22134
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C313B5AD;
	Thu, 11 Apr 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ay8UAFde"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDC604DD;
	Thu, 11 Apr 2024 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804345; cv=none; b=KM4XAOJpixZXdTptBCxciXTfldzjiJA2WblrDs1ymRcYY2g2mdCsp/d1mle4A2FUlGGVw9/lNaszKaF0vp6/N/dXIC+asBJG//JFHx+WorWWMz9Ln4xqlWMMvTlD7jUOS5al8Bp89GmAnH2v+yKpVJruOAljN+gYCVG27v2TvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804345; c=relaxed/simple;
	bh=fTwTC2Vl3waazgIcqNRDB1djaYoyH6BIGDFyWFkcaZs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ooJtjpMNIFeV6eRAXCOeqFDqmcW5JkVcprVRoeGiRPcsfQqHGHy6IYmgAKrbkLVnv9c5CGoarmtafvn7UhByvw8DlxwMrMZPfUYcvxUGZjT4dgJHHiDbfENkU31SN6yQyu5+ODd7rOp6OAhv4yFlqmC8mb2p9OLM+hYdvOiTtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ay8UAFde; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804344; x=1744340344;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fTwTC2Vl3waazgIcqNRDB1djaYoyH6BIGDFyWFkcaZs=;
  b=Ay8UAFde4fvJN2noYSjhrrPP9IS7pln7q19yYTIaytv1GuVQ8IYgFKkb
   kzHRC7uWXf4xtMRzA9G5ihar50s/yVQMfjtLkZu0KKqaumJ5s+7nUlFYQ
   ueyRjAtWSSGspe2Uq/gKlqB37RKo1xfgMP0q3xOewYtJZeNh/Ozns8+00
   LaKXhcLYczWa9XChwQHoG3dN2pSQKUcuS+3RA+UOXwoTbR3g0NVxWUx+Q
   tQ5GMM3KuFA5Px6JaZC9oUQKw5CSdqg7EU5pnjveHAt2X9m30jyHzk7Db
   JNGeBoLu9SGehNhgcJXZhoRAZBtEZfUmvaUZAF2yTPMjsBbTWdjNjne4v
   Q==;
X-CSE-ConnectionGUID: 6j2AEVM1S+u3f+vIJC+OCA==
X-CSE-MsgGUID: d4auY5i2SwaFKFJ3Wa4h4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8054662"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8054662"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:03 -0700
X-CSE-ConnectionGUID: FEbaUXETQw+652YxPu7GxQ==
X-CSE-MsgGUID: gPhHzcNmSHqYOn5SSZAVmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51730470"
Received: from karczmac-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.255.229.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:59:03 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V4 0/9] Intel On Demand changes
Date: Wed, 10 Apr 2024 19:58:47 -0700
Message-Id: <20240411025856.2782476-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds driver and tool support for a new "current" meter that allows reading
the most current, but not attested, value of the meter counters. Also adds
fixes for the intel_sdsi tool.

David E. Box (8):
  platform/x86/intel/sdsi: Set message size during writes
  platform/x86/intel/sdsi: Combine read and write mailbox flows
  platform/x86/intel/sdsi: Add attribute to read the current meter state
  tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
  tools/arch/x86/intel_sdsi: Fix meter_show display
  tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
  platform/x86/intel/sdsi: Simplify ascii printing
  tools: intel_sdsi: Add current meter support

Kuppuswamy Sathyanarayanan (1):
  platform/x86/intel/sdsi: Add in-band BIOS lock support

 drivers/platform/x86/intel/sdsi.c      | 118 ++++++++++++++++---------
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 108 +++++++++++++---------
 2 files changed, 144 insertions(+), 82 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.34.1


