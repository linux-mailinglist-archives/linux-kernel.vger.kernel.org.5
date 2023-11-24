Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22F67F7131
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjKXKRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbjKXKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:16:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7211738;
        Fri, 24 Nov 2023 02:16:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9e1021dbd28so230870166b.3;
        Fri, 24 Nov 2023 02:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700820991; x=1701425791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roBdCcPzLstLM8/JSIpHl0j2D5fXKoNfX0rW8q8tWfA=;
        b=ewBPZ+SbgeALGi8KZJKOcnVm7qA9nK396I8YH86I6IUBRQtWdteCaWQ9J1H6QQViR/
         YSfiXmKP3JL22CXE2eA2pkF2Ce6j4CHz1piydGL0IjYdRvvxgwERkgVgXYKGTtOVOQmx
         8HkBMjNPB5+F5VmmLssxfEnZO+K01/4bRfgtfhHdnwMpnj1YCCGqjz9Z5j7T4ZAv9280
         EXKiNClkUcH8vx84PtmWaoTd76/Sz89mg25Gg0iMzzem6sDPMwDPzHI9wkw1VpYVHbqP
         hmQHs8bTggQIfzh2291hzqdBcH7AWLedn25lHT26ZPmFeOZjsgASuQcxtGc0JqcpnNmY
         9d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820991; x=1701425791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roBdCcPzLstLM8/JSIpHl0j2D5fXKoNfX0rW8q8tWfA=;
        b=jL1tray28HJGLgf4gxp9NLnMGzvrHP4xj97exLABDPxr0vhY/Idk9xBWE1lr7yKnWT
         X+1lJaFFUIuMdYY9/J7huhXVsjbQ+IRyX33rkndFIpz2QyfmGkpbe3XtnZoYFbKYte0B
         Zhk+BsqrRh0ClhkTDCuV87z1xepG79CjMf8KI8PMQb0fm+rWa4zsWIYMlVB0HX+Rh2Jh
         rEGhYUd+ugM4NBwmISgqYqgi3CHnWffM8F1vEhiSB/nJuQmb+hqeqHaKawPCAZT2QA8i
         D6MtaGlJ/0U+NKNLRLFMESujrciVs81+l+GLHw0aZb0RO68fa0OH4DonK9CrZM556Uk3
         45Xg==
X-Gm-Message-State: AOJu0YzQOaqJ1Qv/Imoq8wPhw8sictRGQ73Fl2ARxAeuue7Ol4pm630R
        svThiZCiaTL2TQGaFKi1bEcf50M8zMfDzw==
X-Google-Smtp-Source: AGHT+IGQvQB8JVIO8p2f/RQEQ1IEuGFwq7QTzYVaZTGIFi+zECRu/DnCeCLti0SHBU4MgRhu0UousQ==
X-Received: by 2002:a17:906:7f96:b0:9c2:a072:78c4 with SMTP id f22-20020a1709067f9600b009c2a07278c4mr1681371ejr.25.1700820991231;
        Fri, 24 Nov 2023 02:16:31 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-72cf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:72cf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b009fbf15cee7fsm1887801ejb.69.2023.11.24.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:16:30 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] i2c: mlxcpld: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Fri, 24 Nov 2023 11:16:16 +0100
Message-ID: <20231124101619.6470-8-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124101619.6470-1-hkallweit1@gmail.com>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of the legacy eeprom driver the only remaining I2C
client device driver supporting I2C_CLASS_SPD is jc42. Because this
driver also supports I2C_CLASS_HWMON, adapters don't have to
declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
It's one step towards getting rid of I2C_CLASS_SPD mid-term.

Series was created supported by Coccinelle and its splitpatch.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/i2c/busses/i2c-mlxcpld.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 6fec64ea6..099291a04 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -477,7 +477,7 @@ static const struct i2c_adapter_quirks mlxcpld_i2c_quirks_ext2 = {
 static struct i2c_adapter mlxcpld_i2c_adapter = {
 	.owner          = THIS_MODULE,
 	.name           = "i2c-mlxcpld",
-	.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.class          = I2C_CLASS_HWMON,
 	.algo           = &mlxcpld_i2c_algo,
 	.quirks		= &mlxcpld_i2c_quirks,
 	.retries	= MLXCPLD_I2C_RETR_NUM,

