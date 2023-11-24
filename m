Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95D7F7134
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbjKXKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbjKXKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:16:33 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B10C198B;
        Fri, 24 Nov 2023 02:16:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a02d12a2444so251192466b.3;
        Fri, 24 Nov 2023 02:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700820993; x=1701425793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBFVvNKhAX+OR3ALwztSAgxwFpQwZtLHeEc/T4Eghog=;
        b=VPE49zcijTl3r1uq8JC2J7ZTPBU+nTGgImSZ216lLyfwXt+SMt0GGo3SqL1n4tLg+U
         y1YuffBXxih4pkXqjpu3KktdTjiGFdv3egfmYMsTX04QJrTJSPg4RNlAL5PNLEHnyAwY
         pff1tI3vEDmt4uq1DicmZlZdz7ASngEknQQ1ulmbhgce+CabbEYEjf1fnBSM3FUZv3Fk
         +OM1nzFJoRXs3Y1Nmd9LjauV1B9uUMQmuIDidu/cLv7PDEFNcSfule0YDw9mI+V8swNX
         cs+17KtPw3XeInnhxuaAqatRrIxoR+r5uHLMy2xtbR4C6SBpqZPP1tFpbjseEf2TTg18
         9N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820993; x=1701425793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBFVvNKhAX+OR3ALwztSAgxwFpQwZtLHeEc/T4Eghog=;
        b=TSNenK1xHwwl9kU5ZHW/W7PgrvFovsAhGjZRLC4V1H1I1y4VEE5UTGYwNw1Lb2n3xa
         2q8BFxa0BKUAG8uf0Lv0V3VFkdvberymcHIM3N9ExEtoI8ZIe8vK4orwzsodD1gR+HG8
         3YxcWvvDnhooygVVZpp9gmj9C5m7a7MIKDoUkjXyBGppVRpehDM/92weOp7kEKXArySy
         +s79IXEkv2Hsvtqs32itkwdxsK3qfYAdBOU6qKQcigrsFWyCnGGK1RDgwmwbviEyK2rQ
         q7NHsIofaqRG7RbieAM0rsy/EQlX9PNy88Ktq5J5o0P1Q2zqqE3/wDXBGPcpzESWiAii
         et5g==
X-Gm-Message-State: AOJu0YymuLzpXlLFtPodpfHNVNcYUFrliXLM9S0322JTkuQXLI5IAFBH
        0vcgCHn8U/e95+9B1MmSS9U=
X-Google-Smtp-Source: AGHT+IGN7nZjWxlJe5L69GaAaOT9ZlgxzJNpnwIeau0kbIYcFkVvFfiCCMZIPevdOms/UBtxi3Dx1g==
X-Received: by 2002:a17:906:7c41:b0:9e6:cd68:5e57 with SMTP id g1-20020a1709067c4100b009e6cd685e57mr1674371ejp.2.1700820993427;
        Fri, 24 Nov 2023 02:16:33 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-72cf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:72cf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b009fbf15cee7fsm1887801ejb.69.2023.11.24.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:16:32 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Rudolf Marek <r.marek@assembler.cz>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] i2c: ali1563: Don't let i2c adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Date:   Fri, 24 Nov 2023 11:16:18 +0100
Message-ID: <20231124101619.6470-10-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124101619.6470-1-hkallweit1@gmail.com>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
 drivers/i2c/busses/i2c-ali1563.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
index 55a9e93fb..307fb0666 100644
--- a/drivers/i2c/busses/i2c-ali1563.c
+++ b/drivers/i2c/busses/i2c-ali1563.c
@@ -390,7 +390,7 @@ static const struct i2c_algorithm ali1563_algorithm = {
 
 static struct i2c_adapter ali1563_adapter = {
 	.owner	= THIS_MODULE,
-	.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD,
+	.class	= I2C_CLASS_HWMON,
 	.algo	= &ali1563_algorithm,
 };
 

