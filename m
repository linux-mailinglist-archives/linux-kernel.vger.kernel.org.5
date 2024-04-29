Return-Path: <linux-kernel+bounces-162198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC2D8B5784
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25081C2230D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7D71734;
	Mon, 29 Apr 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khJtnEAt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343506EB6F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392572; cv=none; b=GAIFKwQ/cwz5OEkNU+aNLmak9Y5DVi+WCw3ampbI93cQqRaerZJwjGrGUKf69BOKVPtWJG2D2eVw2dTTlIZwfJSHjbmxWltsfIrep/2qxOmDZQkZM06krqp+YI828e8K2irrzPnAxgie+zm/YG+nU/KdzYoB0kgz0eVH7dmBZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392572; c=relaxed/simple;
	bh=J9FY2ipo2lxecD7Za9X7g2Z+V+7tNAF/Om/EeWGmizU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXRaU+M7+idtNEvTqaw76EzFfh2SEf4rQERQ6DtbzVXGjDDHGEGhxg4bk3sSJrz4YrMfgHUCrab0ULK8vv1JtPiR0jt9PNWAetBR1w4f77qrrWZDL1XqFEq5ZXz/9xiuKhjSEC/zZrdp4ZYcR62FzXh54ifvicCAyQ2mMtU6DCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khJtnEAt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392572; x=1745928572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9FY2ipo2lxecD7Za9X7g2Z+V+7tNAF/Om/EeWGmizU=;
  b=khJtnEAtHthfl/3lkymHwvT513Z5nnCeo5cG0cOzu7CDDbbke86GhGzy
   +g8Ass/Qy1ezwWiN/7fDyFHKhSO12WKca+6j9qZa6tu6qb4D/oFrNI7vk
   KYV1x6EuvA6cj2eLAgsChmX/7Zk2tCgnxv5j+h/NEB7bkoFIUUKafi3Xd
   J7n1SOs0l61DfdOtyerLFXr3BkkS5JAOVWTgsiu9VFmRrv+HoOYQ5c0vm
   9pDHLrm+A7r+NGIUOvBT8f5I0K7bEVqP33y1BZhYMxzT7f34P7ZvmHyLt
   KuBRzafuEyz402AdcLy1KqySvpsgQs3azSAxaxTuZc71o6+OTWDhVwMiQ
   g==;
X-CSE-ConnectionGUID: OEYvmlmbRtCGK+WImS+tpQ==
X-CSE-MsgGUID: lmeugz1hSaWFR77UpljEeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908267"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908267"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:31 -0700
X-CSE-ConnectionGUID: WchvvseIQnyeTacoQeFBfg==
X-CSE-MsgGUID: 7Bes899vR0Syg//Bed5mTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166640"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:29 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 08/14] intel_th: msu: Fix kernel-doc warnings
Date: Mon, 29 Apr 2024 15:09:02 +0300
Message-ID: <20240429120908.3723458-9-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

Correct function comments to prevent kernel-doc warnings
found when using "W=1".

msu.c:77: warning: Function parameter or member 'msc' not described in 'msc_window'
msu.c:122: warning: bad line:
msu.c:760: warning: No description found for return value of 'msc_configure'
msu.c:1309: warning: Function parameter or member 'nr_pages' not described in 'msc_buffer_alloc'
msu.c:1309: warning: Function parameter or member 'nr_wins' not described in 'msc_buffer_alloc'
msu.c:1309: warning: Excess function parameter 'size' description in 'msc_buffer_alloc'
msu.c:1376: warning: No description found for return value of 'msc_buffer_free_unless_used'
msu.c:1444: warning: No description found for return value of 'msc_win_to_user'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 9621efe0e95c..be63d5b8f193 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -61,6 +61,7 @@ enum lockout_state {
  * @lo_lock:	lockout state serialization
  * @nr_blocks:	number of blocks (pages) in this window
  * @nr_segs:	number of segments in this window (<= @nr_blocks)
+ * @msc:	pointer to the MSC device
  * @_sgt:	array of block descriptors
  * @sgt:	array of block descriptors
  */
@@ -119,7 +120,6 @@ struct msc_iter {
  * @user_count:		number of users of the buffer
  * @mmap_count:		number of mappings
  * @buf_mutex:		mutex to serialize access to buffer-related bits
-
  * @enabled:		MSC is enabled
  * @wrap:		wrapping is enabled
  * @mode:		MSC operating mode
@@ -755,6 +755,8 @@ static int msc_win_set_lockout(struct msc_window *win,
  * Program storage mode, wrapping, burst length and trace buffer address
  * into a given MSC. Then, enable tracing and set msc::enabled.
  * The latter is serialized on msc::buf_mutex, so make sure to hold it.
+ *
+ * Return:	%0 for success or a negative error code otherwise.
  */
 static int msc_configure(struct msc *msc)
 {
@@ -1291,7 +1293,8 @@ static void msc_buffer_free(struct msc *msc)
 /**
  * msc_buffer_alloc() - allocate a buffer for MSC
  * @msc:	MSC device
- * @size:	allocation size in bytes
+ * @nr_pages:	number of pages for each window
+ * @nr_wins:	number of windows
  *
  * Allocate a storage buffer for MSC, depending on the msc::mode, it will be
  * either done via msc_buffer_contig_alloc() for SINGLE operation mode or
@@ -1370,6 +1373,9 @@ static int msc_buffer_unlocked_free_unless_used(struct msc *msc)
  * @msc:	MSC device
  *
  * This is a locked version of msc_buffer_unlocked_free_unless_used().
+ *
+ * Return:	0 on successful deallocation or if there was no buffer to
+ *		deallocate, -EBUSY if there are active users.
  */
 static int msc_buffer_free_unless_used(struct msc *msc)
 {
@@ -1438,6 +1444,8 @@ struct msc_win_to_user_struct {
  * @data:	callback's private data
  * @src:	source buffer
  * @len:	amount of data to copy from the source buffer
+ *
+ * Return:	>= %0 for success or -errno for error.
  */
 static unsigned long msc_win_to_user(void *data, void *src, size_t len)
 {
-- 
2.43.0


