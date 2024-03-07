Return-Path: <linux-kernel+bounces-96303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8318759EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E52B21362
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79C13DB99;
	Thu,  7 Mar 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kWAIt/jr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0C130AD0;
	Thu,  7 Mar 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849166; cv=none; b=JSuM/DXvw2KSyB5RwABfgXXzYuKIgYu2wDqKT5cUid1qmyB+p1O+ywS/3myWXj/5L62mCV3YHHNaUIuk1VhYRNzgLF0KY6QcyWDElNRhIHSxRCciMbiOdjOMRdMkVy80zE+63j5RGU3r7dAOahVrA4WdJSn9NAUIO0LZg8BXVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849166; c=relaxed/simple;
	bh=OhHJ41vSOTMo2bLACgKWhLDz7+2yE1z6/TA3Fn3DXUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rUIpT5UjGavH8uuMyitRQZMQO6lCYbqWrkZ4C0jzOyrVGG5404zuh0z/sh9i2zOJ/jGNsqwlWTU+L1Z79WLt2YyjNbFCkJP8mFRtMSFtYHNU0ghRN7CrfD+lcmkSnKK0g1RDrSnoCcAHpFmimAc1Jn+97/rblEfhrgLF0a046Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kWAIt/jr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709849161;
	bh=OhHJ41vSOTMo2bLACgKWhLDz7+2yE1z6/TA3Fn3DXUk=;
	h=From:Date:Subject:To:Cc:From;
	b=kWAIt/jr9o4MOnRMCXoICYinsb6YSTG9cm/Plim3+otNta5XVB36sskdeW3OEUNbx
	 B/rrNm+U7kpuIK7EejeMlPEuZfxqydBAehqBn4Pjwm/k9imOIMTMgnH7pPxY7d/lq7
	 RAxCeGazTNy808CBIsvHOHyxTIvn4oqpL5eFTPPnDtHkzFkZ2TKVAg1+URApmtrFBX
	 Ke4IWXfD6LV0hdQ/ZYIokfn+m0KdnmO23MFvzz+FsDVr8whW6JGtzwRXT7Gt6FY0V1
	 p5t2XHsR0U/WVAMoP0X7O10QhkDIl7SJXq0i6SAYYYtentWpA0XjSU3ck+Gg0h2I6H
	 gI7A4j+SbgpIg==
Received: from [192.168.1.3] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA24637804B2;
	Thu,  7 Mar 2024 22:06:00 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 07 Mar 2024 17:05:10 -0500
Subject: [PATCH] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-sbs-time-empty-now-error-v1-1-18d0f8702330@collabora.com>
X-B4-Tracking: v=1; b=H4sIABU66mUC/x3MOQqAQAxA0atIagNjRhC8ili4RE3hjCTignh3B
 8tX/P+AsQob1NkDyoeYxJBQ5BkMSxdmRhmTgRyVzrsKrTfcZWXkddtvDPFEVo2KnqgfXFWOfiJ
 I+aY8yfWvm/Z9P13wf55qAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
specification as required, it seems that not all batteries implement it.
On platforms with such batteries, reading the property will cause an
error to be printed:

power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5

This not only pollutes the log, distracting from real problems on the
device, but also prevents the uevent file from being read since it
contains all properties, including the faulty one.

The following table summarizes the findings for a handful of platforms:

Platform                                Status  Manufacturer    Model
------------------------------------------------------------------------
mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
rk3399-gru-kevin                        OK      SDI             4352D51

Identify during probe, based on the battery model, if this is one of the
quirky batteries, and if so, don't register the
POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW property.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index a6c204c08232..85ff331cf87a 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1112,6 +1112,49 @@ static const struct power_supply_desc sbs_default_desc = {
 	.external_power_changed = sbs_external_power_changed,
 };
 
+static const char * const unsupported_time_to_empty_now_models[] = {
+	"AP16L5J", "AP15O5L", "AP16L8J", "AP18C4K", "GG02047XL"
+};
+
+static void sbs_remove_unsupported_properties(struct power_supply_config *psy_cfg,
+					      struct power_supply_desc *sbs_desc)
+{
+	enum power_supply_property *new_properties;
+	struct sbs_info *chip = psy_cfg->drv_data;
+	bool missing_time_to_empty_now = false;
+	const char *model_name;
+	unsigned int new_num_properties;
+	unsigned int i = 0, j = 0;
+
+	model_name = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_MODEL_NAME);
+	if (IS_ERR(model_name))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(unsupported_time_to_empty_now_models); i++) {
+		if (!strcmp(model_name, unsupported_time_to_empty_now_models[i])) {
+			missing_time_to_empty_now = true;
+			break;
+		}
+	}
+
+	if (!missing_time_to_empty_now)
+		return;
+
+	new_num_properties = ARRAY_SIZE(sbs_properties) - 1;
+	new_properties = devm_kzalloc(&chip->client->dev, new_num_properties * sizeof(sbs_properties[0]), GFP_KERNEL);
+
+	for (i = 0; i < sbs_desc->num_properties; i++) {
+		if (sbs_desc->properties[i] == POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW)
+			continue;
+
+		new_properties[j] = sbs_desc->properties[i];
+		j++;
+	}
+
+	sbs_desc->properties = new_properties;
+	sbs_desc->num_properties = new_num_properties;
+};
+
 static int sbs_probe(struct i2c_client *client)
 {
 	struct sbs_info *chip;
@@ -1210,6 +1253,8 @@ static int sbs_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	sbs_remove_unsupported_properties(&psy_cfg, sbs_desc);
+
 	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->power_supply))

---
base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
change-id: 20240307-sbs-time-empty-now-error-322bc074d3f2

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


