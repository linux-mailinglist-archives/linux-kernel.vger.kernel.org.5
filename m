Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEA7E9B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjKMLZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjKMLYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:24:31 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798101700;
        Mon, 13 Nov 2023 03:24:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-407da05f05aso31960515e9.3;
        Mon, 13 Nov 2023 03:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699874654; x=1700479454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwYQsxTIlPnpbp305mlbq5GplvUv/n/Jh48i1GH8+AY=;
        b=LAtEzR3a+X8SkFHS28mkox51HJDUtCTWP0/LaxVWvf0FXv7+0ntsGlXHvwoo9TemS9
         gRH0D8zIyvVHpxF87A3asJOKak/zntc0csV4BArE2rZRQX3nQ7VPanm8sflIa0pbl7Bl
         vsjIPPiQf6rUsk30g7eh1Vp59dBfpTR02C/jswZi3sg8lEZFRDOTqmvqMxPTkWrgmD8O
         e+dLfgbqrrn/jg4ZFzl7YBappx+BKgfxvmFnzNbcpDTj/xGbt2vEbaR7UGhUgGNEKCEb
         UuE6XgD9dfo34tOsHAo/25BRZnAWxZTqJhN3MCwBjL0oLIHAP10dIRiOY3nqcdgtmYPT
         y67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874654; x=1700479454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwYQsxTIlPnpbp305mlbq5GplvUv/n/Jh48i1GH8+AY=;
        b=L7Q0nkxd5gCR68pdzZaHe6nAlN/RpeAFeBjyz5rsYFi0VmQmI+vS26Wl3hyDfJmNoG
         jLlGK+Zb5Zj1xe9/2ReTJNFaqrowKhetixBHS5X56uJOWmdmFv1KS6s+KvgF+tFUZopB
         14U/ZNffhIvIyJxp3tkttg+icgD/wh8zqS2dJzserzz14Fo9baSdkWwFaahsLakjWx1S
         ZoAqDpzLQ5Ntm0F4QJXv0f69vQY3Yd2MPKZNV3ciu1zNPRamSDCt9MjMR5U+Nk7VM4Yf
         8/bjYRT/avRvTSl1z5WV3d+i0Ri0K/cpqJGN5oE3sb/E63vBxI4dn/1WP/sD0uqWvjrE
         lDvA==
X-Gm-Message-State: AOJu0YxUa2cZNIZ+j30OmMwnHtVWZDHTmOGGggif2gU29FooIycChTsS
        xOjHiSBr+pYeIUa9sSWhLbk=
X-Google-Smtp-Source: AGHT+IFbNwXT87/A3jEt8J3J2IIJaKfXP5VLFa7X0d4Q5ivIh7Rq49/jVdFtcRm7vBeOvUh6yIYXWQ==
X-Received: by 2002:a05:600c:4f54:b0:401:daf2:2735 with SMTP id m20-20020a05600c4f5400b00401daf22735mr5024747wmq.31.1699874653800;
        Mon, 13 Nov 2023 03:24:13 -0800 (PST)
Received: from zotac.lan. (dynamic-2a01-0c22-6e16-fe00-2223-08ff-fe18-0310.c22.pool.telefonica.de. [2a01:c22:6e16:fe00:2223:8ff:fe18:310])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0040772138bb7sm13565787wmq.2.2023.11.13.03.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 03:24:13 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] drivers/gpu/drm/msm/hdmi/hdmi_i2c.c: remove I2C_CLASS_DDC support
Date:   Mon, 13 Nov 2023 12:23:38 +0100
Message-ID: <20231113112344.719-15-hkallweit1@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231113112344.719-1-hkallweit1@gmail.com>
References: <20231113112344.719-1-hkallweit1@gmail.com>
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

After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
Class-based device auto-detection is a legacy mechanism and shouldn't
be used in new code. So we can remove this class completely now.

Preferably this series should be applied via the i2c tree.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

---
 drivers/gpu/drm/msm/hdmi/hdmi_i2c.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
index de182c004..7aa500d24 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
@@ -249,7 +249,6 @@ struct i2c_adapter *msm_hdmi_i2c_init(struct hdmi *hdmi)
 
 
 	i2c->owner = THIS_MODULE;
-	i2c->class = I2C_CLASS_DDC;
 	snprintf(i2c->name, sizeof(i2c->name), "msm hdmi i2c");
 	i2c->dev.parent = &hdmi->pdev->dev;
 	i2c->algo = &msm_hdmi_i2c_algorithm;

