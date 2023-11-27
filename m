Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075B87FACEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjK0WAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjK0WAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:00:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D491A5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:00:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cfe0b63eeeso24403337b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122450; x=1701727250; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fTNvGVxIFnvSGPtP4qlnkK9J/w0WE03mzYNhzIBqHiA=;
        b=dSBw1aIJkIfaJ45FqI7HnpDSRyNOXMy52Pf5+BqIOj047Y/euEW8PM0r1Q+at212K/
         IMdqZaeV6/mjfaaOOOOOxqmqGm0s4QUlq1nUUhlGvnjQSatTRndJH5gN0c7MxfdHKvid
         1X1JAs9gvxCVCDPesw6UtRLK5GuaGrXScawU9eACEX35Zjt9fZQRAdugc8oBDY0Gg89I
         o8c0eWFALe79laCS9N/GzEeNzbs1bN2l8/srTz6iE6R7TGcqvHZsaZYNIbOqv1StxeJL
         /nykYmPQ8aGKiInIeFCCM8zOY4W4Q4wYzkJG6hzakNcaVyRoTqnorNvgQ6/KzcOh0sUx
         z5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122450; x=1701727250;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTNvGVxIFnvSGPtP4qlnkK9J/w0WE03mzYNhzIBqHiA=;
        b=YbA/mRTPutSZx0V2Ntt/v07nkHrwSfVLF6SdYEuC3lh6Bywcwq663vK6JG6y8IYU9T
         J9m9q+FPRqNm++fdj3dGbbDVs0sTvZ0GomkcpHrQk4OrAASXEukd+IUJ03NEHDRkU55O
         rrTx87ljpPJu3effsB/bTZoo9RmOkGGsr76bv9eYiccumAQDC8X+XcECTckVjJFm39NO
         nJuo3IjoXrGKAo1eEFH4tXFcDB3Kvz6XdyNB/6ggRrA9Iyo9Dbp+lZMSLJcQYNP6nHET
         5jUG8j+pHygZz75mQACu/rQezX+kqx/VOd6SzcKJq2SIenF2YAtC3/ACaDsHbmuZaGbu
         h/GQ==
X-Gm-Message-State: AOJu0Ywpbg+4rwJio4f/EzrXsjui4IyCE07WLAIN9dHTWxC8EyQkCg+w
        XiB00fPQYBvWfmljWpj7EhPpaL/x2aQ=
X-Google-Smtp-Source: AGHT+IFp2Pz+pOp/aFYeFRUmrMvmR3U8j8U5gIjALYCSDa+RLFWYAHmdFK9ITbZLy1xqGIaSxJpqICqdkPw=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a05:690c:470e:b0:5cb:d80c:3d34 with SMTP id
 gz14-20020a05690c470e00b005cbd80c3d34mr263835ywb.8.1701122450148; Mon, 27 Nov
 2023 14:00:50 -0800 (PST)
Date:   Mon, 27 Nov 2023 22:00:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127220047.2199234-1-royluo@google.com>
Subject: [PATCH v2] USB: gadget: core: adjust uevent timing on gadget unbind
From:   Roy Luo <royluo@google.com>
To:     royluo@google.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KOBJ_CHANGE uevent is sent before gadget unbind is actually
executed, resulting in inaccurate uevent emitted at incorrect timing
(the uevent would have USB_UDC_DRIVER variable set while it would
soon be removed).
Move the KOBJ_CHANGE uevent to the end of the unbind function so that
uevent is sent only after the change has been made.

Fixes: 2ccea03a8f7e ("usb: gadget: introduce UDC Class")
Signed-off-by: Roy Luo <royluo@google.com>
---
Changes since v1: add Fixes tag
---
 drivers/usb/gadget/udc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index ded9531f141b..d59f94464b87 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1646,8 +1646,6 @@ static void gadget_unbind_driver(struct device *dev)
 
 	dev_dbg(&udc->dev, "unbinding gadget driver [%s]\n", driver->function);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-
 	udc->allow_connect = false;
 	cancel_work_sync(&udc->vbus_work);
 	mutex_lock(&udc->connect_lock);
@@ -1667,6 +1665,8 @@ static void gadget_unbind_driver(struct device *dev)
 	driver->is_bound = false;
 	udc->driver = NULL;
 	mutex_unlock(&udc_lock);
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 }
 
 /* ------------------------------------------------------------------------- */

base-commit: 9b6de136b5f0158c60844f85286a593cb70fb364
-- 
2.43.0.rc1.413.gea7ed67945-goog

