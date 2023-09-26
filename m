Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB00A7AF658
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjIZWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjIZWdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:33:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69814A276
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:29:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690d2441b95so7339859b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695763740; x=1696368540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ7x1sGJs3IwI2EHRWherpwDYB2HwErhY7l2CYJSHl8=;
        b=VJIuaHiWKyIqjyfefgBHHnrzx1bPs6hpgjKgZkpdlvzWpBF1epF9oc6phvRSxezdsF
         2wnyEHTfBcq9kjMIivQIxor8T/f84K53NS8ky5knTzHpKLhghakZ2tXKeRZ4yD+Fz+E3
         zJYrcsrG2SEUInFEiXGd6DYDpAiPd+5Yd2BK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763740; x=1696368540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZ7x1sGJs3IwI2EHRWherpwDYB2HwErhY7l2CYJSHl8=;
        b=U3KZ1wALPZPB6u/LnR3GsvqaETQlgBvae8TQsT0GmH9tXSC+DvbCa0abeVjrpQ1fcQ
         sAYEI+A0WwjzezSJWjA2KsN0uGiQA0FGifRoMZK3p7/E3mSXVdNXEV2k9uyetrzr2xuY
         6qP9YWh8EZ41SI+D7oQqNeGJREH9f1ssa15Z9rFjcf5VrJ8ftUVwGI3ettrdoCmZ840P
         8WLj4rTE7Om+W/J2V7xtk/Ze7/AH4GWW9EjBiaOkcyVx4dyhlr5OcriO5+64gTiC/RIW
         P8k93DIi9n8l0L73e/YpNoikFwW1/0gBbjOeTXS3RPhfDD5ger7AZDhBQ0Vymx2Yxi0g
         S8Pg==
X-Gm-Message-State: AOJu0Yzbl0R034nRyvgqhUVmKkwdhMBz1mVAD0BTtGyKxAqhWzLt2tnm
        bu23JHR3bciiMzRm8ef4t+v3+A==
X-Google-Smtp-Source: AGHT+IGliQVWRvnnGx8nZVCufY9sGes+j8Ixl6hIyxdTACxOhy8mzzlzOZKuwqC7TvNTBKSNs5S2GQ==
X-Received: by 2002:a62:ee06:0:b0:68f:a92a:8509 with SMTP id e6-20020a62ee06000000b0068fa92a8509mr4687125pfi.7.1695763739823;
        Tue, 26 Sep 2023 14:28:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f39:c3f2:a3b:4fcd])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b0068fece2c190sm10337251pfd.70.2023.09.26.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 14:28:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>,
        Douglas Anderson <dianders@chromium.org>, bjorn@mork.no,
        edumazet@google.com, horms@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: [PATCH 3/3] r8152: Block future register access if register access fails
Date:   Tue, 26 Sep 2023 14:27:28 -0700
Message-ID: <20230926142724.3.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926212824.1512665-1-dianders@chromium.org>
References: <20230926212824.1512665-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in the patch ("r8152: Retry register reads/writes"),
much of the r8152 driver doesn't check for error codes when modifying
the adapter's registers. Specifically, the worst part of this appears
to be when the driver does a read-modify-write of a register. If the
read is garbage (because the read failed) and the write succeeds, we
end up writing modified garbage to the adapter and this appears to be
able to hard wedge it.

After we added the retries, it should be nearly impossible to see this
problem. After all, the problem shows up if the register read failed
and _then_ the register write worked. If the read fails for many times
in a row, chances are things are really dead and no future writes will
succeed.

However, nearly impossible isn't actually impossible. To be safe,
let's fully lock out all register access if all of our retries
fail. When we do this, we'll try to queue up a USB reset and try to
unlock register access after the reset. To avoid looping forever,
we'll only attempt this a handful of times.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch was tested with REGISTER_ACCESS_TRIES set to 1, effectively
disabling the patch ("r8152: Retry register reads/writes"). I also
decreased the timeout back to 500ms so I could use kgdb to reproduce
failures. To confirm that the reset queuing worked, I allowed queueing
a reset even if pre-reset was running. That worked fine, but did cause
a double-reset.

 drivers/net/usb/r8152.c | 80 +++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 976d6caf2f04..a7a55849fa1a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -953,6 +953,10 @@ struct r8152 {
 	u8 version;
 	u8 duplex;
 	u8 autoneg;
+
+	bool reg_access_fail;
+	bool in_pre_reset;
+	unsigned int reg_access_reset_count;
 };
 
 /**
@@ -1210,14 +1214,22 @@ static unsigned int agg_buf_sz = 16384;
  */
 #define REGISTER_ACCESS_TRIES	3
 
