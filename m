Return-Path: <linux-kernel+bounces-64823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489E854343
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B501C20B31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146C12E4E;
	Wed, 14 Feb 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SIMvMopQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6912E72;
	Wed, 14 Feb 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894298; cv=none; b=HTvxZeufWdEHLEq5Gz0tFS7SJSMI0TS+lyBzxA+sUcTe6JsmrD6+2nA8CE3wJTpIk2Wq8oias1axtm2zvuJtXuZ1ZCmijYnvcgbMWMbqQG1WZnZwFZE5gWvYyI4D2avhM5icF3u+F08Eiw+/4dHb4vISvNrLQJdC/GQ9LkSEE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894298; c=relaxed/simple;
	bh=jNbs6mh9NRNmcMy+geYDC/0FJuXGdyoG3yuMN5TBvyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiXWmt0Q4xvb1KAmOd72bLsYwNFk4KVxnjNM+UcLSq6kKI4Mn2blVFIDR1sl8RHEdB+RB1+fAkM7m2dBQo7TU7shArg5suRhX7oBd9ElSsGBKoh5s6bN+OWkt6bPWh32YEaPiCPxa8160wWqbNtTENA+h9S4C6EltIK/ytl/u/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SIMvMopQ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707894284; x=1708499084; i=w_armin@gmx.de;
	bh=jNbs6mh9NRNmcMy+geYDC/0FJuXGdyoG3yuMN5TBvyE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=SIMvMopQ3rd+EVHEJtD1umlmMjnWjtFqsGqKfQtI8pHKo8ZPNcVvUNMNyPb56gqJ
	 uXDFWT5XsuJQT4ZfhyLnFm2XB01toM15TiH7cyJRh3OkCrqs1Z4Mi98Q11I1i20cp
	 lhwh5y8rjpmwqSM1hV5H+E8S9mpbCiLtiwpKmQaLIfnmz79a491A8QMzKmACpjZao
	 5ys5hGhbR6qBknZAFIpfwt4BoQdBnNbeBtVGIixjmbTvYUesHyXwVLMZfUHZxuXFP
	 I8Q0M3tM7BL93VLB7UnwpyPVTMwQuHTvWYqpWVJzx/9ckRUn7vxM8h4e+gIqWCbvC
	 CkrQJlJhp6ofj9sZrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYeR1-1rWUJz0P8V-00Vf0h; Wed, 14 Feb 2024 08:04:44 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Revert "platform/x86: asus-wmi: Support WMI event queue"
Date: Wed, 14 Feb 2024 08:04:33 +0100
Message-Id: <20240214070433.2677-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214070433.2677-1-W_Armin@gmx.de>
References: <20240214070433.2677-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wyGbHPosidm1hk/7v8ToNR7ME3UU99ChHqlYcLaMV5BXXNBdroc
 c0JsZdWySDnOxaTGtRltdabda71rSYPXuoHFe0D54wFJDN4yN4nmKdckTB2voiXx9C4rAyq
 pFM4TBG1e7H0QqIaX8GI5gB4gMtTrgp5JgvrIwj3sZx5/xv5TxzfeB++gHxJteW77QWvH10
 F/nM0Bk3p2N7gly30hu0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VggErPqJM9c=;PauDD9Ido5AEVDLIW3VhEGRrO8V
 sDNPHDUGZRec9GOTnqKdSvtNLMfDvyDcShVmaPPNE+AEQFRxMusubSNIlFTvYEpcZS9WYjayg
 jJAeYDbr2F4NKMqxlv57DZHNb66LuXIfw66CZtL136XdjfPOJaCnF9/2R6ijzvauaG5bnjvIX
 7a3jjJk6FHnuORUUBpDINq5LCfjoFKl6WTOUl8ftfmf0/4NDlkFUrwD6p6YGuFvqw9aZ8j4SJ
 7YQund/DFxAq0M6pezSj4VeHLoNFDby61ksAZXvFsu3p5prE8a8rzVg2itwuCHvnZx8eg3oJd
 X0rwaJ1TLfVmbPaa960VpYUPb19F4p9shp0XOfh25n8MbBCWgCrAbopBZMSsgay0/DOOLhaG2
 a2JVf/cj0rXViV1zCUQ3On0bxbQOytXF0rYLdJ0O16kpmZRXwCD//Tc7qBG/6dGzxHrF8cdn3
 o1c59O+KL6dI6a22CJDuzFyTs0OIuj9ygNVe//2NqMwCoJDlhjgLN/MK47FRkebVlV/aXoHnR
 yIGMUlX3Uh/hoIkKwj0mSlVsueTNQXlkdZVRZM4IUTM1pWEHyARv3yqUje290W1ScP1Qhu15Y
 74ql3vMKJqPTQH8he063400q0UIYG/uFQYX23G6bLkDwlkt4KyhzYUY6jFLgRY3hIo1U0B9wv
 Ikb+ouKy/djRt2d0mYr+6omUkcmlRnkJsJ3Kxn4pbLAcaGgSQrYIl76PjrvDdOEg5YyTslGbH
 e+h42LNNDXYrbnkMY1jo/xxofpObcW6YYg3jw+QHNWTwaC998cdeRZTvzPChvmnL5bh5aEcs1
 AdvY018m246TnKtGckaoEoPF/p7B6wUb2gKx0mm8JDfDo=

