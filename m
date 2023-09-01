Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A678FF48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbjIAOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350023AbjIAOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:35:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A912F18C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693578911; x=1725114911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKT+ykQbNHS9+8Gbke64yJMsbr+GQH6JTNZUp4MCMeM=;
  b=KGtrmlwvboDr+AntVxPzQ8gIvX3MJd5wclLqPgVPDmNcRQ3M6kaXWbIZ
   3oSqR5K1Ag9xJc+jzZR5ogw7L0Tt6QiJpN+xcF90Arr+pt1x+0rfaff5C
   sNkh5uGe/U75Kic0tz4Ja6K2ImQjNs53kudWDhh07I1LQX4H+VgF7tpjv
   0G4WX5DGnAUq0hG4wfSiv50U86l9gcUY8SXs74L3u/m01/Hi0/hcfsE0w
   DTZXAkuPKzY2cWXV0/CR7VMkBfKVLHsPzs/qCxJL20laW6WytDy7BREiX
   zrH7zDawXJkMg9SbJ7G2z9NKQs+NW+bqAaXwEMFzF1B0a7ZKpCqd1fxBC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373627551"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373627551"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 07:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805450069"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="805450069"
Received: from sunyi-station.sh.intel.com (HELO ysun46-mobl.sh.intel.com) ([10.239.159.10])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2023 07:35:06 -0700
From:   Yi Sun <yi.sun@intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, dave.hansen@linux.intel.com,
        yi.sun@intel.intel.com, Yi Sun <yi.sun@intel.com>
Subject: [PATCH v6 3/3] tools/testing/fpu: Add a 'count' column.
Date:   Fri,  1 Sep 2023 22:34:14 +0800
Message-Id: <20230901143414.1664368-4-yi.sun@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901143414.1664368-1-yi.sun@intel.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the total number of each combination of event-RFBM-XINUSE. Users can
identify which data is noise and focus more on useful data.

The sample of the output is as follows:
EVENTs         RFBM     XINUSE   CNT     min   max   avg   avg(97%)
---...-------  -------  -------  ------  ----  ----  ----  --------
x86..._xrstor  0x20ee7  0x0      1       xx    xx    xx    xx
x86..._xrstor  0x20ee7  0x2a2    997860  xx    xxx   xx    xx
x86..._xsave   0x20ee7  0x2a2    45      xx    xx    xx    xx
x86..._xsave   0x20ee7  0x2e6    146613  xx    xxxx  xx    xx
x86..._xsave   0x20ee7  0x202a2  31555   xx    xxx   xx    xx
x86..._xsave   0x60ee7  0x602a2  818608  xx    xxxx  xx    xx
x86..._xsave   0x60ee7  0x602a3  1       xx    xx    xx    xx

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

