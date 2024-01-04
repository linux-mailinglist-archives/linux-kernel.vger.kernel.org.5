Return-Path: <linux-kernel+bounces-17235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B4A824A41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0825288007
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF52C6A1;
	Thu,  4 Jan 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LotKH7lg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E32C856
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e617562a65so20302087b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704403479; x=1705008279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3EcDyhJpXfuqwObCE0OlLjCVuMesE+JcrTbbaHS7TvA=;
        b=LotKH7lgllB4kBU5B5E+oVZQl97UZumqcsTNzKaAycUxfsJBWL0Qe6PawMZ96UUYjx
         83Zbglq/FID45oO/tQbsB35VDrlu5ZTIfaHO7YQgoz+yebbbOpJXZh98lwLRZA0qiA/G
         QmqWZaIZN784CcZO9BE77GrsGta+VG4GFQix6z/tenaWdm5+wKEKvC7boPdWjbci14Xs
         acdsVbIf3ZcsqLb4E35MojRUjjFicmsJF97rpfP+cX+nB0r87fZyXDb4EYSxX7WpZ67B
         XAxUKEEILStPAF61yU0Top6xba12ZrN27HFX36A0GB9Ucngjdh02GAxMNlThCnawamtg
         Hsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403479; x=1705008279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EcDyhJpXfuqwObCE0OlLjCVuMesE+JcrTbbaHS7TvA=;
        b=XPy3RuixbfyrHI5fmg3UTqXVOIrpG3S/9P3Ak9wc5/Leysph5upavlGr6jVLeoIkiC
         P9ToGXNDEQ24OI1TCi3QbjMk5bIytsaaqYQ4VOeKaEZXT8UC3J6/JYzKAvkkHg5Ug/kJ
         yBE4+SUM97RZ73bBpx6j+bUYSa50q9JxCVQGmp05AsR1SuUHGoX+0IUi3qK5Wfr3jKIk
         +1yoARX+jmuEkyuGwkmxxm9xQDzz4N62NuUSXkDYCk63XjUn7WFaCibBat8uuWEQY37V
         C6xjxZBXIrNVTI2vdujhBgyuXD4sInASU2KlibxW+ONckmF9PiS/sSlv+gmpcCamSjvC
         9tVQ==
X-Gm-Message-State: AOJu0YzHiLNVkOu38K2GNEaQNbf4OosVnB+o3j37TkTGt+m6T13s5FMl
	dW5F2H92wUuebQmVpsZFEHZAzVeRo0NKE+J/QJA=
X-Google-Smtp-Source: AGHT+IFyGuvvGsK4MYW1STDNxBXNcWnNz2TEZSC2WyHSKJfWvjhnBymy4PreKpmWN+Yt326Lq1gIuzLNjad2
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:690c:3389:b0:5e5:c7de:e7ac with SMTP
 id fl9-20020a05690c338900b005e5c7dee7acmr598138ywb.1.1704403479494; Thu, 04
 Jan 2024 13:24:39 -0800 (PST)
Date: Thu,  4 Jan 2024 13:24:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Message-ID: <20240104212436.3276057-1-maheshb@google.com>
Subject: [PATCHv3 net-next 1/3] ptp: add new method ptp_gettimex64any()
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

The current method that gets pre/post timestamps for PHC-read
supports only CLOCK_REALTIME timebase while most of the systems
have their clock disciplined by NTP service. There are applications
that can benefit from pre/post timestamps that are not changing
or have different timebases.

This patch adds the new API ptp_gettimex64any() which allows user
to specify the timebase for these pre/post timestamps.  The options
supported are CLOCK_REALTIME, CLOCK_MONOTONIC, and CLOCK_MONOTONIC_RAW

Option of CLOCK_REALTIME is equivalent to using ptp_gettimex64().

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: John Stultz <jstultz@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: "Willem de Bruijn" <willemb@google.com>
CC: netdev@vger.kernel.org
---
 include/linux/ptp_clock_kernel.h | 50 ++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..b1316d82721a 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -102,6 +102,17 @@ struct ptp_system_timestamp {
  *               reading the lowest bits of the PHC timestamp and the second
  *               reading immediately follows that.
  *
+ * @gettimex64any: Reads the current time from the hardware clock and
+ *                 optionally also any of the MONO, MONO_RAW, or SYS clock
+ *                 parameter ts: Holds the PHC timestamp.
+ *                 parameter sts: If not NULL, it holds a pair of
+ *                 timestamps from the clock of choice. The first reading
+ *                 is made right before reading the lowest bits of the
+ *                 PHC timestamp and the second reading immediately
+ *                 follows that.
+ *                 parameter clkid: any one of the supported clockids
+ *                 (CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW)
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
@@ -180,6 +191,10 @@ struct ptp_clock_info {
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			  struct ptp_system_timestamp *sts);
+	int (*gettimex64any)(struct ptp_clock_info *ptp,
+			     struct timespec64 *ts,
+			     struct ptp_system_timestamp *sts,
+			     clockid_t clockid);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
@@ -452,16 +467,47 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
 
 #endif
 
+static inline void ptp_read_any_ts64(struct timespec64 *ts,
+				     clockid_t clkid)
+{
+	switch (clkid) {
+	case CLOCK_REALTIME:
+		ktime_get_real_ts64(ts);
+		break;
+	case CLOCK_MONOTONIC:
+		ktime_get_ts64(ts);
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		ktime_get_raw_ts64(ts);
+		break;
+	default:
+		break;
+	}
+}
+
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_real_ts64(&sts->pre_ts);
+		ptp_read_any_ts64(&sts->pre_ts, CLOCK_REALTIME);
 }
 
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_real_ts64(&sts->post_ts);
+		ptp_read_any_ts64(&sts->pre_ts, CLOCK_REALTIME);
 }
 
+static inline void ptp_read_any_prets(struct ptp_system_timestamp *sts,
+				      clockid_t clkid)
+{
+	if (sts)
+		ptp_read_any_ts64(&sts->pre_ts, clkid);
+}
+
+static inline void ptp_read_any_postts(struct ptp_system_timestamp *sts,
+				       clockid_t clkid)
+{
+	if (sts)
+		ptp_read_any_ts64(&sts->post_ts, clkid);
+}
 #endif
-- 
2.43.0.195.gebba966016-goog


