Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA77B38E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjI2R06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbjI2R0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:22 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3F3171A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:08 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c63588b554so969973a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008367; x=1696613167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OIko2VEB5nAyTulOY98c2fJMS8MyLj5LBT+8EJliTE=;
        b=uDwfI9bK5peAeMnIANey7TuPdPH2kwgahpBGpVPU0q+4zxHzDxh3vXa+VnNdfPEZs/
         fkUiPok7E+Z//R5LD9haXGT09CLLtVlwkIYP2CBNo8q9Zqz4qHFu7WDaEnRZENo8xbe8
         226clGwDHUb69X6oTNLbjwHLGILtPkcMtjsMKmTVCZ8y+zame2IXffYE6G3Sk5dBiWyP
         paWl7pas5pXN6UcuIKPyCxpg5pJ+PnmKzaWDkVMTus6/VrV8kSt9xQmNGVtFs+jF2LkA
         9Ocy4BJVT/wk2KcfPVhwKvISPpOY5od5X6c3vMSnkoBJgv/HBL0iWlUaOoCK4KO6QJbD
         4uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008367; x=1696613167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OIko2VEB5nAyTulOY98c2fJMS8MyLj5LBT+8EJliTE=;
        b=kA61U+PYVLXjyOul6TTaM72GUcCeycxy2mFl8p98ixK5Fz8Ho7Kb1/AkiQVI6RsuLl
         Dz84SudKQHj2Q77NQIlKLWhm3PsVecEfGwIR5HuxA4OzTKRoTNM0y77aIB2/YuFdT7L5
         5l2LWRLvL6Hr2CscTXdZ20jOSwAslvQUGx7GyFJPsbUKelP7taGowaYv2PSWTZWRPUbn
         orFaEc0wNjSkFoqKBz8m+r6dpBgHRCqndacxJCTkrRew0203zFV/RjVU5suNA4XjexS3
         rOsaddZSDMZVAcLihseWXacpDojmZYDpjdlPFGLxx1NdiBjV7kZjCwNkD6ttgk4Btdfl
         eD9A==
X-Gm-Message-State: AOJu0YzlgXSoYqNDoW2anr1ZRS+0rm+R9WPUWxD6DgiIVf2e/sv7ZrhB
        vvJhtjkLRso4oXNZ5EMMghy85K7kvXJrILiUTzCxXg==
X-Google-Smtp-Source: AGHT+IHTEaVTYh4HKw2eTk3iwn4k3aJ3xEvVUYXL3bv/BfLYpVM3D+/eYIoo0BxU7JlfwzagPveJGw==
X-Received: by 2002:a9d:624b:0:b0:6bd:9fa:34ff with SMTP id i11-20020a9d624b000000b006bd09fa34ffmr4760967otk.9.1696008367691;
        Fri, 29 Sep 2023 10:26:07 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:07 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 23/27] staging: iio: resolver: ad2s1210: convert DOS overrange threshold to event attr
Date:   Fri, 29 Sep 2023 12:23:28 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-23-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

The AD2S1210 has a programmable threshold for the degradation of signal
(DOS) overrange fault. This fault is triggered when either the sine or
cosine input rises the threshold voltage.

This patch converts the custom device DOS overrange threshold attribute
to an event rising edge threshold attribute on the monitor signal
channel.

The attribute now uses millivolts instead of the raw register value in
accordance with the IIO ABI.

Emitting the event will be implemented in a later patch.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes: This is a new patch in v3

 drivers/staging/iio/resolver/ad2s1210.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 7abbc184c351..66def9f1dd1b 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -743,9 +743,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
-static IIO_DEVICE_ATTR(dos_ovr_thrd, 0644,
-		       ad2s1210_show_reg, ad2s1210_store_reg,
-		       AD2S1210_REG_DOS_OVR_THRD);
 static IIO_DEVICE_ATTR(dos_mis_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_MIS_THRD);
@@ -787,6 +784,13 @@ static const struct iio_event_spec ad2s1210_monitor_signal_event_spec[] = {
 		/* Loss of signal threshold. */
 		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* Sine/cosine DOS overrange fault.*/
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		/* Degredation of signal overrange threshold. */
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
 };
 
 static const struct iio_chan_spec ad2s1210_channels[] = {
@@ -860,7 +864,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_fault.dev_attr.attr,
-	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
@@ -899,12 +902,14 @@ IIO_CONST_ATTR(in_phase0_mag_value_available,
 	       __stringify(PHASE_360_DEG_TO_RAD_INT) "."
 	       __stringify(PHASE_360_DEG_TO_RAD_MICRO));
 IIO_CONST_ATTR(in_altvoltage0_thresh_falling_value_available, THRESHOLD_RANGE_STR);
+IIO_CONST_ATTR(in_altvoltage0_thresh_rising_value_available, THRESHOLD_RANGE_STR);
 IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
 IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
 
 static struct attribute *ad2s1210_event_attributes[] = {
 	&iio_const_attr_in_phase0_mag_value_available.dev_attr.attr,
 	&iio_const_attr_in_altvoltage0_thresh_falling_value_available.dev_attr.attr,
+	&iio_const_attr_in_altvoltage0_thresh_rising_value_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
 	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
 	NULL,
@@ -963,6 +968,9 @@ static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
 		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
 			return ad2s1210_get_voltage_threshold(st,
 						AD2S1210_REG_LOS_THRD, val);
+		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_RISING)
+			return ad2s1210_get_voltage_threshold(st,
+						AD2S1210_REG_DOS_OVR_THRD, val);
 		return -EINVAL;
 	case IIO_PHASE:
 		return ad2s1210_get_phase_lock_range(st, val, val2);
@@ -996,6 +1004,9 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
 		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
 			return ad2s1210_set_voltage_threshold(st,
 						AD2S1210_REG_LOS_THRD, val);
+		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_RISING)
+			return ad2s1210_set_voltage_threshold(st,
+						AD2S1210_REG_DOS_OVR_THRD, val);
 		return -EINVAL;
 	case IIO_PHASE:
 		return ad2s1210_set_phase_lock_range(st, val, val2);

-- 
2.42.0

