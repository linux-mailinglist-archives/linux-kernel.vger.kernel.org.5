Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8870B7B5FBB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjJCERP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjJCERI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:17:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9694C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:17:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a23fed55d7so8469157b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306624; x=1696911424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aGh7NZY3G/0+YsZGvHoKe2ZjMznUVNFroVuVfb1sCeU=;
        b=4DxFbGdLAcLEZW/nYnlExMyot3rLmOaPvn16YQb3HxUjP9JiEkA/Wtfyphh3w4FzBX
         4po+XgWtuyIWaxUjkxMl+xRl0Bln9kmA5jojlOldippa0aR6tBBAUY9ypxxYicd75z2L
         bvTpFhp0RZ7bD+p7QuB6nf+WSWZNDvOG65KaDkW1AW69YdKJe5LqnKzYf6HEwqTTqxC9
         c4dtQcIpmLhmQ0fv6+ZRO3zwUM+xSeI1k/W5xYa7qseFYZANq4g6NVYgYhq5VSpDDFdt
         oSyvZuTw4P5LclTmLUUNpsy8LFaH0cV05ED6Q9YhOOWGSFjvcSdBpz0yQquKWzni8Wac
         SigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306624; x=1696911424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGh7NZY3G/0+YsZGvHoKe2ZjMznUVNFroVuVfb1sCeU=;
        b=vZ5Kwo5fpeFbpTx/bl57DINntyh1BWZgUu1R75XG/ag9rZlrPGMxdMK7IObaUz+Hz5
         aQjrUoygPee/ww375xFZpB5h2aSIUBppNL5ellb4ozqcaxZwMR6IwvHaUHdNELNlupbp
         clBxTOUIL88ln27UEj5M3Rmpd1UnrkiHUMXFfEeN8CH0BccgEIzaUou1ezZTn4yTXmGN
         6FvtRZSZm0s7VQUuqbbM8g638hoPy9YQI47gf9emtI8wzf1khNzvWCkIchFLhE35sint
         hbnVKRo/Zc9halcpTjYCJC/OiiFAAwaU3OISUjtno+8c1G1u6ZqL6IiIDFkbu+8QW2gn
         ciSA==
X-Gm-Message-State: AOJu0YxQRrHTyoPy0Amj5RI/kET4PZaVs2GL9RFhFnJsvRWMLDA4mlug
        Drx8B5rBKprA+Cu0lArwsYR1TdUkqygH
X-Google-Smtp-Source: AGHT+IFbk7fg0MfySoTbN9JFW98cBRoCCraNT8L733mRlsZTKHztkNB7g7HHmIW1/cNnkcpT656oF4V+5E57
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a81:ca41:0:b0:59b:e684:3c76 with SMTP id
 y1-20020a81ca41000000b0059be6843c76mr215109ywk.2.1696306623933; Mon, 02 Oct
 2023 21:17:03 -0700 (PDT)
Date:   Mon,  2 Oct 2023 21:17:01 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041701.1745953-1-maheshb@google.com>
Subject: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
From:   Mahesh Bandewar <maheshb@google.com>
To:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Mahesh Bandewar <maheshb@google.com>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add support for TS sandwich of the user preferred timebase. The options
supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)

Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
---
 include/linux/ptp_clock_kernel.h | 51 ++++++++++++++++++++++++++++++++
 include/uapi/linux/ptp_clock.h   |  7 +++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..fd7be98e7bba 100644
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
@@ -464,4 +476,43 @@ static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 		ktime_get_real_ts64(&sts->post_ts);
 }
 
+static inline void ptp_read_any_prets(struct ptp_system_timestamp *sts,
+				      enum ptp_ts_types type)
+{
+	if (sts) {
+		switch (type) {
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
index 05cc35fc94ac..dc44e34f8146 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -69,6 +69,13 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
 
+enum ptp_ts_types {
+	PTP_TS_REAL = 0,
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

