Return-Path: <linux-kernel+bounces-98046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D912877406
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 22:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68E6B21D18
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2B50A97;
	Sat,  9 Mar 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q4WWjwL0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9844F1EA;
	Sat,  9 Mar 2024 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710019253; cv=none; b=LgeIxJ/VCaNU6w4GCs6+pZrDGYU//AH8w4f7DvFJczENUTaLW6mXFC7q0zWp3KpE1DqzvZTv0JVXiRStYUoGamYd8XamGmZY+aZCf3i20WdGMNw1hiJxH4Hnwzb2mSxpCWbeEDJgMfRhTZBxBc7ZELwpl41jSoLfj/gK/YL2eLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710019253; c=relaxed/simple;
	bh=jwYLheKafoEdRj/WUSjPR9nptvkIrxnKoUmUcaiDndI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cblpl0FUP3xAaR+0snUqc5jzYWiNjzr2TFHmPm6y+DKjxXtH3PnPyvMxasL+Z1tPn2A8KaSjkXr8c0/8YS9BUkLdR2PxvpMYZXsjow0uwrTkNkCOnEY4e43ROGT+3pDDjcUcWMGR/FDk5rcU+bS/NJ3YxHl4DseIIsmrwJDGcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q4WWjwL0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710019230; x=1710624030; i=w_armin@gmx.de;
	bh=jwYLheKafoEdRj/WUSjPR9nptvkIrxnKoUmUcaiDndI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=q4WWjwL0puVqmrhyxvT3M8bzLJ9kcx6rEPOrsMHTAusOtAW90x5IMo6BNalm6QH4
	 qB33JcupPSrz2EgEikrtag5QWqhoTmJGuI2AQjl9Dqe1p8ndPWC2tr2m45JJScwU7
	 1wa1nvfNHcE+PQp1km6oIZAfUs0R8cNPb9pVJd3RgwG8ksO1V/Spbr7O4nvIqNQnv
	 peujJ48KpuPUpkZW2CVo250K8P9nlKWciVUoxrP/Z3IconwanuWZzmmF30NZAsNVD
	 A8Vux3+etw0G2xXMy3dw2PjD6rzIa6ha+W0IsOWHZy+8eHtuhV4ZM83icfvc6a+cv
	 rhSpxXcOsKVoLxHEpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MqJmF-1r6AfO3bDH-00nP1d; Sat, 09 Mar 2024 22:20:29 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add XPS 9315 to fan control whitelist
Date: Sat,  9 Mar 2024 22:20:25 +0100
Message-Id: <20240309212025.13758-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:swpdh4JsTpFtnzIysBrvCz2ZTYiNBe0QBrwpt//PgztZi2cNV+W
 PE3PxWMsozRjreuieNgrr8ARI9d82TWKleYi7oH3nPjFdmbyr+T9117AzVGES7zKucNonzu
 N3SNbBrfEcpEwsqIuiEHJPMY5vMIl8GIYaMgEnkWfxTniptVgIUQi/l706HiNmHl9uIxGxo
 V/+SG8jsJnh3gtO6azhOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GgMHZQ7Aqac=;W/V/jBdhqodYP/kUg/KjZFHf0pN
 zEZxKHj9SNtldHFK2Uzfyv0AvwflxZeG9TXE/+JCpKrkD8hczggKfu1PYq+hr3zebqBCHhXmm
 v4tdqtOWE+2kuhQFFQ0jyn6tlG8aEi6oAbgGLbTp5LXcLQdvqdGKxU1B2JwfH2YRkO8cahrUA
 DPcBF20UDdDEH+Ca0p5EQhaXpCI/IrrKGBpXDUKzUclbqEqyAyTnL27aCRmTtcdP5b/dgXJpR
 LmwBKUiyupSFUt5mc2y6TXIv7Zvto2o+Yo4PTKEGOEB2Egb8B5bzz3eQS7AivyTeV9AwhH6xi
 5S0PoC3LuTOB8IjTGfmWEqdonZ0MElShKHCr9Qrru0P4rMk9js1KF6eqrvyYMZixRgn1tlmsJ
 E4FRzAljtQ/Pmy/sFJ/C0jI9414Mo9goSUYytwFsChC3E/CHHc9RsverYG0RedgM5PHH7wW3H
 X7yeZcz4jzIa0KAo5VX2R1P8SyUD1vTxu620a4f+iV2YfB7F3Jt466/HEcjVcjAb7c+8Vncev
 D1n/MyvdxhD35nzZxRToGR3EZrY3yJVuQu2JKjVTl2czb5xLdcxNtYLJaSUp6wAafDvVjiTNv
 l0545I+v6SF7zChyIa/m5k0K01tLjTO777kF7I5A99dkX4BgX3Aml/nZgW/toUq1fWqDEXnLO
 E66MQWuygpaLOFrb8vvgTkPloSXhF5apB9WlAefLucjFgeuYL3VmiYNx96rHc+NYZnCHdkSNM
 VOrM4JiECJQgKG+zeovZta+63HAnYKV3SbSyzPix6KXRVD1ItXmbMmIEVSKVMm9zq9ugFhHtT
 135qDZQ5TsBJIfgWzIywCnYlFjzBOYjDsEIRys85/F200=

A user reported that on this machine, disabling BIOS fan control
is necessary in order to change the fan speed.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
c
index 6d8c0f328b7b..4fa837e65a61 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1450,10 +1450,15 @@ struct i8k_fan_control_data {
 };

 enum i8k_fan_controls {
+	I8K_FAN_30A3_31A3,
 	I8K_FAN_34A3_35A3,
 };

 static const struct i8k_fan_control_data i8k_fan_control_data[] __initcon=
st =3D {
+	[I8K_FAN_30A3_31A3] =3D {
+		.manual_fan =3D 0x30a3,
+		.auto_fan =3D 0x31a3,
+	},
 	[I8K_FAN_34A3_35A3] =3D {
 		.manual_fan =3D 0x34a3,
 		.auto_fan =3D 0x35a3,
@@ -1517,6 +1522,14 @@ static const struct dmi_system_id i8k_whitelist_fan=
_control[] __initconst =3D {
 		},
 		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident =3D "Dell XPS 9315",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
+		},
+		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
+	},
 	{ }
 };

=2D-
2.39.2


