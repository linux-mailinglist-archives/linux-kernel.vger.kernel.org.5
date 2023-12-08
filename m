Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5580AFD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjLHWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:32:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3259171D;
        Fri,  8 Dec 2023 14:33:04 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c6b9583dcbso2203321a12.2;
        Fri, 08 Dec 2023 14:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074784; x=1702679584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7/WtxgUAWS6Tp08MVlyJfenFT48ukqZMUj0ickzAyfY=;
        b=Z8psMDphgG7ou0YNxlFVX43rVHmyfli2Aai+HmEWZQuOxfhijfhcObF1Hy3cs2q8Xs
         8Vv93g4Vivh87bLKjs2XgeaB4SyRyIGc63CEUqyv8OpBzPgtU+BqNrJmumdwpJWk/6YN
         pgDG0xDHPj9tBM8BudnRpLXfhWI3qgqpAsc6xfASQZ1PG2MNjt/KtfZkn3EmWyRv4IZS
         c98UFtgK/q7SLEi6j+jwKE44StTKeOv5tlZwmtrcBDQz8ZhVM3A4A+SICwo5io7V93cw
         lK04+t2ndbUnBdXFOschRdx2ibmXuJv1cXIfduElChjKkNSifUXvXnROuAmiT3m9sTza
         0+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074784; x=1702679584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/WtxgUAWS6Tp08MVlyJfenFT48ukqZMUj0ickzAyfY=;
        b=va73gwHbn7pQiS1eFv9QuRkkhEig0NTRXoTiappbVKbdeZKPJBoq8IMZT2ob168rzc
         VOzc1ULLVnEtKQaBatIjIOxSdvGmRkwxKpqWQZjsfwTraXQ+t99qq6NYnVUVupv/1dtJ
         +VpHfqIXZhzK5cHte6cb3JUhTTR7Fe7AOBElGDl5cZ9g0b9CjFNZxWUJ3Lbn/xCCKBLd
         3lyqKtL0CCpiIg0RVa8MC4RndXDqDD97CwNwSNDf8/azktS5Wd1L2dFw55+Y0EJUD74B
         URoF0V7TxmrqK8zKA/FV1D7fIO+G9YNZEVWUgFa7/CLyY/7orcFyYXBEb+DPJDTSyZiJ
         FtnA==
X-Gm-Message-State: AOJu0Ywp1RMAUyZmdbxHLITXD4IxLxL2FsC4adKApdNupO6xxAqzPCcp
        H5dMYi0VS/T7xYCxRSD7co0=
X-Google-Smtp-Source: AGHT+IFVc692Bvw+Q0cSJPBmNMR6eyUAxX79wkgrwu2XgMRDR12eeYbcwdv1ouQwdnV1lxpGLq1xVA==
X-Received: by 2002:a05:6a20:3942:b0:18d:b43:78ea with SMTP id r2-20020a056a20394200b0018d0b4378eamr975811pzg.43.1702074784032;
        Fri, 08 Dec 2023 14:33:04 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:e1f1:b259:a950:f2ac])
        by smtp.gmail.com with ESMTPSA id ey2-20020a056a0038c200b006cbb75d87d2sm2101165pfb.6.2023.12.08.14.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:33:02 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf tools fixes for v6.7: 2nd batch
Date:   Fri,  8 Dec 2023 14:33:00 -0800
Message-ID: <20231208223300.3877553-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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

Hi Linus,

Please consider pulling the perf tools fixes.

Thanks,
Namhyung


The following changes since commit 57686a72da08ae555d93148aa8756b16417a6aff:

  tools: Disable __packed attribute compiler warning due to -Werror=attributes (2023-11-22 12:23:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.7-2-2023-12-08

for you to fetch changes up to b1693747487442984050eb0f462b83a3a8307525:

  perf list: Fix JSON segfault by setting the used skip_duplicate_pmus callback (2023-12-05 11:16:00 -0800)

----------------------------------------------------------------
perf tools fixes for v6.7: 2nd batch

A random set of small bug fixes including:

 * Fix segfault on AmpereOne due to missing default metricgroup name.
 * Fix segfault on `perf list --json` due to NULL pointer.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Ian Rogers (2):
      perf metrics: Avoid segv if default metricgroup isn't set
      perf list: Fix JSON segfault by setting the used skip_duplicate_pmus callback

Ilkka Koskinen (1):
      perf vendor events arm64: AmpereOne: Add missing DefaultMetricgroupName fields

 tools/perf/builtin-list.c                                      | 6 ++++++
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json | 2 ++
 tools/perf/util/metricgroup.c                                  | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)
