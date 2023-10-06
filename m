Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03B7BAFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjJFAvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJFAvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:18 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD2100
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dcf357deedso1018572fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553474; x=1697158274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GrKPt25v0F5qGW1MO1rwyIqOaGtfzlSF8OgaxvhkIk=;
        b=Y2H5BKE4zFQJlB8r2FJTCegXm1JOSonT+7KIVkfQ6ppeupYScPggpt8Zye1BI3g4ad
         9vQ8hJ5oR6UAjR+UDugsC3fei7E0kCYWtMfKEUytazv6aXGXN6jddEaVZFeOc5FelGkn
         DfZVcQqoJayrwy2ZeGOZtwK2Iluw7hGreBhAaZV2eUbzonELF/1dTTjG8+jI0HxzqZEW
         zqeDkFq4BGvi+wa9sUuKqneNFI/kFGe762Y4EaUKUAUtZxqXWq00DQugKG4jsnb9Kg2w
         dYfpLmf0+0vybJP1w7KmEfpZrdF1BvqO8X9f9V6wgJXRl0jwTNv4R/0r0ZFf/dOfA7Y/
         76Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553474; x=1697158274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GrKPt25v0F5qGW1MO1rwyIqOaGtfzlSF8OgaxvhkIk=;
        b=vcVEN5KKY/yu5sDk+o56Rlk4SFPLt0BFTCh1M+iI/513Epd31qKbzpQI7z7lHdWZd6
         sdVeR75QtG2wHwZ8+tH4P6d6gkRnmkzQLR1Bpu77DwYrcURdbDBcp7wvz8c54HpRibHk
         wt7Tx0wM9E71Jth4MJ6ecNbkV2b9LOg6n61W6lL4EDdomEzCdJLZqhqjdE3yCkkVrY6G
         vtsnVzG+E5uMdKjzGLhRphPQiprI0RGeNgNp7b/3nmloY3oN0dg/ZEPw9aa1Kl/W3mMf
         WBzMoCeWXBNVgyctgnPji41MfjqXEK+1TgoPvBOgR+vMaQ52f9IQogTtV6p+MCwEgiHR
         UcdQ==
X-Gm-Message-State: AOJu0YzBgK9iIspD0bQB6Q4ry5N/4WCH8F/TpgzZIUi+l4k0bDQYFeyy
        s7/AnzM7rNcWuPMu6y6opsnYGA==
X-Google-Smtp-Source: AGHT+IGyRfxDTD02W+NbTYBrLlyMzhCYrXHFjw0o8iIP3moML03a5BAuKjg5nbPWICu7hYMW6ckgQg==
X-Received: by 2002:a05:6870:40d0:b0:1d6:96f9:66fa with SMTP id l16-20020a05687040d000b001d696f966famr7940966oal.54.1696553474233;
        Thu, 05 Oct 2023 17:51:14 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:13 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/17] iio: event: add optional event label support
Date:   Thu,  5 Oct 2023 19:50:29 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-12-ec00746840fc@baylibre.com>
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

This adds a new optional field to struct iio_info to allow drivers to
specify a label for the event. This is useful for cases where there are
many events or the event attribute name is not descriptive enough or
where an event doesn't have any other attributes.

The implementation is based on the existing label support for channels.
So either all events of a device have a label attribute or none do.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: New patch in v4.

 drivers/iio/industrialio-event.c | 55 ++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h          |  8 ++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 19f7a91157ee..910c1f14abd5 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -355,6 +355,21 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	return len;
 }
 
+static ssize_t iio_ev_label_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	if (indio_dev->info->read_event_label)
+		return indio_dev->info->read_event_label(indio_dev,
+				 this_attr->c, iio_ev_attr_type(this_attr),
+				 iio_ev_attr_dir(this_attr), buf);
+
+	return -EINVAL;
+}
+
 static int iio_device_add_event(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int spec_index,
 	enum iio_event_type type, enum iio_event_direction dir,
@@ -411,6 +426,41 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 	return attrcount;
 }
 
+static int iio_device_add_event_label(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      unsigned int spec_index,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	char *postfix;
+	int ret;
+
+	if (!indio_dev->info->read_event_label)
+		return 0;
+
+	if (dir != IIO_EV_DIR_NONE)
+		postfix = kasprintf(GFP_KERNEL, "%s_%s_label",
+				iio_ev_type_text[type],
+				iio_ev_dir_text[dir]);
+	else
+		postfix = kasprintf(GFP_KERNEL, "%s_label",
+				iio_ev_type_text[type]);
+	if (postfix == NULL)
+		return -ENOMEM;
+
+	ret = __iio_add_chan_devattr(postfix, chan, &iio_ev_label_show, NULL,
+				spec_index, IIO_SEPARATE, &indio_dev->dev, NULL,
+				&iio_dev_opaque->event_interface->dev_attr_list);
+
+	kfree(postfix);
+
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
 static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan)
 {
@@ -448,6 +498,11 @@ static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		attrcount += ret;
+
+		ret = iio_device_add_event_label(indio_dev, chan, i, type, dir);
+		if (ret < 0)
+			return ret;
+		attrcount += ret;
 	}
 	ret = attrcount;
 	return ret;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 7bfa1b9bc8a2..d0ce3b71106a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -427,6 +427,8 @@ struct iio_trigger; /* forward declaration */
  * @write_event_config:	set if the event is enabled.
  * @read_event_value:	read a configuration value associated with the event.
  * @write_event_value:	write a configuration value for the event.
+ * @read_event_label:	function to request label name for a specified label,
+ *			for better event identification.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
  * @update_scan_mode:	function to configure device and scan buffer when
@@ -511,6 +513,12 @@ struct iio_info {
 				 enum iio_event_direction dir,
 				 enum iio_event_info info, int val, int val2);
 
+	int (*read_event_label)(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				char *label);
+
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
 	int (*update_scan_mode)(struct iio_dev *indio_dev,

-- 
2.42.0

