Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9095A7AC0DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjIWKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIWKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:54:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDE19C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 03:54:28 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id k0HKqXroxN7Qtk0HKqgwxU; Sat, 23 Sep 2023 12:54:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695466467;
        bh=o6dXl6wZ2p8h+DtX0RSVtic+N8fFWJdpYZ/8V5pO/+o=;
        h=From:To:Cc:Subject:Date;
        b=mcQykgLvv5hKI2mZozZzRXVLylMgYxnioHBSXfRif9ZDjE83Z/OAuwY+RqsnqOzpM
         Q68eBhNpcMD3XG+M/8YAjS9naOqitumOm5q4mvb78YMGynFQTHdaaExjWFnVBxO9Gj
         SQr626Hk9TehEbEinQ7CSVJbmBhL6sV93okVDGlKXVcsLRW52qDyde59c5zzkBf79l
         pXA+8Np6xLdKu+z9sgMh91E25QQ3z0U1PZicqI15p26rDfiqUhPUWBG7HYO3WMj8zw
         qSF5HPBSe1BCEX3yMey2QOBg8RkJzalbPZvVlI4vWGORh2jOhE/qGwzIFyAH5su7S7
         ybkC0BMuGIQJA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Sep 2023 12:54:27 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Dooks <ben@simtec.co.uk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc2: gadget: Fix a warning when compiling with W=1
Date:   Sat, 23 Sep 2023 12:54:24 +0200
Message-Id: <5cf603809388aa04c9a02bbfe3cf531c20bb043e.1695466447.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to teach the compiler that 'hs_ep->name' will never be truncated,
we need to tell it that 'epnum' is not negative.

'epnum' comes from in a 'for' loop in dwc2_gadget_init(), starting at 0
and ending at 255. (hsotg->num_of_eps is a char)

When building with W=1, this fixes the following warnings:

  drivers/usb/dwc2/gadget.c: In function ‘dwc2_hsotg_initep’:
  drivers/usb/dwc2/gadget.c:4804:55: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Werror=format-truncation=]
   4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
        |                                                       ^~
  drivers/usb/dwc2/gadget.c:4804:52: note: directive argument in the range [-2147483645, 255]
   4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
        |                                                    ^~~~~~~~
  drivers/usb/dwc2/gadget.c:4804:9: note: ‘snprintf’ output between 6 and 17 bytes into a destination of size 10
   4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 5b7d70c6dbf2 ("USB: Gadget driver for Samsung HS/OtG block")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Only changing:
  -	int epnum;
  +	unsigned int epnum;
is enought to fix the build warning.

But changing the prototype of dwc2_hsotg_initep() and the printf() format
as well, to make obvious that epnum is >= 0, looks more logical to me.
---
 drivers/usb/dwc2/gadget.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index b517a7216de2..102b2dd8113e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4786,8 +4786,8 @@ static const struct usb_gadget_ops dwc2_hsotg_gadget_ops = {
  */
 static void dwc2_hsotg_initep(struct dwc2_hsotg *hsotg,
 			      struct dwc2_hsotg_ep *hs_ep,
-				       int epnum,
-				       bool dir_in)
+			      unsigned int epnum,
+			      bool dir_in)
 {
 	char *dir;
 
@@ -4801,7 +4801,7 @@ static void dwc2_hsotg_initep(struct dwc2_hsotg *hsotg,
 	hs_ep->dir_in = dir_in;
 	hs_ep->index = epnum;
 
-	snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%d%s", epnum, dir);
+	snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%u%s", epnum, dir);
 
 	INIT_LIST_HEAD(&hs_ep->queue);
 	INIT_LIST_HEAD(&hs_ep->ep.ep_list);
@@ -4965,7 +4965,7 @@ static void dwc2_hsotg_dump(struct dwc2_hsotg *hsotg)
 int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 {
 	struct device *dev = hsotg->dev;
-	int epnum;
+	unsigned int epnum;
 	int ret;
 
 	/* Dump fifo information */
-- 
2.34.1

