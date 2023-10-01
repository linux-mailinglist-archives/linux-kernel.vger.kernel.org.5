Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB647B4881
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjJAQAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjJAQAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:00:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A8D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:00:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4066241289bso17465955e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696176012; x=1696780812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKun88ibkbujMSV7ziw9uIyf2WbEOY54JUL6u/KwN9Y=;
        b=ikurUGbAkTec8UM6M/cK8aM22hqVN3YesBMi2a+t0fqgMn/G+hx7FQ5Kz592kakc83
         PqxmeO8rHY7GttX0Ebmm5yHee1HKE63oLKmMZl9pNb3UMFqqs4HvJTqYYo7wMONriHCi
         d0j+txlH0BgefD6d4Sq3h9dv/LaDkDzx/UcyojVzvouJ/fcU8En+B6znwnFZmmd06h26
         bW57zJjt1GdWuxPtRrTAyUSPZTfuUFDrMqTSycN9ekNNZxlbikV2rlzQLrLMXWCVzN3o
         SuJ8DyVjFk9RcqIZ1eTUZhQ7iO5yOTiTA7uyoPdg/iVm7fX1YZp2/lldLlmt1AzlyLNO
         mXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696176012; x=1696780812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKun88ibkbujMSV7ziw9uIyf2WbEOY54JUL6u/KwN9Y=;
        b=B/STIgu5zlIvpC4Sc0TCRMfZyUnGis+NTKYa1dIz9oC+WX1SknReli9OHpg+sYa2tm
         o1e955/spSkVbQRomgwiSGYIphuuPr8acatGZhWM7erb0fHYjhqaskJeBgt1epndhCBh
         TuEfZop52peyPS+FA+J5nZpHBt+AlvSzS2bUUYq96cQpk8YMFvqAMBuD9X7A3jI9IK7e
         ZVnXn5zFYoW9qWA6kKXQHbYAJemCHv2NAktBnuoMcxpLW5fRzSil0pGOiV9NpSVSxRJ4
         WnIsrd7aQ7+o7BN/yn1rEN6TBZY+eUpBcMyG0/lwvmBa26nA31wK6e1xRSFAlJMJNPj2
         1eyQ==
X-Gm-Message-State: AOJu0Yyy1VjNZmzUEz8S6vImfliW0IDiRvLcc7Al1CUFaxIMF/le3/YH
        WLK+iBqU/xuNw01D/KMasHA=
X-Google-Smtp-Source: AGHT+IFnnsWiobuODClQVC5VSivppI1POmujPR7WElSjDMqnAnbl/lbUpE8dWdav5pBbnzl7mmgOrg==
X-Received: by 2002:a05:600c:293:b0:401:1b58:72f7 with SMTP id 19-20020a05600c029300b004011b5872f7mr8926916wmk.38.1696176011866;
        Sun, 01 Oct 2023 09:00:11 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id s16-20020a05600c045000b0040536dcec17sm5487695wmb.27.2023.10.01.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 09:00:11 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 2/4] mm/gup: explicitly define and check internal GUP flags, disallow FOLL_TOUCH
Date:   Sun,  1 Oct 2023 17:00:03 +0100
Message-ID: <5b20f3cda7cd841555c2626f98d23aa25a039828.1696174961.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696174961.git.lstoakes@gmail.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than open-coding a list of internal GUP flags in
is_valid_gup_args(), define which ones are internal.

In addition, we were not explicitly checking to see if the user passed in
FOLL_TOUCH somehow, this patch fixes that.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/gup.c      | 5 ++---
 mm/internal.h | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2f8a2d89fde1..b21b33d1787e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2227,12 +2227,11 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 	/*
 	 * These flags not allowed to be specified externally to the gup
 	 * interfaces:
-	 * - FOLL_PIN/FOLL_TRIED/FOLL_FAST_ONLY are internal only
+	 * - FOLL_TOUCH/FOLL_PIN/FOLL_TRIED/FOLL_FAST_ONLY are internal only
 	 * - FOLL_REMOTE is internal only and used on follow_page()
 	 * - FOLL_UNLOCKABLE is internal only and used if locked is !NULL
 	 */
-	if (WARN_ON_ONCE(gup_flags & (FOLL_PIN | FOLL_TRIED | FOLL_UNLOCKABLE |
-				      FOLL_REMOTE | FOLL_FAST_ONLY)))
+	if (WARN_ON_ONCE(gup_flags & INTERNAL_GUP_FLAGS))
 		return false;
 
 	gup_flags |= to_set;
diff --git a/mm/internal.h b/mm/internal.h
index 449891ad7fdb..499016c6b01d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1018,6 +1018,9 @@ enum {
 	FOLL_UNLOCKABLE = 1 << 21,
 };
 
+#define INTERNAL_GUP_FLAGS (FOLL_TOUCH | FOLL_TRIED | FOLL_REMOTE | FOLL_PIN | \
+			    FOLL_FAST_ONLY | FOLL_UNLOCKABLE)
+
 /*
  * Indicates for which pages that are write-protected in the page table,
  * whether GUP has to trigger unsharing via FAULT_FLAG_UNSHARE such that the
-- 
2.42.0

