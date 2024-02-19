Return-Path: <linux-kernel+bounces-71267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A785A2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B7C1C23866
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDA339A8;
	Mon, 19 Feb 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="I4mq0iXe"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A52E64F;
	Mon, 19 Feb 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343984; cv=none; b=qMz+Zuml6D6gEIXtqUvcYwA3QIq5UOJG/YMU5ZuMpJ1g+F0OxJaTjRjnBNuNuQ1vwRcbx9uFoxdTfEyYrwXyTpOkxAoW2mHKl4Ik45lXdheCeFh8rQFN8Od1Lgt2HvJAWEcoXmptoiguxWauaAMgwdEPPhdAHMybp//ZBPAeHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343984; c=relaxed/simple;
	bh=jNbs6mh9NRNmcMy+geYDC/0FJuXGdyoG3yuMN5TBvyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1AaW/w0V35xyWLWcBtsMOoXiIqCA7kSQ2B7b+Zm5sHyWoYdz3YWc7mBLO/K22w0vSdQNcAQLPJWPPMRNoVnRfiP/WJ3giQ4lEvkCSBEMsbSheCnOMzW7g2vHccXWhu4MBVj/yczJ5SEASA3CoDPr5C3eKD/wV6pmIySq0jGvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=I4mq0iXe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708343973; x=1708948773; i=w_armin@gmx.de;
	bh=jNbs6mh9NRNmcMy+geYDC/0FJuXGdyoG3yuMN5TBvyE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=I4mq0iXeFesQug4BYeka52DUBNP8YLI8wT2M2IDy8gtqTUhvc67lC7oOKd04Yqs/
	 XMxxUN3zGfXHQuvBr6gMSoTQkZcgB508c8VPiRk4JAzGnyDfnu0Lx90TiF8HxIPBI
	 LnIGolY0b0HOEf0o80hkBQ9aPiw40WmgIYMnydVNsxvpa4QEUxsDb4/2uIC/W0zyp
	 ANBj8Wb2WvZlkMskAPHq49bdf5FWE69J14yPdzvR1JS8PEJS7/rvjPmKuFhNaxkFk
	 uW+F9fdEgz52haLW3W7uohoZVE4/hSeV+QVqZRGk14BlHzyRafckeAZs8Cgl3ChZ6
	 nI+VPfEfCo/D3Y/dVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MS3il-1rUaKc07kh-00TR3q; Mon, 19 Feb 2024 12:59:33 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Revert "platform/x86: asus-wmi: Support WMI event queue"
Date: Mon, 19 Feb 2024 12:59:19 +0100
Message-Id: <20240219115919.16526-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219115919.16526-1-W_Armin@gmx.de>
References: <20240219115919.16526-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZJ35nPdHK8By7gcfdclwJO+Zz2VmNR2oBXLTl1BfboyzseFu4eM
 9j0u4g9AnK4alZu5BgzD1/RrSyATmuST0UgaMyYSg44fH80oZRxZx+l2Ejej8RujZIsDSQt
 3YScrQCg2HB/DrYN5fOQJ0A45lpjER+tb13KsNf8H7CSTBrswl333dGGPVLIgP15EKZ/vHA
 XvC4TfXpBMqlYS5Vs6UAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q79NRxKhYPU=;eELxmKwKpi3aicwQv7bWuu442fg
 5ivSD5qpdpakCi748gekkHyOzAnbt4cgowvdS2dxunpxFNLiDTd5iJyvYKQYzAEb546c+YrR0
 pC2u4ztK81cPvnfeCJm9rWvQfbxheVhN/Ue5L4Cs4i5q9ET2UpVeUC42A/42yHoVjJqAe7bpp
 tiRzZyrwU+qdDmQ00MtPCkYwjLPia+p+frjkOzxVNfz81JqbS1ROIKBDj80rSFPxTIlEkwUtc
 UbX9PIi4py/ZqPETtvx/U9PLVd110ASe03cLKSZEwRaeYM7q9uyLHsQLA0JrfUGdJH2UodVfo
 vv4Sq7Hc4JlT+8nHZdEZ5crfMfKP9asoHYLQhmIFqJzDeSgeXbIBZRJRNGm4OYgqZNFtZwqhA
 40Q9c9qhiIx6RTVlCIuxoHdujJCV3W0m5lttOaKPUiR7K4AqftlhGMFLnmacP8fgcIZKzz08S
 Pcs/FMqSae/o7LefEeghybqlwOTh5WYdvr5zzn1gp9oLrR0+QE6pebZakBueYZn7Cj48XvROn
 E6Icbyh41zh+SA0+iYjtpgacOKdZWGp2mFfUCE6ObbW4HxfUqOk2IbXSrI5BCtHYk32NcbkjK
 qL6zYJS9dqByjqcCC25CxlDknPS8fovTg3swtsNBzJE2SUyIkZpFPu+2nfpzj+/SV2wVdZvD5
 bC9f6wgt3hjC4tOuGeHlH5d1r9eLb1drxSEjb8jGouZBT4RYyrtKCdE/j5GLjdrZXqgsEDAa0
 d8KQmrPFF219Sd4Jqpl9j3fVqoyrSRQn9HElySRbS4mD3bP7qm1FwoaxCkpPEVLzFlDfTbmmq
 FGl8z4CeBY7eURaysQcEH9s6AJC02RXsJLxHNzEHdjeks=

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


