Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECBE7B8D59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244452AbjJDT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbjJDT1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:27:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E823C10F
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:26:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c736b00639so884685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696447618; x=1697052418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yUN7CDK7tdnHnhEo0ihBj9Nx/WrF19COgm2gecWY5o=;
        b=morGGIos0ErE6JYiwbUX8Ef1Xc5wT8hALdwGEXu5P2vbkohd47uoft80UKsFyYBPfr
         pk7G5l3Ird1dKgZrZx79uK3Myn2vaU4T8m+I7/iXyPAjbcSq2xYk1/ChEkR8KKsrAbrh
         W2aLMHjoPt2z8/qgOvWMabCdf3n2n+n1rh540=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447618; x=1697052418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yUN7CDK7tdnHnhEo0ihBj9Nx/WrF19COgm2gecWY5o=;
        b=YYDFHDxEDwf15XTjMKDtFizPhSLby9sMX+0nMCJ7FXY0U1Vn20+I/D+DtYPcPBMSa6
         z4nk84L2o76/zYF+9p/Tu540zxPB+zNRZhbTV2XiF4+/BfpDUZVtzNC3gZzdJty9bldW
         hJHqA5fDwKOxxTPJAAScvWUDUKHSii/XThwhguraCLCPjErxcYul8ABjlQS6vqYgpQUe
         h5SSYAT0sbGQ4YUIG8hzXaVVCycPdw1p92p5pko1McHpHhToqPCGFsKUYMMsXzObgSs7
         f8tF4CvGQaseg6wVBDI2dOAb+GDnfIdh5fTc4S1UrRuEZMeCkX40JT/5SdV6+tETWOqw
         HpcA==
X-Gm-Message-State: AOJu0YxY1FgPz7djZEMVPTi9u90hnv+IabGWm9KHoelOLSkdbj0TR0L5
        x8Yji4RzLtHVsB1UUH+tX59Psg==
X-Google-Smtp-Source: AGHT+IFBhr3cgEEHlLdL7vsDLDynYtLxUS9+MdfPrrviEyiTJkEQRnCanyhPFTfpBhqpKrumR5WjwA==
X-Received: by 2002:a17:902:720a:b0:1c4:72c9:64ef with SMTP id ba10-20020a170902720a00b001c472c964efmr3181928plb.40.1696447618322;
        Wed, 04 Oct 2023 12:26:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9cce:13a8:f2b8:b799])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b0057c29fec795sm3649151pga.37.2023.10.04.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:26:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 5/5] r8152: Block future register access if register access fails
Date:   Wed,  4 Oct 2023 12:24:42 -0700
Message-ID: <20231004122435.v2.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231004192622.1093964-1-dianders@chromium.org>
References: <20231004192622.1093964-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the functions to read/write registers can fail, most of
the places in the r8152 driver that read/write register values don't
check error codes. The lack of error code checking is problematic in
at least two ways.

The first problem is that the r8152 driver often uses code patterns
similar to this:
  x = read_register()
  x = x | SOME_BIT;
  write_register(x);

