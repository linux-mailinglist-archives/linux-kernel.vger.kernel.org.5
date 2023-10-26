Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D207D82A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbjJZM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZM2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:28:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99AC111
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:28:41 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778925998cbso67045985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698323321; x=1698928121; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WGRGpf1ARbPQY1fumL5DeKAJhYKCHf4gxWwDp4LFCQ=;
        b=dnKI+KRYtDpu0CiG0JK1pul4NU9Hct+sFwSQOppcwiuo8mtHcmyexNE62F4XUS6IPD
         g1YscC/b6pe9EAhaoZGXT6l9HHlQNzZ8w36M+vDezM3QHk2MHFxgv1cH8CcmlC3Q9cJY
         /qd79aJ3ykA0+83zUYpG3QUwRwtwOnB5h+CbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323321; x=1698928121;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WGRGpf1ARbPQY1fumL5DeKAJhYKCHf4gxWwDp4LFCQ=;
        b=RJp2DJK+vctUjdAdFniSBkG6VM4eTXjOx8YgeVPgaNp3S/+zUPCJbxQqjfyVG8ZUgv
         IIPYCX8+ZCyMqpjU6iKVekQ3oKXb4FIo7nXzA6ElruHS8VPrImScNdcAuOLKgINIzc/f
         2frpvzPWo+NFA7MwIOBNF7oLOYloMXBOJI2+P675d94UXz3XZK/JQ7SKhYNSI2fzrDoO
         WNbBgD875B1kttSJmYB27P0HkRMILNhQBnDS4O7eTHYtVzCUXo8mllDMaR+QUFtCwds/
         pBNWOxtgmfyhBS42zlgQvQsFtuH2i8fu6M5RnTXkfxUM+aP2wJ4Lc2oTwhT4ufkSLv2z
         W6iA==
X-Gm-Message-State: AOJu0YxCi6iDlGIeZLrBeMBLRyM8FT7xkn95PDq0eFU9uhT6S4DODrFz
        5WCApmoV+JNx4jgyEFhaphDWg9dCYy0T5U0K81Y=
X-Google-Smtp-Source: AGHT+IGbmmi/fPDM4l/eOyFgg7t4XG2htGE2skFiTTZytx2fRoIZQX1f5cqp42EdqvLnV4afw+cnOw==
X-Received: by 2002:a05:620a:22a2:b0:770:72c3:dbbc with SMTP id p2-20020a05620a22a200b0077072c3dbbcmr16056365qkh.18.1698323320869;
        Thu, 26 Oct 2023 05:28:40 -0700 (PDT)
Received: from denia.c.googlers.com (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id x6-20020a05620a14a600b0076f35d17d06sm4941476qkj.69.2023.10.26.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:28:40 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 26 Oct 2023 12:28:36 +0000
Subject: [PATCH] usb: dwc3: set the dma max_seg_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-dwc3-v1-1-643c74771599@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHRbOmUC/x2MSQqAMAwAvyI5W9BWFPyKeEhjqgGp0uIC4t8NH
 mcY5oHMSThDXzyQ+JQsW1SoywJowTizkUkZbGVdXdnWTBc5E5C6JpB33iJo6jGz8QkjLRrHY11
 V7omD3P97GN/3A0wzq51rAAAA
To:     Zubin Mithra <zsm@chromium.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow devices to have dma operations beyond 4K, and avoid warnings such
as:

DMA-API: dwc3 a600000.usb: mapping sg segment longer than device claims to support [len=86016] [max=65536]

Reported-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Found while running 
yavta -f YUYV -s 1280x720 -c  /dev/video0

with:

CONFIG_DMA_API_DEBUG=y
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 343d2570189f..65f73dd8ef47 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1918,6 +1918,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err_exit_debugfs:

---
base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
change-id: 20231026-dwc3-fac74fcb3b2a

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

