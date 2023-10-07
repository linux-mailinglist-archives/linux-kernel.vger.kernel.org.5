Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A17BCA60
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 00:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbjJGWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbjJGWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 18:22:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEADC5
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 15:22:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso571799366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696717368; x=1697322168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO9pyv976h/9S8gorIMhEgb5zOHhcco+YLW7BrIty0s=;
        b=MXDLfYzPfKTShjB7oNk3W4gMl872e6xz3zo0EioiJB1jI0+kfdzAU4kFLmETjIO5R6
         BC1ZNiOaxhe92hiV7laqu5VWhAkE6U6PeRVu5Eu71vUD8Vw4yWUPH3jrFRDE8OyNSanT
         8sFmAkmAnrqzeGEkcN3eqqa73U/UQHuKMDTTz0QoCL6WL3IifpOgSop7Uhf1yl8TnCWB
         tPZJ1CWf23iHr9uLJx6ZD7gYqk8w7DvIbKMH/srsz1XZpsSH18/byXKLLP6CKa3131lO
         it2/4gqbdU9u78vDk0tTLPDOOGx+dfIyOc3g75pdND+y1s8TwawA5rz98CctV0rwVaqT
         iPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696717368; x=1697322168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO9pyv976h/9S8gorIMhEgb5zOHhcco+YLW7BrIty0s=;
        b=KKWB48OXfoyfrVexYsIeISWowhnDDSVD9ZGGOYdOYOUXpjzLdgQgJ51sZzIHcYAsby
         pH3rusVRLf1CQAwsOT6/9VVYan1s1sUXz7J7B3IesJ2K7ko7INIa6N+x+Md1WsGnOqML
         fzfIrpAxsp82bs7L5GpP7Z+3CJAsfUnVsJ//2VYRUPHL3NPcmx6dL60K+JrNGlxOcCM4
         KPjFF1iD0MjqOrlveXhkmQUcYFuLfw5n9VRoScM6HN491kUqB/VGUdsYmSl/ahh3a/xA
         Z/nOItVILK8BNnAYACtk4sRn/HP4+jV0Mw8CVGZu20UT1gRVccsuW3uHs/FdbKBoooSD
         n1yQ==
X-Gm-Message-State: AOJu0YyPyLkFw/9e6FptEGBcU0S5Qavgtd9n0J7Ced5vEv9ArSvzHyHY
        FvWMurs1HXp50xrOZ3gOiPM=
X-Google-Smtp-Source: AGHT+IGdq5dIDjHMSpBY9R+UTam87sGHsEfph2UKnCXlBgN8QygP/VfkEkyJer83iK+mdYOBQ9QSgQ==
X-Received: by 2002:a05:6402:1b06:b0:530:8488:b9bb with SMTP id by6-20020a0564021b0600b005308488b9bbmr9606367edb.15.1696717368578;
        Sat, 07 Oct 2023 15:22:48 -0700 (PDT)
Received: from Slimbook.. (181-251-201-31.ftth.glasoperator.nl. [31.201.251.181])
        by smtp.gmail.com with ESMTPSA id p7-20020a056402074700b0052f3471ccf6sm4315631edy.6.2023.10.07.15.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 15:22:48 -0700 (PDT)
From:   Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     boukehaarsma23@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date:   Sun,  8 Oct 2023 00:22:05 +0200
Message-ID: <20231007222205.316032-3-boukehaarsma23@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231007222205.316032-2-boukehaarsma23@gmail.com>
References: <20231007222205.316032-2-boukehaarsma23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk orientation for the Ayn Loki Zero.

This also has been tested/used by the JELOS team.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d5c15292ae93..7466354c7e5b 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYN Loki Zero */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.41.0

