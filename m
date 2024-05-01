Return-Path: <linux-kernel+bounces-165354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40C8B8BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EAF1F22203
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C012EBED;
	Wed,  1 May 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPqw6FoH"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702212DDB0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572186; cv=none; b=HJKh7kqLo1RzYJQYJCbuv4gP4xc8pGQSLAlnfE5Vqf7Uu0y5ep6PKKfZh0ro6OT6580kSemHVKN9c3mfqVp1rHALO4oCB9+A4b3aNIVZE0J6ogS8wok+WFhMAg4Fie1RhYDu6NEfxfrsNLIh2VD2SUFHuPYBO9uk+4dCW+Znguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572186; c=relaxed/simple;
	bh=hflhYB4Noj4nERICqWqd6RQ5KHGcpSWf8R1+rSb3bnQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E7KdafJVVmZzUj19wWflvDxiDzivDPw8cb+rMUmZYMqdTU7gzASJ/zcfGKjU3ZKAaF3Epo0Xa6NutVAPDzWWIs3//9WewP8uCaExEpWyjGB9NCtZikERVVlc94LncP7KWhpW2vl726rNBYvrd//KkDX5fR6w2vLVK0a/vKRJ6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPqw6FoH; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7dabc125bddso740663139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714572184; x=1715176984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WEz7e1nQ37hCn/3Xwr+FGVChoRELfC0yh3iJRprUV14=;
        b=OPqw6FoHZzr/b7RVyXVf9O2zlSARYPggemxysk6k1oDULs2scfW7pnDbT0DonJeUqW
         qXPx2WEz3lWL0Q7bpqswqLMCI67hxm6JNMNItHnMojU5zcc2TZYkN7Np0ayvuH1vWA/A
         5zFSrEdcoacb7rBsGsTRtetGgOk8zj/b5YqJPXUBCTOOJvdwzOkFlbWIOOKoSaYS6gLE
         ZSrl6kjRcv6gzzcnj825RwwC4Mu1ymTlJjkZBt+GvgJi0j2W6E1KLoMVSnDgX5u/Ib97
         utIsPhTrl+txJWndBXXsO7tHTPmLrV7DNpkDnJuejJsE8n3LXYbY4mXVMEHAs4V2oARC
         e/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572184; x=1715176984;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEz7e1nQ37hCn/3Xwr+FGVChoRELfC0yh3iJRprUV14=;
        b=n6BfYtHEsGxl8CjZvVQX5fS0WoM3g/jtdNR771CCUfEbP/AsHEQCEpdj64EIar1kkR
         HDoOe50XXos5kk0Zo50h419fZz+zlhUZlFNigHUvBQn2R6UxadW/S5LAAxfzSyxMz5X1
         iox8WrJ6oj9bNLzNpiHzAfiSU14TDKu93Jp/WsqwF89wNss+gU//nfgD/XSWtpjYu4VH
         /01i0bbJQM5/XDjqLfyZF0acJmtfPNVp8qjm6AcuFmRThl4VxoedHlSozGhWSMIp3Y4I
         eWiSdYWvS4HmHoyfdwX5sQpkG+dGLp0/C90ObIRd2WLs8xfAdEcARX57/zqj36o82NkM
         qqHw==
X-Gm-Message-State: AOJu0YxivOssY/ukBgR8Rigu48iK0CZae8u3JLCn8RDbi33Z77UglCCA
	PLzWujmmLEyunu5rZposy3zxQVyrx73zQ849D3dAWD7Knt7lADfvkuhO91m42D05/DATsSa43Jt
	Cr4NNPBEU4GnKLiPMGo7kxS95fdj4NYbrhGaFpoX5kB8klt7sqJwg83Y9dz3VF2j4WOYtJVoT2q
	uKzJ/IspMcv3y5MrEKIMXuMLG9kZrD6FLl6e8MKlqYbVx8rw==
X-Google-Smtp-Source: AGHT+IGTruoJbxEag2Zphrnj9aAkedb6FDf5j2791xk6DWblhokX7i4TGzOYSlerpjVnCD5w2qDi9foKJuQj
X-Received: from dynamight.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:17a])
 (user=jdenose job=sendgmr) by 2002:a05:6638:8c15:b0:487:8cf0:df03 with SMTP
 id jl21-20020a0566388c1500b004878cf0df03mr77559jab.5.1714572184397; Wed, 01
 May 2024 07:03:04 -0700 (PDT)
Date: Wed,  1 May 2024 14:02:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>
Subject: [PATCH] Input: elantech - fix touchpad state on resume for Lenovo N24
From: Jonathan Denose <jdenose@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-input@vger.kernel.org, Jonathan Denose <jdenose@google.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jeffery Miller <jefferymiller@google.com>
Content-Type: text/plain; charset="UTF-8"

The Lenovo N24 on resume becomes stuck in a state where it
sends incorrect packets, causing elantech_packet_check_v4 to fail.
The only way for the device to resume sending the correct packets is for
it to be disabled and then re-enabled.

This change adds a dmi check to trigger this behavior on resume.
Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/input/mouse/elantech.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 4e38229404b4b..e0f3095b4227e 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1476,6 +1476,23 @@ static void elantech_disconnect(struct psmouse *psmouse)
 	psmouse->private = NULL;
 }
 
+/*
+ * Some hw_version 4 models fail to properly activate absolute mode on
+ * resume without going through disable/enable cycle.
+ */
+static const struct dmi_system_id elantech_needs_reenable[] = {
+#if defined(CONFIG_DMI) && defined(CONFIG_X86)
+	{
+		/* Lenovo N24 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "81AF"),
+		},
+	},
+#endif
+	{ }
+};
+
 /*
  * Put the touchpad back into absolute mode when reconnecting
  */
@@ -1486,6 +1503,22 @@ static int elantech_reconnect(struct psmouse *psmouse)
 	if (elantech_detect(psmouse, 0))
 		return -1;
 
+	if (dmi_check_system(elantech_needs_reenable)) {
+		int err;
+
+		err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, NULL);
+
+		if (err)
+			psmouse_warn(psmouse, "Failed to deactivate mouse on %s: %d\n",
+					psmouse->ps2dev.serio->phys, err);
+
+		err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_ENABLE, NULL);
+
+		if (err)
+			psmouse_warn(psmouse, "Failed to reactivate mouse on %s: %d\n",
+					psmouse->ps2dev.serio->phys, err);
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad back into absolute mode.\n");
-- 
2.45.0.rc0.197.gbae5840b3b-goog


