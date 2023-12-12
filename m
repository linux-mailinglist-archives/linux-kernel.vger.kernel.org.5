Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857880E4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjLLHFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLLHFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:05:43 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C5D0;
        Mon, 11 Dec 2023 23:05:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cda22140f2so4626996b3a.1;
        Mon, 11 Dec 2023 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702364750; x=1702969550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cSrzQ4FDDeqPwfBNWP1LcLTFq/yFZjcBCmoTNQG3Jbc=;
        b=QxFcJjjYIDnXD8IUvnNAiAfryIkdOrPDGo0qH2/XA9/Fnk9ktbHEQ+njmVDnumjcab
         TtKaubL530F80z7dq8mYxVe6lfP6I+OZmZvtfjNstC7WjYxYdoDQxR/rTV5zJokyxTUe
         e6P2zoKRTNkzvu33ppDiLZd/+dur8eUzzMuZBcsVGoQ0ZN3o1wjYabqDqi1G98BtwhW5
         idKXyHgw/4GdNuGwQxUssfLHlWMvHu7Vd96VehhjoCD8gs5EibeEURkl/SXzTMfFS7Ds
         2oqBeZLiXP76zUYNdpvIRTYYUW+s/DUE+q7wExubnxOS2hFFe01VWhtFkQ/bZHs6Lv/q
         VZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364750; x=1702969550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSrzQ4FDDeqPwfBNWP1LcLTFq/yFZjcBCmoTNQG3Jbc=;
        b=xSrCCpDKykl9PoyjOhkhWVC2McA7MZu7ofRpwdKegZIvll1ih1IaPAFccFINVT0ill
         w0l0DGwOah/gDAS3Y5DyDMlw1XCPgAptwnTslOTjHKhpx8q9zYuIP63jYdb08fgnkH6A
         L73uCMfiBbz384PhNuCmWXqsIfKmAziErzezO/06//6zYj9WxavHcg3b4zmMWv6pSt7c
         wyeSmWi4IlWSuI8mUX1OozZfx4zhkTvZZ/eSYW6C52Lhq14uWABRflfxfFYmDNlPwCRs
         FzYDTcm19tWUIg9IiH51yULWalxaj0Goh7xJmueomtFwa4jkxngqozcBEyYuIwbdNTTX
         iYTA==
X-Gm-Message-State: AOJu0YySjKOYrVxZMQrGXxL+PVIBOxy/cUoWqMOAndUVWJ0gokwOBiVL
        cccBhYZNdWDnS5lUga9I4wkbDYpO+KmO6w==
X-Google-Smtp-Source: AGHT+IECAOXD/0B+W79A1JJLZZXjjM6ziU0kkw9o9WVVRBBXjx1IEv5o3dwdJSk4XvSkOKpIiVt8zg==
X-Received: by 2002:a05:6a20:7d86:b0:18f:f86f:bcdb with SMTP id v6-20020a056a207d8600b0018ff86fbcdbmr6978625pzj.93.1702364749630;
        Mon, 11 Dec 2023 23:05:49 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7da0:5ec4:de63:3cf4])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a0023d100b006cb6e83bf7fsm7397491pfc.192.2023.12.11.23.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:05:49 -0800 (PST)
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
        Milian Wolff <milian.wolff@kdab.com>,
        Pablo Galindo <pablogsal@gmail.com>,
        Fangrui Song <maskray@google.com>
Subject: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
Date:   Mon, 11 Dec 2023 23:05:43 -0800
Message-ID: <20231212070547.612536-1-namhyung@kernel.org>
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

Hello,

I've found a couple of issues on the unwind code while I'm playing with
the JIT-dump code for the CPython.  The code assumes normal DSOs mapped
from the beginning of the file and aligned to the page size.  But it's
not true for the JIT-dumped DSOs which are generated for each function.

Depending on the JIT implementation, the code address and accompanied
ELF info (like ELF file headers and unwind info) can be overlapped to
adjacent (JIT-dumped) DSOs.  So it should take more care when it
calculates the mapping address for the DSO.

It seems these changes need to go to the stable trees but they are
changed a lot since then so I'm not sure.

Thanks,
Namhyung


Namhyung Kim (3):
  perf genelf: Set ELF program header addresses properly
  perf unwind-libdw: Handle JIT-generated DSOs properly
  perf unwind-libunwind: Fix base address for .eh_frame

 tools/perf/util/genelf.c                 |  6 +++---
 tools/perf/util/unwind-libdw.c           | 21 +++++++++++++++++----
 tools/perf/util/unwind-libunwind-local.c |  2 +-
 3 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

