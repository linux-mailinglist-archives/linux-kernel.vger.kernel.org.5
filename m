Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05577DC50D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjJaDyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjJaDyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:54:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473DDF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:54:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so4486037276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698724450; x=1699329250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2cP+jDgw/2kP2sqdhKr1b6gogBv0upq1OLhtOXXb4qE=;
        b=hUMsp+3QTspn4HUPM16z6tezTZjk0W3dKrjhgyZj0xhrDpWfO8quLgRh4qDfzsfXWR
         /VemPdm0axb9IIEgcy5VUBYtoCWFtj9porV94st3kEAHCpDyZHR09Y7IbKQpgk9BRyxG
         M/eKDMc18yVf3xmBUOIWsTL5e3Vm44JGb3k9yJFYyEZDiYFSrbkfU2BQ/4+0bXe8aQka
         5mzIJtTaK+XsXuc/AhQxM5nz97o2yh1El/nTcwU/mbvQvP/3MklDgFzXYIV8YJ0sAtPD
         Yw6cv2++sX9PaggHpx4A6fo8UPA4oe0CByzz8HJQkDVDa8TEOTb0BaCCu8mFyu2u5PB9
         cVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698724450; x=1699329250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cP+jDgw/2kP2sqdhKr1b6gogBv0upq1OLhtOXXb4qE=;
        b=S4XWEDn0nyaz5q1e8Rhwa1VrRaRtnby4LSltgJoRsIFYiQmG9eJNeWeTcmPhnkLkwv
         oAuC83kNknVKzZX50Wb2faRAOnhtMmRLqNLY47mrMk1L4DBtlLDTnCdMCxySt+YjNf80
         uhfbVywRImDVQSxQPhbC20LgCWk50sCoUL5Xjo0D3NV7Aoak8MGMqish9Hy/PTHs+fj+
         KQQ3CIfPyPvvKMVHKBTk3HF3QkC+CCYFsU8iLFO2labeRt6RBIMj5tZklS1mAgnTHcy5
         6lxRKYBWgBljFADcdi143Px2y33WzQcsaWtIlJbpEkaBh3ekk/lECXz0X8XFv0epgnny
         /BMg==
X-Gm-Message-State: AOJu0YwdRAiC5804gDVw4IZh9BJiiDLVHR44BDAAWiwno9sSlGWsyCgI
        Og3CN2hWmMBI7XKDSPBUgVIN6Qj6ltRp
X-Google-Smtp-Source: AGHT+IHGg0y7OU+iyHQXVt+LK3C1hQ4yiq0V2qpg6y69gt9i7uZwJItKrRflBjP8X+XmHUqg3XuSC9o3kcoZ
X-Received: from maurora-apa.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:1184])
 (user=maurora job=sendgmr) by 2002:a5b:e83:0:b0:da0:6876:a8f4 with SMTP id
 z3-20020a5b0e83000000b00da06876a8f4mr37799ybr.2.1698724450352; Mon, 30 Oct
 2023 20:54:10 -0700 (PDT)
Date:   Tue, 31 Oct 2023 03:54:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031035403.661938-1-maurora@google.com>
Subject: [PATCH] usb: gadget: Support transfers from device memory
From:   Manan Aurora <maurora@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Manan Aurora <maurora@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB gadget stack only supports usb_request objects that point to buffers
located in memory. Support use cases where data is transferred from
physical addresses in device mmio regions

Added a bit "pre_mapped" to usb_request to bypass dma_map_single and
dma_map_sg for such requests

The caller must determine the dma address for the request before queuing
it

Signed-off-by: Manan Aurora <maurora@google.com>
---
 drivers/usb/gadget/udc/core.c | 4 ++--
 include/linux/usb/gadget.h    | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index ded9531f141b..236165ba08f4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -900,7 +900,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_activate);
 int usb_gadget_map_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0)
+	if (req->pre_mapped || req->length == 0)
 		return 0;
 
 	if (req->num_sgs) {
@@ -948,7 +948,7 @@ EXPORT_SYMBOL_GPL(usb_gadget_map_request);
 void usb_gadget_unmap_request_by_dev(struct device *dev,
 		struct usb_request *req, int is_in)
 {
-	if (req->length == 0)
+	if (req->pre_mapped || req->length == 0)
 		return;
 
 	if (req->num_mapped_sgs) {
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index a771ccc038ac..6bc035439098 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -111,6 +111,7 @@ struct usb_request {
 	unsigned		zero:1;
 	unsigned		short_not_ok:1;
 	unsigned		dma_mapped:1;
+	unsigned		pre_mapped:1;
 
 	void			(*complete)(struct usb_ep *ep,
 					struct usb_request *req);
-- 
2.42.0.820.g83a721a137-goog

