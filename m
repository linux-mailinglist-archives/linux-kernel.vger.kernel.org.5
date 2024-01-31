Return-Path: <linux-kernel+bounces-46366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D1843E93
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130251C20BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD907AE7D;
	Wed, 31 Jan 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW3J+uem"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886657AE61;
	Wed, 31 Jan 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701049; cv=none; b=nXS2o0x/qjl3LgrhxJUfOcxDnEYoV8i0IZseyKtc05zeCBcyNh1GKRgyxxvRhGoIyPDL5uQMXQms2Nt3xSxW0QJvkXs5metwYApRQ3qfU3s+ak/qNzMDB3eM+FTVYbl4UEPFCxHyN23SCv5VjxQdoblIOMpV+0xEG0bGxpQnku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701049; c=relaxed/simple;
	bh=2+l/sdKWhGevWKdnh5NkECeIK7BiXrdRRKl9YlUqCeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U60I88q896u6/p9VVA+cxBoTh5lrzQGHt6i2igv8B8JlL58jY7jrj3fv6xiuDjN6qKGXwBplhifwjcFe6kh0ajDHyDYOf7UvZzSokhG9PwxuH7PoFBfcR6ER5UNE90259NNwAzxkJnHuB8NfQylZurlEKjAABmUAHu9u4ApVkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW3J+uem; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701045; x=1738237045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2+l/sdKWhGevWKdnh5NkECeIK7BiXrdRRKl9YlUqCeg=;
  b=OW3J+uemmLhseFk4VmIbZMVOPHPExPASR6Y9L8nVAZLQlqkkKabxqalz
   39crVt1R3wY3AH7i12QfRLMG5pF/ovRA+Ua2lhd1rPhMFsP9myAei+a91
   oyp/4YGNLI9X9xpmOAZxBR7RU/chFwErgICRx9tC3mMfCJvlzfSs6HHlH
   +0bpi6nBYL03qvz3LvTxKLu7etSmoYpxONvlBJcyHQWpqxji5y2hafBnd
   D6drxuqgvcR7vM/znH8/QgZpVVGyeF0n6PyL0IBZEJ25VHoYyCpPhviCD
   DHi6sS1iC1xD8xLbJHJB3+cyF3gIzRIaLN+pVATEZYKEMzzkxebKPRaN/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3441602"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3441602"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788542465"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788542465"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:21 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/6] powercap: intel_rapl: Fixes and new platform enabling
Date: Wed, 31 Jan 2024 19:37:07 +0800
Message-Id: <20240131113713.74779-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1/6 fixes a real bug when MMIO RAPL driver is probed on platforms
that are not listed in current CPU model list. IMO, it should be
considered as stable material.

Patch 2/6 fixes a potential racing issue, but I have not reproduced it
yet.

Patch 3/6 ~ 4/6 fix a problem that TPMI RAPL driver probes disabled
System (Psys) RAPL Domains.

Patch 5/6 and 6/6 are two simple CPU model updates to support MSR RAPL
on Arrowlake and Lunarlake platforms.

thanks,
rui

----------------------------------------------------------------
Sumeet Pawnikar (1):
      powercap: intel_rapl: add support for Arrow Lake

Zhang Rui (5):
      powercap: intel_rapl: Fix a NULL pointer reference bug
      powercap: intel_rapl: Fix locking for TPMI RAPL
      powercap: intel_rapl_tpmi: Fix a register bug
      powercap: intel_rapl_tpmi: Fix System Domain probing
      powercap: intel_rapl: Add support for LNL-M paltform

 drivers/powercap/intel_rapl_common.c               | 36 ++++++++++++++++++++--
 drivers/powercap/intel_rapl_msr.c                  |  8 ++---
 drivers/powercap/intel_rapl_tpmi.c                 | 15 +++++++++
 .../intel/int340x_thermal/processor_thermal_rapl.c |  8 ++---
 include/linux/intel_rapl.h                         |  6 ++++
 5 files changed, 62 insertions(+), 11 deletions(-)


