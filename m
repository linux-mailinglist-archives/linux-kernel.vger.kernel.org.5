Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09587C4221
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbjJJVND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJJVM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:12:58 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE79E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:56 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c63588b554so4172414a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696972375; x=1697577175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DYF1hS/5DymrCK+wzJy8sJOlUG28zHWF8r/ohf2D3c=;
        b=s3mcMq8j3JSUASvkKDnNiZnuvk5b5lyGFJs5G+sHN2deakumu5WD2vpRyzJr514x22
         XsGm5RK4Y4OayeyMk/Qne5g319Fh2PtYzV0+4XZMzod9rfDE18F/ivF98+aw/3Z96Ux3
         oLrNrHODpCbTqX1CUylh78pT7bflW5gHGcSbZZZYCoct7J3Nif2Z1DZvNSdmsylhhtrs
         6KqcxYPYyCYOlmiG5Yd3U3SVn/goP7Iclx8kRvK0eagaBFMz94fQOQP7UuqYAaHQnEay
         fIftmNp1XKd5qoFBNUfI/DlNUlB9yX0FX6/5ddfq9NsN4k+/jNcEVVL/kpBdzmzpBmbw
         M0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972375; x=1697577175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DYF1hS/5DymrCK+wzJy8sJOlUG28zHWF8r/ohf2D3c=;
        b=NMLDHHI8MIEWNNTlkZk/010Kxl7j+oEjssUpE3yHNdBagLCeZUIgkqKap8jIhPfjo8
         jOuwZhr/n7nDL6PX8/qoUoFCmUPj4q4Hd81UGgL6VqEw7VxiHUHTuzytnFhTMbAv1H7f
         pkFG8yD70qYVaxEs/UvrW+AjcFtBQe+2mWO8dOhEKL5AmHUhDoyLPtgJxWsdKhlQL5GJ
         kq3IyxxnyHnGs3AgdZV5dykWyQIwAc0Lz7FmYDZGkKpH+Pq285w1iFkuHzga5oi/eET+
         t/2e8ZoOCleY53UVN8LIbrKZXmWMZPPiuQdYfcnlQfESR9xw+h8cgrqDAM2ntuHxo3TV
         Ig3w==
X-Gm-Message-State: AOJu0Yzj60HNBiKyG23E9bTN7wuHFYo8g1QJ0+ObFDg249tAmGADgVV8
        r2kmkPamOPewKFaQVLvKsDtGzw==
X-Google-Smtp-Source: AGHT+IH/gAGxyJIE23ycqiVPoJK2HFCeDd+zgQkTpKMR2q0Gj2vVF5euMIUZKlQ9IEciY75efo8P6w==
X-Received: by 2002:a05:6870:2198:b0:1c1:e6da:f88d with SMTP id l24-20020a056870219800b001c1e6daf88dmr22531136oae.56.1696972375541;
        Tue, 10 Oct 2023 14:12:55 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ed46-20020a056870b7ae00b001e98b1544fesm52494oab.9.2023.10.10.14.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:12:55 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] staging: iio: resolver: ad2s1210: clear faults after soft reset
Date:   Tue, 10 Oct 2023 16:12:34 -0500
Message-ID: <20231010-ad2s1210-mainline-v5-2-35a0f6ffa04a@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
References: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
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

When a software reset is performed on the AD2S1210 to make the selected
excitation frequency take effect, it always triggers faults on the
input signals because the output signal is interrupted momentarily.
So we need to clear the faults after the software reset to avoid
triggering fault events the next time a sample is read.

The datasheet specifies a time t[track] in Table 27 that specifies the
settle time in milliseconds after a reset depending on the selected
resolution. This is used in the driver to add an appropriate delay.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: New patch in v5.

 drivers/staging/iio/resolver/ad2s1210.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 59c273a4b6a9..cf4018434447 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -314,6 +314,9 @@ static void ad2s1210_toggle_sample_line(struct ad2s1210_state *st)
 static int ad2s1210_reinit_excitation_frequency(struct ad2s1210_state *st,
 						u16 fexcit)
 {
+	/* Map resolution to settle time in milliseconds. */
+	static const int track_time_ms[] = { 10, 20, 25, 60 };
+	unsigned int ignored;
 	int ret;
 	u8 fcw;
 
@@ -329,7 +332,27 @@ static int ad2s1210_reinit_excitation_frequency(struct ad2s1210_state *st,
 	 * Software reset reinitializes the excitation frequency output.
 	 * It does not reset any of the configuration registers.
 	 */
-	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
+	ret = regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Soft reset always triggers some faults due the change in the output
+	 * signal so clear the faults too. We need to delay for some time
+	 * (what datasheet calls t[track]) to allow things to settle before
+	 * clearing the faults.
+	 */
+	msleep(track_time_ms[st->resolution] * 8192000 / st->clkin_hz);
+
+	/* Reading the fault register clears the faults. */
+	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &ignored);
+	if (ret < 0)
+		return ret;
+
+	/* Have to toggle sample line to get fault output pins to reset. */
+	ad2s1210_toggle_sample_line(st);
+
+	return 0;
 }
 
 static void ad2s1210_push_events(struct iio_dev *indio_dev,

-- 
2.42.0

