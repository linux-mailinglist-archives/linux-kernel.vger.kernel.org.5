Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284127F3F22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKVHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjKVHog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:44:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B449C110;
        Tue, 21 Nov 2023 23:44:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-332ce3fa438so274227f8f.1;
        Tue, 21 Nov 2023 23:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700639070; x=1701243870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RMtf+nMXyr13s6ho7A/Kx++tkVNMl8kxvJFGLmfEYgY=;
        b=fBs7ai6n6hHAIj004BJA0tcG1Ez12jpTDJKIOCCrPVKCbSUBpb7qNk6OkwVtGEEYeC
         OX6wpe+muOMtZSN9SHxIBHEYvAk1KnmBhOdVat+HqGFExVY3ZfosbzU/uByakoEfQhdz
         H9u2CfG+y1vs/9Tp5yQSCSdRXVSzkKIBTTDuPFtxSeNb0IvJXP44O/Xjj2ktDawFxESJ
         jqLQLR3MeZJUOoeWIKaKdESXtoadw5A7EpIbZNNsUxvdNY3Cg91zC/IAqZ3fZmSfE5yA
         kf+/LMwqofu71sBgWqvOrXKCxGvTYNol/dBtN8l7Jqsj1s/vZbmfup1cUzTUmDSt9jsc
         8yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700639070; x=1701243870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMtf+nMXyr13s6ho7A/Kx++tkVNMl8kxvJFGLmfEYgY=;
        b=uOnSAPurzMR5p1P5+g+wWxdV941skUYw2cNKRNz454Q7G/EhGX0cbi877iffTWWMFW
         ESNXFt1BaXMAnkpso0bK4xHIHOySu9N2BIjnJVks2AL+jk8wIkpHpQ/KuxM7ebBDrOLK
         zwy2OTJTCBKyHSzefr/g6h8ryPDKXEj3iMQZsGCAaF5e5oRX78Z0dOouBg5sGU1+L8bD
         OHXZX6Ag640QYP9zOoh5pKPeqmUQymSwJ0Gt5/IJSbDjwemnyBemUxrVv2L9tdRNg410
         tRYVkpyN85SdhEvV98AykmesCfplYLwLtTJQFe0v9M63KsYWAoXCoFeSt3m1exrAt6Um
         21gA==
X-Gm-Message-State: AOJu0YxjgiJJUy1V4VPNBfen7NV9+lIN4wHodDANOhyz7gEWjEp+FwOB
        CgAB66ati97U8zM6c+wZk+N+47HuoZd+cA==
X-Google-Smtp-Source: AGHT+IHlIW5lsVEK6LR3m/SPcoGubIixSvLKvFGaGjv+v7e3uCub8ozqUSajfRNUoepVE1nNAxTNag==
X-Received: by 2002:a05:6000:1ac8:b0:32f:7502:fba9 with SMTP id i8-20020a0560001ac800b0032f7502fba9mr4566508wry.1.1700639069872;
        Tue, 21 Nov 2023 23:44:29 -0800 (PST)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600002a900b00332cb5185edsm6390475wry.14.2023.11.21.23.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 23:44:29 -0800 (PST)
From:   Sagi Maimon <maimon.sagi@gmail.com>
To:     richardcochran@gmail.com, reibax@gmail.com, davem@davemloft.net,
        rrameshbabu@nvidia.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maimon.sagi@gmail.com
Subject: [PATCH v1] ptp: add PTP_MULTI_CLOCK_GET ioctl
Date:   Wed, 22 Nov 2023 09:43:52 +0200
Message-Id: <20231122074352.473943-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        Some user space applications need to read some clocks.
        Each read requires moving from user space to kernel space.
        This asymmetry causes the measured offset to have a significant error.

        Introduce a new ioctl, which can be used to measure the offset between
        multiple clocks, from variety of types: PHC, virtual PHC and system time
        (CLOCK_REALTIME). The offset includes the total time that the driver needs
        to read the clock timestamp. Similar to the capability already introduced
        by PTP_SYS_OFFSET ioctl (read PHC and system clock), with flexibility
        regard clock types and number of required clocks.

        New ioctl allows the reading of a list of clocks - up to PTP_MAX_CLOCKS.
        Supported clocks IDs: PHC, virtual PHC and system time (CLOCK_REALTIME).
        Up to PTP_MAX_SAMPLES times (per clock) in a single ioctl read.
        The ioctl returns n_clocks timestamps for each measurement:
        - clock 0 timestamp or system time
        - ...
        - clock n timestamp or system time

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_chardev.c      | 38 +++++++++++++++++++++++++++++++++-
 include/linux/posix-clock.h    | 10 +++++++++
 include/uapi/linux/ptp_clock.h | 13 ++++++++++++
 kernel/time/posix-clock.c      |  6 ++++++
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 3f7a74788802..c5318f7c1f75 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -170,7 +170,9 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	struct ptp_clock_request req;
 	struct ptp_clock_caps caps;
 	struct ptp_clock_time *pct;
