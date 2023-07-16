Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1224755063
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 20:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGPScX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 14:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 14:32:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8ADF;
        Sun, 16 Jul 2023 11:32:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so5385179a12.1;
        Sun, 16 Jul 2023 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689532339; x=1692124339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoxN8xF03T7cZqcQApZMu5JlfIYPUFqX+rnqT1miq2o=;
        b=VaGlBnl7PMz8cnF6BTLHqoF3g+DQvHafo6pmiuBu3IQbrsvDoms0g5SgnH4Q/kwUs8
         Eeiy8BAXmQb33rcRyv8FUDWi9nzl+MWTuG50So357nniMTXjQ0XPTcvXccpFRvktjrTN
         Nn9g5kDQ2EPRwKf2mKnckmx4Ye4vQZl+OriOhhGmwKdfeHrrP0VdzharW144I4z9l5hQ
         iokfVUcYX88xWazdG7hzma1fvJ+W1Qw9R3Nm7MGdEN5RsPBSnylk9KmPcfrCpBy2mFTD
         Ov3i7UK/wZA8Wk00IId9pzeCUyHpS4jj06EWX5J5IXUFQxnzN8/QojS25dE9Ppthfh4J
         jzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689532339; x=1692124339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoxN8xF03T7cZqcQApZMu5JlfIYPUFqX+rnqT1miq2o=;
        b=HDPDFhMuvB/UuY7e/TObBYqPe+vMcNYl1gyV2hliT2wnJmN4KruZY7SDSc/bTQbl9B
         RrdBaH2ldsq0HWajQkCR4y48m0Z+bAm9S0dsHxcgjVDo3LxeMAeW/MsfZQOpQrrCtlfN
         aJYBdzypX1PYVWYT+ZLu9H/i3sbgMppGskZ7wlb2f4Tehp+GT5yweAZB2LgXLSNx3aMH
         5E3EH2BDKaIZnC7yhJDkvF4TyGLS9sRb91Wxo9ythQhu+cGcKsrAhJIdS7HwtTOc66Xf
         ig5u/WYYUrnbMCAAV4Z/mn0rGVJPRBWmx8nzHp9fgc8GasIJHzqg4+EvyAtXy+su5CZN
         Q58A==
X-Gm-Message-State: ABy/qLbFJc124x6GFEB8LCtK6cermfsiZ1cjmfmEH9Nbq1sN/fvhJfV8
        jwj6U+3Asc730ZLE99/y5vL5f9LJgk1qJg==
X-Google-Smtp-Source: APBJJlFiSWW6CNJglKO9srZc6x0ffWly/Rw3yEoz+X7VNowODJ+qTL01Yn9M3cinRWOH6tJZNPL5ow==
X-Received: by 2002:a05:6402:68c:b0:51e:1095:5ae5 with SMTP id f12-20020a056402068c00b0051e10955ae5mr10540578edy.8.1689532338830;
        Sun, 16 Jul 2023 11:32:18 -0700 (PDT)
Received: from localhost ([185.220.101.82])
        by smtp.gmail.com with ESMTPSA id i21-20020aa7c9d5000000b0051495ce23absm8636612edt.10.2023.07.16.11.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 11:32:18 -0700 (PDT)
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Alex Hung <alexhung@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH v2] platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS DMI quirks
Date:   Sun, 16 Jul 2023 21:32:13 +0300
Message-ID: <20230716183213.64173-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP Elite Dragonfly G2 (a convertible laptop/tablet) has a reliable VGBS
method. If VGBS is not called on boot, the firmware sends an initial
0xcd event shortly after calling the BTNL method, but only if the device
is booted in the laptop mode. However, if the device is booted in the
tablet mode and VGBS is not called, there is no initial 0xcc event, and
the input device for SW_TABLET_MODE is not registered up until the user
turns the device into the laptop mode.

Call VGBS on boot on this device to get the initial state of
SW_TABLET_MODE in a reliable way.

Tested with BIOS 1.13.1.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 drivers/platform/x86/intel/hid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 5632bd3c534a..afa16520b363 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -150,6 +150,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G2 Notebook PC"),
+		},
+	},
 	{ }
 };
 
-- 
2.41.0

