Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBDF7DA097
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbjJ0SfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjJ0SfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:35:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23110BD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:34:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da13698a6d3so863451276.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698431691; x=1699036491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2KQL5mvly38v1BFhse+1fz0BAqnm18zxyTLFh/7tsk=;
        b=Z5ILT5hvKkDIHkefyZ7DIbBIF4l+w7ELSsLPK5m/QuyaiH5Aw4BbDIsLkqFnnFA3TB
         4Fv/axwSRpcfIKikQYYzcPYcM5mhIGd7cT8dvN18RQjgxCIHQxeQXDxfw5ih6bFTvI1a
         dp8lsS19F67GlMSvqFtbIU+owE7wY/WB6rmv+WG/LosTg3PLLncwFyKk98j6HU1toKRX
         yh9ZGH06yCf2KOkXRcK/WFCXc88PdlO3vua+PPrukDveeKhed+rs1ARycDwM5HnLdmEJ
         lbyBWXBoH5jtUlzy6JMj1QJ62nVcto3fPQy5btlPoY2DMdfpIpDxiWWXkaAhbyUy07/p
         bHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698431691; x=1699036491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2KQL5mvly38v1BFhse+1fz0BAqnm18zxyTLFh/7tsk=;
        b=HrXLZKKqdl24btimw0e9tko4pLJM7520EBlytnVJ8DfSUnuoZNTY6g8EwuHUgG5nhF
         zy9+Pat1uAYLcpaw1foXjtO0v2V+3ube8Qu6pUWCE1wfq0Nu8NQn42ErQo9G16RI4u7W
         I+vq/eTX0fhXqUd0LsyCsd0hA87vEccRHhEhSEO+yVaJhev0z5roh4SWCsYKdagImXmc
         HxOlKebiN4ddzOfdI4P1kk9dgdYeZBWEvx7Vs6ZwG/Xvxx6+DRAKfiIM8Gqm7DwgUfil
         PyhZu5CNVvuBZCeCeOQ3rwPjMxw8rcwsedeeWSYR+aqkF/VpL9yLJds4JIUjrAk+NNXd
         3uLQ==
X-Gm-Message-State: AOJu0YyldEK8pV5PEAjoIZ5Nlkvmw4IHJj8xGoCwvckY5OWPaIB/Ti+U
        FtGa5rnpEVOksTvuwrYXlgzlfURu/5aD4Wff7Q==
X-Google-Smtp-Source: AGHT+IHO7TfvuhqtaNPamSWCx8oIFoDkAauEh146HYvDhEqkkJsUEpXQ/mGMMdFvo6VFXYCnA+3y2HxsYhlkjW1YXQ==
X-Received: from shuzhenwang.mtv.corp.google.com ([2620:15c:211:201:c5e7:1675:d0d:2a4c])
 (user=shuzhenwang job=sendgmr) by 2002:a05:6902:565:b0:da0:c979:fd70 with
 SMTP id a5-20020a056902056500b00da0c979fd70mr70535ybt.9.1698431691381; Fri,
 27 Oct 2023 11:34:51 -0700 (PDT)
Date:   Fri, 27 Oct 2023 11:34:40 -0700
In-Reply-To: <14ceb63f-1769-4025-ad90-c38112dfec79@google.com>
Mime-Version: 1.0
References: <14ceb63f-1769-4025-ad90-c38112dfec79@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027183440.1994315-1-shuzhenwang@google.com>
Subject: [PATCH v2] usb: gadget: uvc: Add missing initialization of ssp config descriptor
From:   Shuzhen Wang <shuzhenwang@google.com>
To:     shuzhenwang@google.com, gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
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

In case the uvc gadget is super speed plus, the corresponding config
descriptor wasn't initialized. As a result, the host will not recognize
the devices when using super speed plus connection.

This patch initializes them to super speed descriptors.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Shuzhen Wang <shuzhenwang@google.com>
---
 v2: fix patch formatting

 drivers/usb/gadget/function/f_uvc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index faa398109431..786379f1b7b7 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -516,6 +516,7 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 	void *mem;
 
 	switch (speed) {
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		uvc_control_desc = uvc->desc.ss_control;
 		uvc_streaming_cls = uvc->desc.ss_streaming;
@@ -564,7 +565,8 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 		bytes += uvc_interrupt_ep.bLength + uvc_interrupt_cs_ep.bLength;
 		n_desc += 2;
 
-		if (speed == USB_SPEED_SUPER) {
+		if (speed == USB_SPEED_SUPER ||
+		    speed == USB_SPEED_SUPER_PLUS) {
 			bytes += uvc_ss_interrupt_comp.bLength;
 			n_desc += 1;
 		}
@@ -619,7 +621,8 @@ uvc_copy_descriptors(struct uvc_device *uvc, enum usb_device_speed speed)
 
 	if (uvc->enable_interrupt_ep) {
 		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_interrupt_ep);
-		if (speed == USB_SPEED_SUPER)
+		if (speed == USB_SPEED_SUPER ||
+		    speed == USB_SPEED_SUPER_PLUS)
 			UVC_COPY_DESCRIPTOR(mem, dst, &uvc_ss_interrupt_comp);
 
 		UVC_COPY_DESCRIPTOR(mem, dst, &uvc_interrupt_cs_ep);
@@ -795,6 +798,13 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 		goto error;
 	}
 
+	f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
+	if (IS_ERR(f->ssp_descriptors)) {
+		ret = PTR_ERR(f->ssp_descriptors);
+		f->ssp_descriptors = NULL;
+		goto error;
+	}
+
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
-- 
2.42.0.820.g83a721a137-goog

