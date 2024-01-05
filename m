Return-Path: <linux-kernel+bounces-18185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2AF8259C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E084283789
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8D935283;
	Fri,  5 Jan 2024 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="DVOY9zk1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4835347A4;
	Fri,  5 Jan 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704478302; x=1705083102; i=erick.archer@gmx.com;
	bh=WZ9qe02V+01V4KAvxMBIjiVOmDsQ6TARqMrWkQ1Sf2Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=DVOY9zk18IErWyRYfutczyRnlaKEvJrrM742acHf6Lun4N/+G4tgXL8lA6Uv1VvJ
	 NkeWgXItyvR5UCq7bPYbzVJta1TOmUT6qP1ofzbimtn6SngXe/HpuexXLIIV3rnvC
	 X1B0OvO4XzS6pfZg7LQQUBBT2Pgg+OuqLD2fYkX+yEZ7cr+lHu3bfJ0ASSbuVWsb+
	 yK90wxU8TaQBYrvTdg7d/BDimJm9ICWhA5JXAibTyRolgkUxx2fvQHeR5YAa/7Rb/
	 9HRtlAwkXB+Ql//2A5UzAqNJqX8ICdSCcuVaTgmgVk+ZqxEhFXFA+6E71tOkx4hko
	 ud4t9LirfFGUKIZqgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MjS54-1qtwm41b4c-00kvAN; Fri, 05 Jan 2024 19:11:42 +0100
From: Erick Archer <erick.archer@gmx.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] PM / QOS: Use kcalloc() instead of kzalloc()
Date: Fri,  5 Jan 2024 18:11:04 +0000
Message-ID: <20240105181118.116292-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:omxFqGTE8J8I8WmBeLTm2kk9TxR0E4AfbUe68X34vGK0eXl+Bxz
 m/covJsAe4mLfLWn3Vo0evT9CfW7Cd1nMUA4qoO45oVdZONfZi1TnnLQPN0X9iCQ3ro5ISX
 /VZP/7f+1R/0c14vE3F5J+OSTG2zudQGlp0ccMgpyVy0sl4Cgflh8RADjTCIopFvUZJvDpP
 clDOJy/O0mMq0KOwQ0P1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fX1Ne/RBy28=;lsNhU36ONPPYM5u1Vd312QkjHPg
 UX/mIszyTZrX1HiV8GBoYIsfKFWHczzz82eU2mhfrrJ5B5+soaQUbD6lG2e1bcvY/OBgUPzfn
 dwuLqG40CIMj8EDvIQ6G1CAlO9jmyOHQ8BBwUOHRtzhRr3sfDiU/qqbWppEiTFTDU1S7ndZoT
 RclAKFItZDoZ1UVNOHPx58f+fhO4XL0wFtsDNU3bA+uxu73UqT6My8NwkNtuT5vUI2ChRpQ5m
 3pHRZLOnGcbt6uly3QIMkUvHLXKtua3HODV5i/fgw+BedOJi0pJ3S7L4I2xWPwsL55G7F8Kpk
 8UHlvoEbipLfeYH2K5gWRdC4P5Q7BLq24dAMdHjZXXfgmifO2o3pIPIQoerb2l43RyhnFifG+
 zLBtEt/lBQWUDoD4sHafXiGkaK73tLpw2ufrLFhOZf4SsJZ62tFXy8+aMxMzjyRIW0KH5VlbL
 32Z+GKszh9pUSPljRALpadq9Tssz7upqGfKIrzu7qmy7oXw2hPqTuKF97w0TmtvjD4mpB4iDe
 a0+uCht1zeg9bltchsJ9DcNs766VDTC+BV9bR61Qg85Z1gIJl6FhmWJu9Tyibr9D4EjZ94JoN
 taw3yAkJNG9QtXnWFpSlLN3IDoYKy8g8u27sDiN+wieT94Jc3hMbZTHkDHu3226qI+uN0W6dI
 7PlT1GrsrhlHoB3EWiUBdYlRTq1/ipzN7t2y3qKHvmC26Unwzct6JMcLAPBCLSMQ2EWf9kiV/
 5NiZ3yvbAytIPrykbZSB8M+no2LisZP6yve1h3+aKcO9WdUGqnmpEYL/IDq2DttTFlEmJmYes
 XTatMihIuc22yLbBwdMmGCu+ryVQwBPQJqc7mfpiXW9GlqJ71GFJ2QQ/aIx42jt/G2iFcpejE
 DtTfD+eKIgWEJzWjx5q1eW9EtuwF0BPho+0M4nx516NIX24MGl0+vwIyA6Nic9ARuuT7+u8yA
 4A66Avm12EO/XYws+iXyTyUlFaM=

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/base/power/qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 8e93167f1783..bd77f6734f14 100644
=2D-- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -201,7 +201,7 @@ static int dev_pm_qos_constraints_allocate(struct devi=
ce *dev)
 	if (!qos)
 		return -ENOMEM;

-	n =3D kzalloc(3 * sizeof(*n), GFP_KERNEL);
+	n =3D kcalloc(3, sizeof(*n), GFP_KERNEL);
 	if (!n) {
 		kfree(qos);
 		return -ENOMEM;
=2D-
2.42.0


