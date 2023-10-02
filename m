Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9320E7B5D9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjJBXPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJBXPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:15:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CEDAC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:15:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d20548adso338480f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288500; x=1696893300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOt3XSQtUEUA5CNWLdkquGCY/Lz/78GBxWkDuifhphU=;
        b=Cs/VF1UEb1eZ3HPJdTFHHgU/FAjfgeM0Xfg4eMRk74bAg4qW1ZE+5iMy6ptlrjRH84
         p+ifDZp0OGBCI7c+h7rVpJ+Ie/Am9fn9PP7qy7bdKtfBUr43htDHGuFoqO1HDyKpVYcc
         +FiD0Xj1TkVj1S8VoKu/En54uTXqgC/at1jwOetTGFaF6OF32dgCrYQaxbIYQpoQuKpT
         Y0eMOyi6t9OPoxzoVwfBGEmXeYzMDPkdGxVixDi9n1rVfau1cd0a/NhumESK8OL2Oer/
         kQ608/fm/xTaLfs+1jVLDa10mSDEKrJgMTO4JzkElkp1j3A6c9xA8xGoxlFj+k0XDAZB
         om3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288500; x=1696893300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOt3XSQtUEUA5CNWLdkquGCY/Lz/78GBxWkDuifhphU=;
        b=HYcn7ArS1S5nAlXrUoIyGSoy8QtLWS5qBCqTHPlmNhIvzzsW/bTztEGOASRF8tOrAG
         h8ZA6sgfFksqAPURPMFEa3oQX7CFujbWJvjYX8wmv0vqL3LRboLnRwkimGW5U/XEcP8g
         FD2+aRS/mJ29MHCZ5gDEHP0k++X64Nv6oT/eC/lCmcvhT90JGuz6X/8P822RZhDQJnhc
         swzQPkoNkm5GAcHZi/kQ7B3SNNmZN0TmV7yYKoCGEWd6NLKCFmzTqRfnanQ41Xx5HEvm
         T1s0VKvREkx8eAHUC+RkpQOOHZ5bYfr5VDv0p2X7xf7MZqJYx9uwdqxGACMkkt3C0790
         /GHA==
X-Gm-Message-State: AOJu0YyzGBDqk1VFTv4kv2mhTeIgBxI+kH9CJYqLdE9yD5eMHuuw3+dL
        0kIuPAQI0sFLLw6SKbpi204=
X-Google-Smtp-Source: AGHT+IHWnytmP2BpQFox1Y7j1Ao8wc2rkcTlgLD3/VFtY2ODQJ53FA1ArPwBB6DUdfuWAo7yw+iOSw==
X-Received: by 2002:a5d:5550:0:b0:309:1532:8287 with SMTP id g16-20020a5d5550000000b0030915328287mr11155438wrw.19.1696288499527;
        Mon, 02 Oct 2023 16:14:59 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e31-20020a5d595f000000b0031fbbe347e1sm63860wri.65.2023.10.02.16.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:14:58 -0700 (PDT)
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
Subject: [PATCH v2 0/4] various improvements to the GUP interface
Date:   Tue,  3 Oct 2023 00:14:50 +0100
Message-ID: <cover.1696288092.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
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

v2:
* Corrected spelling mistakes in patches 1 and 2 (thanks PeterZ).
* Made things WARN_ON_ONCE() where appropriate and dropped unnecessary
  checks (thanks David).

v1:
https://lore.kernel.org/all/cover.1696174961.git.lstoakes@gmail.com/

Lorenzo Stoakes (4):
  mm: make __access_remote_vm() static
  mm/gup: explicitly define and check internal GUP flags, disallow
    FOLL_TOUCH
  mm/gup: make failure to pin an error if FOLL_NOWAIT not specified
  mm/gup: adapt get_user_page_vma_remote() to never return NULL

 arch/arm64/kernel/mte.c |  4 ++--
 include/linux/mm.h      | 14 +++++++++-----
 kernel/events/uprobes.c |  4 ++--
 kernel/ptrace.c         |  2 +-
 mm/gup.c                | 16 +++++++++++++---
 mm/internal.h           |  3 +++
 mm/memory.c             |  7 +++----
 mm/nommu.c              |  4 ++--
 8 files changed, 35 insertions(+), 19 deletions(-)

--
2.42.0
