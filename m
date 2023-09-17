Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9997A3686
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjIQQT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjIQQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:18:58 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A3E118
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1694967530; x=1695226730;
        bh=RUQIbh4mykPDFpwSsOl8cABgN/OT0C59vVfLwOnYqHc=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=qAQ9RbaAgK4P2I7BncTsJmiFc+wCZdTbNabd3QCZUZnxcItTyMTFnbO5W2h+sE2x/
         ok7Rmmcbsb/sdRUh6YcEUAv0GqE1p1HdsKmjP+rLZwXMOkCG7GLCg5rTo/Ye6wKtva
         sZ9kBuk3wNOiVT9BD+A8UC6hDMVOvNHIxS7Qd/x2NDK2eIDclAPQ3DS0NPf88Yw6Vg
         x64srzhY5hy8baNvQMPeYX4QNlrng+4kOhFm1MAtBTqiNLOt7iYPa7KoZTydz+Jeur
         uTXpuDM1OtKugU6xSsUUh/Fw5iDx4Y1Spv/4zeq8+emwdb/Fka/NH7NCC/mcqkU11g
         9TmsCaJDtr5qQ==
Date:   Sun, 17 Sep 2023 16:18:43 +0000
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <sergeantsagara@protonmail.com>,
        Rain <rain@sunshowers.io>
Subject: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xcd7e device
Message-ID: <20230917161802.39716-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the Synaptics device as a special multitouch device with certain
quirks that may improve usability of the touchpad device.

Reported-by: Rain <rain@sunshowers.io>
Closes: https://lore.kernel.org/linux-input/2bbb8e1d-1793-4df1-810f-cb01373=
41ff4@app.fastmail.com/
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---

Notes:
    Theory:
   =20
      I think the Synaptics device in the related email to the linux-input
      mailing list requires certain quirks like MT_QUIRK_HOVERING to correc=
tly
      reconfigure the distance configuration for multitouch events. This mi=
ght
      explain why light touches were not registered originally when
      MT_CLS_DEFAULT was used by default for the device. Would like to have
      this patch tested before being merged. A Tested-by: git trailer can t=
hen
      be appended.

 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 521b2ffb4244..8db4ae05febc 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2144,6 +2144,10 @@ static const struct hid_device_id mt_devices[] =3D {
 =09=09=09USB_DEVICE_ID_MTP_STM)},
=20
 =09/* Synaptics devices */
+=09{ .driver_data =3D MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+=09=09HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+=09=09=09USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
+
 =09{ .driver_data =3D MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 =09=09HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 =09=09=09USB_VENDOR_ID_SYNAPTICS, 0xce08) },
--=20
2.40.1


