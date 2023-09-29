Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62A7B2A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjI2Chu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjI2Chp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:37:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01F11A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:37:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81c02bf2beso20635963276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695955063; x=1696559863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIHaxhAoJd7uqW2IBjHfoZybMFoN9LgbXxplOyXZzn8=;
        b=bPuh26LGYqk1JacugXDz8GvIhf08jQ7HS1VIUdM9HaKGEHRAcpwvsywdpmzStfaU6x
         6U3NMhmQbVR/6WqmE6qrnlbNlNz8l5HZuRchJBZe9gkp49ovHKQSDWKiVFjrylUSUBwY
         3kN5g1R5VusA3wPQKqWDCyCe33hHn7FPYsN54SxxPYWOxOGvEFitqzhMP5VpWLXq3psy
         BSmNlhFML0K2KLGEhlAgITBi3fPfyYew+H0Wj7fXKTToF792DZzkKHY7ANTUjQ3WfEZz
         Ok51cih6JuIJ1bkC7fnmeIvlGOqV79jtaPFBm18iv70t6jVOx53Zeb40nxQwAU0fR1TY
         xAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955063; x=1696559863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIHaxhAoJd7uqW2IBjHfoZybMFoN9LgbXxplOyXZzn8=;
        b=dJpG2amSFVhFTU3kC1qI7exBDQa1trap+ZFudtYHdu9kQyaod7XnZAQrF/7e3IuZZ3
         tk0mgjOAhqslwmrbiU5ZW6FbIHYIG/1SgCKU3Fe8Q1Lm/ZYBg0/b4e7vrVnr1yGctsE/
         jDEsFoqeBToOoHyr1mr5LTzz7a6HDkNqh0OhsTtZ6yLhmwHdFjU0Je5m7GWO198VKKWt
         EPkfsIwxIqrlggwgJoMajlYv2rCVv9K9HZytWl67FBSXQcm3/S/fRO9AGnlyP1fNvdT5
         sK+8bQi3/UZOcyfLn9Bx+tRJ1Jr2YeTrbeEFnWNCtIzmGW40xj40f+uJDXBHsJc7iXxy
         k8/A==
X-Gm-Message-State: AOJu0Ywg/akGbNV9q1ifnaShnKtvRtqjCbT1J3SUVZJnzGRVV8iUGS4m
        XevvRkWRVD88DiuPpxCSJBSYRDe5jJHI
X-Google-Smtp-Source: AGHT+IEf1Ys0iOiiWuTEzqwmd93QceZy824b+kpoVoMGTZ1j9BHorHAPDC1Gqx1O1ZgwJF04wu+0I4WHCms4
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:6902:136b:b0:d81:4107:7a1 with SMTP id
 bt11-20020a056902136b00b00d81410707a1mr40041ybb.2.1695955063070; Thu, 28 Sep
 2023 19:37:43 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:37:40 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929023740.1611161-1-maheshb@google.com>
Subject: [PATCH 2/4] ptp: add ptp_gettimex64any() support
From:   Mahesh Bandewar <maheshb@google.com>
To:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Mahesh Bandewar <maheshb@google.com>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for TS sandwich of the user preferred timebase. The options
supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
PTP_TS_RAW (CLOCK_MONOTONIC_RAW), PTP_TS_CYCLES (raw-cycles)

The option PTP_TS_CYCLES will return the cycles in 'struct timespec64'
format so something equivalent of timespec64_to_ns() need to be applied to
covert back into cycles.

Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
---
 include/linux/ptp_clock_kernel.h | 57 ++++++++++++++++++++++++++++++++
 include/uapi/linux/ptp_clock.h   |  8 +++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..87e75354d687 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -102,6 +102,15 @@ struct ptp_system_timestamp {
  *               reading the lowest bits of the PHC timestamp and the second
  *               reading immediately follows that.
  *
+ * @gettimex64any:  Reads the current time from the hardware clock and
+                 optionally also any of the MONO, MONO_RAW, or SYS clock.
+ *               parameter ts: Holds the PHC timestamp.
+ *               parameter sts: If not NULL, it holds a pair of timestamps from
+ *               the clock of choice. The first reading is made right before
+ *               reading the lowest bits of the PHC timestamp and the second
+ *               reading immediately follows that.
+ *               parameter type: any one of the TS opt from ptp_timestamp_types.
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
@@ -180,6 +189,9 @@ struct ptp_clock_info {
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			  struct ptp_system_timestamp *sts);
+	int (*gettimex64any)(struct ptp_clock_info *ptp, struct timespec64 *ts,
+			     struct ptp_system_timestamp *sts,
+			     enum ptp_ts_types type);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
@@ -464,4 +476,49 @@ static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 		ktime_get_real_ts64(&sts->post_ts);
 }
 
+static inline void ptp_read_any_prets(struct ptp_system_timestamp *sts,
+				      enum ptp_ts_types type)
+{
+	if (sts) {
+		switch (type) {
+		case PTP_TS_CYCLES:
+			ktime_get_cycles64(&sts->pre_ts);
+			break;
+		case PTP_TS_REAL:
+			ktime_get_real_ts64(&sts->pre_ts);
+			break;
+		case PTP_TS_MONO:
+			ktime_get_ts64(&sts->pre_ts);
+			break;
+		case PTP_TS_RAW:
+			ktime_get_raw_ts64(&sts->pre_ts);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static inline void ptp_read_any_postts(struct ptp_system_timestamp *sts,
+				       enum ptp_ts_types type)
+{
+	if (sts) {
+		switch (type) {
+		case PTP_TS_CYCLES:
+			ktime_get_cycles64(&sts->post_ts);
+			break;
+		case PTP_TS_REAL:
+			ktime_get_real_ts64(&sts->post_ts);
+			break;
+		case PTP_TS_MONO:
+			ktime_get_ts64(&sts->post_ts);
+			break;
+		case PTP_TS_RAW:
+			ktime_get_raw_ts64(&sts->post_ts);
+			break;
+		default:
+			break;
+		}
+	}
+}
 #endif
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 05cc35fc94ac..1f1e98966cff 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -69,6 +69,14 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
 
+enum ptp_ts_types {
+	PTP_TS_CYCLES = 0,
+	PTP_TS_REAL,
+	PTP_TS_MONO,
+	PTP_TS_RAW,
+	PTP_TS_MAX,
+};
+
 /*
  * struct ptp_clock_time - represents a time value
  *
-- 
2.42.0.582.g8ccd20d70d-goog

