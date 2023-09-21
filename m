Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7A7A9B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjIUSxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjIUSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:53:21 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F240900ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:46:27 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50317080342so2226823e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695318385; x=1695923185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWszhBlTWMiwkXqgF1w4h8oNmYkV0xe9wPBMJvnXBgI=;
        b=QBLXTUv2w46Huf/WDJ3zyFzZ1LM/+FazknkYHKDSibQkMof8TcpZ69Cz7x8g9R0ifu
         vX5xnIjCuKDkRxGcdaAonCNJBJkY9LGlIZJ7mHQ71Z296130lHkEJ0fmi+2IAdSzWptz
         s8sQltIvy6G5tbj796Bpt/72torA2+qea5Is/NKnpmLDir/TlOBjiSxhuWwMs3OAKTnV
         0x4LLbzcKeVP9XHqurIkwGAG0EtIDagQA+ZCjfAR9DvVfFBjy8svcL9cH+v9ikW4815O
         4F+67Z9XgGebtD6KIGikm2wIYX7rT15Uqx7pVcQuo8twWtQT72/Y7nVWXat4hpH9um9t
         Uf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318385; x=1695923185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWszhBlTWMiwkXqgF1w4h8oNmYkV0xe9wPBMJvnXBgI=;
        b=niy8a5KYNohQ8xV5Y7VXwHsljiKVyy6AkbPRaLQm8fA/o9NU8QB26wRu2wADUHr0Ue
         b2K+wPRWNZ1RorXkQEQB8tS8DhAcryev1aYOTi7z62xjj49zon+3Ey0COOF5PjGXdfe4
         ve7Hq2PtvKZQQcbf7ahnMn2lxrtfpx0e4UER+mZKhho7xYRuN0sxhvAKhGpWlcF6ErJH
         YDaZctoK+lBjvYwapSeUtef26UTwdk5It+8w1U6MEem7XXPDkpNtSv7c1m0AqjW5oUIf
         HoHzGKVfD1PQTSomWeiO8j8LTEoaPeNY6TnBJ5o3+4nKmI+NeSdEEcb+cojo0bXng+8R
         n68w==
X-Gm-Message-State: AOJu0Yw5pM6VQgpvc4lWYn2TtTCg0TPoNSxlPMNFdmSW4s0hX1jri/+q
        QaK6eH+UlVBCQeNSfoxfuQdS5LN0jAboQZMOEaoW6NwK
X-Google-Smtp-Source: AGHT+IEbn5IMsdjtBHEkcUJjQZ6PeFE6mcT6qeW6zrirIQz8hU6m6170Q4EKzy7+2zTNsR6rNCEY9w==
X-Received: by 2002:a05:600c:ad4:b0:3f9:b430:199b with SMTP id c20-20020a05600c0ad400b003f9b430199bmr5382212wmr.15.1695307455234;
        Thu, 21 Sep 2023 07:44:15 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:14 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 03/19] staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
Date:   Thu, 21 Sep 2023 09:43:44 -0500
Message-Id: <20230921144400.62380-4-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the fault attribute, an empty string was printed if the
fault register value was non-zero.

This is fixed by checking that the return value is less than zero
instead of not zero.

Also always print two hex digits while we are touching this line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 06de5823eb8e..84743e31261a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -393,7 +393,7 @@ static ssize_t ad2s1210_show_fault(struct device *dev,
 	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : sprintf(buf, "0x%x\n", ret);
+	return (ret < 0) ? ret : sprintf(buf, "0x%02x\n", ret);
 }
 
 static ssize_t ad2s1210_clear_fault(struct device *dev,
-- 
2.34.1

