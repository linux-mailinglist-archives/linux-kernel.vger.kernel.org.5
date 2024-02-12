Return-Path: <linux-kernel+bounces-61597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6FA85140F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B950286E35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C73A1C1;
	Mon, 12 Feb 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ugbnwtqm"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1E3A1A0;
	Mon, 12 Feb 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743147; cv=none; b=XtRMQzjY/l6AJIseKGY9zD3EaXdLA/jAfaWtO6a0YiVwAToQBnT8OMN6cxllnzudgdwFH3hcZcy7dlB5ga110yx/iWqUWNvxL0MVrWuJwHkJEd1drkVGkBkUrpBYASu4xAsg2KeP3fKsMQa7YsJGIb0gm4C/hiLwH/GE0o0IiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743147; c=relaxed/simple;
	bh=TBXApfwK8hbONStkVoXVydtssWRk/QH7CP5R59ri3vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYap+wuCs2aLEapS/9PHsLtKaT9dTynFWPzUIhWFw6m9zEsa83Mhtebl9YbFa4s2EI7srAfn3i/WKmSds7MIFs2ZH9entBx/t9xvwAkPNf2qdQxO0rBQT8ockP07s2yifS6aq5aQW86FF+jqRXxPbtm4HHgzamF2l341WOoGNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ugbnwtqm; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707743145; x=1739279145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TBXApfwK8hbONStkVoXVydtssWRk/QH7CP5R59ri3vs=;
  b=Ugbnwtqmyjko1CsS58fFHo4DA2sZm3xIfqfQEfZiE5E01sYwyiVajL6u
   6ldaI9iJUkS6C2lJtMVvEx0qsLtBdbai39m/ck1xJnSZV4euQCQeOh2Zq
   Xl2Zj1GDQTqrdKCdtPtgtuUI4jl4a22x0LN6KMtZd+pnWnrjjkVy6FKTm
   L4OBJ6KTTE2YqpANcmyr8tuQL3cIJt+vxU0894M5GZXnEg4YqE8E39W/+
   KWd2TRb5VNpXphI5QYdh2xOiED4nC4cCTnc2TmrWkQ6T7Mt1AQgj1GGa+
   4RdsDdQXu/6vyieUI7jtKoeGn4LYPPzOIYRVoaaOQ34WGFyPjR/qpZzlM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="396152022"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="396152022"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="33654468"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa001.fm.intel.com with ESMTP; 12 Feb 2024 05:05:41 -0800
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	sfr@canb.auug.org.au,
	damian.muszynski@intel.com,
	mun.chun.yep@intel.com,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH] Documentation: qat: fix auto_reset section
Date: Mon, 12 Feb 2024 13:05:09 +0000
Message-ID: <20240212130532.50350-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

Remove unneeded colon in the auto_reset section.

This resolves the following errors when building the documentation:

    Documentation/ABI/testing/sysfs-driver-qat:146: ERROR: Unexpected indentation.
    Documentation/ABI/testing/sysfs-driver-qat:146: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: f5419a4239af ("crypto: qat - add auto reset on error")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-kernel/20240212144830.70495d07@canb.auug.org.au/T/
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-qat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index 6778f1fea874..96020fb051c3 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -153,7 +153,7 @@ Description:	(RW) Reports the current state of the autoreset feature
 
 		Device auto reset is disabled by default.
 
-		The values are::
+		The values are:
 
 		* 1/Yy/on: auto reset enabled. If the device encounters an
 		  unrecoverable error, it will be reset automatically.
-- 
2.43.0


