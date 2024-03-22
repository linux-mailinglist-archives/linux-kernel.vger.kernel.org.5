Return-Path: <linux-kernel+bounces-111957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C4E887339
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E01A28644B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7B692F6;
	Fri, 22 Mar 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUw6NKza"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80863CB4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132446; cv=none; b=cxnk+1gZDAa5ePxuQ+UWJ/G/JJ7KrHHa/+G2CqW5B7riJVOA7XnwbayTcNDjZBR8RW0iDek8ZFR+2YCbsmk7iv8MZ0LyYFyKiydBXPbi5JHaKB0Nyms3DF54N4D1qr4YeXKuI/I2644LZuJmQgGLS9+/EAsmYmTpuqdN8uSOnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132446; c=relaxed/simple;
	bh=Y04CvwO+bPmfse2Dh/eX4xfm5KubVq0lxI+hRh84dAA=;
	h=Subject:To:Cc:From:Date:Message-Id; b=V+IYvys3KsHdP/IRfoUj+6yJ/ZCvnu8trDeBv/2qpmIJ8xvSKCevrPuOMl0nNcACLpZl49Tgo3EAkvie+zv4AYen11fPzxQuOyawtlNfw49BPgsXxTlrMN33IHEs+hA6kVUjQ0R0SjuSOXoHAWGQpIwEsDSPhhg3GLNMyA1Dgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUw6NKza; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711132443; x=1742668443;
  h=subject:to:cc:from:date:message-id;
  bh=Y04CvwO+bPmfse2Dh/eX4xfm5KubVq0lxI+hRh84dAA=;
  b=EUw6NKzaaVym6rjDNAfpBZOCsCDebYK3ARJ0402pbF6AzcbhZNg68mRC
   BFtCLaltCrir5BNDwKEfcyo7YrOStY3N/loSZDw3aFKGe/DP9XOhX+O71
   tfcyVaAwnv0wa5qihecdbe+UuzDU2PDrGWVAP1ZIkGJ3t1u15kFRHeVlc
   2lngAiUkSASFGBCozDtn8Tqtf1azf75k9HnD+RQlZ4HF+GeVFksmuu+AZ
   Eq+3nLL0AEMqDqMSWGM4yKoN/8ZYB3zKgCx3wOk08HtRSH4LrnrtM91sV
   QTxgz44vSBmQbghkp5JeppqqmwbYI9J+OlOtZOOai/nmrO+yNxTqi7FMD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16829923"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="16829923"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 11:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="38127463"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa002.fm.intel.com with ESMTP; 22 Mar 2024 11:34:03 -0700
Subject: [PATCH] Documentation/maintainer-tip: Clarify merge window policy
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 22 Mar 2024 11:34:03 -0700
Message-Id: <20240322183403.67BAEEFE@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

There are lots of maintainers "pings" during the merge window, even
for trivial patches.

Clarify that contributors should not expect progress on *any*
non-urgent patches during the merge window.  This applies to all
contributions, not just large ones.

Clarify the language around -rc1.  Trees really are closed during the
merge window.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/Documentation/process/maintainer-tip.rst |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff -puN Documentation/process/maintainer-tip.rst~maintainer-tip-merge-window Documentation/process/maintainer-tip.rst
--- a/Documentation/process/maintainer-tip.rst~maintainer-tip-merge-window	2024-03-22 10:58:48.064400749 -0700
+++ b/Documentation/process/maintainer-tip.rst	2024-03-22 11:09:06.688554211 -0700
@@ -407,20 +407,20 @@ See :ref:`resend_reminders`.
 Merge window
 ^^^^^^^^^^^^
 
-Please do not expect large patch series to be handled during the merge
-window or even during the week before.  Such patches should be submitted in
-mergeable state *at* *least* a week before the merge window opens.
-Exceptions are made for bug fixes and *sometimes* for small standalone
-drivers for new hardware or minimally invasive patches for hardware
-enablement.
+Please do not expect patches to be reviewed or merged by tip
+maintainers around or during the merge window.  The trees are closed
+to all but urgent fixes during this time.  They reopen once the merge
+window closes and a new -rc1 kernel has been released.
+
+Large series should be submitted in mergeable state *at* *least* a week
+before the merge window opens.  Exceptions are made for bug fixes and
+*sometimes* for small standalone drivers for new hardware or minimally
+invasive patches for hardware enablement.
 
 During the merge window, the maintainers instead focus on following the
 upstream changes, fixing merge window fallout, collecting bug fixes, and
 allowing themselves a breath. Please respect that.
 
-The release candidate -rc1 is the starting point for new patches to be
-applied which are targeted for the next merge window.
-
 So called _urgent_ branches will be merged into mainline during the
 stabilization phase of each release.
 
_

