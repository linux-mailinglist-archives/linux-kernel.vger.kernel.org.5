Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903BF7E095C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377317AbjKCTTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjKCTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:19:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE918D60;
        Fri,  3 Nov 2023 12:19:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso2270803a91.0;
        Fri, 03 Nov 2023 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699039151; x=1699643951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=A/lpgYKX/gR35qBoWxiaOvO5gEklUt5pUGK1IY4URpI=;
        b=LLPb5pI0ry9vw5ATA9rFnErDoMd+x2lGH/r3LGldi6h1LiwFn7zpBWRV/byaBpu5Lp
         X+hoxlgJNzFhToW6hRQi0NXRMGGwi0JoVnUgzLnnCBipj5glioS0s2usDKPVt3vAArZN
         aKpuJQMAuGwNRUsPZPdq84pWF9F7+SqR86inqPqCDtVqaZ1JwRmzcIN67a/lyRzjEEcn
         xxeLviKGZf9MqZhkWRuP+lCtwdDFcdSKGoVV/JcBY62z3OdkfEHMS8p1H0FBMdt2sp7K
         q9teRKCooNM3CRKS9SyHZWQEbhsbDivptYnO6uUiGZ0TKUkic9bBzXl7qpPCzZ3Iz08s
         RTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039151; x=1699643951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/lpgYKX/gR35qBoWxiaOvO5gEklUt5pUGK1IY4URpI=;
        b=SWhHEcBx3ID7Sxbo2pEwH/fw51TZY2HKh9hsctqvZGhCYkxkiLBtcXJCqtk1pTEOyk
         VKaX6/pywukuEBbdpwL+2ODMdywSi3KdgE2alwp1g7dlE/e+OZ7rlyJgk2evAT31sN+h
         tKUB/lyxa/YllVyboACKRUA6eBXsTOvJ25sbK5UQCSZQP3xXiHmxeRyE+ks2jNqAdFBU
         RMmQmK/kvIirR+OsqjXd27aJCpHtXbuv32f2AvINem2e293oXg7ZI/6efJWlddQMZF5c
         DLYZUtvvIVdQAJZm11Zpzk95BKyLy+vFnQYLW6dO5ruT/1GVwjMfGJjVMoGLd0exWX6M
         p4aw==
X-Gm-Message-State: AOJu0YziVdmqK7K8TvcMSevObFsrO3FGrHXGTFv7irOV2IzPsvj8ned5
        ctaW0GxM6d9HPKMOB+k+cs0=
X-Google-Smtp-Source: AGHT+IGmUsnpJVdKcmG7uFjZ2O9KNZGMpVDIPEooC8azFogL4lbOXFiXWEHOiuqleXFuo2QuA15d0w==
X-Received: by 2002:a17:90a:17a2:b0:27c:fe72:6e9 with SMTP id q31-20020a17090a17a200b0027cfe7206e9mr19234826pja.27.1699039151179;
        Fri, 03 Nov 2023 12:19:11 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:8234:4ed3:2635:c9d6])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090aca9100b0027cf4c554dasm1761349pjt.11.2023.11.03.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 12:19:09 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCHSET 0/5] perf annotate: Reduce memory footprint (v2)
Date:   Fri,  3 Nov 2023 12:19:02 -0700
Message-ID: <20231103191907.54531-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a part of my work to improve perf annotate.  At first, I'd
like reduce the size of struct annotation which will be allocated
together with struct symbol in some cases.  In fact, it doesn't use
most of them so it needs to slim down and lazy-allocate used part.

* v2 changes)
 - fix typo
 - reorder struct annotated_source
 - add Ian's Reviewed-by tags
 
With this applied, size of the struct goes down from 96 to 48.

The code is available at perf/annotate-diet-v2 branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (5):
  perf annotate: Split struct cycles_info
  perf annotate: Split struct annotated_branch
  perf annotate: Move max_coverage to annotated_branch
  perf annotate: Move some fields to annotated_source
  perf annotate: Move offsets to annotated_source

 tools/perf/builtin-annotate.c     |   7 +-
 tools/perf/ui/browsers/annotate.c |  18 ++--
 tools/perf/util/annotate.c        | 162 ++++++++++++++++--------------
 tools/perf/util/annotate.h        |  49 +++++----
 tools/perf/util/block-info.c      |   4 +-
 tools/perf/util/block-range.c     |   7 +-
 tools/perf/util/sort.c            |  14 +--
 7 files changed, 147 insertions(+), 114 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

