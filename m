Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828C79C332
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbjILCms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjILCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:42:05 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F01E5B15;
        Mon, 11 Sep 2023 16:11:17 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-34e202a9cc9so16177705ab.2;
        Mon, 11 Sep 2023 16:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694473747; x=1695078547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcAgeVHnxNNRvfl+2uM1osGvKKovW40vicb6K15Ndz8=;
        b=b7rVmnS9T2aQg3o2AMKyW8JM0sAfC7g3uZR+9zk+WYr+FmzAR1qZHWThmg1cJGEN7I
         MoRELaXROKoZKKXMIei0VQ1XVB1i51m3iLSQp7hs4vfYZ0JD2z8yT5OEhooFVLKzLNdp
         9J2wQUfGv3mZKgCf1ST3EC93stRjqwBN9kBQ6c4aVxs5f8gndoLNxzLM5+5wrP+Baj/f
         OXEawUVMX8Nfzo/83S/AaRGB9aTnweFyK1Cst6MkrPcNlTVv2m+KPWPumIheQv1b7R0X
         J/t3r4CWBQTtPWqGOztAghW011W6vhTAcMgyaWaNHB+wdBAalaJgQ1XrBxmV89L1IIn1
         K0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473747; x=1695078547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcAgeVHnxNNRvfl+2uM1osGvKKovW40vicb6K15Ndz8=;
        b=Os1ooQGMtjx0G8t19xaarmAbi1Npkk7HtGf9w9wNvA6w6snMgJJZCaK2X1eY0Y5jnJ
         c8ezqJlQQXJLrxjK1iCtNs3hqzRCrwMg9ckjq7iahi6wJ3uOSDyodP/dnK12qulAIGY+
         Go+oK95FRrQ26lYC7ARpFuzuxgnm1dHJ2wgF+Ad7+fqlXl2AaCNtOhnI1y49aO9i54Eq
         J96GFLLvLtHQ9xQI9iCpv7pUZDoYP4smWl6ckJwQltzKm0/5ojoi2fQbLa3g9alcg7lf
         am+zdkNneuurL3zSn7zbrOqtSgyGQU4Z/3WgQVydbqYKLuQOLu6vVAMIg8gY7+p2jOxP
         rBRw==
X-Gm-Message-State: AOJu0YxbZlsvX9xK0AZDVxrQg7Q0ftHK5NTrGNVbZpQLlDpyNXyXKJgo
        agF/go/aZ5MOHwYFh7s4bPU=
X-Google-Smtp-Source: AGHT+IGm8XJJjgEBdcXS6iFzgL2wU9gzTG524paxkBRkx7pWMbgnsFowJbau/w+sUivI5RVDg02BfA==
X-Received: by 2002:a05:6e02:1a85:b0:34f:49cb:40a9 with SMTP id k5-20020a056e021a8500b0034f49cb40a9mr12781961ilv.4.1694473747663;
        Mon, 11 Sep 2023 16:09:07 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:09:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 20/22] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date:   Mon, 11 Sep 2023 17:08:36 -0600
Message-ID: <20230911230838.14461-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
index afb3b2f5f425..27bbb03e84dd 100644
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

