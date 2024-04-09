Return-Path: <linux-kernel+bounces-136249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DC89D1E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756EE283C51
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EDB612F6;
	Tue,  9 Apr 2024 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZxH2qNbe"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1CB54BCB;
	Tue,  9 Apr 2024 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712640310; cv=none; b=rDwdYhD312hsvurzjIw9IgBwXFGcm37SlV6YwagxswnHdjsxLKEXyNC8pnZALz+49w39W8vehY2XHuU5ql16SNofzkejGD+zNQRlG2+V3M+kw2PHweS1mOVw17vQy4s3XbxtTIqcS4lFYwXVF7KlmZO71r3Jfbh0y8t1wE9IJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712640310; c=relaxed/simple;
	bh=c+E0Ivgu8zc3jsKPVvka9jymECqjH91wtE41Wl9104c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pse2kReQoemp9Stua4Oy09CWcBah4i4ECa1OEfsjrvrLuL4P7BOSG0bw5daEbW6ddvLSUWDk4+n4DHI4DF/uKslaAZJ/66kblaUdT0EzDCcDui6x5OtRACWHbDSBSF++IZ3TsklkRcPXzzKtJx8BU/N9hz5tWYrBTskfnASjk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZxH2qNbe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [167.220.77.82])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0CEC20EA451;
	Mon,  8 Apr 2024 22:25:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0CEC20EA451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712640307;
	bh=FBSe4rDQmSTpv21rWEaJ0GJmEOffcUGm1Kyb8bb+B0c=;
	h=From:To:Cc:Subject:Date:From;
	b=ZxH2qNbetXYoC5X+JBetIEOdZixI3OTd/3EXEfyemurOcvab17TfSReMc3gnLdKnF
	 M5jCY5LrRkJLCqTQuY+6yYylrMT29XMT76HnStrh4rr+DtoDZIoiwFA0mDYDBsDYp4
	 AdYgJdPxvCquqQm/2MgtoqvLR+AlEyDhGsZv6EfI=
From: Jarred White <jarredwhite@linux.microsoft.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-kernel@vger.kernel.org (open list)
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: CPPC: Fix bit_offset shift in MASK_VAL macro
Date: Mon,  8 Apr 2024 22:23:09 -0700
Message-Id: <20240409052310.3162495-1-jarredwhite@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
system memory accesses") neglected to properly wrap the bit_offset shift
when it comes to applying the mask. This may cause incorrect values to be
read and may cause the cpufreq module not be loaded.

[   11.059751] cpu_capacity: CPU0 missing/invalid highest performance.
[   11.066005] cpu_capacity: partial information: fallback to 1024 for all CPUs

Also, corrected the bitmask generation in GENMASK (extra bit being added).

Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
CC: Vanshidhar Konda <vanshikonda@os.amperecomputing.com> 
CC: stable@vger.kernel.org #5.15+
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..00a30ca35e78 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -170,8 +170,8 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
 
 /* Shift and apply the mask for CPC reads/writes */
-#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset & 			\
-					GENMASK(((reg)->bit_width), 0)))
+#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+					GENMASK(((reg)->bit_width) - 1, 0))
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
-- 
2.33.8


