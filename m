Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3026805C92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjLERCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjLERCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:02:45 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B923A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:02:51 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1915034144so717514266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701795770; x=1702400570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBCPsrxEK/c4yfZsrOW2rPVQB4Gl/XCShj5B3/oom0w=;
        b=dn52+ZZVLXYbKJXoZ5Q9wnIZRklo996GyaVsx9sz396C1ZtND3fGLaHXsRg2knPUSC
         5nb1AQIyYj8MOBFknL4KMyjRTQgiUgsOpLDz4lgbrcz3uC46VgfTOflMuOGwgVvgi/6s
         dU3EuCbhPgL3gwW9b1QAZg6E8pReE9rLPuqAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795770; x=1702400570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBCPsrxEK/c4yfZsrOW2rPVQB4Gl/XCShj5B3/oom0w=;
        b=KslOlL8OmWwUovkFOn64BI2IMshKgMVcZVE5NODzoN9pWmpYd2MfwW0JIBHGtBwn7F
         X5ckiFhUP5t81HAumWDflaDeYkCu6Ro3NmOmKNfSO3BX66SOwxN1d7ZUL6xrJoddKPCv
         lIqM/aLuNGlXrelH1kOj1+SWrRpBujneKTrfcagLBx5zE+j3rHovAhS9O5QVPbLxKzm1
         1F8c9hSWz/adKjC49LYqdTuwrfSSfwIb4h7JR6+nAUBYzxn4m7hWmAYhk+sIZ4xxM7gE
         Pf9R/QMJEtayoU7ftP9kr88IIfB6FckhgpJZQGiuIsBkjrqEymPCD0rrfgd5MuBwtBMS
         D+hg==
X-Gm-Message-State: AOJu0Yz2QFE1+KszfJapeRz47up3uamJxF7QOm0QDt6QwjDPf07AzPRd
        oCCzA0hbV+ZrCEci89HbL/fz4dnFGYykUcubRZp0nA==
X-Google-Smtp-Source: AGHT+IF6pfu03qpQiFZ3BlrYh/Quz8jSlWuW9+HAm2uQIiOgN9orMb3UfN2bEmGq1S95ehwpvEzeMg==
X-Received: by 2002:a17:906:739c:b0:a1b:86e5:4e1 with SMTP id f28-20020a170906739c00b00a1b86e504e1mr1744817ejl.108.1701795769422;
        Tue, 05 Dec 2023 09:02:49 -0800 (PST)
Received: from dmaluka.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id uz14-20020a170907118e00b00a0104d5758dsm6932354ejb.50.2023.12.05.09.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:02:49 -0800 (PST)
From:   Dmytro Maluka <dmaluka@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v2] mm/thp: add CONFIG_TRANSPARENT_HUGEPAGE_NEVER option
Date:   Tue,  5 Dec 2023 18:02:44 +0100
Message-ID: <20231205170244.2746210-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently enabling THP support (CONFIG_TRANSPARENT_HUGEPAGE) requires
enabling either CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS or
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE, which both cause khugepaged
starting by default at kernel bootup. Add the third choice
CONFIG_TRANSPARENT_HUGEPAGE_NEVER, in line with the existing kernel
command line setting transparent_hugepage=never, to disable THP by
default (in particular, to prevent starting khugepaged by default) but
still allow enabling it at runtime via sysfs.

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
via sysfs if needed, based on the total amount of memory.

This could also be achieved with the existing transparent_hugepage=never
setting in the kernel command line instead. But it seems cleaner to
avoid tweaking the command line for such a basic setting.

P.S. I see that CONFIG_TRANSPARENT_HUGEPAGE_NEVER was already proposed
in the past [1] but without an explanation of the purpose.

[1] https://lore.kernel.org/all/202211301651462590168@zte.com.cn/

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
Link: https://lore.kernel.org/all/20231204163254.2636289-1-dmaluka@chromium.org/
---
v1 -> v2:
  Cosmetic documentation changes:
  - s/Disabling/Disable/ per Andrew
  - Clarified in the changelog that this adds a new choice "never" in
    addition to "always" and "madvise"
---
 mm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..1930e18be8a1 100644
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
+	  Disable Transparent Hugepage by default. It can still be
+	  enabled at runtime via sysfs.
 endchoice
 
 config THP_SWAP
-- 
2.43.0.rc2.451.g8631bc7472-goog

