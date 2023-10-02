Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B107B5DA2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbjJBXPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbjJBXPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:15:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBDBB8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:15:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231d6504e1so326819f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 16:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288504; x=1696893304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG4wWkmLCo1BkRFV+SZ7pD22xcplU2FkjQ1ykcSCzlA=;
        b=nC2uPqKaHv+ZGud73irvViL69+e70oLHG/gE2GX5iioSIZDUkiEo98cvpWWRs1rQcv
         RfcE+uhXBrltGQtEpvz5V0Ax9Vnw2nM7lX0JoKEjmQrRg0E7591VUPJbjcstCmwofFqt
         q97vZQz+EFQTogxvoFm9ej8w8yjOU9/jGQiZ1G78g12HaTPIJCgnOYheji9YzxAH6hFv
         RkHR4NlcMwukPC/Z3H7sjjA4aD2VAyvsFFohdkgrlQg3CIGne/Vsx/wnikP4/SdmeoGJ
         otRHdMIZjHFKOPMVYH/oYiP7q01NGT3do9AuZPdKboGKT9dEGHO59C6F0sjg6a890Eh4
         xhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288504; x=1696893304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG4wWkmLCo1BkRFV+SZ7pD22xcplU2FkjQ1ykcSCzlA=;
        b=NY/aBdgqAVPDE/MwiT/8tomrmf562qNV3S1OotbuNXsyRf/RtMZjeyFVkrmxicOq4h
         iB5QL4KHsOgsmyjCWIXF2RqOpcggBYhItPzMORWYeWX0aFabqjX4CP9sUZioLwv6+cz0
         EVmdAr4ZYlJtsbjQlo3tqDPG0uUm1+tPH2oa2o0uBLrVI4mxNAuXrvlpwYjcj17jzOiG
         k3CHohqoewDsnQKOECjtHhDEjzpgHxbg40/unthwpdrFcacAa8+hihxC2B3aBeG+C+rx
         qjgkMvQRFPU/8Uwph1mWPnlGDUYxuuig2zrBMdZBn+AFoOi8bQVGzbo7L38X/rbxcU1U
         okcQ==
X-Gm-Message-State: AOJu0Yx2+QcmQP1Eutl/q3VMefQ1wF0fF8Q9fSasj3cBaMMYNkGtbE4z
        ZdUwgoDLE6JzrNcSz4FlZvs=
X-Google-Smtp-Source: AGHT+IHPD0YW6W2NKg8MPeJMMqQ8iaJpIr7CxgDjPL+crfsBudmp0EpxGqIbkwK6ssWkl/HoqBh5Gw==
X-Received: by 2002:adf:ea8f:0:b0:320:1c6:628c with SMTP id s15-20020adfea8f000000b0032001c6628cmr12351480wrm.65.1696288503641;
        Mon, 02 Oct 2023 16:15:03 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e31-20020a5d595f000000b0031fbbe347e1sm63860wri.65.2023.10.02.16.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:15:02 -0700 (PDT)
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
Subject: [PATCH v2 3/4] mm/gup: make failure to pin an error if FOLL_NOWAIT not specified
Date:   Tue,  3 Oct 2023 00:14:53 +0100
Message-ID: <2a42d96dd1e37163f90a0019a541163dafb7e4c3.1696288092.git.lstoakes@gmail.com>
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

There really should be no circumstances under which a non-FOLL_NOWAIT GUP
operation fails to return any pages, so make this an error and warn on it.

To catch the trivial case, simply exit early if nr_pages == 0.

This brings __get_user_pages_locked() in line with the behaviour of its
nommu variant.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/gup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index b21b33d1787e..231711efa390 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1471,6 +1471,9 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 	long ret, pages_done;
 	bool must_unlock = false;
 
+	if (!nr_pages)
+		return 0;
+
 	/*
 	 * The internal caller expects GUP to manage the lock internally and the
 	 * lock must be released when this returns.
@@ -1595,6 +1598,14 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		mmap_read_unlock(mm);
 		*locked = 0;
 	}
+
+	/*
+	 * Failing to pin anything implies something has gone wrong (except when
+	 * FOLL_NOWAIT is specified).
+	 */
+	if (WARN_ON_ONCE(pages_done == 0 && !(flags & FOLL_NOWAIT)))
+		return -EFAULT;
+
 	return pages_done;
 }
 
-- 
2.42.0

