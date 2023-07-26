Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3217B7637B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGZNgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGZNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:36:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6A1734;
        Wed, 26 Jul 2023 06:36:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb81809ca8so35380325ad.3;
        Wed, 26 Jul 2023 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690378609; x=1690983409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gYgt2/L5v2iTxYlRyElhhZxpEQdszhBpRfoZ9bvFiQ0=;
        b=cc+iIay/ECUUq2pHo33gxd4ADnap2aPJzZM2OBywjK7f+VDRd1WJuOxS7c6n9Q7ZYX
         fR4V3H1u8u+4i4JlE5fZwItEwJ8c5gLPRtmyo4wIGDY4I74cL9fi0puRyvoPVDG5kchY
         MIdU+wVuzneuLtM5doFCVEuZuvGwpdAvIbcflbNd+WB+bVKPyaxKU46Y5Sw05gCDtmOJ
         l6anyIffgIvqiITu4Bns3vF7CAsi8KZFdlHTS8EPisT85e5Vxw+6grzUvglcRdOR0hKU
         bUxryPE8Il+DhsnQv6g9XDQA1JOca6j/I9LS6MN1zNm47Mdo9qab6hDwxGv0LsBnUtmU
         YGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378609; x=1690983409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYgt2/L5v2iTxYlRyElhhZxpEQdszhBpRfoZ9bvFiQ0=;
        b=G1NNdhkpQvkvtA2wkj2UO6RFn578CXuX0RCGF10UUiJ06jzFQZHkLa7bSqDMcOH1EF
         MAppjIX6LMqBSFeI0bUwq+IEvL2uk7AZEw3CfwsU6xse7lk+BRIPzftJNUlBQHqnXQNK
         m4xsnEPd3pcjmPBj9F5P6xfRZj/CLb9jv4KHhy3De9OvGWITWRHM78ItuEIo7xEX0rrD
         V06ZJA8XeOsr97zOmgjXPY0W3dX02C8QGfK1HGR2S8m0ilXOtrilfdpILpaDPhlb7iO5
         7SmVZ8fiK6UX8OovQhRk/voH5haZ0wBmLy7goimgsANw+sYHFOvkUVmuw3wcUvIRuecG
         ZR/g==
X-Gm-Message-State: ABy/qLZ+VJqXO07FbOM/N+Q4wcdM1hcC+xztI54NmJG08WVR8bKrCKXa
        21G3tW4sHU9XfwtehH1ARZg=
X-Google-Smtp-Source: APBJJlEpN1bPsnxPRND9LmzHt5o47i8k3Fn9HUNUfEcvha9GSBEaVJ0F0bDgj9ExYJlu7Ub8tl8QCw==
X-Received: by 2002:a17:902:b08a:b0:1b8:c972:606c with SMTP id p10-20020a170902b08a00b001b8c972606cmr1869361plr.57.1690378608925;
        Wed, 26 Jul 2023 06:36:48 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([114.129.115.132])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902b10800b001b8baa83639sm13206369plr.200.2023.07.26.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:36:48 -0700 (PDT)
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
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] perf build: Update build rule for generated files
Date:   Wed, 26 Jul 2023 06:36:41 -0700
Message-ID: <20230726133642.750342-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bison and flex generate C files from the source (.y and .l)
files.  When O= option is used, they are saved in a separate directory
but the default build rule assumes the .C files are in the source
directory.  So it might read invalid file if there are generated files
from an old version.  The same is true for the pmu-events files.

For example, the following command would cause a build failure:

  $ git checkout v6.3
  $ make -C tools/perf  # build in the same directory

  $ git checkout v6.5-rc2
  $ mkdir build  # create a build directory
  $ make -C tools/perf O=build  # build in a different directory but it
                                # refers files in the source directory

Let's update the build rule to specify those cases explicitly to depend
on the files in the output directory.

Note that it's not a complete fix and it needs the next patch for the
include path too.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/build/Makefile.build  | 8 ++++++++
 tools/perf/pmu-events/Build | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 89430338a3d9..f9396696fcbf 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -117,6 +117,14 @@ $(OUTPUT)%.s: %.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_s_c)
 
+$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
+
+$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
+
 # Gather build data:
 #   obj-y        - list of build objects
 #   subdir-y     - list of directories to nest
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 150765f2baee..f38a27765604 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -35,3 +35,7 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
+
+$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
-- 
2.41.0.487.g6d72f3e995-goog

