Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A090B7EA217
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjKMRhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjKMRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:37:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B71727;
        Mon, 13 Nov 2023 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897060; x=1731433060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mw29f1QIt7U37r6p+V4Yyfpi9cV1+O/PtDoSzXpXBFY=;
  b=m8Gg+Anln4XxjOmcuK9xgdfYjKks8xW8B9k8uFXI0D2Ra045UEBnkGfZ
   HUnEOWvst4vy21zTnBnC44xC5sHR3fUycaEgbifUfwqH/Ayecqd5VLj6a
   UQ8ImBnkuEJdXwCoXalrMhy4cFs+USaXegFd7pj1bJpsOrAVw4xNHKf9+
   E8O+gCGQ43RZD+Wxqr7jWN93jTV76zKwulso3nnAX2OdSovZ2NJvXFbMy
   8oqplPaU1cUNXpJI4vbOlg/qtrUFmaLwqkueZzs8n2NNIAYX13fOGGpex
   SxEG6ltz5eGSm+KagYTU7jqYuwDSVAo7jdTnwhmLX8vK6GUfbDVlwf4wm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671566"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671566"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812670"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812670"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:36 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] s390/cio: rename bitmap_size() -> idset_bitmap_size()
Date:   Mon, 13 Nov 2023 18:37:11 +0100
Message-ID: <20231113173717.927056-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113173717.927056-1-aleksander.lobakin@intel.com>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_size() is a pretty generic name and one may want to use it for
a generic bitmap API function. At the same time, its logic is not
"generic", i.e. it's not just `nbits -> size of bitmap in bytes`
converter as it would be expected from its name.
Add the prefix 'idset_' used throughout the file where the function
resides.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
idset_new() really wants its vmalloc() + memset() pair to be replaced
with vzalloc().
---
 drivers/s390/cio/idset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 45f9c0736be4..0a1105a483bf 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -16,7 +16,7 @@ struct idset {
 	unsigned long bitmap[];
 };
 
-static inline unsigned long bitmap_size(int num_ssid, int num_id)
+static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
 {
 	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
 }
@@ -25,11 +25,12 @@ static struct idset *idset_new(int num_ssid, int num_id)
 {
 	struct idset *set;
 
-	set = vmalloc(sizeof(struct idset) + bitmap_size(num_ssid, num_id));
+	set = vmalloc(sizeof(struct idset) +
+		      idset_bitmap_size(num_ssid, num_id));
 	if (set) {
 		set->num_ssid = num_ssid;
 		set->num_id = num_id;
-		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
+		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
 	}
 	return set;
 }
@@ -41,7 +42,8 @@ void idset_free(struct idset *set)
 
 void idset_fill(struct idset *set)
 {
-	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
+	memset(set->bitmap, 0xff,
+	       idset_bitmap_size(set->num_ssid, set->num_id));
 }
 
 static inline void idset_add(struct idset *set, int ssid, int id)
-- 
2.41.0

