Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35DA7BE9CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378251AbjJISjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378216AbjJISjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F5A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d866d13c637so6317834276.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876771; x=1697481571; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=rJVw0PRwWoWB1JfvSPLNZitx9J0lPvSXce12MjbCoJebzY1f9ObYixNey0ePBNFGfu
         k+lYGp4k8V7bZWyIhtZF87XDFupG6NLihJ/k8/6kLHwbifENW4htVxpYTIyzocosjnBD
         zi1BRAPqMy5DU/cb+BLUgRyLXV3jFcoQW5qaFBzzSbyhqCx7pgkBJouZ0CjLaixtELrp
         cxQ/xrh+S0k4ubh4VaeaDVdlkcuepGdD7Zyp51oQtxQBlLjvdiGNfUnFpfRM1xzmdXGM
         MO1x8FgShnL+xValM1rAQbHX/w8ozGFrtzMjX/rtNcAKSZhBmKazcwWpPPJ5C4y9eQuy
         /bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876771; x=1697481571;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=iAz4xOlXrT0x0cPmWCxEu3IyTrYVVv5OYjY6n/OdL/lL1IXo6NDty32J1R4gSMPPJA
         GKGwJdWsCFDMR5O/3VTdmIOe+LkI1g74MiCP1mtVJG28/37bv0cDs6/rqFnSqCHH/IQe
         lo6n+OhunmVOnVfou2BhhInd9FuyOCAgJplfZANzhxndauQH+oHsT91/AgaK8XetXPa6
         syJ7eSNmcNt4yyiya1Qkz/AzAMJ0IJSl5bPaqlX+yzFcLCnMHSc87f1jPN8ZAT5X9D4l
         vZo8U7lar19hWFd5nE3iBNZZ7GoqPnHe7VILJziYszGisA+pGneLgD8K0VZHeNXWYXGn
         A43w==
X-Gm-Message-State: AOJu0Yz87e8nQgS9G5nQ/Lq3SQV1Z3xBXIE9udK1iArdXEvjGNz5VyQS
        NN/C80b6fuQXeAtYWf0dRG3eMzMg6jVT
X-Google-Smtp-Source: AGHT+IGj936HBpMxd79H02f/BbU/72frkk4HM9RAto5NleLe3XJS2mgffVtBe63zJHi0k9rP3973otb4eFsT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:6881:0:b0:d89:4776:5d6b with SMTP id
 d123-20020a256881000000b00d8947765d6bmr254778ybc.5.1696876771177; Mon, 09 Oct
 2023 11:39:31 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:03 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-3-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 02/18] gen_compile_commands: Sort output compile commands
 by file name
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the output more stable and deterministic.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index b43f9149893c..180952fb91c1 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -221,7 +221,7 @@ def main():
                                      cmdfile, err)
 
     with open(output, 'wt') as f:
-        json.dump(compile_commands, f, indent=2, sort_keys=True)
+        json.dump(sorted(compile_commands, key=lambda x: x["file"]), f, indent=2, sort_keys=True)
 
 
 if __name__ == '__main__':
-- 
2.42.0.609.gbb76f46606-goog

