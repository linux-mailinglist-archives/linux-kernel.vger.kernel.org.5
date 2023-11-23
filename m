Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EDD7F5BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjKWKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjKWKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:06:44 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2A21A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:06:50 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d7f225819eso426967a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700734009; x=1701338809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDfm4qt8S0psZXBmQIeh0wAKIGN0pAlOy023J24MLXE=;
        b=ei9V8O/lWWrMt6qDzhuZXqn6k80g2VhHPgoLnW9Eomeb0+ApkX+z9Z2s9PitirckWT
         tNSprB7IT6c+sRFJrts2wjzY32HakmNU9SDx0HU2LABQZL4lqupEPQ+8rL5WBCn+QQpH
         eeGzxlsAJaM34UWN6lpWbE27pAUVe9czUdhKZVudGVqtDGpjskDM0rzZGl9ouqQ1SIHA
         i2wl8Qx05cZptOkoMXiBhKEdNqeVOb+5Z+ByYUEj91pF5VUw4Xh6jxvgoI6+d9VRNSFX
         ImognsvlWsj9DVvK803uYe+gCrQOQUXAmL1UqOKyVIYygL9p8qhJ8pEeDcpSF2Zo5Xpy
         uMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734009; x=1701338809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDfm4qt8S0psZXBmQIeh0wAKIGN0pAlOy023J24MLXE=;
        b=U87mKwI/j4Mk6fsu5lWWGbUzJEPJpC2dC4tSTaPQ7Qj4TUCUlv04QrdBCy1dBtUzQ9
         oO5fLXycr0hKJE/QK3mfmKHIPAV33MXHClw8t5V6BRFf2WIxnEWbvzlbQxuwzF6OJhk3
         5tffD01g9O8QSMMdCCHhT1p7jlA6u8bnJIsc74dzdsYlGfWhrCqnUt1xXQga1yDMMl0t
         f0IdIQ5kd5aR0Y4iNDA4Y/soCSvSV3qNkxc+9Vxf79cMMJfSON0IRXTnuUg34b+xxiSY
         dQM/z/OOIXEX9RY1bDgfmMs6qfizxBfj7ON7n8wjUQMH8hz5D3Xoi12QzGXj9FCedMfc
         Jq+Q==
X-Gm-Message-State: AOJu0YzfazmTtOrZqN5G37fXLuPJGbo9/98QHI++MiR++bmOvTXP+Vkz
        FDYbARYClddcNWtOZE9aISymvYfcnztEFw==
X-Google-Smtp-Source: AGHT+IEutua3pI8NOni3oG8j1Dg9pd6f93LkwDUSkT4HyOKJkm22ZwndG7qOx6OzG+LoSkNfb7EdyA==
X-Received: by 2002:a9d:6b13:0:b0:6d6:33c7:802a with SMTP id g19-20020a9d6b13000000b006d633c7802amr5802221otp.2.1700734009319;
        Thu, 23 Nov 2023 02:06:49 -0800 (PST)
Received: from smi-System-Product-Name.tw.smi.ad (61-219-235-31.hinet-ip.hinet.net. [61.219.235.31])
        by smtp.gmail.com with ESMTPSA id d3-20020a63ed03000000b0058ee60f8e4dsm972473pgi.34.2023.11.23.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:06:48 -0800 (PST)
From:   "Jim.Lin" <jim.chihjung.lin@gmail.com>
X-Google-Original-From: "Jim.Lin" <jim.lin@siliconmotion.com>
To:     kbusch@kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
        david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: [PATCH] Merge tag: Fixed an issue where it takes more than 20 mins for SK Hynix BC901 to switch to developer mode on Chromebook
Date:   Thu, 23 Nov 2023 18:06:42 +0800
Message-Id: <20231123100642.40923-1-jim.lin@siliconmotion.com>
X-Mailer: git-send-email 2.25.1
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

SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
"disable wrtie zero" can fix this issue and Sk Hynix has been verified.

Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046d..f27202680741 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.25.1

