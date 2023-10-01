Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE707B487F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjJAQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:00:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A0DF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:00:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406402933edso73933055e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696176009; x=1696780809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbQ2+MNx7iQKlTg6jhWJ9e8ngVQbdAZdbk2tukIrGRw=;
        b=IVRm8T0V976mZ9cTdEnp23eUgJqclHZFvpe5N6nVDwaCGxt8aYCLNtA5lRF1MpPyUv
         1XjtCpfA2GBvPb4ysyuutwMdTN2mw9cIU86LpPVaYHWXkhGBvR3Vfjbry2euyn9yKSKu
         k4KA90KaSJzrOsqqOG355vhEVv+/zoL32ibAJfpodhFLuamR7q2ll6KCKxO3g7UNJ/i9
         WoqoTf3zRg2iERk297zbpPeMlyz6+EaXVurZ9OvACAmmxCFFgeC6oD7McpQVeq0SnAnL
         xcAHJJuHopkI/wJ6YJoJhhG6xHVTNVktruod3QpZGW2HPNlMHLyQfjkF3Ccqs6vbDdl+
         ijmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696176009; x=1696780809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbQ2+MNx7iQKlTg6jhWJ9e8ngVQbdAZdbk2tukIrGRw=;
        b=bp+pw1DAJY+puMzIEebxSdQpoz2o/DJq3YcxBGH0dp1LxSPwRw4s1OueSvU4qt9o4d
         xWwoip+04JFlWKFkqof2SGVaKDh2tqdevQ5o0uscf0myHnmiH353zyx/FRR831yCys80
         O/ZK1vaPqEwqhEk/KQIf1vu+rDkS2kpjQ/cm5zmK4ruYHgGIbYLgltLHOeOXqID5C8R/
         IGBYx36eV45Zt50Ykcp8fBNFfha1KuLlG06m+TSgt9DXViLz10fzaO1O06YXcNcfaIny
         1Mt4mbmAXlFZSt8tsj3K87wXbPeO0TNC2cW7OpUQmER71/fcwG0CBHGrWKy01n1npGKq
         2GFQ==
X-Gm-Message-State: AOJu0YzDovH3uxB7PgA6HXtfWfdwh0VN3bQ6Z4Lwp5LXq5narPR6DU8f
        /3oo861ooIhv6Mrc9fmPeDM=
X-Google-Smtp-Source: AGHT+IGsBTJNp2/AtL0YHzJ0LwsCxVV5d5j9nxOnHW1suaWojSlQ/S2cfF5NquVDInPTiVFlnC6r1A==
X-Received: by 2002:a05:600c:6027:b0:406:535a:cfb4 with SMTP id az39-20020a05600c602700b00406535acfb4mr7987766wmb.1.1696176008738;
        Sun, 01 Oct 2023 09:00:08 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id s16-20020a05600c045000b0040536dcec17sm5487695wmb.27.2023.10.01.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 09:00:07 -0700 (PDT)
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
Subject: [PATCH 0/4] various improvements to the GUP interface
Date:   Sun,  1 Oct 2023 17:00:01 +0100
Message-ID: <cover.1696174961.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
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

A series of fixes to simplify and improve the GUP interface with an eye to
providing groundwork to future improvements:-

* __access_remote_vm() and access_remote_vm() are functionally identical,
  so make the former static such that in future we can potentially change
  the external-facing implementation details of this function.

* Extend is_valid_gup_args() to cover the missing FOLL_TOUCH case, and
  simplify things by defining INTERNAL_GUP_FLAGS to check against.

* Adjust __get_user_pages_locked() to explicitly treat a failure to pin any
  pages as an error in all circumstances other than FOLL_NOWAIT being
  specified, bringing it in line with the nommu implementation of this
  function.

* (With many thanks to Arnd who suggested this in the first instance)
  Update get_user_page_vma_remote() to explicitly only return a page or an
  error, simplifying the interface and avoiding the questionable
  IS_ERR_OR_NULL() pattern.

Lorenzo Stoakes (4):
  mm: make __access_remote_vm() static
  mm/gup: explicitly define and check internal GUP flags, disallow
    FOLL_TOUCH
  mm/gup: make failure to pin an error if FOLL_NOWAIT not specified
  mm/gup: adapt get_user_page_vma_remote() to never return NULL

 arch/arm64/kernel/mte.c |  4 ++--
 include/linux/mm.h      | 18 +++++++++++++-----
 kernel/events/uprobes.c |  4 ++--
 kernel/ptrace.c         |  2 +-
 mm/gup.c                | 16 +++++++++++++---
 mm/internal.h           |  3 +++
 mm/memory.c             |  7 +++----
 mm/nommu.c              |  4 ++--
 8 files changed, 39 insertions(+), 19 deletions(-)

-- 
2.42.0

