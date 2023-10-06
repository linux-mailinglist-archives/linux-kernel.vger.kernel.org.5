Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DAE7BBDD1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjJFRcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJFRcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:32:11 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FFD8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:32:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690d2441b95so1884107b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696613529; x=1697218329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uht+32O1H7tS91EbXmyBFBF49QB3RXcTs2kBCgDMo1c=;
        b=XlVwCyAWmU8ndqXRIJA7TfC4EvPbZrwe8odwn4qzeERELDMpVsYEcVieocMAg9LPyo
         VuvH4TLUEggostVeCCCQYZmfznbAihPRVPwL5Sr4p5zuKCpSJesB+KPdiWMVZVsdPXok
         71+wVP68t9gKXgKqMn6ZAmWu+bUQ+wyZ7NmVGY/MP4I+/mtbYM8R6myIEmKhfkLSl0ei
         VWTdgcZQCSsyW+hr0wpEjfaqA0u/YqkjwQAT6KZCUyYBRyxjZ/l0os+N7XIgCiOSmlfy
         bHb/gfPVJvBIxcDdUmbU3a++O/tOtRqzEIvo67nqSyVhkcN1X9UnQRaLVpMDlJ/+IK43
         Fe/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696613529; x=1697218329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uht+32O1H7tS91EbXmyBFBF49QB3RXcTs2kBCgDMo1c=;
        b=rlz+2SwlFi/cJjx1UY2pfaYyG7q7iiTpyf1XbE6/4kAS+SmtGCxjQ8J13rGfyQU/6J
         p8mTNeTkBTKayXuAyLSREPOVk1EkqWrUKZ3WDIqkgNFbXxldxiQ/sMIE7991dBauB5ER
         DyZrGNJITA5M+kuRBOO0N7DuXhw9fiWewf8XPiMjDiY4BhS1V1czfhmn5eaeHg5DfKMK
         xJpTMSKsNrEar0+MZWKoGeLNhjwKZibW+9lHYDLVnoKnmMzU9/7Lf1wgpKaf7YoJEy09
         oBFPAtpaj3zEUEJ3EsfPLYLsDICxCZJO1qRuAiL6To6IM0hrLssA6zaIsEw8Z64lO04N
         0ZiA==
X-Gm-Message-State: AOJu0YxDeh2+KqgQSHsM7HnwlcyJ27QOqRCik3ayh8vU0qpUDGfSKKF4
        /Gy57QJyrFZcwDZyAjjXBeI=
X-Google-Smtp-Source: AGHT+IF03+UeFYlMbGjpNfhcVQTy2jzlGLfhtzouZi5hnhM3IqftqKCIAYKKX1oupjvWcd0yojLG1Q==
X-Received: by 2002:a05:6a00:b82:b0:68b:a137:373d with SMTP id g2-20020a056a000b8200b0068ba137373dmr9853667pfj.17.1696613529169;
        Fri, 06 Oct 2023 10:32:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id k2-20020a632402000000b005898e4acf2dsm1577574pgk.49.2023.10.06.10.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 10:32:08 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Emma Anholt <emma@anholt.net>,
        Helen Koike <helen.koike@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/ci: Default to UART for logging
Date:   Fri,  6 Oct 2023 10:32:04 -0700
Message-ID: <20231006173205.371205-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

ssh logging is the default for mesa, as it is generally more reliable.
But if there are kernel issues, especially at boot, UART logging is
infinitely more useful.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 2c4df53f5dfe..7c55f02f7313 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -27,6 +27,12 @@ variables:
 
   LAVA_JOB_PRIORITY: 30
 
+  # Default to UART logging.  Mesa uses ssh by default, as that is more
+  # reliable if you have a stable kernel.  But kernel CI is more likely
+  # to encounter unstable kernels (and has lower volume of CI jobs so is
+  # less likely to be troubled by occasional UART flakes)
+  LAVA_FORCE_UART: 1
+
 default:
   before_script:
     - export SCRIPTS_DIR=$(mktemp -d)
-- 
2.41.0

