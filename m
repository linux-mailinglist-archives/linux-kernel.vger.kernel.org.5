Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C007FC869
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345721AbjK1VQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376702AbjK1VPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:15:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42F5BBF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:10:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2BDC4339A;
        Tue, 28 Nov 2023 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205829;
        bh=OUs5FG7ULH224TIbE83Vh9ZuqywUndaQmOhejOrmEoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iS84HzhYyyCiHhUtGkP4/azjAdQk4qTABoUusaqVu+yjAGix/OQtoiVZ2cVeuFtUZ
         0O+bbB2dU81+wbp9LyIua0l45akKiCNverj1T7NacvRgG/mYI59TOJe/yzfdUOKJWv
         4JAHxICn+kEjxyIulPulOapvSQAxe5iWI6HD5WtYCbIjJjXFpNb6zX7Wg+dS1Ge+kv
         SFN0K81PpLu1qerM51AuKkg0KU/jIqkB6oStx4TqbCl6L7txhC6w9rmEAO1lOKwOQ/
         KP72Sat6sXjnJjlIWDqmouvziQjAt1am2d8mC6GOv23NudrjqO0kI2HG7h9HblDHYI
         i5mRpuJXZdGGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aoba K <nexp_0x17@outlook.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/7] HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad
Date:   Tue, 28 Nov 2023 16:10:15 -0500
Message-ID: <20231128211018.877548-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128211018.877548-1-sashal@kernel.org>
References: <20231128211018.877548-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.331
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aoba K <nexp_0x17@outlook.com>

[ Upstream commit 9ffccb691adb854e7b7f3ee57fbbda12ff70533f ]

Honor MagicBook 13 2023 has a touchpad which do not switch to the multitouch
mode until the input mode feature is written by the host.  The touchpad do
report the input mode at touchpad(3), while itself working under mouse mode. As
a workaround, it is possible to call MT_QUIRE_FORCE_GET_FEATURE to force set
feature in mt_set_input_mode for such device.

The touchpad reports as BLTP7853, which cannot retrive any useful manufacture
information on the internel by this string at present.  As the serial number of
the laptop is GLO-G52, while DMI info reports the laptop serial number as
GLO-GXXX, this workaround should applied to all models which has the GLO-GXXX.

Signed-off-by: Aoba K <nexp_0x17@outlook.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 55b1023af31fa..2fa9013c90c82 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1602,6 +1602,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_HANVON_ALT,
 			USB_DEVICE_ID_HANVON_ALT_MULTITOUCH) },
 
+	/* HONOR GLO-GXXX panel */
+	{ .driver_data = MT_CLS_VTL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			0x347d, 0x7853) },
+
 	/* Ilitek dual touch panel */
 	{  .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
-- 
2.42.0

