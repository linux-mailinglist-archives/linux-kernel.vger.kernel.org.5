Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A1803A55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbjLDQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLDQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:33:06 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B99B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:33:11 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50be3611794so2952682e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701707590; x=1702312390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFhZWsGjljRXuXWmnaUrVNi01SgHI8BoKOEoL7qVnHM=;
        b=GCy15aynLwI4wXSUjUxK92KBjCnLLxjk912+M+iO/dIvG7+SbSWTWxNvWGa3nXiS1b
         4TtfTz0SC31Yw0xw8G6GDHVH2UUoFKm8T3Utq9ruz1Bn6QmjLVviYYZDI3LFAK7u9eUf
         fH8JcgSO5H5ngdubrN8t7huQwHI/Z2HFV58Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707590; x=1702312390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFhZWsGjljRXuXWmnaUrVNi01SgHI8BoKOEoL7qVnHM=;
        b=xSYPFk1m7UaJprnBF0Uh5FKU6idp6X6k1hhAVWAJbaM39Ai6pXtgK2wOc4QVOBO+dT
         fj9Ra+qIO/FjqWMqwgMb4uN/DinYzRKtv7qvj6PtbWnTm3eGof7263Tb1wU6cx0vG6n6
         REayuPxy/lJYwB0kUPNjWsSNMzMyit0AmL4ETIJO6h/5KH5z38UZ3ECReSI80OAVgPRS
         xRcHzB8BlK+Dgdt94tkGwXx2DZttgGvWRCqixblznepHg6ETHfjOF+VavEb4/kNuuCbU
         36+b0zk/hsZgFGQOhzq2ou5WPV/F0PYVMzhgHauZlh6OI3+kDDlXR6C7yhGXfxRxfD4l
         Hxzg==
X-Gm-Message-State: AOJu0YyskEYbBPrc6Fi9jKWuUP1lBUoejqyL9SChDIpa9zQJ1N2bDZh4
        DmUQcqkbqO0E/ywtqv+UVt0L/i8W5lMYMlirGDMocg==
X-Google-Smtp-Source: AGHT+IEzscqvonPSYN5fzR00W/YM0kbQcClqgy3YC5nfaM4r56UyO5MKoZDd6gtHz3ghLKHrVeeAGw==
X-Received: by 2002:ac2:42c2:0:b0:50b:ffb9:be80 with SMTP id n2-20020ac242c2000000b0050bffb9be80mr192530lfl.119.1701707590111;
        Mon, 04 Dec 2023 08:33:10 -0800 (PST)
Received: from dmaluka.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id c27-20020ac25f7b000000b00507a0098424sm557118lfc.109.2023.12.04.08.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:33:09 -0800 (PST)
From:   Dmytro Maluka <dmaluka@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH] mm/thp: add CONFIG_TRANSPARENT_HUGEPAGE_NEVER option
Date:   Mon,  4 Dec 2023 17:32:54 +0100
Message-ID: <20231204163254.2636289-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to disable transparent hugepages by default, in line with
the existing transparent_hugepage=never command line setting.

Rationale: khugepaged has its own non-negligible memory cost even if it
is not used by any applications, since it bumps up vm.min_free_kbytes to
its own required minimum in set_recommended_min_free_kbytes(). For
example, on a machine with 4GB RAM, with 3 mm zones and pageblock_order
== MAX_ORDER, starting khugepaged causes vm.min_free_kbytes increase
from 8MB to 132MB.

So if we use THP on machines with e.g. >=8GB of memory for better
performance, but avoid using it on lower-memory machines to avoid its
memory overhead, then for the same reason we also want to avoid even
starting khugepaged on those <8GB machines. So with
CONFIG_TRANSPARENT_HUGEPAGE_NEVER we can use the same kernel image on
both >=8GB and <8GB machines, with THP support enabled but khugepaged
not started by default. The userspace can then decide to enable THP
(i.e. start khugepaged) via sysfs if needed, based on the total amount
of memory.

This could also be achieved with the existing transparent_hugepage=never
setting in the kernel command line instead. But it seems cleaner to
avoid tweaking the command line for such a basic setting.

P.S. I see that CONFIG_TRANSPARENT_HUGEPAGE_NEVER was already proposed
in the past [1] but without an explanation of the purpose.

[1] https://lore.kernel.org/all/202211301651462590168@zte.com.cn/

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 mm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..ec2d5841c9dc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -859,6 +859,12 @@ choice
 	  madvise(MADV_HUGEPAGE) but it won't risk to increase the
 	  memory footprint of applications without a guaranteed
 	  benefit.
+
+	config TRANSPARENT_HUGEPAGE_NEVER
+		bool "never"
+	help
+	  Disabling Transparent Hugepage by default. It can still be
+	  enabled at runtime via sysfs.
 endchoice
 
 config THP_SWAP
-- 
2.43.0.rc2.451.g8631bc7472-goog

