Return-Path: <linux-kernel+bounces-150100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B618A9A62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626411F210C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D1F165FC7;
	Thu, 18 Apr 2024 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="sQf11lHi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21482165FC0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444518; cv=none; b=iQQADhqR/SogVgDL1Lfni1thkjLT3pHLF9nxJK0zYJtAY5s9F3n4LXUjbwCjLIU+MNTcaXMWaTHMractw7m4PCsmID8zhQr+hYE/aH2ySULlwafbtzEKbV3+rnM+CRB3WrNvUgjh6PLe7vTmCUxB6m13vx7T4eWVS1aNruR7/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444518; c=relaxed/simple;
	bh=5AN52fvuIGpZ7M8dMmpZFYqxQTNW8ioM6dCfXkkJGVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E+oL+1OMFmBtlQemx1oWIaQ+EMfoSzk2tLMNQMUX5shdEp/ggEyMADtk7WlvyIVzBdgtlAKnl+AKCBTszhsnfHn2QtsAYe1kGEU1kqWPFbuzCzbf6e1f23eIVGJs6E3NcBMrOZhMUZnBndVsApLy4Q2PlQc2Kpo/RzW4N3nWyLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=sQf11lHi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2b137d666so6981905ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713444516; x=1714049316; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0M78v9nKtcu9aDQjEM1qTGU4tk87ySL7DtZXrv0/mjY=;
        b=sQf11lHieGFQMWgBmc86ov7fAqVarrfIb0F3DENxhj3Ssbr+eRM4VRP+isNKES+m28
         5w35eiXHVxh7ZHUmUgiZKGD2dyFStvpt+kbgCDpCc+E3kpTg42jawCxTS7pcfYOZztA/
         /B5bYHhhMK9fpxujf0aPobj30Pjk1H0yxmPIWg0uZcuNCBYfYxT5Nc93mPSHQasjPpc/
         QkpMTnBPF7t1A0Ock/bANHR5O4jv3vsDM8xYkPygdv5xJozVZwaGTMWB4lnf2dcLKZz2
         ZRJPaTOf2Tnvgdo3FMrzsqcNpQqIVL1An1nOB3Ldp4mvHRdCSUJ9WqbXmEXDZIirxwgG
         KCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444516; x=1714049316;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0M78v9nKtcu9aDQjEM1qTGU4tk87ySL7DtZXrv0/mjY=;
        b=GD0AxUnfaodwfXTwuwoFHQbP1Wi5G3X+SVbP2cWsDF/+gbCgSu8KbO/2/XQocw5Any
         hB96WxBILV4F5dlac3w7p3P2WIUpe0SLYIo8MsIL9GKCLM9ZoLBg61C66OKlNr2cVMYM
         xpqhbPFOOSMPNQNK1qlTi0vtGyecFeOIn1JybxSYlb/LJnBtK81/ljPsMZGJkC8OW7FD
         GpSDMfJ0XDBxR4aFpS3GjrsMLPjdwERzfGzrlXVQTH5k2IFaIf5PjntxIOb/PEvI3dcF
         vWKOTze/KeQJCrCML3RUopNORkcTxCxoakBUDqiQgjMR9YkrZKhXSbWBLaeF5rkNnLuN
         S5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjidEIBLpo9lW9o0yeeT1lfV3OQXv1od5+4rOpyeyQ7TV679i1IrLAvNwFD3UwdrDkU8LvpMhZQgH1BPRgo/Rx3q9mULi0qiC7b9Mg
X-Gm-Message-State: AOJu0YwYuHLwnaBAqjgf0MCLmGCN0spQ+wRhYdrYb+UAf+L97zKoSLsW
	9XML/7qJOOUZu9nHPk1VcCb8xRjMshxTLjZlJSDLUXPUfcaWba3jmI2eU4qs5z0=
X-Google-Smtp-Source: AGHT+IGNj2qyqpmKhYF5SNexUkkbj2Eqj5W+/wzjibv+mQrOYEFftw0xcyN8tor6A7xrYppfL8hXHg==
X-Received: by 2002:a17:902:9a0b:b0:1e2:ac38:2674 with SMTP id v11-20020a1709029a0b00b001e2ac382674mr2553527plp.46.1713444516478;
        Thu, 18 Apr 2024 05:48:36 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id ju24-20020a170903429800b001e3d8c237a2sm1423509plb.260.2024.04.18.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:48:36 -0700 (PDT)
From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 2/2] HID: i2c-hid: elan: Add ili2900 timing
Date: Thu, 18 Apr 2024 20:48:15 +0800
Message-Id: <20240418124815.31897-3-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418124815.31897-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240418124815.31897-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ILI2900 requires reset to pull down time greater than 10ms,
so the configuration post_power_delay_ms is 10, and the chipset
initial time is required to be greater than 100ms,
so the post_gpio_reset_on_delay_ms is set to 100.

Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 5b91fb106cfc..3073620b2dec 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -137,10 +137,18 @@ static const struct elan_i2c_hid_chip_data ilitek_ili2901_chip_data = {
 	.main_supply_name = "vcc33",
 };
 
+static const struct elan_i2c_hid_chip_data ilitek_ili2900_chip_data = {
+	.post_power_delay_ms = 10,
+	.post_gpio_reset_on_delay_ms = 100,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = NULL,
+};
+
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
 	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ .compatible = "ilitek,ili2901", .data = &ilitek_ili2901_chip_data },
+	{ .compatible = "ilitek,ili2900", .data = &ilitek_ili2900_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.17.1


