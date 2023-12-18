Return-Path: <linux-kernel+bounces-4320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A945817B74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8174A1C22E32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51173470;
	Mon, 18 Dec 2023 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kr1BfU1e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80497204B;
	Mon, 18 Dec 2023 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702929337; x=1703534137; i=w_armin@gmx.de;
	bh=Gv/3KB2nhnzbj6OabYsWChzNP4Kil+PLOJoDKQOnE44=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=kr1BfU1e5QwdCrsIKQxt8ifB3LOarI+FVBbBBe60A3gFSTyySAiRByyuxZhqbG2F
	 RN2FZxijKl/sU3V/w/18GRVqixNBY17cIIp2nycB0ylnVjytxnEFCvX2cznC84Zv1
	 rluf29wmd4VmrPlVq2i++2kmKyeLEYXix5chfuAiMx8rMHzq15t6bbIJL1RDj3CIg
	 UcV5VutLycAwAPJxcYeabEsXSDjVmNpgB2707R8CDO63KZYb2/ktVBvv+7Kz/rFqU
	 W0hrtt4B5pEikbc9vjj2priHjlLJGJxJquT6BU50BW+lPfvsKikQXnBZfyVfzrYOm
	 LFDCWPao+QxccfU2Hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MMobU-1rY5aH32M0-00Im6V; Mon, 18 Dec 2023 20:55:37 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] platform/x86: wmi: Remove ACPI handlers after WMI devices
Date: Mon, 18 Dec 2023 20:55:27 +0100
Message-Id: <20231218195531.311179-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218195531.311179-1-W_Armin@gmx.de>
References: <20231218195531.311179-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aeKtvZ4V2lj3I0tEnb7InzU3Z34FsD8fgWF57Z0yT3t+dlDqYsZ
 z51xStBTs32mG+RI2X3a7x8x3LJ9++1C6gC7ooqQJjlbQ58wwBXYTIvtdaq1TvtMy9LGv5J
 IcI/AEW80KBp3FdK/dtXRHsllM0iBVWXoYg6+LiUvpF/MLIVZhHZjGjZuNs3MfCkmxS8qz+
 MLnroa3MlIqRYVEPLQYrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vbZRc5hIZb4=;AmxXZ3DRZnAeljagOPAQiu3ggDY
 TAZu9Js+Zo/F5sr5dqfzGCHBGQ1tFYDjDuW79RJj0UTnRgWCU1TTzmWfhjjzG4e+Yiegq9gCi
 oe6adJWB/Nen+LRNKpAi7C53raB3Il+cPba3Wc4tlhmo7zPrVerr5SzItOL09ObJ4xgFLgXGp
 VC0GFea5WX5Tl3nC4bY/f7LeFBI1v80PWsIfjiSJRpvS8GZZiY2DEkjvouDfRPGYjyKLQR6do
 +DQrwi1qeoXuKO6hSGjKTF7g6hTwBeep9rYZzHml4TkTx6H6vnZuPqUUg9tIUU8bJg6pRk05k
 nqO6QLP/l6NwMmjaE8yVJuvjZuqnD7A/oBM+ShmbJfd0BJAKtn08h/fTAZy1S4IHVEt65TBgI
 vWVIdzzbY437qjQknVrnnVAp62g62rcuK0ePVA2nB/L/2wFuAAroLluK503QjayMVWDjrzziG
 3qA/4GOCktXpYfV8mX+onFePr0iQsVkCLzWepQws+gxvQ6ViwOjrwklPwIzoKO0i9AsR1SiLp
 GfAdv+45KnA9gc+0jWaBWAQyM9ovIhno/FIwwzaWdalTkHhVE5HReMXAnI0DXHz239DBmGoO/
 XO+BlfR73ySHpk4D17JKjNccoJhIp5a8syO8VjlsO1YWbQyxEh2WtTrITy+GLY5ygUMo29kCZ
 Wd9s+pk1cJ3tfQ2kTV1l1mQOogHND7KB2gJP5qh4ge9ZPcqELBAbocH4RSALgxbCcKeQYRU2U
 8U0KyDMmE7RfUjNVAcCh1Cf0jwZgTiK6ymnAbjoarLGAoCtusP0bvrrvFM+WHwcneLGDVxDVF
 hCZX8t31mwtGG5OqxnMnIcWq1u8d+Nqy7DvfSK6N4fKiYOoBbciIC/fIPZg1sdCt7fCzV//Q8
 mBzl442sSnYvu9n+h9DxaMHL+k8azgGy2fj6mvYe+gTsQb7zEZZs7tHnMegVWHGvZD8UKMDCC
 fa0T8CS+d59bKpDzsxZTJ/2W1fw=

When removing the ACPI notify/address space handlers, the WMI devices
are still active and might still depend on ACPI EC access or
WMI events.
Fix this by removing the ACPI handlers after all WMI devices
associated with an ACPI device have been removed.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 906d3a2831ae..2120c13e1676 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1239,13 +1239,12 @@ static void acpi_wmi_remove(struct platform_device=
 *device)
 	struct acpi_device *acpi_device =3D ACPI_COMPANION(&device->dev);
 	struct device *wmi_bus_device =3D dev_get_drvdata(&device->dev);

-	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY,
-				   acpi_wmi_notify_handler);
-	acpi_remove_address_space_handler(acpi_device->handle,
-				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
-
 	device_for_each_child_reverse(wmi_bus_device, NULL, wmi_remove_device);
 	device_unregister(wmi_bus_device);
+
+	acpi_remove_notify_handler(acpi_device->handle, ACPI_ALL_NOTIFY, acpi_wm=
i_notify_handler);
+	acpi_remove_address_space_handler(acpi_device->handle, ACPI_ADR_SPACE_EC=
,
+					  &acpi_wmi_ec_space_handler);
 }

 static int acpi_wmi_probe(struct platform_device *device)
=2D-
2.39.2


