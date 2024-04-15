Return-Path: <linux-kernel+bounces-145738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5A8A5A34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53811F232AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38163155752;
	Mon, 15 Apr 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=gschafra@web.de header.b="GqGg1tPx"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8491553A7;
	Mon, 15 Apr 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207094; cv=none; b=PymB3cKJvs3cBK+NaoYVJzSQV6e9UkU7CImVuaerIuU58NOh6pRjM7dje7g0ar2k+pHiRF91eYzts121703nJe4j46li465nK63phbTyW+hFxWCTCPtYiZo5dZDii+WaUqrd9VzROTZwLjzQyWmnZiYLmg4tt9gKeT2Sfeug0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207094; c=relaxed/simple;
	bh=DfqDZSCy1bT7YhVav0SrkmE8gji+HQI8UQPnQWILtoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjK6rcdnH1bnoWCXrny3LZHO5ItV7lkFD02EtwAsjR3CU3Uh03zxTJIh518pvANse+YGOf+vJI1GtE4PnUKavdFbD4FadBGVMGMGBwqcWThB2Sa758OowDJp6WGJ0cKG6DJJlR9KS8KJWq1QAFhT/coQWM5A1jlN1NZkZIztQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=gschafra@web.de header.b=GqGg1tPx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713207085; x=1713811885; i=gschafra@web.de;
	bh=/G+TvMeVvPYHHHKjlKDGzZ+uXBSjb0e1s3YVRMV7XBQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GqGg1tPxo9aX6ntVK9oke/lh/dHH4VOMSWckBxUT4zvv+0VjgxS1O+u22ugcvJaV
	 zmoQQCUTdV14YZSv79VYObx4AWBx9UqgiGLGdWCuyppgaBMhKvd/SaotMhZ3gcJWv
	 1zRDl+iWWpT52CS8CWooYbZxjwAzvtDkRoWd+11eXmMLsRm9AzbMSErWCT7Rm+lgC
	 nvTIRmdk1Ylq4GXrXd1m8VH/W5HmJGnOSJcvhWCCNhC5rvc5Vr3PMk8peO1Q7/pm9
	 IgvXqOu/CZem3KxNgxGZiAhJrhzp6Hog3FAc7lRa5T9BcfTlLumCkJykoJPzlACek
	 0GKq2hNSEHQwLUxFNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from tazdevil.fritz.box ([213.152.127.16]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODmV-1s75UL3rRJ-00OUz7; Mon, 15
 Apr 2024 20:51:25 +0200
From: Guenter Schafranek <gschafra@web.de>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guenter Schafranek <gschafra@web.de>
Subject: [PATCH] ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)
Date: Mon, 15 Apr 2024 20:51:18 +0200
Message-ID: <20240415185120.57973-1-gschafra@web.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uKPrlSo69z6OcNVYMf+a7dHHP1IGatc+qsoMPIE2d6gPMjBHJTf
 lFUptmJ900MTQUl6Sqf/rHNe0uKTgpPhq2y+DvAlI3VU8Uhfjo2OeuYnqH6mJCoQoinS5xa
 OcR45WY4R/Vd905SVsZ1pdp0j4bXw5PapQyOnEMx+LDP+jwtfqd1rFQlk9d9W6zsNr1V1Bi
 FwruoplEaPNP3CDmGcYHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lXaItDdWRiA=;OLLhv9+CCWfpiDvGx/H5kfutapw
 Gg+Gy2LvlEW2R7+Gxuk8EduOMzjtU8wxUyus9UcalC/qjLsB/5N4T6dfVAXDCk2iEbu3bexHo
 clUhK2jbOf4C98xLpG4Mnn8Gq1SgpPAp8JvQelsyWFxZFNG6pReduvNJ4x3kptkRv+LR7D7SZ
 53bgN4pGLF1mMt3spXcGFzbhi78Kbu7QYAs3BnpSQx1lqYJ80Gl7rSgtO5t/mUNNEB1pysu5C
 z7VDcVjXOy2kWFqz+paadYDcCrAUVKgg3A4cUIFsbX9pBD+N31/V1pOp5ueveaI7tJFXNbl0H
 6ysTAw/kXnnJnp+8ItdyX2csm4IvDW8veGIX8Tzl/q0QEI14K58oX3MsoFPsPyLIRTS8l/C0w
 lNeVA9srRXdSFtxI81ePDDAGl4lYqnNtnNWo4QvggBHwAl1EXLyOavB/TsI0hWQNwcWv3T0Lo
 WfSf/flDUroZuOM5e0/dQ6CjBdGMh6DF4UpE7DUPd0fzINonYE1A2PbMkDI02XxBRisvixZ5U
 c4x+c2FnT52VFSaz/e/X5ojXKK77fTywX2CrcwwLH4eEvnsmOwnfZqzv43aQ+6GBuzflhcrXR
 AOkMNvHXrlTupHq7hv8HuqL7g09SHO78E1wIrTN9G6u8Y9dmNh5+NK+r+YgUpJnLFFJwri3lS
 R/YQyNdOxU4PSzmGEQKig2MfEQszddXwuBzWDbqQ83MWSe6+zHp625dEdqdrA1d4eYiwp55UI
 CDj0/X9VHm/SP5ULe9OK5Ho66KSaHBWzcU0Ohpa+h4pxzkHriLxasIMhlW3wdIax29cSDAdF8
 BxcoeDGGQfUqJcDrKdNsRQuEFvfa6pcLZz1vYFmSEPv/g=

The XM APEX 17 M23 (TongFang?) GMxBGxx (got using `sudo dmidecode -s
baseboard-product-name`) needs IRQ overriding for the keyboard to work.
Adding an entry for this laptop to the override_table makes the internal
keyboard functional.
See https://www.reddit.com/r/XMG_gg/comments/15kd5pg/xmg_apex_17_m23_keybo=
ard_not_working_on_linux/.
Patch was successfully tested with Arch Linux Kernel v6.8 under
Manjaro Linux v23.1.4.

Signed-off-by: Guenter Schafranek <gschafra@web.de>
=2D--
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 59423fe9d..c9af5d2f4 100644
=2D-- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -533,6 +533,12 @@ static const struct dmi_system_id irq1_level_low_skip=
_override[] =3D {
  * to have a working keyboard.
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] =3D {
+	{
+		/* XMG APEX 17 (M23) */
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxBGxx"),
+		},
+	},
 	{
 		/* TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD */
 		.matches =3D {
=2D-
2.44.0