...with the above pattern, if the read_register() fails and returns
garbage then we'll end up trying to write modified garbage back to the
Realtek adapter. If the write_register() succeeds that's bad. Note
that as of commit f53a7ad18959 ("r8152: Set memory to all 0xFFs on
failed reg reads") the "garbage" returned by read_register() will at
least be consistent garbage, but it is still garbage.

It turns out that this problem is very serious. Writing garbage to
some of the hardware registers on the Ethernet adapter can put the
adapter in such a bad state that it needs to be power cycled (fully
unplugged and plugged in again) before it can enumerate again.

The second problem is that the r8152 driver generally has functions
that are long sequences of register writes. Assuming everything will
be OK if a random register write fails in the middle isn't a great
assumption.

One might wonder if the above two problems are real. You could ask if
we would really have a successful write after a failed read. It turns
out that the answer appears to be "yes, this can happen". In fact,
we've seen at least two distinct failure modes where this happens.

On a sc7180-trogdor Chromebook if you drop into kdb for a while and
then resume, you can see:
1. We get a "Tx timeout"
2. The "Tx timeout" queues up a USB reset.
3. In rtl8152_pre_reset() we try to reinit the hardware.
4. The first several (2-9) register accesses fail with a timeout, then
   things recover.

The above test case was actually fixed by the patch ("r8152: Increase
USB control msg timeout to 5000ms as per spec") but at least shows
that we really can see successful calls after failed ones.

On a different (AMD) based Chromebook with a particular adapter, we
found that during reboot tests we'd also sometimes get a transitory
failure. In this case we saw -EPIPE being returned sometimes. Retrying
worked, but retrying is not always safe for all register accesses
since reading/writing some registers might have side effects (like
registers that clear on read).

Let's fully lock out all register access if a register access fails.
When we do this, we'll try to queue up a USB reset and try to unlock
register access after the reset. This is slightly tricker than it
sounds since the r8152 driver has an optimized reset sequence that
only works reliably after probe happens. In order to handle this, we
avoid the optimized reset if probe didn't finish.

When locking out access, we'll use the existing infrastructure that
the driver was using when it detected we were unplugged. This keeps us
from getting stuck in delay loops in some parts of the driver.

- Reset patch no longer based on retry patch, since that was dropped.
- Reset patch should be robust even if failures happen in probe.
- Switched booleans to bits in the "flags" variable.
- Check for -ENODEV instead of "udev->state == USB_STATE_NOTATTACHED"

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Originally when looking at this problem I thought that the obvious
solution was to "just" add better error handling to the driver. This
_sounds_ appealing, but it's a massive change and touches a
significant portion of the lines in this driver. It's also not always
obvious what the driver should be doing to handle errors.

(no changes since v1)

 drivers/net/usb/r8152.c | 176 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 159 insertions(+), 17 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 151c3c383080..ec9f4973f150 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -773,6 +773,8 @@ enum rtl8152_flags {
 	SCHEDULE_TASKLET,
 	GREEN_ETHERNET,
 	RX_EPROTO,
+	IN_PRE_RESET,
+	PROBED_WITH_NO_ERRORS,
 };
 
 #define DEVICE_ID_LENOVO_USB_C_TRAVEL_HUB		0x721e
@@ -953,6 +955,8 @@ struct r8152 {
 	u8 version;
 	u8 duplex;
 	u8 autoneg;
+
+	unsigned int reg_access_reset_count;
 };
 
 /**
@@ -1200,6 +1204,91 @@ static unsigned int agg_buf_sz = 16384;
 
 #define RTL_LIMITED_TSO_SIZE	(size_to_mtu(agg_buf_sz) - sizeof(struct tx_desc))
 
+/* If register access fails then we block access and issue a reset. If this
+ * happens too many times in a row without a successful access then we stop
+ * trying to reset and just leave access blocked.
+ */
+#define REGISTER_ACCESS_MAX_RESETS	3
+
+static void rtl_set_inaccessible(struct r8152 *tp)
+{
+	set_bit(RTL8152_INACCESSIBLE, &tp->flags);
+	smp_mb__after_atomic();
+}
+
+static void rtl_set_accessible(struct r8152 *tp)
+{
+	clear_bit(RTL8152_INACCESSIBLE, &tp->flags);
+	smp_mb__after_atomic();
+}
+
+static
+int r8152_control_msg(struct r8152 *tp, unsigned int pipe, __u8 request,
+		      __u8 requesttype, __u16 value, __u16 index, void *data,
+		      __u16 size, const char *msg_tag)
+{
+	struct usb_device *udev = tp->udev;
+	int ret;
+
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		return -ENODEV;
+
+	ret = usb_control_msg(udev, pipe, request, requesttype,
+			      value, index, data, size,
+			      USB_CTRL_GET_TIMEOUT);
+
+	/* No need to issue a reset report an error if the USB device got
+	 * unplugged; just return immediately.
+	 */
+	if (ret == -ENODEV)
+		return ret;
+
+	/* If the write was successful then we're done */
+	if (ret >= 0) {
+		tp->reg_access_reset_count = 0;
+		return ret;
+	}
+
+	dev_err(&udev->dev,
+		"Failed to %s %d bytes at %#06x/%#06x (%d)\n",
+		msg_tag, size, value, index, ret);
+
+	/* Block all future register access until we reset. Much of the oode
+	 * in the driver doesn't check for errors. Notably, many parts of the
+	 * driver do a read/modify/write of a register value without
+	 * confirming that the read succeeded. Writing back modified garbage
+	 * like this can fully wedge the adapter, requiring a power cycle.
+	 */
+	rtl_set_inaccessible(tp);
+
+	/* Failing to access registers in pre-reset is not surprising since we
+	 * wouldn't be resetting if things were behaving normally. The register
+	 * access we do in pre-reset isn't truly mandatory--we're just reusing
+	 * the disable() function and trying to be nice by powering the
+	 * adapter down before resetting it. Thus, if we're in pre-reset,
+	 * we'll return right away and not try to queue up yet another reset.
+	 * We know the post-reset is already coming.
+	 *
+	 * We'll also return right away if we haven't finished probe. At the
+	 * end of probe we'll queue the reset just to make sure it doesn't
+	 * timeout.
+	 */
+	if (test_bit(IN_PRE_RESET, &tp->flags) ||
+	    !test_bit(PROBED_WITH_NO_ERRORS, &tp->flags))
+		return ret;
+
+	if (tp->reg_access_reset_count < REGISTER_ACCESS_MAX_RESETS) {
+		usb_queue_reset_device(tp->intf);
+		tp->reg_access_reset_count++;
+	} else if (tp->reg_access_reset_count == REGISTER_ACCESS_MAX_RESETS) {
+		dev_err(&udev->dev,
+			"Tried to reset %d times; giving up.\n",
+			REGISTER_ACCESS_MAX_RESETS);
+	}
+
+	return ret;
+}
+
 static
 int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 {
@@ -1210,9 +1299,10 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 	if (!tmp)
 		return -ENOMEM;
 
-	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
-			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
+	ret = r8152_control_msg(tp, tp->pipe_ctrl_in,
+				RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
+				value, index, tmp, size, "read");
+
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1233,9 +1323,9 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 	if (!tmp)
 		return -ENOMEM;
 
-	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
-			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
+	ret = r8152_control_msg(tp, tp->pipe_ctrl_out,
+				RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
+				value, index, tmp, size, "write");
 
 	kfree(tmp);
 
@@ -1244,10 +1334,8 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 static void rtl_set_unplug(struct r8152 *tp)
 {
-	if (tp->udev->state == USB_STATE_NOTATTACHED) {
-		set_bit(RTL8152_INACCESSIBLE, &tp->flags);
-		smp_mb__after_atomic();
-	}
+	if (tp->udev->state == USB_STATE_NOTATTACHED)
+		rtl_set_inaccessible(tp);
 }
 
 static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
@@ -8265,6 +8353,19 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 	if (!tp)
 		return 0;
 
+	/* We can only use the optimized reset if we made it to the end of
+	 * probe without any register access fails, which sets
+	 * `PROBED_WITH_NO_ERRORS` to true. If we didn't have that then return
+	 * an error here which tells the USB framework to fully unbind/rebind
+	 * our driver.
+	 */
+	mutex_lock(&tp->control);
+	if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
+		mutex_unlock(&tp->control);
+		return -EIO;
+	}
+	mutex_unlock(&tp->control);
+
 	netdev = tp->netdev;
 	if (!netif_running(netdev))
 		return 0;
@@ -8277,7 +8378,9 @@ static int rtl8152_pre_reset(struct usb_interface *intf)
 	napi_disable(&tp->napi);
 	if (netif_carrier_ok(netdev)) {
 		mutex_lock(&tp->control);
+		set_bit(IN_PRE_RESET, &tp->flags);
 		tp->rtl_ops.disable(tp);
+		clear_bit(IN_PRE_RESET, &tp->flags);
 		mutex_unlock(&tp->control);
 	}
 
@@ -8293,6 +8396,10 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	if (!tp)
 		return 0;
 
+	mutex_lock(&tp->control);
+	rtl_set_accessible(tp);
+	mutex_unlock(&tp->control);
+
 	/* reset the MAC address in case of policy change */
 	if (determine_ethernet_addr(tp, &sa) >= 0) {
 		rtnl_lock();
@@ -9494,17 +9601,30 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 	__le32 *tmp;
 	u8 version;
 	int ret;
+	int i;
 
 	tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
 	if (!tmp)
 		return 0;
 
-	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
-			      USB_CTRL_GET_TIMEOUT);
-	if (ret > 0)
-		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
+	/* Retry up to 3 times in case there is a transitory error. We do this
+	 * since retrying a read of the version is always safe and this
+	 * function doesn't take advantage of r8152_control_msg() which would
+	 * queue up a reset upon error.
+	 */
+	for (i = 0; i < 3; i++) {
+		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
+				      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+				      USB_CTRL_GET_TIMEOUT);
+		if (ret > 0) {
+			ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
+			break;
+		}
+	}
+
+	if (i != 0 && ret > 0)
+		dev_warn(&udev->dev, "Needed %d retries to read version\n", i);
 
 	kfree(tmp);
 
@@ -9784,7 +9904,29 @@ static int rtl8152_probe(struct usb_interface *intf,
 	else
 		device_set_wakeup_enable(&udev->dev, false);
 
-	netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
+	mutex_lock(&tp->control);
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
+		/* If the device is marked inaccessible before probe even
+		 * finished then one of two things happened. Either we got a
+		 * USB error during probe or the user already unplugged the
+		 * device.
+		 *
+		 * If we got a USB error during probe then we skipped doing a
+		 * reset in r8152_control_msg() and deferred it to here. This
+		 * is because the queued reset will give up after 1 second
+		 * (see usb_lock_device_for_reset()) and we want to make sure
+		 * that we queue things up right before probe finishes.
+		 *
+		 * If the user already unplugged the device then the USB
+		 * farmework will call unbind right away for us. The extra
+		 * reset we queue up here will be harmless.
+		 */
+		usb_queue_reset_device(tp->intf);
+	} else {
+		set_bit(PROBED_WITH_NO_ERRORS, &tp->flags);
+		netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
+	}
+	mutex_unlock(&tp->control);
 
 	return 0;
 
-- 
2.42.0.582.g8ccd20d70d-goog

