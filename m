Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39157BCA5E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 00:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbjJGWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 18:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344218AbjJGWWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 18:22:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C49F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 15:22:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso5782175a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696717369; x=1697322169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdB/BGfiU50tq91OXEW4jEb/ithHfUpM77EyD2syuso=;
        b=TJ7SpE7eDms4BaiFvNrZnLlh1QM2Ix6PDsz/J3gAUmJ/NBkvSHdo8ekcvf0eWbtuUz
         neoAgqTLvo7ifcJ00+aPqrWb90cdxesDJ+58rzNzbyfGdxNRsKP8y3eHIaR4zUbrYNkh
         WCveyOPVVqT6mxsyIrJXXBvxUX/LyPtwsdntM0SPQRFnYCeGMPJ/7O3OeMx9NrDqKwLX
         U/FVlzZSOtMehLF9rjJFCjCQWOPFb+OR1SuiikqSdhGPp+9eIRdzrVMq69/1zeXNc5zi
         SUJf88trktcVjnZrLg7JEVaZENdTXaDKE1U/YY8j5nWUEtvITPmvjvOBJp2Yd2nhyogA
         Z6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696717369; x=1697322169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdB/BGfiU50tq91OXEW4jEb/ithHfUpM77EyD2syuso=;
        b=JmWPOnzo7/xc/PbrD4Jyz2Ck0++wo4Yb6mU9Ebp/NmFqMoV40yHt81U4qv0wWKgO22
         KUygjy9zcY2EEUU5CpQK3VmDkKkl7OCxNplKbzf1X+1dH046DY2erqTTPzU76T+d9Xk7
         ExJn4En14dkSuh0R7PMf5Tu0qa2Klq6DLwKu9+e9xddiWwPrK7Qykp9Zxyp060NFT3jy
         8Ongrukgi+dNyOX6ZGOgXQxqeLc2BD30ZeEZ3WTBH5oOF9rxFES7KsYQx/O+NtEik9G1
         eOOvQ1N/r8HGga8EJpQWNwNG4rQCKyW8zPEJzalcIYtzneO0OKxGfnQDRl/O27E1jKfM
         s9QQ==
X-Gm-Message-State: AOJu0YxYpjKlMEvfRtLoaUO0RRsRyXvXm25ajmJURqbGSOHEGKHcSj78
        sZ/WbHMFHTOqLcbYo6LFi1o=
X-Google-Smtp-Source: AGHT+IE5XwNPgW5i1gff9lZx5O8y0seN1+Vsx5TQstnKeLrpfJPXQk623LewLQsVUSD2NoeKkMi3gw==
X-Received: by 2002:aa7:c154:0:b0:522:b112:6254 with SMTP id r20-20020aa7c154000000b00522b1126254mr10627245edp.4.1696717369194;
        Sat, 07 Oct 2023 15:22:49 -0700 (PDT)
Received: from Slimbook.. (181-251-201-31.ftth.glasoperator.nl. [31.201.251.181])
        by smtp.gmail.com with ESMTPSA id p7-20020a056402074700b0052f3471ccf6sm4315631edy.6.2023.10.07.15.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 15:22:48 -0700 (PDT)
From:   Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     boukehaarsma23@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
Date:   Sun,  8 Oct 2023 00:22:06 +0200
Message-ID: <20231007222205.316032-4-boukehaarsma23@gmail.com>
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

Add quirk orientation for Ayn Loki Max model.

This has been tested by JELOS team that uses their
own patched kernel for a while now and confirmed by
users in the ChimeraOS discord servers.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 7466354c7e5b..5adf9ff07c3e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {    /* AYN Loki Max */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYN Loki Zero */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.41.0

