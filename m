Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04109777540
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjHJKBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjHJKAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:00:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD135B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5233deb7cb9so823722a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661586; x=1692266386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DbDWowkXJ8CHoc7ekr/xcmqd0aQK/hBwEyNws4eo4A=;
        b=fEpu3P8zAA6g7fvRKT2cpmWB+RQRVV+s3zv8bjnpqc5yMAo2GYdQt69/ZdgjF+1uiM
         h8moA7LpmwcRIBx8RtuLFpfmTKUB/67tqoWQhqikKz+/VhoRLRpOzPWunEe2Heh86X60
         XcNuUTZbzN4jYV0ZDzwhJnOSn5kqWgRzPea6hv/xOdKUAis45iHhxStH/TV74qSVnjCp
         W37VVZMgP6ljLw7eqElsaNvQw9SjkCBaqfcBqDQzhxypH73my2bDGcqDL/ftJ9nUk58A
         Iop686p7ftJbt+00lN9WdQbkU1MMZ9wa4Qdtj7NgFco5DWgP3GHYE6FANlCmfTwuZEzH
         L9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661586; x=1692266386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DbDWowkXJ8CHoc7ekr/xcmqd0aQK/hBwEyNws4eo4A=;
        b=X1iseS/TCaDNhbyGRYWVmmgcrvNTDUSQcOd3Rjm1OaATNrxwlCk7bSpGe+6SfPpHQw
         /q++nY2FLQ0+21m7lLAhTfSNrq6z3PZ3ZcurIlEUcf+ewfgGKm6Oipeep5sNQIqA3H/J
         Dy2VIdT6szT53C+FtKwxOLXoXFxPnZc4oSMs5oIRiUlkUk27KiS5HFw1PIwCwDIZZg7k
         eqedMBNs/Yd9I83FMbZQLzzbArN0yyhOeG9Jzak8RlTfU7cx6WvIxOVFYfd2AxaDiYkV
         3wydHG3gfdkfpixI4E2x1d5PwwkhUhXBXE3fG31nH+aoc38ptLfItPWUc9kXRvazg3fD
         m3MA==
X-Gm-Message-State: AOJu0YzUjyiaV8t9+AdiSd/kKzzzYqdTL7gQwx8XXj9YYWcFlOJkZHyF
        z128r6xOk/4TQca8v22cXZ5h2CiW7taiL059jXD1Gw==
X-Google-Smtp-Source: AGHT+IFadznnKin1G3h7chRKcx6AsNDRLqsGXsvhVAb+I5BficeEjg/qSB9kBj0IybuULnXYxHHDmw==
X-Received: by 2002:a7b:cc85:0:b0:3fe:173e:4a53 with SMTP id p5-20020a7bcc85000000b003fe173e4a53mr1551533wma.0.1691661566553;
        Thu, 10 Aug 2023 02:59:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id v1-20020adff681000000b00313e2abfb8dsm1610969wrp.92.2023.08.10.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:59:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Qiang Yu <yuq825@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lima@lists.freedesktop.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] drm/bridge: adv7511: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:59:22 +0200
Message-Id: <20230810095923.123388-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  adv7511_drv.c:1214:19: error: cast to smaller integer type 'enum adv7511_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 2611afd2c1c1..0e284f379602 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1211,7 +1211,7 @@ static int adv7511_probe(struct i2c_client *i2c)
 	adv7511->status = connector_status_disconnected;
 
 	if (dev->of_node)
-		adv7511->type = (enum adv7511_type)of_device_get_match_data(dev);
+		adv7511->type = (uintptr_t)of_device_get_match_data(dev);
 	else
 		adv7511->type = id->driver_data;
 
-- 
2.34.1

