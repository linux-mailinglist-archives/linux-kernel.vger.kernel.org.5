Return-Path: <linux-kernel+bounces-166923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF28BA1F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5BA283DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD8C181CFC;
	Thu,  2 May 2024 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smkmEQwG"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63E1635DB
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684256; cv=none; b=FVMputu1xJwELLBZ6ZGNs3vthHtvlslfsbI2pOiRujGnVeh9ienfOXvKlGQ+mXRAOnPwY3to2toJj1er7yKd2yunwSR9kTdQxzYkSKz0I686AuOO5W3U2YNEQma5jbM48rbcYlHHBvrp7JLOimgaOlaEFJjYUcpEuaHcQ6Hyd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684256; c=relaxed/simple;
	bh=krIDpfVlHokKADsy8ABlAejvV7EDi/6npSNZcWjvN14=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rACuMwDyWIqLpWzyuFbIJ0xgRT8YTscmdAopMib8zYymFuRdUQhhgEnBryqXy5NV8eOIQHB2ptqqK/iRBsS6bz1AWd8TcFKXHivOYfK8e8eHGwncwRrfyad6qon27bvaw8R2tHUqFzswQLNfPKKkO7u+FnjhunDu+Wrjv3mkMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smkmEQwG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60cd96bf3so5303090276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714684252; x=1715289052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7oLpaeNuXcZtTtnpYpGqVfNwLvB3vnuoJ7noH+4jhl8=;
        b=smkmEQwG4wQ25pMEDSQZoVvHq4nZFI4KfFxV7XdeiARTHfX+FRtx9ai9g4Keiz3/jP
         S8qZ/qtf1PKednapdQJKbtKda6LNGtgyPH8XvUMypdGKqL5SFY1G0FOQZ9/kkb9N4swM
         YGmEDP2ilfps+kQIAvaMrXILdlnAGeGIcXGMk5deVSxtaqf39b5PtAQtk12uB6qNIYjF
         0U+8NpeLvdDtdqfmT/HSisB16Skv4nSsMVZbMyHGzWGTBCsfCLvNDBTnLoJXCKSWwlh5
         XGMs1DMtzF2gmmQW3lCjjB70GCYeE9tB+jHkFpXidoiZ4n0lL/kYrjupyisJ7lVvVfBs
         ug9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714684252; x=1715289052;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oLpaeNuXcZtTtnpYpGqVfNwLvB3vnuoJ7noH+4jhl8=;
        b=rSmTwJ/cL5oMhwfyLoSGExnh67ng+Vwj9zJSGxnt3v1FhgVgVykbThvahBm8QPEVXR
         4KAgsaNs8Re4VNNw5EHTw3Iw3Vql/8mO6hGUixO/Ja2euNfZhNP7kAEGPsdbb4EzQgZ7
         jmPzgvCSNwNEpzeq1NLn0eKmPEX+PGKaoIjfNqfeWnIGHGuHa6opkGeeQGRbx6z91C+O
         B9CJNGzONxidEaZdaK16MHuSM404cpwFdlj4GOyAjfCX3AKXxTwNAVmxwChQ3PzYbogt
         HEe89JeO7FrA4sIoVdMYPdnrgQfjO8Pmjy0O1WK1NUQp1r4Wf0KjzP55LT41sAl9rvG6
         8ZqA==
X-Forwarded-Encrypted: i=1; AJvYcCVKtWXrWmuRq98BB4FYbl5jijKE9jlYXeCSfSxfsFaVbBbRVAzz+wmHz6m2lf31fA+cI3OMudJzNiKVRgXMSklVCY7TQujvp/rGBtAV
X-Gm-Message-State: AOJu0YwjrPbFP4J8QEeaI4Ts6YMa6iN30wsV/6o80+3OrOEzPQAOoiYz
	+wpi2gwhS/zZmEBbIOqwr2Du9a9oQDQdGs1RZ5z25f3rA0BQ3flTFMNN6EW8OthWjiDyhAGGebi
	NkZAAXw==
X-Google-Smtp-Source: AGHT+IHiJeFJiz4vngM3WfTr5yZzY5ViWNwfjpxSlWiQz8BQkKUHngOgc/DpXbyyrPpBCPv6QpoQtjrCjlJC
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:6902:1505:b0:de5:9ecc:46b6 with SMTP
 id q5-20020a056902150500b00de59ecc46b6mr301723ybu.6.1714684252381; Thu, 02
 May 2024 14:10:52 -0700 (PDT)
Date: Thu,  2 May 2024 14:10:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240502211047.2240237-1-maheshb@google.com>
Subject: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps for PTP_SYS_OFFSET_EXTENDED
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Richard Cochran <richardcochran@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sagi Maimon <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

The ability to read the PHC (Physical Hardware Clock) alongside
multiple system clocks is currently dependent on the specific
hardware architecture. This limitation restricts the use of
PTP_SYS_OFFSET_PRECISE to certain hardware configurations.