+/* If register access fails too many times, stop trying to access the registers
+ * and issue a reset to fix the issue.
+ */
+#define REGISTER_ACCESS_MAX_RESETS	3
+
 static
 int r8152_control_msg(struct usb_device *udev, unsigned int pipe, __u8 request,
 		      __u8 requesttype, __u16 value, __u16 index, void *data,
-		      __u16 size, const char *msg_tag)
+		      __u16 size, const char *msg_tag, struct r8152 *tp)
 {
 	int i;
 	int ret;
 
+	if (tp && tp->reg_access_fail)
+		return -EIO;
+
 	for (i = 0; i < REGISTER_ACCESS_TRIES; i++) {
 		ret = usb_control_msg(udev, pipe, request, requesttype,
 				      value, index, data, size,
@@ -1233,14 +1245,54 @@ int r8152_control_msg(struct usb_device *udev, unsigned int pipe, __u8 request,
 			break;
 	}
 
-	if (ret < 0) {
+	if (ret >= 0) {
+		if (tp)
+			tp->reg_access_reset_count = 0;
+
+		if (i != 0)
+			dev_warn(&udev->dev,
+				 "Needed %d tries to %s %d bytes at %#06x/%#06x\n",
+				 i + 1, msg_tag, size, value, index);
+
+		return ret;
+	}
+
+	dev_err(&udev->dev,
+		"Failed to %s %d bytes at %#06x/%#06x (%d)\n",
+		msg_tag, size, value, index, ret);
+
+	/* If tp is NULL then we're called from early probe or from the
+	 * r8153_ecm module. In either case, the retries above are pretty much
+	 * all we can do. Bail.
+	 */
+	if (!tp)
+		return ret;
+
+	/* Block all future register access until we reset. This prevents the
+	 * parts of the driver that do read-modify-write without checking for
+	 * errors from writing back modified garbage to the adapter.
+	 */
+	tp->reg_access_fail = true;
+
+	/* Failing to access registers in pre-reset is not surprising since we
+	 * wouldn't be resetting if things were behaving normally. The register
+	 * access we do in pre-reset isn't truly mandatory--we're just reusing
+	 * the disable() function and trying to be nice by powering the
+	 * adapter down before resetting it.
+	 *
+	 * If we're in pre-reset, we'll return right away and not try to queue
+	 * up yet another reset. We know the post-reset is already coming.
+	 */
+	if (tp->in_pre_reset)
+		return ret;
+
+	if (tp->reg_access_reset_count < REGISTER_ACCESS_MAX_RESETS) {
+		usb_queue_reset_device(tp->intf);
+		tp->reg_access_reset_count++;
+	} else if (tp->reg_access_reset_count == REGISTER_ACCESS_MAX_RESETS) {
 		dev_err(&udev->dev,
-			"Failed to %s %d bytes at %#06x/%#06x (%d)\n",
-			msg_tag, size, value, index, ret);
-	} else if (i != 0) {
-		dev_warn(&udev->dev,
-			 "Needed %d tries to %s %d bytes at %#06x/%#06x\n",
-			 i + 1, msg_tag, size, value, index);
+			"Tried to reset %d times; giving up.\n",
+			REGISTER_ACCESS_MAX_RESETS);
 	}
 
 	return ret;
@@ -1258,7 +1310,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = r8152_control_msg(tp->udev, tp->pipe_ctrl_in,
 				RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-				value, index, tmp, size, "read");
+				value, index, tmp, size, "read", tp);
 
 	if (ret < 0)
 		memset(data, 0xff, size);
@@ -1282,7 +1334,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = r8152_control_msg(tp->udev, tp->pipe_ctrl_out,
 				RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-				value, index, tmp, size, "write");
+				value, index, tmp, size, "write", tp);
 
 	kfree(tmp);
 
@@ -8317,7 +8369,9 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 	napi_disable(&tp->napi);
 	if (netif_carrier_ok(netdev)) {
 		mutex_lock(&tp->control);
+		tp->in_pre_reset = true;
 		tp->rtl_ops.disable(tp);
+		tp->in_pre_reset = false;
 		mutex_unlock(&tp->control);
 	}
 
@@ -8333,6 +8387,10 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	if (!tp)
 		return 0;
 
+	mutex_lock(&tp->control);
+	tp->reg_access_fail = false;
+	mutex_unlock(&tp->control);
+
 	/* reset the MAC address in case of policy change */
 	if (determine_ethernet_addr(tp, &sa) >= 0) {
 		rtnl_lock();
@@ -9542,7 +9600,7 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 	ret = r8152_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 				RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
 				PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
-				"read");
+				"read", NULL);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
-- 
2.42.0.515.g380fc7ccd1-goog

