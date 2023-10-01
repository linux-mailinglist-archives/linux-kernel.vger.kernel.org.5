Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059627B4883
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjJAQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjJAQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:00:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12817DA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:00:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4066241289bso17466035e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696176013; x=1696780813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xEwOtL01+HmLCODlG5jDnboU50nYLcrpSFuPs0VWD8=;
        b=hFnRHMmA4lo/2w3tKnAYh6JXvlNSDY4KQCmh/Tj9yi79eMbL0j0ysTNz9uh2PRMfb2
         mg80XnivtwqN5F4Wp+d6RIzGD8eXpq6X6V9o/e9oYYDJ0ES+wsce6/0qHMZ6Rg4G6soe
         MlJKbxZzzdxActTVwKf9r6Y2k9BacE+6wdzjshE6szpq6VyY+7HXO3VKSZJ6w3IGQoBc
         QZkXfVphMGrb8J4RMtzY+cIWy6QsN08VVUAUGnFmfHLRrIQK+xIU0X8EX91hOx0uRY0d
         SxBhubrp5oo8i2Lc1wo8BlxaqXTeT8LyEN2zrytq6Mw8tKiEZH8CHZh1vpFzxPk5hxId
         BaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696176013; x=1696780813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xEwOtL01+HmLCODlG5jDnboU50nYLcrpSFuPs0VWD8=;
        b=rUCFtHkrGWLfBbXdQOGVBbqpDk0I+IBJalkcRETJzWJ9DhgHRY9Z1h139LlFXpN8Ed
         /em/spHd/1eQlGwhs1UWR1Yr3Vsg55IzeoyUwhBng8jKdE1AoanpCnFW9/w+LBORGavO
         kxJbHPgk4FidwRcCtQIXbQ05CNYCA5kbAQvAQjUBzpRLO9iVR2k35rWgVz7BBlIaB/8O
         G0dckJK1iiYeG3MrOpEYtiRrUOToN0T/3cGuxujEyK5R+p7/PZs86VnhSdi6u6nYadll
         oGbA/vOY5U8qMgQwAkTJitk/JM791ceNVX9gGH/SfBeZ35hVF4xO9QwcQL3BJT7+zO2p
         qX/A==
X-Gm-Message-State: AOJu0YxDpPk02ehq68fwh/1uBEdWUhlgu3dp3UIc8hv/6XCCX9BS7dcl
        06AsEV0RFwMSEwekV4NssbQ=
X-Google-Smtp-Source: AGHT+IGxL3BxWt0viNQ4gBrwqwGyLTXnXg+le9Rifz61iOn5svjkixg7oOtLo9NMLPoFe6fGC0eUhA==
X-Received: by 2002:a1c:7407:0:b0:3fe:d1b9:7ea9 with SMTP id p7-20020a1c7407000000b003fed1b97ea9mr7951514wmc.36.1696176013401;
        Sun, 01 Oct 2023 09:00:13 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id s16-20020a05600c045000b0040536dcec17sm5487695wmb.27.2023.10.01.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 09:00:12 -0700 (PDT)
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
Subject: [PATCH 3/4] mm/gup: make failure to pin an error if FOLL_NOWAIT not specified
Date:   Sun,  1 Oct 2023 17:00:04 +0100
Message-ID: <c7bfaf30cb682b92766e35ec85d93a84798b37f4.1696174961.git.lstoakes@gmail.com>
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

There really should be no circumstances under which a non-FOLL_NOWAIT GUP
operation fails to return any pages, so make this an error.

To catch the trivial case, simply exit early if nr_pages == 0.

This brings __get_user_pages_locked() in line with the behaviour of its
nommu variant.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/gup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index b21b33d1787e..fb2218d74ca5 100644
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
+	 * Failing to pin anything implies something has gone wrong except when
+	 * FOLL_NOWAIT is specified, so explicitly make this an error.
+	 */
+	if (pages_done == 0 && !(flags & FOLL_NOWAIT))
+		return -EFAULT;
+
 	return pages_done;
 }
 
-- 
2.42.0

