Return-Path: <linux-kernel+bounces-113412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7688841E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29911B2460C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374581A702D;
	Sun, 24 Mar 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIouecgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF461A69BB;
	Sun, 24 Mar 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320214; cv=none; b=p21GcnifznNkPcERyzTWq+wWWamqSq8voYkxo15SHnOv388GxFGq1P5blip6Xw1Qw3HySj3Jwc7lv2LnEeCR56foKkvIJsRsn6mgGmCOLqkRSlwoHfgwBQhzSYocbRLzglNLFIxYOPe16x8hfLHHOe9ZlcWFXj70Szv2cxpMLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320214; c=relaxed/simple;
	bh=mvaQi4rBDSOnIPPLAudxamhpMufrPv08bZt49wXE+sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWz/fjm6jIG/gZdPJkhRdG31KLl2i8fETpCnogHgzhx6omvGNeZ+Rs+ej9hyaJqW32Xnsl1Hj/jK4aUCEI/x/p9X91thMYEKo70CmbhQ5AQycV/liOj4Qtc0ydlgsE58O6APm41+UFchXJqs5SgjZKfj0Wv6z1hZSNw3IAV18ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIouecgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B16DC43390;
	Sun, 24 Mar 2024 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320214;
	bh=mvaQi4rBDSOnIPPLAudxamhpMufrPv08bZt49wXE+sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIouecgF0c4zWdQCS1R5fbJjKKatfuf06eL1y4DVLvwnTgKNuY28gBfrb/GnmmJSU
	 Tm2pfRZjtgIJ3jnpwMqGYKsjn40eQWC5tDerr5TwydvvBzXvGqb0+2pmW1CyOevGjG
	 Kfy9by85k1+MXjyiywxNMUR0ooqDBhIeLgsSCRyjFnJU3TXseXahFHh13ge2DDiMJH
	 b0vD9+K2rxmWwhxK5+R03fSYoBd4akcKozUTywSsZYYjTkoZh0ZeDhhxZq7DdmiZ+v
	 byW1rsJESvGPoEY6ErqNQc3i1lv0kW/TD4v94ZUS+sakkzWirJxDyqIOL/xe5/Pl+w
	 TvpPqhzC5W5Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 521/715] leds: sgm3140: Add missing timer cleanup and flash gpio control
Date: Sun, 24 Mar 2024 18:31:40 -0400
Message-ID: <20240324223455.1342824-522-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

[ Upstream commit 205c29887a333ee4b37596e6533373e38cb23947 ]

Enabling strobe and then setting brightness to 0 causes the driver to enter
invalid state after strobe end timer fires. We should cancel strobe mode
resources when changing brightness (aka torch mode).

Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
Signed-off-by: Ondrej Jirman <megi@xff.cz>
Link: https://lore.kernel.org/r/20240217191133.1757553-1-megi@xff.cz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/flash/leds-sgm3140.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index eb648ff54b4e5..db0ac6641954e 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -114,8 +114,11 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 				"failed to enable regulator: %d\n", ret);
 			return ret;
 		}
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
 	} else {
+		del_timer_sync(&priv->powerdown_timer);
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
 		if (ret) {
-- 
2.43.0


