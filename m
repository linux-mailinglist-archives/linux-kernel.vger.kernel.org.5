Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884ED7AA0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjIUUrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjIUUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:47:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC990F12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318443; x=1726854443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Msw4IpRBg5UAkrhphCxUeE+v0uEt43SFzf7qsAETac8=;
  b=NG8MsCT0CuXvoVHZ+9KL0gg6AOAYvwolup45XBRBSqoYV0st3LGCHtr/
   VPdcfHee+obsOLBG4+Asj21FQQ3wZ+1awC5EnQJc7bxvF8/sSsaZup15N
   db1C3giANs7HaDS5BM/onXBsPKOZB7jWSdcHQ7DA7Gp0ZDFQzNqECG1NI
   Y2H6teq0mUfXgWl0qCJrvVM1C9NEmQPfLl84gQXwu4DvYxN1HBqfdyfLQ
   Kk9jRLYXA8PVc9DV72mqPTUyEIPBQCIUr/yf+iZx9FZL++QaKvzZPnBSY
   Ssinz2nmxRgBMvrAnLwIX0ITd5syNtsiLzaFboOiWFWuFzxfZEEdM94cN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377729757"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="377729757"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 23:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="920606351"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="920606351"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2023 23:30:00 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, yi.sun@linux.intel.com, yu.c.chen@intel.com,
        Yi Sun <yi.sun@intel.com>
Subject: [PATCH v7 3/3] tools/testing/fpu: Add a 'count' column.
Date:   Thu, 21 Sep 2023 14:29:00 +0800
Message-Id: <20230921062900.864679-4-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921062900.864679-1-yi.sun@intel.com>
References: <20230921062900.864679-1-yi.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the total number of each combination of event-RFBM-XINUSE. Users can
identify which data is noise and focus more on useful data.

Signed-off-by: Yi Sun <yi.sun@intel.com>

diff --git a/tools/testing/fpu/xsave-latency-trace.sh b/tools/testing/fpu/xsave-latency-trace.sh
index d45563984fd6..b2f7c3d0dd65 100755
--- a/tools/testing/fpu/xsave-latency-trace.sh
+++ b/tools/testing/fpu/xsave-latency-trace.sh
@@ -99,11 +99,14 @@ function insert_line() {
 
 # Show the results of the trace statistics
 function get_latency_stat() {
+	cnt=`get_combs_cnt`
+
 	SQL_CMD "create table $table_results (
 		id INTEGER PRIMARY KEY AUTOINCREMENT,
 		event_name TEXT,
 		RFBM INT,
 		XINUSE INT,
+		CNT INT,
 		lat_min INT,
 		lat_max INT,
 		lat_avg INT,
@@ -121,14 +124,18 @@ function get_latency_stat() {
 		lat_avg=`round $lat_avg`
 		lat_tail_avg=`round $lat_tail_avg`
 
+		count=`SQL_CMD "SELECT count(*) from $table_raw
+			where event_name=\"$event_name\" and RFBM=$RFBM and
+			XINUSE=$XINUSE;"`
+
 		SQL_CMD "INSERT INTO $table_results
-			(event_name, RFBM,XINUSE, lat_min, lat_max, lat_avg, lat_tail_avg)
-			VALUES (\"$event_name\", $RFBM, $XINUSE, $lat_min, $lat_max,
+			(event_name,RFBM,XINUSE, CNT, lat_min, lat_max, lat_avg, lat_tail_avg)
+			VALUES (\"$event_name\", $RFBM, $XINUSE, $count, $lat_min, $lat_max,
 			$lat_avg, $lat_tail_avg);"
 	done
 
 	SQL_CMD_HEADER "select event_name[EVENTs],printf('0x%x',RFBM)[RFBM],
-			printf('0x%x',XINUSE)[XINUSE],lat_min,lat_max,lat_avg,
+			printf('0x%x',XINUSE)[XINUSE],CNT,lat_min,lat_max,lat_avg,
 			lat_tail_avg[lat_avg(97%)]
 			from $table_results;"
 }
-- 
2.34.1

