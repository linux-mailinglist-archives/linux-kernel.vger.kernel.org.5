Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AE47F016F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 18:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjKRRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 12:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjKRRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 12:42:34 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5512B;
        Sat, 18 Nov 2023 09:42:31 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c72e275d96so37926851fa.2;
        Sat, 18 Nov 2023 09:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700329349; x=1700934149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyZ/cbQESDC/MGT/kN0ThvfGObcymEWZy6uoIIRVQcA=;
        b=S+mei+EGZ2wnXIJQnMifLNK80ndLxmNj3TREd+7hAWgMgmwy/l+KMhFNOwx5DqNzMV
         7IvykPon+yNC1jLu8l2nRlmwQXsw/9pMdaUbA/TMbKG8ZULhjvnxSjcYXTSwi7hPvY4W
         fGe/w1jyE90O5VAC1053C1LpfEo5KNFYIIVtswjOwYyKoUI7eqaib0sH1azGZ4vgigqs
         0BW7UQKKMmXev4RgLgQRsSjKLlwHKu5kQIjOISW0Le+Sx7SixkI6L9dIOCpmRVHWtF2m
         EgLL4xTEXhYC8AHeDOHFZdE3/kk3tLXnA6YFbQgMq4+4VUQY8Ni15M1XxCaKw6KsvYkZ
         5w4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700329349; x=1700934149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyZ/cbQESDC/MGT/kN0ThvfGObcymEWZy6uoIIRVQcA=;
        b=RijU5H8OGhd+lQz0yQmAsGgBPzVpTG/okvCHI3uWJZ7DYZYN8upPePlJeWmnJdzHQv
         HXHy/vcqWmn+SzailRlilV2H+ltyRkTAodCzWsV0L157lfJbHnhzR2jjQGm4WMl4tDmL
         IlKjP66uetRwcD03JXrBNnIq7561bw6ORfPYLnpHtVRM7rPLWDmT8yvIh9r6jZc8RYdt
         2iifEDT1k5BE14pL1w8uqbVO3eN6B4JEzWPPSgadKXBtqY3OW14ceDQzU6WJbJNPWUDG
         AdGqN/6AcIp9dt3wrIuOlzq/P5TcjT9qLx65cNytVZGXJagEHFTVkf9gBqbcSJyce1IR
         mBXw==
X-Gm-Message-State: AOJu0YxskdJE7+4cZBGyOf5kDaRv7j9k1Q/MQL1Y8v7X2YZ8eBA1TJjW
        28XJ4yPx+WVdR/wLBPcPwlQ=
X-Google-Smtp-Source: AGHT+IHnFgNWvQQzwc0XOhpUWTcrcN2j6CYFonTN+gof5Zy5XsRr775SK97ByQAzYdXjmLv3xio01A==
X-Received: by 2002:a2e:82cc:0:b0:2c8:3254:bde5 with SMTP id n12-20020a2e82cc000000b002c83254bde5mr1493466ljh.50.1700329348922;
        Sat, 18 Nov 2023 09:42:28 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-77bf-8300-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:77bf:8300:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c340a00b004068de50c64sm6964211wmp.46.2023.11.18.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 09:42:28 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/20] drm/amd/display: remove I2C_CLASS_DDC support
Date:   Sat, 18 Nov 2023 18:42:03 +0100
Message-ID: <20231118174221.851-4-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118174221.851-1-hkallweit1@gmail.com>
References: <20231118174221.851-1-hkallweit1@gmail.com>
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

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
v2:
- adjust tag in commit subject
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f99f6754..ae1edc6ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7529,7 +7529,6 @@ create_i2c(struct ddc_service *ddc_service,
 	if (!i2c)
 		return NULL;
 	i2c->base.owner = THIS_MODULE;
-	i2c->base.class = I2C_CLASS_DDC;
 	i2c->base.dev.parent = &adev->pdev->dev;
 	i2c->base.algo = &amdgpu_dm_i2c_algo;
 	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d", link_index);

