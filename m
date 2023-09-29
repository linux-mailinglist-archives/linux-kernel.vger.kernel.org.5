Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B17B2A59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjI2Chr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2Chm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:37:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDC1A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:37:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc6261ffso20430729276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695955060; x=1696559860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iULIiWyEAnuPU2ttI+NrM06ywk49WbVfQ4RXn/AgPAM=;
        b=vFsFeWoJZreuLuRPnNzfBGFbw7QPBxRitWxuF/J/pmWEcfCLcryiN8AYKZ2uWDBcmm
         sFmNiF00AU5Zwn6N4pj3fZBz7HIFV9yojk/6iYuwsaE2NwTDhMwAtVPeN3wnXESsJoWH
         N3GDqXUEh4qHIJBi4YBCo9vKiqkd4Uipzj9CmkAbtNpylMc6VHOdB0dynDnxfpdHtx/L
         UuzmWP95AUZaZZbvOlxgc4kMogParp9EKIymf9ir+bqyiVi9ObypLr0TxhnEy4+A7gXn
         sqDjBs5iXZwU8ntaT09NF9NOU8VGyBIyRV+8Br+rbfjcCy03Gfbv2LRyayapTHV2Yf9p
         vHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955060; x=1696559860;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iULIiWyEAnuPU2ttI+NrM06ywk49WbVfQ4RXn/AgPAM=;
        b=pvmoVc0nHg8TVWpdih6EfqSTHWvJVil7ER6Bdb4qBMttWoOhm8+0BdeEV5zXnBENnX
         14rOQ7I+w64g8aC8EdnATMbYQNNaTRuMF6zuN5eMQkF94sBwK4MPiRoAb8bi3NAxwfvk
         EwGnsIiCsMxWBDAude+Vx6wRYF7YyB5Nb5Mct1YcsClEyGJ5RFiK2pu+HnZHu7byWMb4
         eDOya0AQQ1by20gRaM7CfYgDhwIEhiXVrJla5QitW6RAuUm/sOD2qt0iTd8q1QYvRxoC
         GehmtSxFXPiU/xQER/6UvsPaiL0zogttfmgaTwj7kTtis7LbPFInHObIyPDih2i4sU53
         iE5A==
X-Gm-Message-State: AOJu0YylcRL/UGQGhUcMDrYtWIJLWv2eRghmavGP4PoiWsNInaDADdax
        gIav6NVzDCUmZ8B93hQOP55OSGnHpNi4
X-Google-Smtp-Source: AGHT+IF2UHiH6MYgJLyQsGuGuNbtJkhEi9ISCxSd9hNIt5Rms531nuclGSwkAHF9z6nkcArPAwGZzrrkT3Yr
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a25:6812:0:b0:d13:856b:c10a with SMTP id
 d18-20020a256812000000b00d13856bc10amr38603ybc.3.1695955060095; Thu, 28 Sep
 2023 19:37:40 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:37:37 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929023737.1610865-1-maheshb@google.com>
Subject: [PATCH 1/4] time: add ktime_get_cycles64() api
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
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
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

add a method to retrieve raw cycles in the same fashion as there are
ktime_get_* methods available for supported time-bases. The method
continues using the 'struct timespec64' since the UAPI uses 'struct
ptp_clock_time'.

The caller can perform operation equivalent of timespec64_to_ns() to
retrieve raw-cycles value. The precision loss because of this conversion
should be none for 64 bit cycle counters and nominal at 96 bit counters
(considering UAPI of s64 + u32 of 'struct ptp_clock_time).

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: John Stultz <jstultz@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/linux/timekeeping.h |  1 +
 kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..5537700ad113 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -43,6 +43,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+extern void ktime_get_cycles64(struct timespec64 *ts);
 
 void getboottime64(struct timespec64 *ts);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..35d603d21bd5 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -989,6 +989,30 @@ void ktime_get_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(ktime_get_ts64);
 
+/**
+ * ktime_get_cycles64 - get the raw clock cycles in timespec64 format
+ * @ts:		pointer to timespec variable
+ *
+ * This function converts the raw clock cycles into timespce64 format
+ * in the varibale pointed to by @ts
+ */
+void ktime_get_cycles64(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 now;
+
+	WARN_ON_ONCE(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		now = tk_clock_read(&tk->tkr_mono);
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	*ts = ns_to_timespec64(now);
+}
+EXPORT_SYMBOL_GPL(ktime_get_cycles64);
+
 /**
  * ktime_get_seconds - Get the seconds portion of CLOCK_MONOTONIC
  *
-- 
2.42.0.582.g8ccd20d70d-goog

