Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C0D812291
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjLMXCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjLMXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:02:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678599;
        Wed, 13 Dec 2023 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702508557; x=1734044557;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E7M26yPTY6+vjqYd5Bj0fpUoHUYe+VEtT6WJdnLb2Gg=;
  b=QiA1c+ARNSf64K2IW/hpuCI7QIOjYBBUA0yJpBJekWk3BmcvqEh+5Z28
   GRi9e6Ys94QQJlED+G4ZxFRgR6wNVKrZ6oEgdG+eJMWIW0FHYOw0emN/S
   McjSKhevmG52Y9diI6CHc+0goSz8C3enhSWDI+jRDC/t4OQFijye3e/Q0
   0NTIZ9XWuPQuaFJyZdSDiLV5SlPV4e1RlNSjCLTkIoPmk70xAKkeBbv0l
   ZMyyfR/pRfKITk/u6MTd+OZwN0WuFfY6JvfwuIkN/lai7l1gWBF8eVgIk
   NMqzZUbYV8V9JySq/JDtTjwC0Cjl82FACN9UJZCwfXSxEn4dFhyUsYtYi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2210629"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2210629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:02:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="17692849"
Received: from wardsamx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.81.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:02:36 -0800
Subject: [PATCH] driver core: Add a guard() definition for the device_lock()
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Wed, 13 Dec 2023 15:02:35 -0800
Message-ID: <170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present there are ~200 usages of device_lock() in the kernel. Some of
those usages lead to "goto unlock;" patterns which have proven to be
error prone. Define a "device" guard() definition to allow for those to
be cleaned up and prevent new ones from appearing.

Link: http://lore.kernel.org/r/657897453dda8_269bd29492@dwillia2-mobl3.amr.corp.intel.com.notmuch
Link: http://lore.kernel.org/r/6577b0c2a02df_a04c5294bb@dwillia2-xfh.jf.intel.com.notmuch
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Greg,

I wonder if you might include this change in v6.7-rc to ease some patch
sets alternately going through my tree and Andrew's tree. Those
discussions are linked above. Alternately I can can just take it through
my tree with your ack and the other use case can circle back to it in
the v6.9 cycle.

I considered also defining a __free() helper similar to __free(mutex),
but I think "__free(device)" would be a surprising name for something
that drops a lock. Also, I like the syntax of guard(device) over
something like guard(device_lock) since a 'struct device *' is the
argument, not a lock type, but I'm open to your or Peter's thoughts on
the naming.

 include/linux/device.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index d7a72a8749ea..6c83294395ac 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1007,6 +1007,8 @@ static inline void device_unlock(struct device *dev)
 	mutex_unlock(&dev->mutex);
 }
 
+DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
+
 static inline void device_lock_assert(struct device *dev)
 {
 	lockdep_assert_held(&dev->mutex);