This reverts commit 1a373d15e283937b51eaf5debf4fc31474c31436.

The WMI core now takes care of draining the event queue if asus-wmi
is not loaded, so the hacky event queue handling code is not needed
anymore.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/asus-wmi.c | 71 +++------------------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index 21dee425ea6f..2865af89e95c 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -101,13 +101,6 @@ module_param(fnlock_default, bool, 0444);
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31

 #define ASUS_ACPI_UID_ASUSWMI		"ASUSWMI"
-#define ASUS_ACPI_UID_ATK		"ATK"
-
-#define WMI_EVENT_QUEUE_SIZE		0x10
-#define WMI_EVENT_QUEUE_END		0x1
-#define WMI_EVENT_MASK			0xFFFF
-/* The WMI hotkey event value is always the same. */
-#define WMI_EVENT_VALUE_ATK		0xFF

 #define WMI_EVENT_MASK			0xFFFF

@@ -219,7 +212,6 @@ struct asus_wmi {
 	int dsts_id;
 	int spec;
 	int sfun;
-	bool wmi_event_queue;

 	struct input_dev *inputdev;
 	struct backlight_device *backlight_device;
@@ -4019,50 +4011,14 @@ static void asus_wmi_handle_event_code(int code, s=
truct asus_wmi *asus)
 static void asus_wmi_notify(u32 value, void *context)
 {
 	struct asus_wmi *asus =3D context;
-	int code;
-	int i;
-
-	for (i =3D 0; i < WMI_EVENT_QUEUE_SIZE + 1; i++) {
-		code =3D asus_wmi_get_event_code(value);
-		if (code < 0) {
-			pr_warn("Failed to get notify code: %d\n", code);
-			return;
-		}
-
-		if (code =3D=3D WMI_EVENT_QUEUE_END || code =3D=3D WMI_EVENT_MASK)
-			return;
-
-		asus_wmi_handle_event_code(code, asus);
-
-		/*
-		 * Double check that queue is present:
-		 * ATK (with queue) uses 0xff, ASUSWMI (without) 0xd2.
-		 */
-		if (!asus->wmi_event_queue || value !=3D WMI_EVENT_VALUE_ATK)
-			return;
-	}
+	int code =3D asus_wmi_get_event_code(value);

-	pr_warn("Failed to process event queue, last code: 0x%x\n", code);
-}
-
-static int asus_wmi_notify_queue_flush(struct asus_wmi *asus)
-{
-	int code;
-	int i;
-
-	for (i =3D 0; i < WMI_EVENT_QUEUE_SIZE + 1; i++) {
-		code =3D asus_wmi_get_event_code(WMI_EVENT_VALUE_ATK);
-		if (code < 0) {
-			pr_warn("Failed to get event during flush: %d\n", code);
-			return code;
-		}
-
-		if (code =3D=3D WMI_EVENT_QUEUE_END || code =3D=3D WMI_EVENT_MASK)
-			return 0;
+	if (code < 0) {
+		pr_warn("Failed to get notify code: %d\n", code);
+		return;
 	}

-	pr_warn("Failed to flush event queue\n");
-	return -EIO;
+	asus_wmi_handle_event_code(code, asus);
 }

 /* Sysfs ****************************************************************=
******/
@@ -4302,23 +4258,6 @@ static int asus_wmi_platform_init(struct asus_wmi *=
asus)
 		asus->dsts_id =3D ASUS_WMI_METHODID_DSTS;
 	}

-	/*
-	 * Some devices can have multiple event codes stored in a queue before
-	 * the module load if it was unloaded intermittently after calling
-	 * the INIT method (enables event handling). The WMI notify handler is
-	 * expected to retrieve all event codes until a retrieved code equals
-	 * queue end marker (One or Ones). Old codes are flushed from the queue
-	 * upon module load. Not enabling this when it should be has minimal
-	 * visible impact so fall back if anything goes wrong.
-	 */
-	wmi_uid =3D wmi_get_acpi_device_uid(asus->driver->event_guid);
-	if (wmi_uid && !strcmp(wmi_uid, ASUS_ACPI_UID_ATK)) {
-		dev_info(dev, "Detected ATK, enable event queue\n");
-
-		if (!asus_wmi_notify_queue_flush(asus))
-			asus->wmi_event_queue =3D true;
-	}
-
 	/* CWAP allow to define the behavior of the Fn+F2 key,
 	 * this method doesn't seems to be present on Eee PCs */
 	if (asus->driver->quirks->wapf >=3D 0)
=2D-
2.39.2


