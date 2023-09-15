Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F17A2711
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbjIOTTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbjIOTTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:19:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73EE98;
        Fri, 15 Sep 2023 12:19:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABCCC433C8;
        Fri, 15 Sep 2023 19:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694805559;
        bh=O6zKBde/jQeUo4lppmCpOky1iZxcXTpe2NdXo5CtT+k=;
        h=Date:From:To:Cc:Subject:From;
        b=udBm1XbCL5/0ifCYnkf2qJ3cbdstwMq/rAxd67WQQcp3+EJWMFabpDIPT3InuAgxl
         dc4t+yxDE9wFhQVq2rU1ehkXtstoW65Udmk3iflTeYs+8ickHVOnVJNwXZAS6nmKh5
         Gf4VvoP75j65FeMbiMji31mczSwpzVw+xUkiQdxs9gbfFj9Eqn5FOZ190lCOcwA7p5
         1YoDh5XBc0tmkPPQ5t7GUgJVnkr/+x2lbXVtQJSrtQhZRB9Nos9HsIRtqRJSPRT8zk
         lkEduTNvCu53RsDrDUzghpv2wL0VrPPJ4k/XHROZuimlWqt9TJ5GWUKQlLDG03xFNX
         hzac0nz0k+iwg==
Date:   Fri, 15 Sep 2023 13:20:14 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Duncan Sands <duncan.sands@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: atm: Use size_add() in call to struct_size()
Message-ID: <ZQSuboEIhvATAdxN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: b626871a7cda ("usb: atm: Use struct_size() helper")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/atm/usbatm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 1cdb8758ae01..2da6615fbb6f 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -1018,7 +1018,8 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
 	size_t size;
 
 	/* instance init */
-	size = struct_size(instance, urbs, num_rcv_urbs + num_snd_urbs);
+	size = struct_size(instance, urbs,
+			   size_add(num_rcv_urbs, num_snd_urbs));
 	instance = kzalloc(size, GFP_KERNEL);
 	if (!instance)
 		return -ENOMEM;
-- 
2.34.1

