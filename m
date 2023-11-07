Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE287E491A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjKGTUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKGTU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:20:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EA0D43;
        Tue,  7 Nov 2023 11:20:27 -0800 (PST)
Received: from shreeya.shreeya (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B588660748C;
        Tue,  7 Nov 2023 19:20:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699384825;
        bh=v/+HlUbdkVlvRYJEfDzKEel5tt1IxqqmV9wyYAz5uuM=;
        h=From:To:Cc:Subject:Date:From;
        b=VRIlsB1i9+5UiaT42ltAk6+bQE3hononkVqwxA+v9BZeHeHhUwwVByVglRmmTe1Ky
         5cyF8e//xVUHbXwKw+OYnwDeRAkhJ/Zc2Z54EFBmO6LefqNjaPd5gzwrfxkAd8yOPe
         8peLRWsj6j5uDJYR5wBm28WUIcTHadMDPd+WiCwnQizIF/mNUMeF8q9MleRFfApAR5
         DHF04yh/ko0Ssbtg9BTx7hT7rhuOyVt8DmSs2VDU896iwvEIyHdsAhJOGz9iCLI8CG
         oOiOPAZqtC+9GsNxwKzyZdbzUtNOPXX9hTTLGvD+4i1mCpOVy6zpjYrDiQ+TA+Z1AT
         nl1HJcKBkABdw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] iio: light: ltrf216a: Return floating point values
Date:   Wed,  8 Nov 2023 00:50:05 +0530
Message-Id: <20231107192005.285534-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better precision of input light intesity, return floating point
values through sysfs instead of an integer value

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/light/ltrf216a.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 8de4dd849936..68dc48420a88 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -234,7 +234,7 @@ static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
 static int ltrf216a_get_lux(struct ltrf216a_data *data)
 {
 	int ret, greendata;
-	u64 lux, div;
+	u64 lux;
 
 	ret = ltrf216a_set_power_state(data, true);
 	if (ret)
@@ -246,10 +246,9 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
 
 	ltrf216a_set_power_state(data, false);
 
-	lux = greendata * 45 * LTRF216A_WIN_FAC * 100;
-	div = data->als_gain_fac * data->int_time_fac * 100;
+	lux = greendata * 45 * LTRF216A_WIN_FAC;
 
-	return div_u64(lux, div);
+	return lux;
 }
 
 static int ltrf216a_read_raw(struct iio_dev *indio_dev,
@@ -279,7 +278,8 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		*val = ret;
-		return IIO_VAL_INT;
+		*val2 = data->als_gain_fac * data->int_time_fac;
+		return IIO_VAL_FRACTIONAL;
 	case IIO_CHAN_INFO_INT_TIME:
 		mutex_lock(&data->lock);
 		ret = ltrf216a_get_int_time(data, val, val2);
-- 
2.39.2