The generic soultion which would work across all architectures
is to read the PHC along with the latency to perform PHC-read as
offered by PTP_SYS_OFFSET_EXTENDED which provides pre and post
timestamps.  However, these timestamps are currently limited
to the CLOCK_REALTIME timebase. Since CLOCK_REALTIME is affected
by NTP (or similar time synchronization services), it can
experience significant jumps forward or backward. This hinders
the precise latency measurements that PTP_SYS_OFFSET_EXTENDED
is designed to provide.

This problem could be addressed by supporting MONOTONIC_RAW
timestamps within PTP_SYS_OFFSET_EXTENDED. Unlike CLOCK_REALTIME
or CLOCK_MONOTONIC, the MONOTONIC_RAW timebase is unaffected
by NTP adjustments.

This enhancement can be implemented by utilizing one of the three
reserved words within the PTP_SYS_OFFSET_EXTENDED struct to pass
the clock-id for timestamps.  The current behavior aligns with
clock-id for CLOCK_REALTIME timebase (value of 0), ensuring
backward compatibility of the UAPI.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
---
v1 -> v2
   * Code-style fixes.
v2 -> v3
   * Reword commit log
   * Fix the compilation issue by using __kernel_clockid instead of clockid_t
     which has kernel only scope.
v3 -> v4
   * Typo/comment fixes.

 drivers/ptp/ptp_chardev.c        |  7 +++++--
 include/linux/ptp_clock_kernel.h | 30 ++++++++++++++++++++++++++----
 include/uapi/linux/ptp_clock.h   | 27 +++++++++++++++++++++------
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 7513018c9f9a..c109109c9e8e 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -358,11 +358,14 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 			extoff = NULL;
 			break;
 		}
-		if (extoff->n_samples > PTP_MAX_SAMPLES
-		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
+		if (extoff->n_samples > PTP_MAX_SAMPLES ||
+		    extoff->rsv[0] || extoff->rsv[1] ||
+		    (extoff->clockid != CLOCK_REALTIME &&
+		     extoff->clockid != CLOCK_MONOTONIC_RAW)) {
 			err = -EINVAL;
 			break;
 		}
+		sts.clockid = extoff->clockid;
 		for (i = 0; i < extoff->n_samples; i++) {
 			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
 			if (err)
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..74ded5f95d95 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -47,10 +47,12 @@ struct system_device_crosststamp;
  * struct ptp_system_timestamp - system time corresponding to a PHC timestamp
  * @pre_ts: system timestamp before capturing PHC
  * @post_ts: system timestamp after capturing PHC
+ * @clockid: clock-base used for capturing the system timestamps
  */
 struct ptp_system_timestamp {
 	struct timespec64 pre_ts;
 	struct timespec64 post_ts;
+	clockid_t clockid;
 };
 
 /**
@@ -457,14 +459,34 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
 
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
-	if (sts)
-		ktime_get_real_ts64(&sts->pre_ts);
+	if (sts) {
+		switch (sts->clockid) {
+		case CLOCK_REALTIME:
+			ktime_get_real_ts64(&sts->pre_ts);
+			break;
+		case CLOCK_MONOTONIC_RAW:
+			ktime_get_raw_ts64(&sts->pre_ts);
+			break;
+		default:
+			break;
+		}
+	}
 }
 
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
-	if (sts)
-		ktime_get_real_ts64(&sts->post_ts);
+	if (sts) {
+		switch (sts->clockid) {
+		case CLOCK_REALTIME:
+			ktime_get_real_ts64(&sts->post_ts);
+			break;
+		case CLOCK_MONOTONIC_RAW:
+			ktime_get_raw_ts64(&sts->post_ts);
+			break;
+		default:
+			break;
+		}
+	}
 }
 
 #endif
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 053b40d642de..5e3d70fbc499 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -155,13 +155,28 @@ struct ptp_sys_offset {
 	struct ptp_clock_time ts[2 * PTP_MAX_SAMPLES + 1];
 };
 
+/*
+ * ptp_sys_offset_extended - data structure for IOCTL operation
+ *			     PTP_SYS_OFFSET_EXTENDED
+ *
+ * @n_samples:	Desired number of measurements.
+ * @clockid:	clockid of a clock-base used for pre/post timestamps.
+ * @rsv:	Reserved for future use.
+ * @ts:		Array of samples in the form [pre-TS, PHC, post-TS]. The
+ *		kernel provides @n_samples.
+ *
+ * History:
+ * v1: Initial implementation.
+ *
+ * v2: Use the first word of the reserved-field for @clockid. That's
+ *     backward compatible since v1 expects all three reserved words
+ *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
+ *     CLOCK_REALTIME is '0'.
+ */
 struct ptp_sys_offset_extended {
-	unsigned int n_samples; /* Desired number of measurements. */
-	unsigned int rsv[3];    /* Reserved for future use. */
-	/*
-	 * Array of [system, phc, system] time stamps. The kernel will provide
-	 * 3*n_samples time stamps.
-	 */
+	unsigned int n_samples;
+	__kernel_clockid_t clockid;
+	unsigned int rsv[2];
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


