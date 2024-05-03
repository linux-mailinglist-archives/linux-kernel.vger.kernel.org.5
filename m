Return-Path: <linux-kernel+bounces-167877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333448BB09E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C013B1F21410
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA1152DFE;
	Fri,  3 May 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDnDiyzQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433ED46421
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752735; cv=none; b=Emg74fOoqmj6YbKJNO392R9KqouEwIOuVnItGp4haG2iUnsr08AkCqFBAtJIqOvpxEmQJyb2h0VqCBymn6sGyATDRobGfPewBJ+ab+LAPFGiljQoFS+vXCdpfvoTQUEmSjhgSh5fSEVoT2LSnGpxV2zml7bzixwVkQnqc/o/uW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752735; c=relaxed/simple;
	bh=d4IuGFtalUbbFHdhNE+Kmfob/ZGfP/hZ2lAynUSJ3IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iR8Tl7Hk4J6YhgtTDaMwq9gy/PHbFIful9FIWxxJz6MYGYqd9RIT5qzYv/1H55gR7lCeXZWirXGp2xn7AFIHj58o3FVicXeBtsbXpeCSp+347rfN17T6zWopKIvQj8VScoo/g1TvLYRJ69w5VjLq5Sxzl/oGYJPNdfok2HWU/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDnDiyzQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bef0accddso83646937b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714752733; x=1715357533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPKPhF5hHSV72rXRuskt7REVZj/wmqzryYtSK+EmwAs=;
        b=cDnDiyzQbvAADmzGrlOYPdFI8d06y61eOKNfA/Kx05I7WPpQ//fKg2PwrFNINPc4Ta
         OD76VE+h3jrzTRdnQiBa2f/BaSLZ1BAkR/vEUX+ZgpeiQNQZxd4GY9lS2HrNpgtfHoDu
         hrKLtDLcyVZTycqapNwKWEGDwOgfcoqE22DKrUFQZ9z4JNLkR5x9XaEbn3rCuCfjs0q4
         Gb/1MNFOaZqoepST31p3xzOZf1uVhh++LmGpu4Hfed7ezOg2SNeQXzdBVCHLwCMqE/PD
         +iwx/lyihg3ywydnBSV9U8Bwi+vjbpzpXtt/JSiP6HCCJZc1nQQ3wpgJF3w6uZJzUkfC
         VMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752733; x=1715357533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPKPhF5hHSV72rXRuskt7REVZj/wmqzryYtSK+EmwAs=;
        b=BFM0a19e+NHHg9ToL+XMAgkRAA1vw/VHok2brSYDqmLhgGzH0Kn2JKvkVkTifaAM1B
         DWH05I57ygia6lGp4ak66btoNpzYXfxFnaw/OQLNW2kSB5BP4Du4ABqasSmhT78cdHuO
         rAaDryrKLMvcYudTlXG7EI1wDW17r/O1Vd5WxXIn0FF7YkvQZzBsTFZYZfclRLBigjwT
         HOnRPkCwKL/4rrH+zDIoKzBKcYnuSQuX8E++2yh1obRscDSdvINPUWi3OhNMHJrABo2o
         DLwYdtijs90aB3aoIke1qB+/FNnforDvHYLuzIF10GNffkZuzoqbgPb0Pod1y3vCwC43
         AOmw==
X-Forwarded-Encrypted: i=1; AJvYcCUf/dt+5CenqbyMf6rgbvPkYFupuBTJE7co+IHDhcFN5HelmHJQdlleh+dYfqSSdISvqKSynfcjKaOi/KymkA7dPlpAc8lX6fGkKahc
X-Gm-Message-State: AOJu0YxgJGffAgKCr9vK2jTXSACPZO4n4jR3hVVYpJrZIOkHPuFncwBH
	oVTu9TeKZ2CZ2VCBEUIiLTHd+vOn+au+IRgDbPGCPa9iaad9a0hh9LR/zP8Ww51QQ+lkiP3myw8
	RRGPhvQ==
X-Google-Smtp-Source: AGHT+IH9YLvTTbCs+pigjyGOB76rOPYdVPQPbMQLFumi4iZDMdmJZ5B6gE7d+OC9FMN99jfTq+zqBSJuVkqT
X-Received: from dynamight.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:17a])
 (user=jdenose job=sendgmr) by 2002:a25:ad9b:0:b0:de5:9f2c:c17c with SMTP id
 z27-20020a25ad9b000000b00de59f2cc17cmr891850ybi.9.1714752733280; Fri, 03 May
 2024 09:12:13 -0700 (PDT)
Date: Fri,  3 May 2024 16:12:07 +0000
In-Reply-To: <ZjQeE643YAbK1hq5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZjQeE643YAbK1hq5@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503155020.v2.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>
Subject: [PATCH v2] Input: elantech - fix touchpad state on resume for Lenovo N24
From: Jonathan Denose <jdenose@google.com>
To: dmitry.torokhov@gmail.com
Cc: gregkh@linuxfoundation.org, jdenose@google.com, jefferymiller@google.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Lenovo N24 on resume becomes stuck in a state where it
sends incorrect packets, causing elantech_packet_check_v4 to fail.
The only way for the device to resume sending the correct packets is for
it to be disabled and then re-enabled.

This change adds a dmi check to trigger this behavior on resume.
Signed-off-by: Jonathan Denose <jdenose@google.com>
---

Changes in v2:
- change ps2_sendbyte() calls to ps2_command()

 drivers/input/mouse/elantech.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 4e38229404b4b..18f26315cae25 100644
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
+		err = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE);
+
+		if (err)
+			psmouse_warn(psmouse, "Failed to deactivate mouse on %s: %d\n",
+					psmouse->ps2dev.serio->phys, err);
+
+		err = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
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
2.45.0.rc1.225.g2a3ae87e7f-goog


