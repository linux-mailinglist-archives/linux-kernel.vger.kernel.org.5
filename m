Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8212D7CC73A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbjJQPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjJQPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:15:43 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0533CB0;
        Tue, 17 Oct 2023 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
        s=protonmail; t=1697555735; x=1697814935;
        bh=++9pU1La/0B9FiBK0CkwIdzhIQraonwBLREebKGpRAg=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=gvxOeY1XwUMAs9i7bGuAlH66JEHL2qGdQ7chdlMiR5bHF50acZ0K2E6ztwRyv3yQO
         JJk7JL8XOW8UHGeamXM896xnt6E1Oqs3wryhT/6tLSZc6l2DfLnqU1nbRNAT0Jq7Xs
         y0wLb7O0SL9h/Sutb7+jqqBnHvULw0D31kYPaSzPVw/Z8zjEiMgGSjQCDbTbG0C2e3
         wsmto76yMz+0b+wsOjWfpvYKQXKuYJQqchiUtEHwBmxXC+4DA3YOTPeB7PCW4Y8nKN
         aRghUrDdv307FTbvr4n8qSdDF8jgm16BwXLZNrqIStnBEfHs/StU+ghuwbqUn8nibt
         xmrHX8vFLzIhg==
Date:   Tue, 17 Oct 2023 15:15:21 +0000
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
From:   Szilard Fabian <szfabian@bluemarch.art>
Cc:     Szilard Fabian <szfabian@bluemarch.art>
Subject: [PATCH] Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
Message-ID: <20231017151114.99135-2-szfabian@bluemarch.art>
Feedback-ID: 87830438:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another Fujitsu-related patch.

In the initial boot stage the integrated keyboard of Fujitsu Lifebook U728
refuses to work and it's not possible to type for example a dm-crypt
passphrase without the help of an external keyboard.

i8042.nomux kernel parameter resolves this issue but using that a PS/2
mouse is detected. This input device is unused even when the i2c-hid-acpi
kernel module is blacklisted making the integrated ELAN touchpad
(04F3:3092) not working at all.

So this notebook uses a hid-over-i2c touchpad which is managed by the
i2c_designware input driver. Since you can't find a PS/2 mouse port on this
computer and you can't connect a PS/2 mouse to it even with an official
port replicator I think it's safe to not use the PS/2 mouse port at all.

Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
---
I think the same configuration could be applied to Lifebook U748 and U758
too but I can't test this theory on these machines.
---
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8=
042-acpipnpio.h
index 028e45bd050b..983f31014330 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -618,6 +618,14 @@ static const struct dmi_system_id i8042_dmi_quirk_tabl=
e[] __initconst =3D {
 =09=09},
 =09=09.driver_data =3D (void *)(SERIO_QUIRK_NOMUX)
 =09},
+=09{
+=09=09/* Fujitsu Lifebook U728 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U728"),
+=09=09},
+=09=09.driver_data =3D (void *)(SERIO_QUIRK_NOAUX)
+=09},
 =09{
 =09=09/* Gigabyte M912 */
 =09=09.matches =3D {
--=20
2.42.0


