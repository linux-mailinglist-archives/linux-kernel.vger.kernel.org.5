Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1A7B0CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjI0TfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0TfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:35:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D426114
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:35:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f71b25a99so11728972f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695843319; x=1696448119; darn=vger.kernel.org;
        h=mime-version:message-id:cc:to:subject:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b/kwHgGSPER833mfnZsloSnG2/QVneER5ld9wWGGfCM=;
        b=lGC8sVd8hXdm4NDl92gsURS2MHa7lDoI7XJkJ8lDRjEVK0PgBrba4CvO8tJD8H+sq0
         R81Xuf5OBgD11IvQEk0B+CMShjX1YIxFyV/hLZgLS4DuqSDEtlh14Oy/TDujsDaEXfEP
         hNKZEnawN1njGpLmcZq02AynrCZBrixGoGnTB2k/qC4FBuWMVa2ZQdooj/uP2Emsue5/
         DHIFhVPXHRWi7TyIRNmjbNYBRUlgXTO4mSv3wtPPym2JYTPGJ482m0MwQRvKTvnzchw7
         Tfqei+w+kUV1no1dEy/KDnsXEJIcVdBJeWF8jqULvvzzwQMRxVCS63crW9HoUI1nSsya
         8N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695843319; x=1696448119;
        h=mime-version:message-id:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/kwHgGSPER833mfnZsloSnG2/QVneER5ld9wWGGfCM=;
        b=FvqVL1MAaUVTzUQEJ7jamqHJxf7bsSpWHvngvo7KW4K9Ba9OVJuHEk+AJJ2PuMkHwE
         DUZqBY/4LtJHuTQJ6wUWfXfPp+YFgDlM1zSuQK0kGiDPk+XW3SZHB7IjFCLvMSXgOyRb
         XxQIisSm203zdgWgH+xIQAzkDUKOiKNfr2Ylp11VzwMpYXvSrH/mRkOp8KJ7XD3xhrUt
         qoPIHqnkUf3Hp27IOvxHqzWJ/ZTIaJpbpCjOo5WRFR1tGjdAdzoA1VEERMOORKuXlAyW
         L4O6lks0aOJLutocOclVCbmUmdncgetp3528htBqqJJ2k8MAm2yA3Fvt6MiV8XQr1S80
         KiVA==
X-Gm-Message-State: AOJu0YyurARfnJ8ZfK+t9EUFlqWP9i3pK9lrqn2jKS/bximtjvVXn7mi
        TMrjd6JpO1dyq0SWeWafpxA=
X-Google-Smtp-Source: AGHT+IHl9dYpXN9XqXHiG6al2NGt7W95zzeD9nIMVhn3PlsdI/RctpeCZKJ/BoF5mQLG7aW3oIiarw==
X-Received: by 2002:a05:6000:1112:b0:321:6a61:e45a with SMTP id z18-20020a056000111200b003216a61e45amr3040357wrw.15.1695843319317;
        Wed, 27 Sep 2023 12:35:19 -0700 (PDT)
Received: from yoga ([2001:638:904:ffe5:5742:c50f:bd0:6aa6])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b00321673de0d7sm2379099wro.25.2023.09.27.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:35:18 -0700 (PDT)
Date:   Wed, 27 Sep 2023 21:35:12 +0200
From:   Sven Frotscher <sven.frotscher@gmail.com>
Subject: [PATCH v2] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
To:     broonie@kernel.org
Cc:     git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, regressions@lists.linux.dev
Message-Id: <O2TN1S.57QJOL6TXOBC1@gmail.com>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Like the Lenovo 82TL, 82V2, 82QF and 82UG, the 82YM (Yoga 7 14ARP8)
requires an entry in the quirk list to enable the internal microphone.
The latter two received similar fixes in commit 1263cc0f414d.

Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on Lenovo 
82SJ")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Frotscher <sven.frotscher@gmail.com>
---
v1->v2 changes:
* add Fixes and Cc tags to commit message
* remove redundant LKML link from commit message
* fix mangled diff

sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c 
b/sound/soc/amd/yc/acp6x-mach.c
index 3d8a51351e29..e3d2b9d01552 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -241,6 +241,13 @@ static const struct dmi_system_id 
yc_acp_quirk_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
 	}
 	},
+	{
+	.driver_data = &acp6x_card,
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
+	}
+	},
 	{
 	.driver_data = &acp6x_card,
 	.matches = {
--
2.42.0



