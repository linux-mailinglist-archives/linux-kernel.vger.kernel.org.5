Return-Path: <linux-kernel+bounces-106732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88087F2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D91F21AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE25A4E5;
	Mon, 18 Mar 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VPmtGMeu"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36F59B60;
	Mon, 18 Mar 2024 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799077; cv=none; b=MHaLtsIbtW2HnqKrFGqnnloF838+cGZxnsJ6Wia5avqAkaTT0vrULhxoAC7RZrt1l//mY4m0xtzJydgwyBTAGkmmPQIjZEnguCcAYJiPCTrsYVggFxDoB4T6WVG0oXhAP5OiZatQUM4DOs7HwA/AcxnDVxzcCqRY2b87lJn/U20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799077; c=relaxed/simple;
	bh=9dIu8AKGPW4b2LA7WMIo3j+7Gk2uQDHsDxPnjR1PEtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMlH1tXAo2/Wyb2YY4f5rP5DaWA4HubE221B/VBMJfG0glIouuaUWXyezbol4At5bQBA17M1NUHFbc+SQvtKW3y5Z5FiK49rf8bfAABiT1UOGRU+Hn8e4QWUgo0MywIUDTkduIereohOQcEfc6Ucc1r+EZGQcglM2tMneJqhGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VPmtGMeu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710799058; x=1711403858; i=w_armin@gmx.de;
	bh=fmLtM0kbkB+R+fMrBFoqRkupy+V0CixAailgZ+ZySVA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=VPmtGMeuZotGIgPqLDqmZj7qLXIXqughZMvR0Hj3QOkCOMV9p2VEOmte9bBAYNcA
	 S8UD0GFcGF/yHzy6XfILUBA0R9hBh4bJE+82U0fnsc3pVwYhEisSFZiWaWwN6AXnS
	 T/l+FAsdqOxIAp6+3vM+I76tAPm4ILbvwRI3GojJawC1i+9g076sPpkZb3Hct76eU
	 jRxMLJX5vxBQREL1wKQmRumcnqCbC/deAsYatxYnE9bF/dAVnldYvt+Qd53IPFM5S
	 /mAiXjgL9kqqJ01SrsB3I6Fj4MEqHrw1gLEfbydjrZG7T+VbcdJvCr1q/kpu2omw5
	 OdS93j4j491w/68KCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Md6Qr-1rDpVx2riN-00aG6f; Mon, 18 Mar 2024 22:57:38 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] hwmon: (hp-wmi-sensors) Add missing MODULE_DEVICE_TABLE()
Date: Mon, 18 Mar 2024 22:57:32 +0100
Message-Id: <20240318215732.322798-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318215732.322798-1-W_Armin@gmx.de>
References: <20240318215732.322798-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uu1DHhSD0VIUkaLjdx8S9P0g8QVldwlbqjhfxW8oco8AT/WB2VC
 Rj8eTa14ey9JX/K193oiiTr2GxGGdGQuxKs8jqjcXzdO34Z3guXA3NUygrjIFWS6TGo3i6C
 Gxhpqf7nl1+O8JR16khO/lvxebqxCQcxFe26iGkGpueBkVI07YiK4Uzno/MjZe24V3eft+K
 mrQEzy5OPZP+xhCKQ4WNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rVQB6voItLI=;gWrSyvCEQUsNciZHXapRw3fniRM
 XUTFdl3d0/V12DIX1/aliLyzVyZZufyfH2lykqU7QSe7d/XXGsb9ljtssVhnrLdB3OhR3GTe3
 6d80u2tibAJOm7zhNgxwYA7CbR7uDSdkJBYkdW4EdAOkY9kp7kEPvzgJngXjHN1XXQNSLsZmJ
 +L7UE56eSCLlCzkAzkOIZ/DdVu7ZG1XVWiz57tplZULby2Xm5AKuNhnmiLwFvJfYqoq0JJusd
 bRZnrf95zaZB8URgKAx20eVQoBG5HZfsPYlgmxsrtAEOGefvPA8uzKQGfxVwSd8X6IfSfvx3h
 D07rHr2nxvLHvvEH2+gHUohmAXVEh9qMYKeXEgoSTnJibOgo4gWzYIm4ELUQIZXFVy8vpTech
 6kwl90N1oy/rVOy7txyOZkBSEmP53/NCQOqEeul3mgK9+RLkWsL5xtpD+CbKn2t47gg3p23P6
 8b2VfFtWKsh1pmrMN4suiNDQ0HFXop6P0mWOGp2wfc+ghzaWt0a3LlU7EcFCJET14FSpmrO9A
 MXRdH0SKewiz4B/IVyfrj4U+5j4UaMhf+Um2BL+yMtp+GGHmedpP3P2GIBtu1OC0yhcgBH3xy
 ALhByQj4EVv7ho2aV0INRqGx8BjTVveeQqvavowcF6omr+8FlGKAcMheKbB+KaTeSUXxskhnf
 EFuy10KG1N3Pdl5oNp0OMW43dAqbugUVvR1oNcs0QEg/u9Vjw8P8kEjjoIpgAIulZJ8wnstqg
 L2sqbT7pJY55zgPvKSRZUQ4XFp+4F0RQ7to2vDsf/vntrSVdFuMLkbN75VW0KlGAnoHrp+l25
 tRdluYXVGnt4ByrXKBO8BqtLsKfRscNeAYDmiaZekqZBY=

Register the WMI id table with MODULE_DEVICE_TABLE() so that
the driver can automatically be leaded on supported machines.

Compile-tested only.

Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/hp-wmi-sensors.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors=
c
index b5325d0e72b9..493a3b3e86f3 100644
=2D-- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -25,6 +25,7 @@
 #include <linux/debugfs.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/nls.h>
 #include <linux/units.h>
@@ -2072,6 +2073,7 @@ static const struct wmi_device_id hp_wmi_sensors_id_=
table[] =3D {
 	{ HP_WMI_NUMERIC_SENSOR_GUID, NULL },
 	{},
 };
+MODULE_DEVICE_TABLE(wmi, hp_wmi_sensors_id_table);

 static struct wmi_driver hp_wmi_sensors_driver =3D {
 	.driver   =3D { .name =3D "hp-wmi-sensors" },
=2D-
2.39.2


