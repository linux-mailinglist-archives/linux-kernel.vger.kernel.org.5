Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADA7DED8B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjKBHiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjKBHiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:38:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33413A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:38:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afbcffe454so14358157b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698910726; x=1699515526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LGFCJdqQxn9oQK435WcXslLgFBam9J/xIR0uzxICWZc=;
        b=oAL8lnC8C6v7HwEB6QhUwr0yyv32Q3K6+EJwFYgYqJ/XvGE96d0v3NGqhm3moMtktb
         8XmMHa2Oqns1GuEat0a5EMMpm7OUNTPHS3Lwoe9NsihTenXhLtyfvViNvC889bEle4rJ
         eovFgD7jbGiooV16j6BEcTjK0ZMVNm1yexKL0N6DYJRXiNRcQzq7xEzdk93F1sbqVUOw
         Kwxoaupdwyc1tasw2Oaq4ph2n1PD5CIKx774o6SlDMxf1Fsr53MLugYbsWi/veD/Hn1/
         iAvKZsFYTY5ModLguSzpS0J8f/1L8vlMpID2Bb3CQl9bnU54zl96vlWJx3cnJZ3Z6SLw
         hLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698910726; x=1699515526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGFCJdqQxn9oQK435WcXslLgFBam9J/xIR0uzxICWZc=;
        b=LoIS40J5YMUVAtvDRBEhasMiWynE82Ytszp2O7QFNJUE4mhNBIqszhD1VPissRztaw
         LLwQynIuhGZGbPFsgWJ6d3XJGFOZ8lJibqEWgVKN/edSZVKOUwnffNNS2rHgAPMkHcYa
         2j5cJ81TN0WETBvKXu6xyDvVRBgXx8QKtPMJbYPZWmjR0SjTeYcZ5Ca5i0focHJLY/Vx
         ErygyDrMO3fJXFJfYtCKZPgZ+DbepnJQetauFuBCeBxlbhv9xwlv0ALSACZe2Trq5qb7
         0ktsmcXcdhk76nzw44jMejcLqTWpnUD4Y1tQ9SlVTMQhtIjI51rCWdYQ5kUCpMBXYjQf
         iETQ==
X-Gm-Message-State: AOJu0YwYywWF+WaRTgqoqFbg3oXq2L5RfByXbOP9Fted8G2mxeTBUUqh
        yER+4XbZlDNghYgU8glmnF5hRsay//AB
X-Google-Smtp-Source: AGHT+IG+tTos8laLfIX9e5/iwUpTAZExM/+m86dYIDWNBa1YzBAkHxzJSrlMchNnfQREXc/DRykLZa0780V1
X-Received: from maurora-apa.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1184])
 (user=maurora job=sendgmr) by 2002:a81:83c8:0:b0:59b:ccba:1249 with SMTP id
 t191-20020a8183c8000000b0059bccba1249mr416235ywf.10.1698910726644; Thu, 02
 Nov 2023 00:38:46 -0700 (PDT)
Date:   Thu,  2 Nov 2023 07:38:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231102073840.1579540-1-maurora@google.com>
Subject: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
From:   Manan Aurora <maurora@google.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, badhri@google.com,
        Manan Aurora <maurora@google.com>
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
 include/linux/usb/gadget.h | 4 ++++
 4 files changed, 13 insertions(+)

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
index 6532beb587b1..c526ae09bcee 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -209,6 +209,9 @@ struct usb_ep_caps {
  *	by this EP (0 - 16, actual number is 2^n)
  * @mult: multiplier, 'mult' value for SS Isoc EPs
  * @maxburst: the maximum number of bursts supported by this EP (for usb3)
+ * @fifo_mode: indicates that the control of this EP is handed off to an
+ *	hardware fifo device. Depends on hardware support eg. EBC feature
+ *	of DWC usb3.1 device or equivalent. Set before enabling the EP
  * @driver_data:for use by the gadget driver.
  * @address: used to identify the endpoint when finding descriptor that
  *	matches connection speed
@@ -236,6 +239,7 @@ struct usb_ep {
 	unsigned		max_streams:16;
 	unsigned		mult:2;
 	unsigned		maxburst:5;
+	unsigned		fifo_mode:1;
 	u8			address;
 	const struct usb_endpoint_descriptor	*desc;
 	const struct usb_ss_ep_comp_descriptor	*comp_desc;
-- 
2.42.0.820.g83a721a137-goog

