Return-Path: <linux-kernel+bounces-15046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0388226A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAB01C21C40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602C4A10;
	Wed,  3 Jan 2024 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluemarch.art header.i=@bluemarch.art header.b="ABqcVnq7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15446AC;
	Wed,  3 Jan 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bluemarch.art
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bluemarch.art
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bluemarch.art;
	s=protonmail; t=1704246591; x=1704505791;
	bh=Q2ByIq0f90rBeyvpz2j2wURUB6GA7Zy4cGsEAI5uqbo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ABqcVnq708VjHuBxuPotQlxFYa60VFLwp578XP0CXgeJ4M+wm8/ajgBp2YUqbG+dZ
	 45N999H6oJgh1ddkehB1o7AREsFpA75HreMnWSW4J/7EqhkGflh5ulIq09j+wIMwx1
	 nbodqszRh9QDiYOFTjt4xgoGganCOqdJTpQkTjphYHVhg2AQMgbZw6DFUZ8PK+pzc2
	 vQ0bO8Gd2PAGOKarfyoqJdaCzuxD9XJEufVsXgAgLxSnNB606OAtPN97ZmtDyeEUgT
	 yK0J/LDwix6qxBT1Q8Ln43SqU0rHsaHmRASspOjeyjRo+nlOMZfr4T490SiiG9vcJR
	 WeKukAR/NZs6A==
Date: Wed, 03 Jan 2024 01:49:39 +0000
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
From: Szilard Fabian <szfabian@bluemarch.art>
Cc: Szilard Fabian <szfabian@bluemarch.art>
Subject: [PATCH RESEND] Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table
Message-ID: <20240103014717.127307-2-szfabian@bluemarch.art>
Feedback-ID: 87830438:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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
2.43.0



