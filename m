Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2837D03CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjJSVWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbjJSVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:22:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D6E10F0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:21:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1caa7597af9so890865ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697750515; x=1698355315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99XDTyUCvOUhQUp0MWN4ekbCgPLwBk+829H/gHSUoe4=;
        b=MPcZ51HNc62moeK+/HePn0XOKEHJX/127aI6KsxoMr0BIV9AkaT9ImsCYxCC0jAXUV
         3ZznDtvUVFzDoSdxlMhQvO8fXUCOK2ccN762TnO8JMzZajWOF0IWh6JPZ1NuY1mqOEMo
         WobmXd56f4+WENYmSJfy7D/y8DA3xgWDEL21c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697750515; x=1698355315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99XDTyUCvOUhQUp0MWN4ekbCgPLwBk+829H/gHSUoe4=;
        b=KpVCDMR18oJSMzqRZkWI2em0MKCTi7bSCGF/uTByBhqil5IXMomhdF49MTKbUn7LgO
         MWBWPozxCuA7uzC3BAzOrcWmOYGXyayeEvwAQ37imdRdGybqIm8JbPz9ODA7q5kGqfPg
         0nDjcspOtzMSF3betMAiZVCMrVnIe/j3Cp7u653BhpQt+/IO7vDJUAzJeyXjkBzEoR1F
         1GZ0eJbgDSOwvCKpxeRkxFpVcmGdgUON3U/pIuFEdC8tzhfLELT3jNMqzjfxGqGr0T6R
         NuGZOoJmmnIrXa6vSZWYGd46gdycIFJkdNBi6gc8nKSN0MPgoJQG7Yjn6wOn9otvVOKf
         Xc8A==
X-Gm-Message-State: AOJu0Yy2zYbYRjZjwLaOG791nArbfPHw6BcDyELUdHBAva3Cg5CQUq54
        WQwmiRLt0mVSrSas8IJdaBkqTg==
X-Google-Smtp-Source: AGHT+IGHsyaazfKztgV6shIemQ+jlC7THOn7sKDO8SWa/SgIufIDIoOEAm3zf/DhGhEpv0iSNhqHcw==
X-Received: by 2002:a17:902:e204:b0:1c9:ccbc:4c98 with SMTP id u4-20020a170902e20400b001c9ccbc4c98mr75405plb.37.1697750515162;
        Thu, 19 Oct 2023 14:21:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a6da:6f08:412:e04b])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm154100plk.136.2023.10.19.14.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:21:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v4 1/5] r8152: Increase USB control msg timeout to 5000ms as per spec
Date:   Thu, 19 Oct 2023 14:20:20 -0700
Message-ID: <20231019142019.v4.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231019212130.3146151-1-dianders@chromium.org>
References: <20231019212130.3146151-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment next to USB_CTRL_GET_TIMEOUT and
USB_CTRL_SET_TIMEOUT, although sending/receiving control messages is
usually quite fast, the spec allows them to take up to 5 seconds.
Let's increase the timeout in the Realtek driver from 500ms to 5000ms
(using the #defines) to account for this.

This is not just a theoretical change. The need for the longer timeout
was seen in testing. Specifically, if you drop a sc7180-trogdor based
Chromebook into the kdb debugger and then "go" again after sitting in
the debugger for a while, the next USB control message takes a long
time. Out of ~40 tests the slowest USB control message was 4.5
seconds.

While dropping into kdb is not exactly an end-user scenario, the above
is similar to what could happen due to an temporary interrupt storm,
what could happen if there was a host controller (HW or SW) issue, or
what could happen if the Realtek device got into a confused state and
needed time to recover.

This change is fairly critical since the r8152 driver in Linux doesn't
expect register reads/writes (which are backed by USB control
messages) to fail.

Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
Suggested-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/net/usb/r8152.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0c13d9950cd8..482957beae66 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1212,7 +1212,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1235,7 +1235,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
 			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
 
 	kfree(tmp);
 
@@ -9494,7 +9494,8 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), 500);
+			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+			      USB_CTRL_GET_TIMEOUT);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
-- 
2.42.0.758.gaed0368e0e-goog

