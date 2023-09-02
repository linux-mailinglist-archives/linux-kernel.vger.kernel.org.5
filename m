Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B1790969
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjIBTq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjIBTq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:46:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BFE4B
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:46:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcb54226e7so2045251fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693683982; x=1694288782; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4021QRHMr8y+B0VlWZUyIOqR4w3eYna7iuJypLbKWU=;
        b=tRNkMAUjv4K4MjaCedQmrqI9XvfiSPSv+eC32+8xq7xVXNFfJ6W3FqZ5LF+NbJDSel
         OvL0JM5wb3Fhiyxzl/b/+tHAq2IhOfBTXPKPLdeXeBcM/4uAS+QHNBGARK+NKkIpXlMI
         NvfdA6yOMtgyW7Zce7zU7ZtnE9WiR8apoHU33qpE55djq10g+a3VXog/lb/jbdAVpwRL
         524Jxqc8oFJrLtJ+/pq41qKt9xPnjj3MjB9jeQ8aLdiVxuciIV8N0hreR7eZgx8iHVjU
         Ae5LZvbZPiFgxRsJ43qp7FZrJlShbpUQm3ieEIhVIKzSN7MXzgehGIUKbsk4bjkA4MPD
         kXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693683982; x=1694288782;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4021QRHMr8y+B0VlWZUyIOqR4w3eYna7iuJypLbKWU=;
        b=FJ8qB1XhCCEcF9XC4XV7l4rJpVLkGm5ZpeEJqeKkaQ2CVAF/COI1SbYp/kCT6s09F4
         97eUHP96/b3WQs7z79exoSN0crLg40Fw6yr5lw/Tw70+gmlDJMCrDfx141gKxTGCuVRA
         X/MPo+SIQo6AiuRuZ0WLtMB2PPt6l5la00ntAdXfkz7gblfaEdXZarHfU3/4oOt0NExG
         Qmq2JaRc01QJbSLxjJjn7pWhgtf4riGbFX932ryQuNXPt4fCSMfBmmrKDXceVNVofudj
         66HuAxwE5wFSKRyirsO9xUXEnJ9XzDksa9qAv/vn1ZBG0XidyYK4zoihnksQAFZJgV0l
         zlqw==
X-Gm-Message-State: AOJu0Yxzrx1+gBLKF2xrwe6ChBaDgAzTGtKICyUshjEpmN9wTfDlYA/F
        05uq60s3LVr8wsWvnBnj5N5ZFQ==
X-Google-Smtp-Source: AGHT+IEl13JkSrjhcK5E2RZ8ZbnUHPZRGghXOrWAhXfO3O5J5ay5Tbyuh24VKqRGcHXPiL+Hyb1DPg==
X-Received: by 2002:a2e:8012:0:b0:2bc:f1d3:b54b with SMTP id j18-20020a2e8012000000b002bcf1d3b54bmr1947534ljg.4.1693683981973;
        Sat, 02 Sep 2023 12:46:21 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o6-20020a2e9b46000000b002b70a64d4desm1289856ljj.46.2023.09.02.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 12:46:21 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 02 Sep 2023 21:46:20 +0200
Subject: [PATCH v2] iio: afe: rescale: Accept only offset channels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAuR82QC/4WNQQ6CMBBFr0Jm7ZhSUNGV9zAsCkxhEtIxU0Ikp
 He3cgGX7yX//R0iKVOER7GD0sqRJWSwpwL6yYWRkIfMYI2tTFMZZBZUir2bCSXMG4r3kRb0tiF
 z6QY7UAd5/Vby/DnKrzbzxHER3Y6jtfzZ/821xBJr47q7r+vq2t+eMwenchYdoU0pfQFfp37Vv
 wAAAA==
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted by Jonathan Cameron: it is perfectly legal for a channel
to have an offset but no scale in addition to the raw interface.
The conversion will imply that scale is 1:1.

Make rescale_configure_channel() accept just scale, or just offset
to process a channel.

When a user asks for IIO_CHAN_INFO_OFFSET in rescale_read_raw()
we now have to deal with the fact that OFFSET could be present
but SCALE missing. Add code to simply scale 1:1 in this case.

Link: https://lore.kernel.org/linux-iio/CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com/
Fixes: 53ebee949980 ("iio: afe: iio-rescale: Support processed channels")
Fixes: 9decacd8b3a4 ("iio: afe: rescale: Fix boolean logic bug")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Fix rescale_read_raw() handle channels with offset but no scale.
- Link to v1: https://lore.kernel.org/r/20230830-iio-rescale-only-offset-v1-1-40ab9f4436c7@linaro.org
---
 drivers/iio/afe/iio-rescale.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 1f280c360701..56e5913ab82d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -214,8 +214,18 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 				return ret < 0 ? ret : -EOPNOTSUPP;
 		}
 
-		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
-		return rescale_process_offset(rescale, ret, scale, scale2,
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_SCALE)) {
+			ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
+			return rescale_process_offset(rescale, ret, scale, scale2,
+						      schan_off, val, val2);
+		}
+
+		/*
+		 * If we get here we have no scale so scale 1:1 but apply
+		 * rescaler and offset, if any.
+		 */
+		return rescale_process_offset(rescale, IIO_VAL_FRACTIONAL, 1, 1,
 					      schan_off, val, val2);
 	default:
 		return -EINVAL;
@@ -280,8 +290,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->type = rescale->cfg->type;
 
 	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
-	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_info(dev, "using raw+scale source channel\n");
+	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
+	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
+		dev_info(dev, "using raw+scale/offset source channel\n");
 	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
 		dev_info(dev, "using processed channel\n");
 		rescale->chan_processed = true;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230830-iio-rescale-only-offset-f28e05bd2deb

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

