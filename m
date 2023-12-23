Return-Path: <linux-kernel+bounces-10471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9533681D4C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BE51F223B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345CBDF63;
	Sat, 23 Dec 2023 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b="VOcFAZgu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE4DF4D;
	Sat, 23 Dec 2023 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brun.one
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
	s=s1; h=MIME-Version:Message-ID:Date:Subject:Cc:To:From:In-Reply-To:
	References:From:To:Subject:Date:Message-ID:Reply-To;
	bh=06NBae489p7VTnS5uQHaWu0R4s/Up1uW1AfzBZmeZH0=; b=VOcFAZgukQREzSY/Zq8WZZJmre
	nXHGkKXNvxM1CNlK+iZag5B8qaMGeUtQW3fVsgWB9JGVOyoCavpZ1vB8mkjfQlUWqw6KP9y184M98
	tBKFqBChzvrxLuFyk5AElL/8Vz/ZOftB85WzR0806utv0LUGqgiGOgmn6FqcNEBa+zsHVm50WZ+tT
	V5Y68DAkJbHIXE0WZ/2CEH8ybGECxki90OdoSlgH8PNxHyLoXE18Fd8gzFGJ1wlPlPnH2fK4Jjaop
	VnrAAPJqZ+g7/Si7jL80Y7yHp3twYJ5y8+holqOQPjbkG4+pGi593G5/P68Toaew1Q+MqLHe/SjvF
	2Fv8L5xQ==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
	by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <lorenz@dolansoft.org>)
	id 1rH3cr-000xdn-1C;
	Sat, 23 Dec 2023 15:09:17 +0000
From: Lorenz Brun <lorenz@brun.one>
To: Stefan Binding <sbinding@opensource.cirrus.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda: cs35l41: Add HP override
Date: Sat, 23 Dec 2023 16:09:11 +0100
Message-ID: <20231223150912.3040328-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org

This adds an override for a series of notebooks using a common config
taken from HP's proprietary Windows driver.

This has been tested on a HP 15-ey0xxxx device (subsystem 103C8A31)
together with another Realtek quirk and the calibration files from the
proprietary driver.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
Changes in v2:
- Use newly-introduced config table instead of function
- Change boost cap value from 10uF to 24uF after cross-referencing my
  sources with the preexisting 103C89C6 entry.

Just noticed that yesterday I sent out another copy of v1 instead of v2,
sorry about that.

 sound/pci/hda/cs35l41_hda_property.c | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c9eb70290973..c65b106ff1ab 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -42,6 +42,30 @@ static const struct cs35l41_config cs35l41_config_table[] = {
  * in the ACPI. The Reset GPIO is also valid, so we can use the Reset defined in _DSD.
  */
 	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
+
+	{ "103C8A28", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A29", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2A", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2B", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2C", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2D", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A2E", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A30", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8A31", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BB3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BB4", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BDF", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE0", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE1", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE2", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE9", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BDD", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BDE", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE5", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8BE6", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8B3A", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+
 	{ "104312AF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431433", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431463", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -374,6 +398,28 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "103C8A28", generic_dsd_config },
+	{ "CSC3551", "103C8A29", generic_dsd_config },
+	{ "CSC3551", "103C8A2A", generic_dsd_config },
+	{ "CSC3551", "103C8A2B", generic_dsd_config },
+	{ "CSC3551", "103C8A2C", generic_dsd_config },
+	{ "CSC3551", "103C8A2D", generic_dsd_config },
+	{ "CSC3551", "103C8A2E", generic_dsd_config },
+	{ "CSC3551", "103C8A30", generic_dsd_config },
+	{ "CSC3551", "103C8A31", generic_dsd_config },
+	{ "CSC3551", "103C8BB3", generic_dsd_config },
+	{ "CSC3551", "103C8BB4", generic_dsd_config },
+	{ "CSC3551", "103C8BDF", generic_dsd_config },
+	{ "CSC3551", "103C8BE0", generic_dsd_config },
+	{ "CSC3551", "103C8BE1", generic_dsd_config },
+	{ "CSC3551", "103C8BE2", generic_dsd_config },
+	{ "CSC3551", "103C8BE9", generic_dsd_config },
+	{ "CSC3551", "103C8BDD", generic_dsd_config },
+	{ "CSC3551", "103C8BDE", generic_dsd_config },
+	{ "CSC3551", "103C8BE3", generic_dsd_config },
+	{ "CSC3551", "103C8BE5", generic_dsd_config },
+	{ "CSC3551", "103C8BE6", generic_dsd_config },
+	{ "CSC3551", "103C8B3A", generic_dsd_config },
 	{}
 };
 
-- 
2.42.0


