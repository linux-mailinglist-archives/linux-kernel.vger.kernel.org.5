Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB70F7DC4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjJaDqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjJaDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:46:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB35E8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:46:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da1aa98ec19so3959987276.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698724008; x=1699328808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XLDwkSvHH9wdnTtbtMwEJ+1MXhphfGEAd2XlaB9k1Nc=;
        b=fjOO6srOlaep4/iSPOs838d5D3tYwuJ8cjzhx9WKa/aQNxL/hVwuzFKGwjguKxk7uC
         +4JZatS1dqPAxmKvdEY/fh1g5JBm2OgNvSOqHOszkrOfIKa5+XbI50tHvCQao+n8xwbl
         oH8HBNmY9ZVjYtSVRjk9OyPWTu60yEZQ/2j698jg2ojP/BiqYYc4HwxXQ8nBdGgN01sx
         B3phBnL+GfHk6fmwygpvpiS95x/M1pHSLGM6yV+4p12Jtn1UsueD5Z+sYZCosBopGC29
         qcVb2cugIsAzBGl2Nd5X3n/kgz19QuCq5YaeHsuJ+abFriXJW50zFJr6m4MDAblTrlQ2
         WLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698724008; x=1699328808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLDwkSvHH9wdnTtbtMwEJ+1MXhphfGEAd2XlaB9k1Nc=;
        b=P1LABJSNnpj1QFXGRDlW1pSpOnO6IRJURjfvBO5wMuMz82Sarngov2Zo1x4B97eGWM
         lErVDGGztHW1ogIunipB4D5AFEtZr1DgjhEc9UQhPP2FDG6elwgph1O5qRi/Jti6KrYN
         RMQS7xu2bMpRj8coxj2SUHK33lwgsQkxeqOk8PJcqlgq/Im/MGQWRu9lvM1JugAN/yi3
         Nn3+kR5VNi1tnbVj3IpFYpzS04IYbgoLp/0GQ5/CCzBlrFLwsLiPO17mHHasz4s8NN7B
         RG8epMX9qAPU+4hGtwfOvwR0NFOSPlg1kcSYBXDraKft1z/S1XUcwhjq7FHmcfvB5q1B
         C5oA==
X-Gm-Message-State: AOJu0YzMTICohPdHJ3Y/PRqeLd7jaHrBnffZzhsC+uoZpzZkzrFqFJai
        Wav0N3O0qZYLG5VaTlL47eZ3W+b3YI7I
X-Google-Smtp-Source: AGHT+IF3tuZqB3jnScYggN4DVKsq1S9lGHS1D1+k8sI5gTcavbD4kXrSGzWArI8YRXyO8uCMehXkVW8twUo3
X-Received: from maurora-apa.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1184])
 (user=maurora job=sendgmr) by 2002:a25:68cc:0:b0:da0:622b:553b with SMTP id
 d195-20020a2568cc000000b00da0622b553bmr206246ybc.12.1698724008159; Mon, 30
 Oct 2023 20:46:48 -0700 (PDT)
Date:   Tue, 31 Oct 2023 03:46:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031034641.660606-1-maurora@google.com>
Subject: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
From:   Manan Aurora <maurora@google.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Manan Aurora <maurora@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support configuration and use of bulk endpoints in the so-called EBC
mode described in the DBC_usb31 databook (appendix E)

Added a bit fifo_mode to usb_ep to indicate to the UDC driver that a
specific endpoint is to operate in the EBC (or equivalent) mode when
enabled

Added macros for bits 15 and 14 of DEPCFG parameter 1 to indicate EBC
mode and write back behaviour. These bits will be set to 1 when
configuring an EBC endpoint as described in the programming guide

Signed-off-by: Manan Aurora <maurora@google.com>
---
 drivers/usb/dwc3/core.h    | 1 +
 drivers/usb/dwc3/gadget.c  | 6 ++++++
 drivers/usb/dwc3/gadget.h  | 2 ++
 include/linux/usb/gadget.h | 1 +
 4 files changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index efe6caf4d0e8..c5b578188cd3 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -374,6 +374,7 @@
 /* Global HWPARAMS4 Register */
 #define DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(n)	(((n) & (0x0f << 13)) >> 13)
 #define DWC3_MAX_HIBER_SCRATCHBUFS		15
+#define DWC3_EXT_BUFF_CONTROL		BIT(21)
 
 /* Global HWPARAMS6 Register */
 #define DWC3_GHWPARAMS6_BCSUPPORT		BIT(14)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..47d2737d528b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -673,6 +673,12 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 		params.param1 |= DWC3_DEPCFG_BINTERVAL_M1(bInterval_m1);
 	}
 
+	if (dep->endpoint.fifo_mode) {
+		if (!(dwc->hwparams.hwparams4 & DWC3_EXT_BUFF_CONTROL))
+			return -EINVAL;
+		params.param1 |= DWC3_DEPCFG_EBC_HWO_NOWB | DWC3_DEPCFG_USE_EBC;
+	}
+
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 55a56cf67d73..fd7a4e94397e 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -26,6 +26,8 @@ struct dwc3;
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	BIT(10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	BIT(11)
 #define DWC3_DEPCFG_STREAM_EVENT_EN	BIT(13)
+#define DWC3_DEPCFG_EBC_HWO_NOWB	BIT(14)
+#define DWC3_DEPCFG_USE_EBC		BIT(15)
 #define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	BIT(24)
 #define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 6532beb587b1..a771ccc038ac 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -236,6 +236,7 @@ struct usb_ep {
 	unsigned		max_streams:16;
 	unsigned		mult:2;
 	unsigned		maxburst:5;
+	unsigned		fifo_mode:1;
 	u8			address;
 	const struct usb_endpoint_descriptor	*desc;
 	const struct usb_ss_ep_comp_descriptor	*comp_desc;
-- 
2.42.0.820.g83a721a137-goog

