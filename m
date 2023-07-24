Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C74275F4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGXL30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjGXL3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:29:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B305CE61
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:29:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso6380814e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1690198161; x=1690802961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRfo5YiTarf2JRuyrUwS+oTWGNTjD9P2a+wjJdihkXc=;
        b=HhR/s2eASv5mFUSwnlt8BH7baCjp+WIg/wvsxT3L+mPE7McqmK60FnGCjwEBEo8ACu
         +g2vps5suXa92g5cA4UxBQBENAjEKTw9zD1cdNXoF5cwDO2BjUyzjNxZ/ezc3iJr29BF
         pBFaFwCiAg4CH1sJBdXftvRH95kYhImN3EkFsaFKiHMRWtn7vo9AI4JAnjy2zTl0CQkR
         mFwLAYR9YP5HpHpDMr5+3wKVm24tV4JKzK0yDMyWAIhGFOgNVk97BgZlHm5fu5uadYvm
         +JMkYoiaUjxN86fzNK9LmlKjpWXUa1Gh4PIeLNi0I54j0GM22BBEOlYRN/sqvSPxdh+D
         hiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198161; x=1690802961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRfo5YiTarf2JRuyrUwS+oTWGNTjD9P2a+wjJdihkXc=;
        b=BR/GA8+4bxKRqmvJ9jxEsBJOAIzY7JOonRdaE8TrPBGwT0dRqe6PeGy9EyKBy1lzqM
         QJeq/S1DlJsysf/pJ1NRH3KyMNGexvUNiBeTAedW4+Bomn+f0Dv9zHQUMiops+Hh5Q4J
         yX/7WE5LmWWrytqhbiLMPxPpXMFRQR/mLuWpeEvmsGmuxOVEOzVl+kBuXft+AvnTjdn3
         lPuGfRja/yqJ7m7efTdNivdyGEu2ldl6XIR6u0mL7i9CUkEHUkUcWjcbE6IGE9/R7HsK
         1oDQNLvTilPItjOXMWgzbWIJgNVRA1WDA1mWODHDt9BxdSPgF1wOCRc+rB+PW7i/H9BY
         5dFw==
X-Gm-Message-State: ABy/qLbvsoWvkaYwlyDF/Q+WTD7GW+dPpZc4TOy9OJqG69gQUa0dYrvp
        tRUbl6QGTABkecQka8MjnPWf
X-Google-Smtp-Source: APBJJlGCu20wuxsL/mNm2Y190ohvk9LaLcsTK7Rk+Ga+zBykBJsQCzEk3W3Jjn+sxPtdrW1I4XwM9A==
X-Received: by 2002:a05:6512:31cf:b0:4fb:93db:fff3 with SMTP id j15-20020a05651231cf00b004fb93dbfff3mr5576926lfe.16.1690198160833;
        Mon, 24 Jul 2023 04:29:20 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id d22-20020ac25456000000b004f858249932sm2166271lfn.90.2023.07.24.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:29:20 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH] USB: quirks: add quirk for Focusrite Scarlett
Date:   Mon, 24 Jul 2023 13:29:11 +0200
Message-Id: <20230724112911.1802577-1-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Focusrite Scarlett audio device does not behave correctly during
resumes. Below is what happens during every resume (captured with
Beagle 5000):

<Suspend>
<Resume>
<Reset>/<Chirp J>/<Tiny J>
<Reset/Target disconnected>
<High Speed>

The Scarlett disconnects and is enumerated again.

However from time to time it drops completely off the USB bus during
resume. Below is captured occurrence of such an event:

<Suspend>
<Resume>
<Reset>/<Chirp J>/<Tiny J>
<Reset>/<Chirp K>/<Tiny K>
<High Speed>
<Corrupted packet>
<Reset/Target disconnected>

To fix the condition a user has to unplug and plug the device again.

With USB_QUIRK_RESET_RESUME applied ("usbcore.quirks=1235:8211:b")
for the Scarlett audio device the issue still reproduces. 

Applying USB_QUIRK_DISCONNECT_SUSPEND ("usbcore.quirks=1235:8211:m")
fixed the issue and the Scarlett audio device didn't drop off the USB
bus for ~5000 suspend/resume cycles where originally issue reproduced in
~100 or less suspend/resume cycles.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 934b3d997..15e9bd180 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -436,6 +436,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* novation SoundControl XL */
 	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Focusrite Scarlett Solo USB */
+	{ USB_DEVICE(0x1235, 0x8211), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
-- 
2.38.3

