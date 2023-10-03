Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771507B5FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbjJCERU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbjJCERL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:17:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8FBB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:17:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a21c283542so8200027b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306626; x=1696911426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYq0uo4Y2Gfz3+tHCOAtr3XBow0LxI3rKbo8nyoJx34=;
        b=CF0TrnO8ODXXQxMLO0w0W8vDQlGw8ZPRStKeLzEqdnP5FM9GLXOs1lOAC4VZFJoI1M
         7ULmb4edrRabkakzGDHptpU2KUFPmy2WgAt026+jTDr+c4qI18AHkdqcw5PBaHXDBFfu
         Erw1k/qW4NJgMvw6neszxKga5cL/Azvc1Ww/sSqUsq09VcKn0d8TNE4qNcvwg8V7t7af
         Doc2IuNcziJPPnPRMDF0xS2NyWumX3Mv6KLgMk2zxBAmvjOo22ijb/4Z62KD+ZNJtueV
         9NsRQVIMqJ2JdtcCTzJoSenR++CDsTNPTc+MWAW9gegp9A+kAJNngAJtOUdur/PEgA7D
         3dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306626; x=1696911426;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYq0uo4Y2Gfz3+tHCOAtr3XBow0LxI3rKbo8nyoJx34=;
        b=gjLMaH8pDrE5dl0fndYe6aodXdsB3IAipXUNJ6TzU4kmcwDhtzAoKQqP5rEe0261Th
         AA8ztvE7GOHVljju7EF3+OaSzhWZ+cB8w6ntyEdeFrcxz4wJ48XSetZnQipxiMVWTHmO
         WLj6der0nbOJq4kmUsroT1AMeCFhkvsWBlBRxeQs2jTleKRogdypoz2xUcyHvlqnJv8z
         xqhSLn3VROfX6SmIA2Udy+x4iK48yCN/Pnygtd4bBPXKhjoJO2WYYSXyw36tNabn9A8b
         JurRyUXta01W3fTzQlsVHDVuJOgumbmdXJ0QTKB0RvqBAb2sVWoy/k9JIxH3skyPl/ZR
         w4aA==
X-Gm-Message-State: AOJu0YyBHBcEsFuiQqpSjHKcKfuorKZEgWwp+ODM3nHNRI7lxaxqamSm
        8sXo/AsGVNIhjWOmV3QU9A7wLErklvuZ
X-Google-Smtp-Source: AGHT+IGC0X7QovnW4gsRVEbo+jsI2T4w9x2kNqBi7zQkcFcnlkyZ8/QUK9c25Bvx/HsSn8VAHB3e5NWoSPgA
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a81:7611:0:b0:59b:eace:d465 with SMTP id
 r17-20020a817611000000b0059beaced465mr225387ywc.2.1696306626466; Mon, 02 Oct
 2023 21:17:06 -0700 (PDT)
Date:   Mon,  2 Oct 2023 21:17:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041704.1746303-1-maheshb@google.com>
Subject: [PATCHv2 next 2/3] ptp: add ioctl interface for ptp_gettimex64any()
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
        Richard Cochran <richardcochran@gmail.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add an ioctl op PTP_SYS_OFFSET_ANY2 to support ptp_gettimex64any() method

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
---
 drivers/ptp/ptp_chardev.c      | 34 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ptp_clock.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b7..fef1c7e7e6e6 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -110,6 +110,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 	struct ptp_sys_offset_extended *extoff = NULL;
+	struct ptp_sys_offset_any *anyoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
@@ -324,6 +325,39 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 			err = -EFAULT;
 		break;
 
+	case PTP_SYS_OFFSET_ANY2:
+		if (!ptp->info->gettimex64any) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		anyoff = memdup_user((void __user *)arg, sizeof(*anyoff));
+		if (IS_ERR(anyoff)) {
+			err = PTR_ERR(anyoff);
+			anyoff = NULL;
+			break;
+		}
+		if (anyoff->n_samples > PTP_MAX_SAMPLES
+		    || anyoff->ts_type >= PTP_TS_MAX
+		    || anyoff->rsv[0] || anyoff->rsv[1]) {
+			err = -EINVAL;
+			break;
+		}
+		for (i = 0; i < anyoff->n_samples; i++) {
+			err = ptp->info->gettimex64any(ptp->info, &ts, &sts,
+						       anyoff->ts_type);
+			if (err)
+				goto out;
+			anyoff->ts[i][0].sec = sts.pre_ts.tv_sec;
+			anyoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
+			anyoff->ts[i][1].sec = ts.tv_sec;
+			anyoff->ts[i][1].nsec = ts.tv_nsec;
+			anyoff->ts[i][2].sec = sts.post_ts.tv_sec;
+			anyoff->ts[i][2].nsec = sts.post_ts.tv_nsec;
+		}
+		if (copy_to_user((void __user *)arg, anyoff, sizeof(*anyoff)))
+			err = -EFAULT;
+		break;
+
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
 		sysoff = memdup_user((void __user *)arg, sizeof(*sysoff));
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index dc44e34f8146..b4e71e754b35 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -165,6 +165,18 @@ struct ptp_sys_offset_extended {
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
+struct ptp_sys_offset_any {
+	unsigned int n_samples;		/* Desired number of measurements. */
+	enum ptp_ts_types ts_type;	/* One of the TS types */
+	unsigned int rsv[2];		/* Reserved for future use. */
+	/*
+	 * Array of [TS, phc, TS] time stamps. The kernel will provide
+	 * 3*n_samples time stamps.
+	 * TS is any of the ts_type requested.
+	 */
+	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
+};
+
 struct ptp_sys_offset_precise {
 	struct ptp_clock_time device;
 	struct ptp_clock_time sys_realtime;
@@ -231,6 +243,8 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 17, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED2 \
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
+#define PTP_SYS_OFFSET_ANY2 \
+	_IOWR(PTP_CLK_MAGIC, 19, struct ptp_sys_offset_any)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
-- 
2.42.0.582.g8ccd20d70d-goog

