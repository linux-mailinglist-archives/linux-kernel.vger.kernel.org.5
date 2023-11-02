Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445137DFC5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377495AbjKBW1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377485AbjKBW06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:26:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3914FB7;
        Thu,  2 Nov 2023 15:26:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5b9a7357553so1177908a12.0;
        Thu, 02 Nov 2023 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698964015; x=1699568815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TjmpE0gPA0E82Gx4VbLnVe9nx66Z7Ry4rmjC/WuSGb0=;
        b=gS57c+lY2XVefQFdw3VkeOsR7hMrJ3kN+XzP/XjsGZtsBGggbspv2mr3vgNat8G/UO
         jh8JC+TDu30CVF9O/ZA7ZSbQDtWeO2S5qJHuVprm/8e8XlSai5wK9m13WQQfC+bWWfw0
         74SBTqXrbMDN4Mq5yD7WW/NzF3vh6A+8436bEELLLdiEiLaAP4FW0ie8ImUbAIEPPDyy
         Iw3fYPTgyf7Lji3+EGats5h+H7NclHXBQHGZo5iD3p2S/yp/eSdZrWbMNnwbwWp9b8fp
         uqUztU1PxcYAAqFb9xMmGl/kVuVghaSDd9/M7MFbkO2nuYLlSgt+ka1RDdYddM4haGFR
         FIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964015; x=1699568815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjmpE0gPA0E82Gx4VbLnVe9nx66Z7Ry4rmjC/WuSGb0=;
        b=MTsy/LM6GkgJojWxYUmcXjRhDVPAUwnyF0vOQEGctgN0vSied+uWrvCy7VNzmIGO3k
         tTH6cLAuPZ4h4OL77A53bm139XbKXxlXBMemuqPH9oDbb/yXSVCBF6moI4e5cBi9GUJ6
         skFhuMIFiMwsIgG5GMXR0hDZZ9FjDeX/Ygo0eVHEOLqRfBOnpM5v1YjD5fYovjka2SGq
         OFC3EcQ/ISdWKB/FYmdaoXIIjQlsm/gAgYDr6GpFcSaQ/zoKqmWjEisaloIq7ESOtZfX
         LBiICXohOHiAqODf3VK03iSrx4TRryRvUSfrzwD/jTN0+QXaRobhIo3wETtHBIxwfJMO
         500Q==
X-Gm-Message-State: AOJu0Yz4I78iHUoTXLub0tFOMUxcYaOicDF6r/0z95hEfDkpFPc3h69F
        08z2d25SUv0dQwp+p8shd7nfgmuo76k=
X-Google-Smtp-Source: AGHT+IGjYGhw65tppYI5b+jq41E6cHakr+ooY+rEmjqbJzBIZz4hiBipZdHhX+60qcK0lZOtwVyQdg==
X-Received: by 2002:a17:90b:4f91:b0:27d:3f0c:f087 with SMTP id qe17-20020a17090b4f9100b0027d3f0cf087mr19355978pjb.25.1698964015475;
        Thu, 02 Nov 2023 15:26:55 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:ea22:bed1:d67b:af04])
        by smtp.gmail.com with ESMTPSA id cn18-20020a17090af09200b0027d015c365csm309894pjb.31.2023.11.02.15.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:26:55 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/5] perf annotate: Reduce memory footprint (v1)
Date:   Thu,  2 Nov 2023 15:26:48 -0700
Message-ID: <20231102222653.4165959-1-namhyung@kernel.org>
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

With this applied, size of the struct goes down from 96 to 48.

The code is available at perf/annotate-diet-v1 branch in

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

