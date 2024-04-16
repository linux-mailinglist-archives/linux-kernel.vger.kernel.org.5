Return-Path: <linux-kernel+bounces-146537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C08A66B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6539B251DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0439385C79;
	Tue, 16 Apr 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="k3Ho+Itd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFQTFJLg"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB685C76;
	Tue, 16 Apr 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258273; cv=none; b=rOgvoCEQLQZ+Zcz8iNNSenZA0uDYTWqzhHHKgbM+OdsFKKzFis6UsyR0xpmJ+lN/ERriMxxkvohTUXWgSqgAUPbrAoSn7HMKRVD8O5bFjUK5R7xf+oaGCuI2XrQ1nlVyj8dpRo4ihRD0Hr54nMxgYMRyEosDVqM+eFwgBQ0gqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258273; c=relaxed/simple;
	bh=dQb7AShGD8SaOB+dpSBrbd+XQBhHaEC69BqBkprUBgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxYpE6PhFZuydZj33rDJRUHroDT+HekEX82eufK4kvaQoin/7zcxOeAb8zxLODHAHj/TtPAUiO+SOxzV2xrlZh5zwXP1Me6xU3b5pnOiAnF2JATW4eljDGcyXBO7P0Pp11FhIuWHHPP3IzWm4BFqkajh3JbfLasiWvEmV2Y50s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=k3Ho+Itd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFQTFJLg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 206C2114015A;
	Tue, 16 Apr 2024 05:04:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 16 Apr 2024 05:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1713258268; x=
	1713344668; bh=o0VguGvkhfjanmvUkZrSpkY8KS8S4SNFR6TNBXk3LdQ=; b=k
	3Ho+ItdpDXP83/Z37rW5CQDefRmQ11lfjJnz05KWiF8wpnCLisJ5FSa1WJfhdHb+
	l7m3gYsr86ZXBp9+nIoKr+8Tgk/T7cj4gmRXW0BewM8p5LPmHX0JHYoCWGWqdKEM
	TlmzGoYT7zA+uR5GP74ln/e9Liqy2lio+UCglZpOqLth5g0XyBw//B4A22cRPaSM
	cVNxC6PGqW4Y40X8HV92jdf7PEi6PzeCQUscqxNtH/b9xAkq/aRs6OS/8gJOF3kk
	5Ug+2384q/DvgllmN+blotR+tnPe8CVnBOI8wwWLoY62rQr03LAkCwLBObeTFTwP
	ARyNBGx1VEAXUB+Oz3lzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713258268; x=
	1713344668; bh=o0VguGvkhfjanmvUkZrSpkY8KS8S4SNFR6TNBXk3LdQ=; b=i
	FQTFJLg4s10kss/qXxC+Ztbt76VHpEGyhjLWAN90IskvQWKA5kJIJhqXPrK+SklL
	KeaxXTALtUJWcm9Z5TwYeqxU3hku9hiFMc533Biwcj4flaOxPx9AnqBgjeU+gZE4
	p4WxbSTOuhjU8M73sC+FkSG8n65vZfkSDaAwosMybItrlmj0s4WbfrXnVzwksHNu
	AmbL/zyN+C8nq86eb0OJghoY8gf4xMUukhJw3IJjECC2wgR+auThGEEr7/C713a0
	ZbW74BzUPxXDdKljwOr4cLsMKvRm+cgLs5Vb+9sQPNlKBKFfAn/6kSfZHHxvP6pM
	rL5E+z2Bk3y6QZwGGH5uQ==
X-ME-Sender: <xms:Gz8eZvcG70iL1Lt-tXuZ9gqt8JQgHbf-Uy1rWwjJAz5-BxymmRQMng>
    <xme:Gz8eZlP9sbNwuAsMruQbbd33OdtS1myIbQNj1g4KhFzl44K1HnFxTCtrWS63OKiUr
    tEOhIa14jxQ-eDqjpA>
X-ME-Received: <xmr:Gz8eZojGRebJxRWc3xfDR2jCat1BRm3K9wkyXzrV68XVrInEF9iatn4EuiDT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Gz8eZg8kV_ZNZNAwVf5WC7HIxaw8CulCakEpSrUc_4xsauI11ow-_A>
    <xmx:Gz8eZruYl6nSTHbdhzQoGLziUBSIdc3EwhwNuoWW21Z0NK_QQBTgQg>
    <xmx:Gz8eZvGlDuAxWlFvS2aTj_4ujVlNqdEh89A7nOub10TvVuPoTO_xBQ>
    <xmx:Gz8eZiO_HPq8ciON_nITvDVXjydQIPUQeIP9F6wlDNIVCi5_4yixew>
    <xmx:HD8eZlLva8rQZlstAptXGTOeZZqTlNWQug62ARjnHX_yB10v2AbSu1M->
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 05:04:25 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 4/4] HID: asus: add ROG Z13 lightbar
Date: Tue, 16 Apr 2024 21:04:02 +1200
Message-ID: <20240416090402.31057-5-luke@ljones.dev>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416090402.31057-1-luke@ljones.dev>
References: <20240416090402.31057-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add init of the lightbar which is a small panel on the back of the ASUS
ROG Z13 and uses the same MCU as keyboards.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 3 +++
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 61820f7a6b25..02de2bf4f790 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1242,6 +1242,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f1e508a7ef06..94501dbdd463 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -208,6 +208,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD	0x1866
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2	0x19b6
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3	0x1a30
+#define USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR		0x18c6
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY		0x1abe
 #define USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD	0x196b
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
-- 
2.44.0


