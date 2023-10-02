Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4584E7B5DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbjJBXPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjJBXPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:15:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228B6AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:15:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317c3ac7339so355260f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 16:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288502; x=1696893302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQvCLVMfpl1rfMES4jKdwm82L8UOBjNuap0Ti+SzBhc=;
        b=M+CLVVRy5HwsqvwlOokevjgvepUgwThG5qiKvLLjgD6DgeE0lvwqnB3Uwnbn04and0
         5FwsF0wShTTx273cd96s8GM5ipKSoQNtSSWLleeCVEi+nkNqXAS5+Skcbte8QM65fri7
         CozNyc2DCzNxLYZC2uztoUiriVNctcjbqvUEIPQSF8LrQiVpZD/grqAQaBMVlZ8pkcYa
         VMbDr9bjJpGKhPJui+9bnSEhAD/CRyHtYHvTgJxCVZq+6//ibb2+RZHErvAkBnvdDDpM
         OsUvgL92PtYNz963pxwdEIybG9/0Q6M8vXsx9KiGD04R9j+8vvMmaHeZfIW3pbIOP23U
         U0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288502; x=1696893302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQvCLVMfpl1rfMES4jKdwm82L8UOBjNuap0Ti+SzBhc=;
        b=Wz91v5mZdLiPfpjUaMQ6OO3YcLFO1BBx+q276hxhSVcJ3ayBLOFG4gRZ63uNAE9UTR
         1IMbZIhkk6Ngb/XEKYfrsRxDl19VZ0Ssa2+YB531BppAlHzyrCZ+yJk4Sb6MikgmKvgD
         qoURXuWHQUFamsz+kbhMqvGHbRLuYld8JybKuvAoVjjqnWlZ0VYgAbv6v+UonAE2aaAM
         gM3Tn/TUaXd0l54rgmo45ZG0qjJ4X+qC3dGTXlXumIoU3VmJ4jn5Vm7+NhP6DHspBXuj
         6SaO8xRzYsLZ9m+w6UCGSnvZFJDn2Ou8MSfUS9RQtNN6wwtZiKsWggVOtPrfVMmabC2q
         QtMQ==
X-Gm-Message-State: AOJu0YwTAQD5Ljb1yb48RliWmioVD9xG4yfLfxsYg2rUnIVteh3tUM5f
        vLvr++qE9AZOvQIYkk0gSH0=
X-Google-Smtp-Source: AGHT+IEtd7/2+KG5WHd0cByCIEOQATOBxdbRX+bfexS1IsqnxYU1Maj/cmH3p1/Wp7fgogXQxGevfg==
X-Received: by 2002:adf:fc4c:0:b0:31a:d4e1:ea30 with SMTP id e12-20020adffc4c000000b0031ad4e1ea30mr11701566wrs.17.1696288502337;
        Mon, 02 Oct 2023 16:15:02 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e31-20020a5d595f000000b0031fbbe347e1sm63860wri.65.2023.10.02.16.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:15:01 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/4] mm/gup: explicitly define and check internal GUP flags, disallow FOLL_TOUCH
Date:   Tue,  3 Oct 2023 00:14:52 +0100
Message-ID: <971e013dfe20915612ea8b704e801d7aef9a66b6.1696288092.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696288092.git.lstoakes@gmail.com>
References: <cover.1696288092.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than open-coding a list of internal GUP flags in
is_valid_gup_args(), define which ones are internal.

In addition, explicitly check to see if the user passed in FOLL_TOUCH
somehow, as this appears to have been accidentally excluded.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
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

