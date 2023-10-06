Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9162F7BAFCE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjJFAwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJFAvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:20 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5FF107
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:16 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1dd1db54d42so1011818fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553475; x=1697158275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=694cROjBX4OIAjPeqcWX3jQmtpcK+zvZ6QnLrkMQvzw=;
        b=MDXpoUmErwMi5IsJSbUQGRqTh569ELJQprCuu+7+prhpsktOkXVij5DHKi+4p11Zi4
         Hh45hFrJMCnot5Mo4itad8JTYXEX4cGWwy3ZX3RdGgqiQilENftz/gtskM2dGpVrDg6l
         6du4Sk+lsoo3BLnYgaZFf5PITWX6urbunJE7MRG4c7O4lHKeaYA0KjE3lSBgFvnyjOH2
         sPqcLy1ZpgsjYnV+c4BcgQNi4H0j/n3YuxTmWCPq9IsLTWzG6RxB/cjDwh/7VtlYR9wB
         D5mzfJ8qrV/k+aRi2y+qW9WmXMKFR/MUa5+wL7egprBsRkx7/1UbSMkuKsHfcKWKvc8g
         JuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553475; x=1697158275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=694cROjBX4OIAjPeqcWX3jQmtpcK+zvZ6QnLrkMQvzw=;
        b=JwU04L30WX50HB1XIRbz+YXfjTyZ2dLD2n5sV3RK/lK4UEmxr3K5t0hvvOl5iCtITA
         GDfSf46AczoHDwYg1dxerJ6Xz9e6q7nl4Y1Gm9NfKjhWuP031rbhoeoMTCVcXfRDEf+4
         Mf6FsLVD0SOgRMOCEtwv0JkyrMnIlEZ43sguWi2eA4QNnW9Rq9EnH7pHi4wOvwpxQ1WZ
         NvsCs+OaiU70fbBDU7AMYCnhV3sqPMG+UHuk4JQ4Yhs2iiDHMd8Fq8h+1+iAZ234nF1v
         r0YjcBTFniwCJV/3In73HhY9tZsCclcJaOHE5QRGcnP9+unEp7nbSXWHjBScnk16t9dQ
         HS5g==
X-Gm-Message-State: AOJu0Yz2h45fLLWGcDv5CzrJ5hELYMhLFV/Kek1oJo9LKeNeB1KFq5EB
        d1hKkH6KzysP3Y/MxHTZDALmKQ==
X-Google-Smtp-Source: AGHT+IFTWwdydsOLr5JLQZcSFArkRd3wlb2R0pk1X5gqz9FgWVbqkrdh9gTslILsB2FD6WKLARmMfA==
X-Received: by 2002:a05:6870:583:b0:1d0:d78b:982e with SMTP id m3-20020a056870058300b001d0d78b982emr8029343oap.35.1696553475710;
        Thu, 05 Oct 2023 17:51:15 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:15 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/17] staging: iio: resolver: ad2s1210: add register/fault support summary
Date:   Thu,  5 Oct 2023 19:50:31 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-14-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad2s1210 driver shoe-horns the register and fault support into IIO
events. The mapping between the registers/faults and the events is not
obvious. To save users from having to read the entire driver to figure
out how to use it, add a summary of the register/fault support to the
top of the file.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: New patch in v4.

 drivers/staging/iio/resolver/ad2s1210.c | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index d9d51bbbade8..51490fea1647 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -4,7 +4,47 @@
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
  * Copyright (c) 2023 BayLibre, SAS
+ *
+ * Device register to IIO ABI mapping:
+ *
+ * Register                    | Addr | IIO ABI (sysfs)
+ * ----------------------------|------|-------------------------------------------
+ * DOS Overrange Threshold     | 0x89 | events/in_altvoltage0_thresh_rising_value
+ * DOS Mismatch Threshold      | 0x8A | events/in_altvoltage0_mag_rising_value
+ * DOS Reset Maximum Threshold | 0x8B | events/in_altvoltage0_mag_rising_reset_max
+ * DOS Reset Minimum Threshold | 0x8C | events/in_altvoltage0_mag_rising_reset_min
+ * LOT High Threshold          | 0x8D | events/in_angl1_thresh_rising_value
+ * LOT Low Threshold [1]       | 0x8E | events/in_angl1_thresh_rising_hysteresis
+ * Excitation Frequency        | 0x91 | out_altvoltage0_frequency
+ * Control                     | 0x92 | *as bit fields*
+ *   Phase lock range          | D5   | events/in_phase0_mag_rising_value
+ *   Hysteresis                | D4   | in_angl0_hysteresis
+ *   Encoder resolution        | D3:2 | *not implemented*
+ *   Resolution                | D1:0 | *device tree: assigned-resolution-bits*
+ * Soft Reset                  | 0xF0 | [2]
+ * Fault                       | 0xFF | *not implemented*
+ *
+ * [1]: The value written to the LOT low register is high value minus the
+ * hysteresis.
+ * [2]: Soft reset is performed when `out_altvoltage0_frequency` is written.
+ *
+ * Fault to event mapping:
+ *
+ * Fault                                   |    | Channel     | Type   | Direction
+ * ----------------------------------------|----|---------------------------------
+ * Sine/cosine inputs clipped [3]          | D7 | altvoltage1 | mag    | either
+ * Sine/cosine inputs below LOS            | D6 | altvoltage0 | thresh | falling
+ * Sine/cosine inputs exceed DOS overrange | D5 | altvoltage0 | thresh | rising
+ * Sine/cosine inputs exceed DOS mismatch  | D4 | altvoltage0 | mag    | rising
+ * Tracking error exceeds LOT              | D3 | angl1       | thresh | rising
+ * Velocity exceeds maximum tracking rate  | D2 | anglvel0    | mag    | rising
+ * Phase error exceeds phase lock range    | D1 | phase0      | mag    | rising
+ * Configuration parity error              | D0 | *writes to kernel log*
+ *
+ * [3]: The chip does not differentiate between fault on sine vs. cosine so
+ * there will also be an event on the altvoltage2 channel.
  */
+
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>

-- 
2.42.0

