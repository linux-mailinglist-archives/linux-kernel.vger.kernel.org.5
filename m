Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A97F52E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbjKVWAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjKVWAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:00:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32311D42
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:00:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db402e6f61dso290027276.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700690433; x=1701295233; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VwCvT/dsp9D8lLZGUBpN5q/USmNxw15gs9X4QsQc4Fw=;
        b=HUXhGEt3+RyaICITA+kxA/raWwRmc84BK8ty5mBc3fNNOW2GzaMqPO6h6rW9fn1Y3S
         SowvS6i7ASfOU3lrCeMzESaQ5US0M8fpzPyEKMQkho8Z3kYYuOcLIcBsGzq9m2QFkYhC
         5uxo5ueuWka/ZHy8xsUkGMjgRwJBnAPKWO5OmXvICbdKwMomLRsRCLjxK6+azNwh4aoO
         nMRrExoegLVwg8hh85csq5HP1T0U+Kj2PCbGg4SQ9bs5XLSu5uOPPDqet5y4YxYSoDOT
         PSEEf2Kt46AIT8iX6wTFemfcuCm5pXwFqgQEA1U3jvv+uAtbBzS2tQOYmA/yqZfjsGun
         TwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700690433; x=1701295233;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwCvT/dsp9D8lLZGUBpN5q/USmNxw15gs9X4QsQc4Fw=;
        b=hQ9hjYH62UPNEn30RMM0mCDy4RX8CS9iVn/StYtLidxi3dvAWwvcnKi7XRSuazrywX
         Loys3zd1vvO3F1t12WVAZU/NitH+DsYhu6vQAro/J8HxPCwyANM1NlSLxap/eago1deK
         QPJlEPT7/C1u18/QKuKW7kYcQws0yw9ShHraVouljEj6sOI+GM5twAMmt9g0iUbWvuV0
         M9rODy74poPj2mgo9coZjYxKKkaG2L6s0jk73tZ1vajQKkqiD1TRFWbaPfX1XPfEXveB
         V33aJE6vm47c8s2xZ7jCp4mkClinFpYRMSvD2hEVpaxFaU5npmy3NO9PWzmPu4+9SbB3
         cBnQ==
X-Gm-Message-State: AOJu0YzqEPIGjYQwxftQ2NbjhA/yYV1qda61Amw5dXA9k6xwkJAshOqs
        RTPBId60kY3XnSd53IzGjxRq+RipaP0=
X-Google-Smtp-Source: AGHT+IEL/pnocvmHrn/XYSGAEzDzJqnyX/9eKAwjY8bggLVmf7lFsaiKZ+3bWBDNgqFZD6COkVyjYJ51Afg=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a25:2d1:0:b0:da3:b4ef:29fe with SMTP id
 200-20020a2502d1000000b00da3b4ef29femr100305ybc.13.1700690433222; Wed, 22 Nov
 2023 14:00:33 -0800 (PST)
Date:   Wed, 22 Nov 2023 22:00:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122220001.539770-1-royluo@google.com>
Subject: [PATCH v1] USB: gadget: core: adjust uevent timing on gadget unbind
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Roy Luo <royluo@google.com>
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

