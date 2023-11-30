Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17AE7FE6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjK3CgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjK3CgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:36:04 -0500
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F5810CB;
        Wed, 29 Nov 2023 18:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2379; q=dns/txt; s=iport;
  t=1701311770; x=1702521370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aqgGUKGQBVUTfW7p4uxQ1YKLQ3kFd6K4NBe7f3cePAw=;
  b=AtWGu9iu2ki68EZ96tqrR1IMG8h/DZtMMzfCuIjnOBPIi8DEZ+cJHBgg
   l9OSxDEJqrzr5z8op9SUqWHT+WQkbI4ILswoQwy0oIyk7nh3TKsJyLKN3
   JxGZ54inL+HdJbq94Qx6uiCzoalKVeqkv3OD+3TmVjR5a2NMhWzUneCfp
   U=;
X-CSE-ConnectionGUID: MTGpEXbsTL+9/g75AfG7Ug==
X-CSE-MsgGUID: dlAFGFb1QQiO7oCkvfW+0w==
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="149776938"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:36:10 +0000
Received: from localhost.cisco.com ([10.193.101.253])
        (authenticated bits=0)
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3AU2YA4A007614
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Nov 2023 02:36:09 GMT
From:   Karan Tilak Kumar <kartilak@cisco.com>
To:     sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 08/13] scsi: fnic: Define stats to track multiqueue (MQ) IOs
Date:   Wed, 29 Nov 2023 18:33:57 -0800
Message-Id: <20231130023402.802282-9-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231130023402.802282-1-kartilak@cisco.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-9.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define an array to track IOs for the different queues,
print the IO stats in fnic get stats data.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic_stats.h |  2 ++
 drivers/scsi/fnic/fnic_trace.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/scsi/fnic/fnic_stats.h b/drivers/scsi/fnic/fnic_stats.h
index 07d1556e3c32..9d7f98c452dd 100644
--- a/drivers/scsi/fnic/fnic_stats.h
+++ b/drivers/scsi/fnic/fnic_stats.h
@@ -2,6 +2,7 @@
 /* Copyright 2013 Cisco Systems, Inc.  All rights reserved. */
 #ifndef _FNIC_STATS_H_
 #define _FNIC_STATS_H_
+#define FNIC_MQ_MAX_QUEUES 64
 
 struct stats_timestamps {
 	struct timespec64 last_reset_time;
@@ -26,6 +27,7 @@ struct io_path_stats {
 	atomic64_t io_btw_10000_to_30000_msec;
 	atomic64_t io_greater_than_30000_msec;
 	atomic64_t current_max_io_time;
+	atomic64_t ios[FNIC_MQ_MAX_QUEUES];
 };
 
 struct abort_stats {
diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index be0d7c57b242..aaa4ea02fb7c 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -204,6 +204,7 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
 	int len = 0;
 	int buf_size = debug->buf_size;
 	struct timespec64 val1, val2;
+	int i = 0;
 
 	ktime_get_real_ts64(&val1);
 	len = scnprintf(debug->debug_buffer + len, buf_size - len,
@@ -266,6 +267,16 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
 		  (u64)atomic64_read(&stats->io_stats.io_btw_10000_to_30000_msec),
 		  (u64)atomic64_read(&stats->io_stats.io_greater_than_30000_msec));
 
+	len += scnprintf(debug->debug_buffer + len, buf_size - len,
+			"------------------------------------------\n"
+			"\t\tIO Queues and cumulative IOs\n"
+			"------------------------------------------\n");
+
+	for (i = 0; i < FNIC_MQ_MAX_QUEUES; i++) {
+		len += scnprintf(debug->debug_buffer + len, buf_size - len,
+				"Q:%d -> %lld\n", i, (u64)atomic64_read(&stats->io_stats.ios[i]));
+	}
+
 	len += scnprintf(debug->debug_buffer + len, buf_size - len,
 		  "\nCurrent Max IO time : %lld\n",
 		  (u64)atomic64_read(&stats->io_stats.current_max_io_time));
-- 
2.31.1

