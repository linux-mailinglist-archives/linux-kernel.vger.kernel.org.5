Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6ED76BAB9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjHARF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjHAREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:04:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D3A2D52
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:04:02 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34911a634edso13153845ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909422; x=1691514222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs8KKrYjZk0r9Wo5TdxMtD6IOfpOECGrCMFsRZEQgtA=;
        b=SFMJTLtjbBRqmzzpSgH+2eB23Tq0h1jxCPHsTNTwjOWfo4n2ijpFGiwN97CB2QxtG3
         qi0iftE0DlDd5GLzpRygtOsaJJQMbCvNuFzSYG0sr/HsJpSWOusKmCuiojZMvjSW5HVO
         RKfwV4xqDO1hZ7e3jHnnJMMxho+9IYVdmjmwSzeN3sqKWVyTetDuS7KNCShgXiRrbU9e
         haNAjxvCvYcYNQs0onXzAQPsFWtG7epspz0wlK5JSyh+dJR11eYicU+JJuQv8dnnirD7
         o6pkPL/PVAZD6oYZQHC2UbZblsu5XieIjB0KV7MLR4xONrP2ekGXh/rdUKtU4nAGqkf9
         n5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909422; x=1691514222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs8KKrYjZk0r9Wo5TdxMtD6IOfpOECGrCMFsRZEQgtA=;
        b=ZMTKHa1WOqbzx2erNMv0PVp+qVuEAW5nP2MAzvmEz1rnAm8+4ftJ28qvl25E7sPTHt
         aTaUbjmmtCIRM6nuXLYry/Mn6KjEKj+YEoUNMGEtjCSJeRRRKS5gb/aHO9ZXJ7MnKx48
         CDkbmUZm7YALeE4Kco058SHtOGQ2ImXuCpBb18MKkRV/49t5C3UA+mf6pL6JCqNmvhvK
         cEOs3/E5WW5scYfKF2H1itlJtyMAfKAd53UmOVzgem7+NkOCbNlovs4hFDJG4UQfEanZ
         4TzjMqGRVorbVgSKa7lrPglIgY7xA1em4Z/kui/yNaljKPxWsjUc//GQegskPW5B/eik
         u8eg==
X-Gm-Message-State: ABy/qLZ3iaAyZCSp7GErsdH4vqjTx/OIJeg5QYTr1q/xl2myHjgd21vk
        d1moZ0tdwdGIXGm0tqfUxuw=
X-Google-Smtp-Source: APBJJlHM6coGF5VoxK2i9FXxeme9tj+l6a1obs3/JcaH5eEwk48eeo+PrnIktcypzFiPVL26NLtzHg==
X-Received: by 2002:a05:6e02:ca4:b0:348:f53e:49f6 with SMTP id 4-20020a056e020ca400b00348f53e49f6mr11938255ilg.1.1690909421849;
        Tue, 01 Aug 2023 10:03:41 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 19/22] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date:   Tue,  1 Aug 2023 11:02:52 -0600
Message-ID: <20230801170255.163237-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of burn-in testing needed before signing, upstreaming.

NOTE: I set default Y to maximize testing by default.
Is there a better way to do this ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ba3fb04bb691..ff478fcba67e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -52,8 +52,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.41.0

