Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E242A7BAFD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJFAwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjJFAvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:20 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B3510C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:17 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1e1e25ab32bso1036301fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553476; x=1697158276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI34v4vwW5XM25KikYNf+BGSccyPUhljKdJ83kHWmf8=;
        b=W88TPZ6QR+KDZ+09EoFJ/KBVc4pnUxcEojw+6zoyfpGjhich4bo2/seVj2CM5P1GNu
         7/Smx4NQk2BkDjEjLhUSkClE7CreWs8lT5BILrr0nX1yUba1hENSZKbhEBiA1Ktjf62/
         OVQpRMzZgKS922x8uTqI3SDfupHT8RQ9+bRVcOSvbynji/DEnOZihy2RIkY+LdJ+j4V7
         yDRLxYEBUK5jPbP20g4C0ea76UwaJlZZggAQUkQHrHB4QLskbLKzTpAZp4y4Q8o4FFqF
         wOYGFcjQENIVLP3un9bI5hESapaYutfu21I7zATPf1dsw1GAGTXya6ibPy+IbQsMesC/
         pBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553476; x=1697158276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI34v4vwW5XM25KikYNf+BGSccyPUhljKdJ83kHWmf8=;
        b=IzkBOAYVbJWKGjj/7puge+arP1K0EH5Ui87Yh8sg+RKVRfHgSAoUuuemizpAMA8ClB
         0UkF+hl7S4zmgJma26jbiVMWMGLh+a0VyQ6Y9VokBTlbMD4E9oxLqKPj8f7mEhgVtxJH
         ECekHC7cP8arOPFj8qc64EdfRjW/cGx9Z0OjrqOIKavHPQyFotMVp7gv6VU4RbNcIL14
         E1wmRRUpniVfEYTU9DUuw9LJhrpSWr8BTLNrA0CnFpt9br2jYyzQ83biuzaMxsuoEHRN
         dvnLf2Fl8wpkQYxAsTsZ+FOuiMyAJcGpHF6FeRO9kirmMxiBmRE1ay/ML85RxGSOtr7t
         EFYw==
X-Gm-Message-State: AOJu0Ywl+bxn4JoIiNHAs9pH6stlQA99a+SwcQucpUq/U5uumVV+RC5n
        JT9HnKDXQUcMwpcjy2TpNfylVA==
X-Google-Smtp-Source: AGHT+IEchoMTXOEbw8NFS2gMIPHbq+oGOliYuhmKz8ENK3CaoNOlDvSRLvdogehnLIb+B2nw1m1lEg==
X-Received: by 2002:a05:6870:1490:b0:1d6:56d8:a788 with SMTP id k16-20020a056870149000b001d656d8a788mr7430599oab.40.1696553476450;
        Thu, 05 Oct 2023 17:51:16 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:16 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/17] staging: iio: resolver: ad2s1210: add label attribute support
Date:   Thu,  5 Oct 2023 19:50:32 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-15-ec00746840fc@baylibre.com>
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

The ad2s1210 resolver driver has quite a few channels, mostly for
internal signals for event support. This makes it difficult to know
which channel is which. This patch adds a label attribute to the
channels to make it easier to identify them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Adjusted for channel rearrangement in previous patches.

v3 changes: This is a new patch in v3

 drivers/staging/iio/resolver/ad2s1210.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 51490fea1647..59c8eed26701 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -1158,6 +1158,34 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	return ret;
 }
 
+static int ad2s1210_read_label(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       char *label)
+{
+	if (chan->type == IIO_ANGL) {
+		if (chan->channel == 0)
+			return sprintf(label, "position\n");
+		if (chan->channel == 1)
+			return sprintf(label, "tracking error\n");
+	}
+	if (chan->type == IIO_ANGL_VEL)
+		return sprintf(label, "velocity\n");
+	if (chan->type == IIO_PHASE)
+		return sprintf(label, "synthetic reference\n");
+	if (chan->type == IIO_ALTVOLTAGE) {
+		if (chan->output)
+			return sprintf(label, "excitation\n");
+		if (chan->channel == 0)
+			return sprintf(label, "monitor signal\n");
+		if (chan->channel == 1)
+			return sprintf(label, "cosine\n");
+		if (chan->channel == 2)
+			return sprintf(label, "sine\n");
+	}
+
+	return -EINVAL;
+}
+
 static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -1338,6 +1366,7 @@ static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
 	.read_avail = ad2s1210_read_avail,
 	.write_raw = ad2s1210_write_raw,
+	.read_label = ad2s1210_read_label,
 	.attrs = &ad2s1210_attribute_group,
 	.read_event_value = ad2s1210_read_event_value,
 	.write_event_value = ad2s1210_write_event_value,

-- 
2.42.0

