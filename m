Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E27FC94E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376462AbjK1WRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376288AbjK1WRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:17:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14052D42
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:18:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daed1e15daeso7883075276.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701209879; x=1701814679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gtOvYyh8TGYD6IrQq8VICCerYbS5GRseWpF/kithmZE=;
        b=ULD2cjSQkohEETdlH+cvO1fMkphoK7YHLoDcr+B6kHrGgMGh2NdpEFaK0MlL0rdH3S
         yY9/4+26aqjaQoRAwy2Cl4q0FbAfxQ6uDSntqoTvgRmeW4ajgTFLklmuZKWiqbzy8wk6
         F78SKWywxNy12tDfJVlhnFE2+vbAo2ysz6eiL8N5EaKrYdaWA/xoM2ZPA0pOc1MLKF3o
         LKEUfsZHO71RMG7RZn0O16Qw7B/knKsnDtEXSGDjs6zKXLauFRNg0CnAGO/m3hsxg2UT
         3HFdHMgXQ7mwqigkpsWAmoyOHGA7VpzSj9hgpSmxmAiO1VXoNuGpHJVZ+o0db4zeoiRJ
         viqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701209879; x=1701814679;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtOvYyh8TGYD6IrQq8VICCerYbS5GRseWpF/kithmZE=;
        b=l40aGuqi4vAsfg3ku57KDd4D8p+MoJNLw3qrbrExZuovJbDVeq4VT09SrRddMq3cRO
         aAY5xotNcu5lDJPvayk5CoqLKJUdwya5BWAD9PtTaikZji5oW6ANsWxS5YG5XftbbV3D
         ZIFveuETrVgsTms1h0CqhMLxpEl5FJXhWSrn5/lQwh7hA3n+lQFUDQNRAenLRXx8smgX
         CfHMRHcv36Z9+nvfrFSx04znUR1SwDM5QIVQE7st9KDHBqtCy4nEJyP3u1ZVEiJaMKa3
         dG1/3oX0ABAc2y+hdcAr1KSJGjEheEb03URMRO2ZZnZXy98LeelaNeCS4ba982jF1Xxk
         XegA==
X-Gm-Message-State: AOJu0Yxg4AJASw03Qk8JQTrpohFHg28YlSvS4ip/HAU+aLH7OcIJ4pju
        pjTA4vlUcES2Xh+7xKu9Q8j4DRISNx4=
X-Google-Smtp-Source: AGHT+IGQUntYpd/ff69xHUeLkNoISStZOZyRssWrSNWB1MYAnQBnISSg8Bi84PrhRI3g/WQcGy4hwxgjaas=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a25:cf8e:0:b0:daf:d9a1:ef48 with SMTP id
 f136-20020a25cf8e000000b00dafd9a1ef48mr493929ybg.9.1701209879262; Tue, 28 Nov
 2023 14:17:59 -0800 (PST)
Date:   Tue, 28 Nov 2023 22:17:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128221756.2591158-1-royluo@google.com>
Subject: [PATCH v3] USB: gadget: core: adjust uevent timing on gadget unbind
From:   Roy Luo <royluo@google.com>
To:     royluo@google.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
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
Cc: stable@vger.kernel.org
Signed-off-by: Roy Luo <royluo@google.com>
---
Changes since v1: add Fixes tag
Changes since v2: add cc stable@vger.kernel.org
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

