Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D31F7A89F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjITRDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjITRD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:03:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1210CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:03:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3200257b9a3so25490f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695229401; x=1695834201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHyufdv37O6S8ZmknToS8IWvP33+rDz8dd7rQRoiFOI=;
        b=KP9aHxWaZhXlVlNIRB3+T0QZnZ5b9vMs/w1TCxRev6FWiykYqLh5FowfmBVEIplrc4
         5CzYIrxjN4Iv85lIgI6B2taeHkDunL9TWA3pVQxSVtPGyqHATtefNe1eIKLPmj096Dw7
         XuGMC6VQZlUZ7g1XBXGHsU9/KXxp6cY+a32qXW5R3cP1cgmEOzNSK69AWjKSpVSUbseE
         FbDQdck2IqDki4vzsrIq5FJQc8XALTwwemOGW16BYdIZ4xarlwl6+nNwO59rMtHfVzPU
         YTtFLEk/jtRKE2Y4lH33+OppoYXyN+JHzLvHiTonWgDNmjr2Yq7QBAdkhT1JpGCRlu36
         tu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229401; x=1695834201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHyufdv37O6S8ZmknToS8IWvP33+rDz8dd7rQRoiFOI=;
        b=h3bj4pweuCjCSZNxqc35EBDKVIGJzBhcWg3H1li2q8076wsHzk5zSbICJVSxNjvob+
         mkK7qqIqaeT/WKs/npcnVKdl8R6XsX9oBDRhnTn7FNL/P4tKiCgfHGGuPBPblpJvT5lY
         XfWd/f6MbU3C9aRt0O1pRHCxEW42TBXXNCc6G8Q0BiPtpC1oDyWMUbTfZFd60rs/A8An
         r4j2m1ZtNVC3pNLaff97wDG8NtuGJHmI/OeuSRFr96uJUx7hnEhP+UwnW5qnTxJVMmeM
         7TZ+aRO5NDPIZeQwL4OHllpejbQfscpKy2i0T0bqYT8lnmfK+k71dYIdcobBpU71BL1i
         yRxg==
X-Gm-Message-State: AOJu0Yz7VuFfSQuKH2NGKmaGiEuxPrmrrA5LBKAaBZ45DjPHLxGwGgwZ
        rlvNk4GYMt5TL5sefmZMeDdbKA==
X-Google-Smtp-Source: AGHT+IEeDYURcssAVtKkHWXgELiscbELYLxLWtKeReqzbYPINC/mwrr6PKnp6JmuUytIY6KCPgVkdw==
X-Received: by 2002:a5d:4bc1:0:b0:319:7472:f0b6 with SMTP id l1-20020a5d4bc1000000b003197472f0b6mr3079743wrt.15.1695229401308;
        Wed, 20 Sep 2023 10:03:21 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id g10-20020adff3ca000000b003200c918c81sm11221089wrp.112.2023.09.20.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:03:21 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: [PATCH 2/4] iio: sysfs: add IIO_DEVICE_ATTR_NAMED_RW macro
Date:   Wed, 20 Sep 2023 12:02:51 -0500
Message-Id: <20230920170253.203395-3-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920170253.203395-1-dlechner@baylibre.com>
References: <20230920170253.203395-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new IIO_DEVICE_ATTR_NAMED_RW to handle the case where
multiple attributes share a common implementation so the attribute
name and the function names need to be different.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/sysfs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index de5bb125815c..ab20c5294e52 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -87,6 +87,10 @@ struct iio_const_attr {
 	struct iio_dev_attr iio_dev_attr_##_vname			\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
+#define IIO_DEVICE_ATTR_NAMED_RW(_vname, _name, _addr)			\
+	struct iio_dev_attr iio_dev_attr_##_vname			\
+	= IIO_ATTR_RW(_name, _addr)
+
 #define IIO_CONST_ATTR(_name, _string)					\
 	struct iio_const_attr iio_const_attr_##_name			\
 	= { .string = _string,						\
-- 
2.34.1

