Return-Path: <linux-kernel+bounces-162311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665C78B5999
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E96B2BAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29F67D074;
	Mon, 29 Apr 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABQlV6pu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83197BAEC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395722; cv=none; b=AXgQG5KFKjUQUaUAjVqbZtlUSAgYz0nFAfXBCKx+nA/EQxlLZu2ztgKACAGbPBOqRiBxAXnrQlOy3ZaToQhXXRFKNOUjsHQZass44e4OkdlBuTlxmIJ16rTZReHsoARYI2LELbJv+2xfBRlM/UmusG79OuGYv3bC/XSYda85SBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395722; c=relaxed/simple;
	bh=J9FY2ipo2lxecD7Za9X7g2Z+V+7tNAF/Om/EeWGmizU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2Dd7DEa88ZeiF7gezNNN+EvKBCI0f/ihfItLdQiZKCmcNiqodXlCcS+cU91xodRQp3CV7Ac7T7T252FM11RxuSGr84Ke40U8cZTF/6BL88gpHoNL9aa00+sOJHH4Xrm7IoiP6HdR+Whmk03/5RXeLdhgrA2BcvXwA0Cq8Xf4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABQlV6pu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395720; x=1745931720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9FY2ipo2lxecD7Za9X7g2Z+V+7tNAF/Om/EeWGmizU=;
  b=ABQlV6puLPR2AmORjbZSM4lq+10339ZC7Wo0CJLncYPTHSelyOu8fwR7
   kKEReVLos74AFP8xs+JiBIh/gM/yiHQn8+Hr06kOmLAY7BXLaM3+4j1qV
   dAEl3C4GeFBNAIga/1VYRERHVfglGoGQMAHXhykGCzh5kjLiitFC6q/S0
   LaEMfGcR/9FgUpM+gk0KWnalx6NeSpvGqqrXAnFrJ6vnBU3QyuG9/7sD2
   DUssp60QXJG1AQXVDl0jEFVr9fxCupPz958gZZDUvxODpEFWwrkKubM/t
   sikR4fgh9QxNn1JZHPZbxICFd+7LLAup/Vu24zZHSxqwDYfkr7HnNIrGP
   w==;
X-CSE-ConnectionGUID: 5nRky0n7RxWKqRPi1A4n/Q==
X-CSE-MsgGUID: ydcx1ShFQG6SoqZwC/8eqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986922"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:02:00 -0700
X-CSE-ConnectionGUID: 8axicsZOTdCDJSKZh3PAGw==
X-CSE-MsgGUID: ZeMfmJgzRG21bEE/sR6SzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507132"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:57 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 09/15] intel_th: msu: Fix kernel-doc warnings
Date: Mon, 29 Apr 2024 16:01:13 +0300
Message-ID: <20240429130119.1518073-10-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
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


