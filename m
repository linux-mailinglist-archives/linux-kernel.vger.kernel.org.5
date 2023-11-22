Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B6C7F438B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbjKVKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjKVKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:19:51 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10043191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:48 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67089696545so25602776d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700648387; x=1701253187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y6RZGZZzUKyI0AjxKgp4LZORspR1wFnVoan2A/smok=;
        b=I/HjlToif65LhLdRS0B35L26u++dsWGjxAPPjcZLEAt73+yV3xFpJT+RYKw4jVJGKG
         w4ETGigoJAzffKSJHdz9fRJu8RmOnM7lGYXdF77FOTkhYnWJn99BXbMbtsvb1pvetZ5L
         MZLpbBxEdhwhW7x0ihj5geRP3EpukcCF9E400=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648387; x=1701253187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y6RZGZZzUKyI0AjxKgp4LZORspR1wFnVoan2A/smok=;
        b=cvwaLGRwgIezbO6lVKaWQKx6cLT4XvQWm1Q1I/pCxOwvDA6Tu+hE8vZWOxtOKsHMK9
         1Sx+rMqTDIUS73pmRWRVFkniR+Qsmgs6oUZm1Qhc72lcuW07dVipClT9K9CEM/WiDfNd
         TkRScTCobZueeOx/+Uj0WnJioTpDfgQI753bkLx1jlXx95xOy/JELQJIBXyTtOYaMlVl
         j/5xsYVq0u/D+CoSatgoj5Ycpqd3n98YrDcWGMRaBTKxMwgj1DBHIJBdjj4/m2vZgOoX
         7a3yy80r+7UnVkxQHnYpBaCVxOPMJbc7w5Gzil6wAzvYl7+T3ul1yBhDZ6XPfj92TsZb
         70Vw==
X-Gm-Message-State: AOJu0YxkDhjYDG6HMRFaF/3ONFZZk1C9RRLofDPkNuP8b8NSM6CouTlm
        qfHzqmZRIIERevrEqmGU9a6zwA==
X-Google-Smtp-Source: AGHT+IFEsCJ45XVX1lArkw/YPBxax3uJbusPHME8iW0AJ3NFgR82vx54nuQtKxpCgoZhDZ7EzAQl9g==
X-Received: by 2002:ad4:5e86:0:b0:672:118e:e368 with SMTP id jl6-20020ad45e86000000b00672118ee368mr2089387qvb.24.1700648387220;
        Wed, 22 Nov 2023 02:19:47 -0800 (PST)
Received: from denia.c.googlers.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id di6-20020ad458e6000000b0066d1d2242desm4739352qvb.120.2023.11.22.02.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:19:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 10:19:35 +0000
Subject: [PATCH v4 2/3] media: uvcvideo: Always use uvc_status_stop()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-guenter-mini-v4-2-3d94e1e34dc1@chromium.org>
References: <20231122-guenter-mini-v4-0-3d94e1e34dc1@chromium.org>
In-Reply-To: <20231122-guenter-mini-v4-0-3d94e1e34dc1@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only thread safe way to stop the status handler is with uvc_status.

Let's remove all the code paths partially stopping uvc_status.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 4 ----
 drivers/media/usb/uvc/uvc_status.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e59a463c2761..8e22a07e3e7b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2765,10 +2765,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
 	struct uvc_entity *entity;
 	unsigned int i;
 
-	/* Can be uninitialized if we are aborting on probe error. */
-	if (dev->async_ctrl.work.func)
-		cancel_work_sync(&dev->async_ctrl.work);
-
 	/* Free controls and control mappings for all entities. */
 	list_for_each_entry(entity, &dev->entities, list) {
 		for (i = 0; i < entity->ncontrols; ++i) {
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index a78a88c710e2..0208612a9f12 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
-	usb_kill_urb(dev->int_urb);
+	uvc_status_stop(dev);
 	uvc_input_unregister(dev);
 }
 

-- 
2.43.0.rc1.413.gea7ed67945-goog

