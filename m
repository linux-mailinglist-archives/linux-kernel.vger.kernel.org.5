Return-Path: <linux-kernel+bounces-130418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE8D8977D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0DDB41BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42721552F0;
	Wed,  3 Apr 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J+Y7l8XR"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A911534EB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167527; cv=none; b=sAi0v46KDKKewY66agKZW+XUElBRnFD9F/GGeBc9moh7cXadv9VsMqJEmnPUoFU7edi7TgmV2GLKA1+ndII/Wri067BiOnS7p8hL4EDQy+4cOaYbD+YehJ46dsDP9O1aLzU3UN10ewozGiF2Sy5eQva2pgyS6+rc/pY1sNFDP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167527; c=relaxed/simple;
	bh=qqGF9xLxJC4LQcm92S4IX/hRHYqAmBrg8Pca6o1qles=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ty5gak8hJb/N6s91Ht2h5ruvE3TO1VfyZb4bFzUt5up2litPIUmVK1jOgKZq6RyeHJgEX0MdyNy+0gSuTJiwNaB+DLSDmxfFpKV5wSlSmXhmNQrIk6uHvFbvC/OFWPOUXM5vZsgD94gwCZg092FSQhraObNccl0pH3oVP6VD8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J+Y7l8XR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecd957f949so85541b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712167525; x=1712772325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJlHPBrdTvEXRp/sm58R6lF6ryZ2TinFdRAYOgnph1w=;
        b=J+Y7l8XR01iEcTEgPlbV4DyD4bhKAEyvrEqV42SBrtzGl6AtuidQdxPr6vPw278ycb
         xMiUFnyeDWb7hBfhiEaZHKGBJsie3n3e7gtcV6F19LDl6FGxL2a3HMA7bfAbuA1Yzou+
         AR/T1uOcMMdPPprYydhfC/Y0R7Lq0XtkRomYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167525; x=1712772325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJlHPBrdTvEXRp/sm58R6lF6ryZ2TinFdRAYOgnph1w=;
        b=mGizRmRSymjnZv5qzwRvjc98G59Zw/ovwOjM1ncALUjdhYehbmDZcK+4RLpTHhB74B
         j3uwyuWay4PlBXoUwNVXv/IsuZ1Xu4xd2eqT1ZyFDYDHXSyoSIMv3SIxYK3TOy3n56x+
         r7hjAfkQLvrgeD/c9xLT4pAhFwsc1bA7MbAp4qXhYzPUWGUJlC7k0WHYMyNT+XihXQuC
         fnmirsJqxuaVWYQ9pNbsew56H6SHoYH79SsverkGMSxcgZmXink2Us2GB9LpbxiaVzDd
         dUUk9dejcmw7/tay1/M20/tHX8k+EBUVH2CoOfRZAQpCSxYvURHrX8CHhd012yoH2m9m
         NfRQ==
X-Gm-Message-State: AOJu0YxfzWzxc1qsEC1znvhxNJoKWPXDXFjqqRaot9+WU3rQ5DCSoZEE
	Zp9iGbWAayIZpXvd015wcoAjP+hpKiTUZUDizfNL5nsYRg+4x1y+buYANEw9Hg==
X-Google-Smtp-Source: AGHT+IFofluak2TNyaj7l3kg/C527840RBEHus7enJda2FbDDZHU7/jIXCY5rcY2cES7AC48lbdI3A==
X-Received: by 2002:a05:6a00:3912:b0:6ea:74d4:a01c with SMTP id fh18-20020a056a00391200b006ea74d4a01cmr310246pfb.14.1712167524934;
        Wed, 03 Apr 2024 11:05:24 -0700 (PDT)
Received: from pholla1.c.googlers.com (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79850000000b006e64ddfa71asm12359162pfq.170.2024.04.03.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:05:24 -0700 (PDT)
From: Pavan Holla <pholla@chromium.org>
Date: Wed, 03 Apr 2024 18:05:21 +0000
Subject: [PATCH v3 1/2] platform/chrome: Update ChromeOS EC header for UCSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-public-ucsi-h-v3-1-f848e18c8ed2@chromium.org>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
In-Reply-To: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
 chrome-platform@lists.linux.dev, Pavan Holla <pholla@chromium.org>
X-Mailer: b4 0.12.4

Add EC host commands for reading and writing UCSI structures
in the EC. The corresponding kernel driver is cros-ec-ucsi.

Also update PD events supported by the EC.

Signed-off-by: Pavan Holla <pholla@chromium.org>
---
 include/linux/platform_data/cros_ec_commands.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ecc47d5fe239..c0f6d054a566 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4933,6 +4933,8 @@ struct ec_response_pd_status {
 #define PD_EVENT_POWER_CHANGE      BIT(1)
 #define PD_EVENT_IDENTITY_RECEIVED BIT(2)
 #define PD_EVENT_DATA_SWAP         BIT(3)
+#define PD_EVENT_TYPEC             BIT(4)
+#define PD_EVENT_PPM               BIT(5)
 struct ec_response_host_event_status {
 	uint32_t status;      /* PD MCU host event status */
 } __ec_align4;
@@ -5994,6 +5996,24 @@ struct ec_response_typec_vdm_response {
 
 #undef VDO_MAX_SIZE
 
+/*
+ * Read/write interface for UCSI OPM <-> PPM communication.
+ */
+#define EC_CMD_UCSI_PPM_SET 0x0140
+
+/* The data size is stored in the host command protocol header. */
+struct ec_params_ucsi_ppm_set {
+	uint16_t offset;
+	uint8_t data[];
+} __ec_align2;
+
+#define EC_CMD_UCSI_PPM_GET 0x0141
+
+struct ec_params_ucsi_ppm_get {
+	uint16_t offset;
+	uint8_t size;
+} __ec_align2;
+
 /*****************************************************************************/
 /* The command range 0x200-0x2FF is reserved for Rotor. */
 

-- 
2.44.0.478.gd926399ef9-goog


