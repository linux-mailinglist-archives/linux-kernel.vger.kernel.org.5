Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5824811F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379007AbjLMTv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34BE9C;
        Wed, 13 Dec 2023 11:51:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-336460c22feso59942f8f.3;
        Wed, 13 Dec 2023 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497087; x=1703101887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ00PVQEEsbBDsAiHtNgQwoZD5SKSh4mT5UUe1TRdHc=;
        b=i9MenSoq+S27p6EzkdVt6PoHi4c17XnWcXOTriSJz+4SquG6SUgS/WD1bHhf5GVrzc
         CZmGwvp41tja5QZI7zwkC1iJ/7YwDxvdNHjORKS5Q8ni6kFfllarwjpq/JRuLquQjNPV
         cbLybRJ0n784+FPefsXgIsJEaNA6Po/M2XApxbIhLYIXH/cEJladXgr3+PBy+9rymHjn
         ctuXh6M2mZeMjtnMPEn5BN7UOdHZw4jiXb3IKv1H+Nj/5uKVTgaILaLJOg4+QAAwVPMV
         V1RjDjcU8gXaea/T4xJ9ob1KSV8JjOuro0iUtwVJcxuHAkPFm9WGkcZH29RiTS5p+NJi
         Cr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497087; x=1703101887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ00PVQEEsbBDsAiHtNgQwoZD5SKSh4mT5UUe1TRdHc=;
        b=Csg5Z4omRBOTqGEckbhk+VSoRA+x1Q1xOj0SvpriYqX/Gs9bSbC8BHP8agEweQyiY2
         auX5OkERs49air3hTkPeTcAxEgcT00q/jsjpjlmBF+n8Xdseu0jwbCFflkf7JCwy3txt
         x3FqIo6JQ3/Y58QBZWNCFIOSeWC3RnsnhhlVk7y9sk2Cm1myq09n0H6mnoYrF58GhHIQ
         LJ4OS3RkZdfZTEuBrA9lbijVePkVHciHbCgSw38YkByHKiQeUkdLYRDYo9RJpxEgLSa5
         K/BmScMroD5bl6BjWSnRDbM/4aElhioeJbriocKN9uqYSRhZu8DBkS1UUobKkMIg443c
         kRzQ==
X-Gm-Message-State: AOJu0Yw8nPJBlDjVbtTrLJKlaDgAQ/I+RcyqDVl21O45MHdvx72alTBG
        qkuEuzj2eKx3q4FX9GnzpQ==
X-Google-Smtp-Source: AGHT+IFBc7XAiSp1dfcz3uO18CnzTmXQGI1tcrG6ntKLXnS0y/BNGLSoesw7UH4cnM9+Bs3NVJG5Mg==
X-Received: by 2002:a05:600c:4f05:b0:40b:5e59:ccdb with SMTP id l5-20020a05600c4f0500b0040b5e59ccdbmr4822082wmq.188.1702497086918;
        Wed, 13 Dec 2023 11:51:26 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:26 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 00/11] Add HDMI support for RK3128
Date:   Wed, 13 Dec 2023 20:51:14 +0100
Message-ID: <20231213195125.212923-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to add support for the display controller (VOP) and the
HDMI controller block of RK3128 (which is very similar to the one found in
RK3036).

The VOP part is very simple -  everything we need for HDMI support is
already there. I only needed to split the output selection registers from
RK3036.
The VOP has an IOMMU attached, but it has a serious silicon bug:
Registers can only be written, but not be read. As it's not possible to use
it with the IOMMU driver in it's current state I'm not adding it here and
we have to live with CMA for now - which works fine also. Andy, maybe you
can shed a light on whether there is any way to not have to write the
registers only and hope for the best (a.k.a rockchip,skip-mmu-read). I have
it working here locally - but nothing for upstream (yet).

The inno-hdmi driver currently gets a lot of attention [0-2] and I'm
hooking in now also. I did only the bare minimum to get a correctly colored
picture and a stable signal for RK3128. I leave the cleanups to those other
series and will come back with sound/CEC support later. It shouldn't
interfere to much, only the csc-part must not get dropped completely and
the mode-check-hooks are no longer dead.

Note: Patches are based and tested on next-20231213.

[0] https://lore.kernel.org/all/20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org
[1] https://lore.kernel.org/all/20231204123315.28456-1-keith.zhao@starfivetech.com
[2] https://lore.kernel.org/all/2601b669-c570-f39d-8cf9-bff56c939912@gmail.com

Alex Bee (11):
  dt-bindings: display: rockchip,inno-hdmi: Document RK3128 compatible
  drm/rockchip: vop: Add output selection registers for RK312x
  drm/rockchip: inno_hdmi: Fix video timing
  drm/rockchip: inno_hdmi: Correctly setup HDMI quantization range
  drm/rockchip: inno_hdmi: Add variant support
  drm/rockchip: inno_hdmi: Add RK3128 support
  drm/rockchip: inno_hdmi: Add basic mode validation
  drm/rockchip: inno_hdmi: Drop custom fill_modes hook
  ARM: dts: rockchip: Add display subsystem for RK3128
  ARM: dts rockchip: Add HDMI node for RK3128
  ARM: dts: rockchip: Enable HDMI output for XPI-3128

 .../display/rockchip/rockchip,inno-hdmi.yaml  |  30 ++-
 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts |  29 +++
 arch/arm/boot/dts/rockchip/rk3128.dtsi        |  60 ++++++
 drivers/gpu/drm/rockchip/inno_hdmi.c          | 203 +++++++++++++++---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |  13 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.h   |   3 +
 6 files changed, 309 insertions(+), 29 deletions(-)


base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
-- 
2.43.0

