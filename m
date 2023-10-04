Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC17B7631
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbjJDBSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:18:13 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3290AB;
        Tue,  3 Oct 2023 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
        s=protonmail; t=1696382286; x=1696641486;
        bh=0/NTixYReknMRRBO500wvyfnj9CRDEyPNDq3gOMgpyI=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=JbU8T7BH5W1VsBAqpE/+zgfEmkKsgSs0kuf9FlkkFVDIv6qxzN6UaauX4d6GHEMN4
         +BI6WqLMcaizQwmsH5GFtwHOTFoekkpKXnLV1F3ShU9/380P7E9O2s/P8eXBxQCdK/
         +vLLtiqZnZWrVyzACuRs8uXtt8ezSCYsjayaUZtf0Ukkq2dF/8sVMbFQ9NFJo8q81+
         3LZejZypDcb1zacvXMqZxFk4pcFBqzW6M/pjW6Zz791TbEXIaj9E75moPosMKoxO3M
         oRxk9RMdtTf5MEUNkPkguKvx/w52XR/Rx9ZR3OlE17/NWozm36tS72F6XlsRyFIOy2
         U9Rwi/KfjA8rw==
Date:   Wed, 04 Oct 2023 01:17:54 +0000
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com
From:   Szilard Fabian <szfabian@bluemarch.art>
Cc:     Szilard Fabian <szfabian@bluemarch.art>
Subject: [PATCH] Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table
Message-ID: <20231004011749.101789-1-szfabian@bluemarch.art>
Feedback-ID: 87830438:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the initial boot stage the integrated keyboard of Fujitsu Lifebook E5411
refuses to work and it's not possible to type for example a dm-crypt
passphrase without the help of an external keyboard.

i8042.nomux kernel parameter resolves this issue but using that a PS/2
mouse is detected. This input device is unused even when the i2c-hid-acpi
kernel module is blacklisted making the integrated ELAN touchpad
(04F3:308A) not working at all.

Since the integrated touchpad is managed by the i2c_designware input
driver in the Linux kernel and you can't find a PS/2 mouse port on the
computer I think it's safe to not use the PS/2 mouse port at all.

Signed-off-by: Szilard Fabian <szfabian@bluemarch.art>
---
I think the same patch could be applied to E4411, E4511 and E5511 too
but sadly I can't test this theory. But these computers use the same
UEFI updates so I think there isn't much difference in input devices.
---
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8=
042-acpipnpio.h
index 028e45bd050b..3f73fa69b8ce 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -618,6 +618,14 @@ static const struct dmi_system_id i8042_dmi_quirk_tabl=
e[] __initconst =3D {
 =09=09},
 =09=09.driver_data =3D (void *)(SERIO_QUIRK_NOMUX)
 =09},
+=09{
+=09=09/* Fujitsu Lifebook E5411 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU CLIENT COMPUTING LIMITED"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E5411"),
+=09=09},
+=09=09.driver_data =3D (void *)(SERIO_QUIRK_NOAUX)
+=09},
 =09{
 =09=09/* Gigabyte M912 */
 =09=09.matches =3D {
--=20
2.42.0


