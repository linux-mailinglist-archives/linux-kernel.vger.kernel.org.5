Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C16B80F74D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjLLT6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLT6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B02A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702411089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vio5W2CXh8VIVVnye0VQz+L8cj+HSZDsPzluUFJanUo=;
        b=fcgYBaeqslA3shJwUhFFBerekSGvpCwQ6tMtt3maXBTVAy+XvCGu8upRc3B0jQxu+CfRAH
        jrk/kzQC5o9ufIk2Hc0YZAZ3UISdyva/4TKAML57KWTweyYMrueRZco1rgJc7CZHhttXvA
        T2XXg1+0thaEgkPrunYptEn8tAFWPVU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-9yEnUYiBPA-5aC5W5-1WEQ-1; Tue, 12 Dec 2023 14:58:06 -0500
X-MC-Unique: 9yEnUYiBPA-5aC5W5-1WEQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5ce16bc121aso72108407b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411085; x=1703015885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vio5W2CXh8VIVVnye0VQz+L8cj+HSZDsPzluUFJanUo=;
        b=ddqIeqHlN7l1rJwJqf2/FvhyhtDkM9p53jYv3rWaWriv5PLmCwc0w3xBmfeYce0h/v
         XLFcwBRSe90lk7oCJ/I1kOhuTRd9sbqGED4wKE7EL5g7YwkrXf0dQL6JULXMvHZ57Iwi
         FKWcMfiH4Qm8WKCm/7srbggtDC4urPRcjpORq/UvAihVvWlFmxSpONOL1Rz/nq89gvCT
         k+51BsP97K1FkONaE4Wax8OKWX0OHC6pId9kA1ohaFv547y6T/ATL9VOVSoB8jOC2APa
         wwyBAGuzjusRj2axUX2gjt033OADXvUjVhUmQUNRWB4bQef3WG2w9LE4RCW7lexMrCgP
         2rDA==
X-Gm-Message-State: AOJu0Yy39T134GcQFuHmJrqrk2bgobCO4m3P/YsEYJhoQRFzhIzFLgnx
        QM1FAbGoMm84wmPpfau9uSHWYEolLzUeLkuHGEewbJyZNLGQenHMQ5zwKvLU0pSTx6++Z0mqWaP
        iKUkxPsp1bNIAtX2otxZkoTTe
X-Received: by 2002:a05:690c:3185:b0:5e1:e50b:ab5c with SMTP id fd5-20020a05690c318500b005e1e50bab5cmr1351519ywb.1.1702411085548;
        Tue, 12 Dec 2023 11:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzll/KfEEeFGXHCYWsZvQiNpoKwD81UlefsjiQ4B9Q//3lL6+1EqEwS9Dic0uVUQCzigLnuQ==
X-Received: by 2002:a05:690c:3185:b0:5e1:e50b:ab5c with SMTP id fd5-20020a05690c318500b005e1e50bab5cmr1351514ywb.1.1702411085342;
        Tue, 12 Dec 2023 11:58:05 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id g184-20020a0dc4c1000000b005a7d46770f2sm3985306ywd.83.2023.12.12.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:58:04 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     hdegoede@redhat.com, deller@gmx.de
Cc:     treding@nvidia.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev/simplefb: change loglevel when the power domains cannot be parsed
Date:   Tue, 12 Dec 2023 14:57:54 -0500
Message-ID: <20231212195754.232303-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the power domains cannot be parsed, the message is incorrectly
logged as an info message. Let's change this to an error since an error
is returned.

Fixes: 92a511a568e4 ("fbdev/simplefb: Add support for generic power-domains")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/video/fbdev/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 6f58ee276ad1..028a56525047 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -470,7 +470,7 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
 		if (err == -ENOENT)
 			return 0;
 
-		dev_info(dev, "failed to parse power-domains: %d\n", err);
+		dev_err(dev, "failed to parse power-domains: %d\n", err);
 		return err;
 	}
 
-- 
2.43.0

