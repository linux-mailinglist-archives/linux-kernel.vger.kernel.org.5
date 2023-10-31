Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B37DD773
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjJaVFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjJaVFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:05:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237AF3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:05:45 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e5bc692721so3742801fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698786344; x=1699391144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylAWoXi+6yzfzvduSB8hqrTOh1zLBHDnHEqXnt/b0ys=;
        b=fgSUFs3mbPlBsK5wCQNOa4ndbVCUacyPUo7OR7Lw8h5/PS4WWsckjB/1tLzsOGhp9p
         rgEJpOZ3UYRoIYEXC5ZI6Zvuh0J68s1KHm10rhdIpp/r0ZVP4Z0UhAU4DAezJ5SBkpux
         HRuEJmzHuJO3deWyeIqgDtD3fnGRrsN5wsXwbScu7HpFYWuf+KbXMylrk+MNl5KLeSWA
         yrH4gvqkBB7os5c1JjKRDIWf7io6rqvuAAnZD88Zw/hq+oNy0Iuq28Lv55QFH+bxuxPE
         LxV8DSNsS1WysAMkC6QeKCtkd6KdscjDcjTEtr7DdZiODzGF7Q19n7SjKP9gqXPR5H84
         KFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698786344; x=1699391144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylAWoXi+6yzfzvduSB8hqrTOh1zLBHDnHEqXnt/b0ys=;
        b=vFSb24WkVecUZdINAIhIxI6aVPTv+4Fx0sh/74TqQNo+qmQl1DSgJj3hxJibVrXp2W
         hpaeQFSCiI/jF0Pp1Xn8um1i6L63I8ubZ5naJEvY5v0KIOl1BdouZ+QY0r1PwOALbVH6
         WMYJWm0FavYc6ENHwrjEAyLjz2IAKGvZXKR51wjOjn9teanU3aarWwVcAocLdjTL8Txf
         dqDfNRSzHTgSfZL+aZWtTDiSvfWsBJbhypaM4l+mKMVc3RcrTpLwU7GlacndQ+veGYuz
         gLwRh2FdsO4Rox6fmQaFQ+tcHL/JKmk0VVv0HiXxXGEvw/RHui48oS5oo2cw5ZsCNNVF
         2aqg==
X-Gm-Message-State: AOJu0YyVL67VkfbChLhgVJGWagmPK1gT+d8GVSM0iDpfMOEBiOinjhi/
        FguIvVdnXabtw74cw/IutD6wqQ==
X-Google-Smtp-Source: AGHT+IFWeaujTZlxNE99wm4MuEN85B5qR+JpSkHbMT/+0Xuf6ptGT02D91k1HtJZSO/Va6heCnyRVg==
X-Received: by 2002:a05:6870:200f:b0:1bf:9f6:b810 with SMTP id o15-20020a056870200f00b001bf09f6b810mr16535724oab.36.1698786344044;
        Tue, 31 Oct 2023 14:05:44 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id ky10-20020a056871c4ca00b001efce0658e6sm24616oac.39.2023.10.31.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 14:05:43 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     David Lechner <dlechner@baylibre.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: triggered-buffer: prevent possible freeing of wrong buffer
Date:   Tue, 31 Oct 2023 16:05:19 -0500
Message-ID: <20231031210521.1661552-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ee708e6baacd ("iio: buffer: introduce support for attaching more
IIO buffers") introduced support for multiple buffers per indio_dev but
left indio_dev->buffer for a few legacy use cases.

In the case of the triggered buffer, iio_triggered_buffer_cleanup()
still assumes that indio_dev->buffer points to the buffer allocated by
iio_triggered_buffer_setup_ext(). However, since
iio_triggered_buffer_setup_ext() now calls iio_device_attach_buffer()
to attach the buffer, indio_dev->buffer will only point to the buffer
allocated by iio_device_attach_buffer() if it the first buffer attached.

This adds a check to make sure that no other buffer has been attached
yet to ensure that indio_dev->buffer will be assigned when
iio_device_attach_buffer() is called.

Fixes: ee708e6baacd ("iio: buffer: introduce support for attaching more IIO buffers")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index c7671b1f5ead..c06515987e7a 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -46,6 +46,16 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	struct iio_buffer *buffer;
 	int ret;
 
+	/*
+	 * iio_triggered_buffer_cleanup() assumes that the buffer allocated here
+	 * is assigned to indio_dev->buffer but this is only the case if this
+	 * function is the first caller to iio_device_attach_buffer(). If
+	 * indio_dev->buffer is already set then we can't proceed otherwise the
+	 * cleanup function will try to free a buffer that was not allocated here.
+	 */
+	if (indio_dev->buffer)
+		return -EADDRINUSE;
+
 	buffer = iio_kfifo_allocate();
 	if (!buffer) {
 		ret = -ENOMEM;
-- 
2.42.0