-	unsigned int i, pin_index;
+	struct ptp_multi_clock_get *multi_clk_get = NULL;
+
+	unsigned int i, pin_index, j;
 	struct ptp_pin_desc pd;
 	struct timespec64 ts;
 	int enable, err = 0;
@@ -491,6 +493,40 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 		set_bit(i, tsevq->mask);
 		break;
 
+	case PTP_MULTI_CLOCK_GET:
+		multi_clk_get = memdup_user((void __user *)arg, sizeof(*multi_clk_get));
+		if (IS_ERR(multi_clk_get)) {
+			err = PTR_ERR(multi_clk_get);
+			multi_clk_get = NULL;
+			break;
+		}
+		if (multi_clk_get->n_samples > PTP_MAX_SAMPLES) {
+			err = -EINVAL;
+			break;
+		}
+		if (multi_clk_get->n_clocks > PTP_MAX_CLOCKS) {
+			err = -EINVAL;
+			break;
+		}
+		for (j = 0; j < multi_clk_get->n_samples; j++) {
+			for (i = 0; i < multi_clk_get->n_clocks; i++) {
+				if (multi_clk_get->clkid_arr[i] == CLOCK_REALTIME) {
+					ktime_get_real_ts64(&ts);
+				} else {
+					err = pc_clock_gettime_wrapper(multi_clk_get->clkid_arr[i],
+								       &ts);
+					if (err)
+						goto out;
+				}
+				multi_clk_get->ts[j][i].sec = ts.tv_sec;
+				multi_clk_get->ts[j][i].nsec = ts.tv_nsec;
+			}
+		}
+		if (copy_to_user((void __user *)arg, multi_clk_get,
+				 sizeof(*multi_clk_get)))
+			err = -EFAULT;
+
+		break;
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f48920..dd88e8d8a66c 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -135,4 +135,14 @@ int posix_clock_register(struct posix_clock *clk, struct device *dev);
  */
 void posix_clock_unregister(struct posix_clock *clk);
 
+/**
+ * pc_clock_gettime_warrper() - retrieve time of a clock specified by clock ID
+ * @id: Clock ID.
+ * @ts: clock time stamp.
+ *
+ * Returns the current time of a clock specified by clock ID, errno in case of
+ * error
+ */
+int pc_clock_gettime_wrapper(clockid_t id, struct timespec64 *ts);
+
 #endif
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index da700999cad4..ef21cc97e9bf 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -165,6 +165,18 @@ struct ptp_sys_offset_precise {
 	unsigned int rsv[4];    /* Reserved for future use. */
 };
 
+#define PTP_MAX_CLOCKS 20 /* Maximum number of clocks */
+
+struct ptp_multi_clock_get {
+	unsigned int n_clocks; /* Desired number of clocks. */
+	unsigned int n_samples; /* Desired number of measurements per clock. */
+	clockid_t  clkid_arr[PTP_MAX_CLOCKS]; /* list of clock IDs */
+	/*
+	 * Array of list of n_clocks clocks time samples n_samples times.
+	 */
+	struct ptp_clock_time ts[PTP_MAX_SAMPLES][PTP_MAX_CLOCKS];
+};
+
 enum ptp_pin_function {
 	PTP_PF_NONE,
 	PTP_PF_EXTTS,
@@ -226,6 +238,7 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
 #define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
 #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
+#define PTP_MULTI_CLOCK_GET _IOWR(PTP_CLK_MAGIC, 21, struct ptp_multi_clock_get)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 9de66bbbb3d1..8df0ba79ebc2 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -284,6 +284,12 @@ static int pc_clock_gettime(clockid_t id, struct timespec64 *ts)
 	return err;
 }
 
+int pc_clock_gettime_wrapper(clockid_t id, struct timespec64 *ts)
+{
+	return pc_clock_gettime(id, ts);
+}
+EXPORT_SYMBOL_GPL(pc_clock_gettime_wrapper);
+
 static int pc_clock_getres(clockid_t id, struct timespec64 *ts)
 {
 	struct posix_clock_desc cd;
-- 
2.26.3

