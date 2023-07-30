Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0D768628
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjG3PQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjG3PQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:16:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247EE138
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso42076465e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690730169; x=1691334969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouZz2dgRhulfVTdETwQCaMD2VZFH/MAUlpDLBWAqkC4=;
        b=WYTpzSFOlYTX+54AiGoo2AA6+qI3YxJezUgecbxkq/6VQ/LX7Ah6udam0ur8G0HjPX
         RztF/lP1AHUJ2o1PYC0taV8FxRDd1UlwjQfxZQmlUSkseRnHWdytaHx9vLUYLJYfj+aN
         fuybUXorlBSBwpIdZ4Ycg0xUrjHlBZItHlPKOiPgPzGs5B4NwRWq0TzxEuVhUFIMG6iU
         TU+gOjw1rI1cZIkIjQCSdZoNtaqWU/Xc3jk5NJJ1sB7ZAhVavj/a3nWEuHgQ+CUaPQ/n
         4CwC1tggDxRRF2El08SFrf28EzZfrvE0NAH36Pa/IErGXSHXEjiaHX6TDZddoE5vnKlw
         JV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690730169; x=1691334969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouZz2dgRhulfVTdETwQCaMD2VZFH/MAUlpDLBWAqkC4=;
        b=SgQYeQg2f+wfaWFb0fGODD+0/ioLrWQQLw1709iLHExP9sfWDEVoGHTKIpWpM+/JFH
         WqLiAh8Gqeq3g8R/qt8+s00m11NQ2yH21aJS1UJS1aRMakgGHnC700sFrv7LAwwllaBe
         9IdHUBn2PLD36rZsDLDNxJ90UoSosGGSASO3ZMaForEjKznc0QpBxV7o2fMEkqfLowYJ
         rVMKCa3grY0Ht3FFotQl3fBsGzI+0XjeH4VVf274BvK8KvbBVxmZY1SdADvu6Wd0axml
         q9coRRI1eOIF8A1ow3RWdsEZSdKpvTnwqLQXJtPZuBsQDp7AITPsLYBdpWg/V/h5BdOq
         wAKA==
X-Gm-Message-State: ABy/qLZG2S6HySdIl4bM7JN2cuMelB2IHlJHkDr1bwFclmGh7u2X4tZq
        VCEMxrdxBSEOl3kPZpXNY1uNkQ==
X-Google-Smtp-Source: APBJJlF5dPGoSedZx/k6nvqInFyfA+121sKKm+aczGQUh4mWlfALM9vJLpnAFciGz6wtqb1QaD/A4A==
X-Received: by 2002:a7b:cbd6:0:b0:3fb:ef86:e2e with SMTP id n22-20020a7bcbd6000000b003fbef860e2emr6360945wmi.19.1690730169537;
        Sun, 30 Jul 2023 08:16:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:eda5:aa63:ce24:dac2])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcc11000000b003fd2d33ea53sm9123027wmh.14.2023.07.30.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 08:16:08 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v2 0/6] mm/memblock: Skip prep and initialization of struct pages freed later by HVO
Date:   Sun, 30 Jul 2023 16:16:00 +0100
Message-Id: <20230730151606.2871391-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the region is for gigantic hugepages and if HVO is enabled, then those
struct pages which will be freed later by HVO don't need to be prepared and
initialized. This can save significant time when a large number of hugepages
are allocated at boot time.

For a 1G hugepage, this series avoid initialization and preparation of
262144 - 64 = 262080 struct pages per hugepage.

When tested on a 512G system (which can allocate max 500 1G hugepages), the
kexec-boot time with HVO and DEFERRED_STRUCT_PAGE_INIT enabled without this
patchseries to running init is 3.9 seconds. With this patch it is 1.2 seconds.
This represents an approximately 70% reduction in boot time and will
significantly reduce server downtime when using a large number of
gigantic pages.

Thanks,
Usama

[v1->v2]:
- (Mike Rapoport) Code quality improvements (function names, arguments,
comments).

[RFC->v1]:
- (Mike Rapoport) Change from passing hugepage_size in
memblock_alloc_try_nid_raw for skipping struct page initialization to
using MEMBLOCK_RSRV_NOINIT flag



Usama Arif (6):
  mm: hugetlb: Skip prep of tail pages when HVO is enabled
  mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
  memblock: pass memblock_type to memblock_setclr_flag
  memblock: introduce MEMBLOCK_RSRV_NOINIT flag
  mm: move allocation of gigantic hstates to the start of mm_core_init
  mm: hugetlb: Skip initialization of struct pages freed later by HVO

 include/linux/memblock.h |  9 +++++
 mm/hugetlb.c             | 71 +++++++++++++++++++++++++---------------
 mm/hugetlb_vmemmap.c     |  6 ++--
 mm/hugetlb_vmemmap.h     | 18 +++++++---
 mm/internal.h            |  9 +++++
 mm/memblock.c            | 45 +++++++++++++++++--------
 mm/mm_init.c             |  6 ++++
 7 files changed, 118 insertions(+), 46 deletions(-)

-- 
2.25.1

