Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F77BAF3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjJEXL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJEXJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E0133
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59ee66806d7so21705687b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547341; x=1697152141; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=0Z0reX4geR/cSknipaVM50KlvfEYYwo4gqWkdh+0Kxnm+ei7ORA6KATmihXv46NRiD
         odQSiVRni2UVxz3GFJihdgGtnaLj0DaEMhd9514EYS5BAYxzBUW/vkfpISY9StziFmQV
         KMYRXBHVoyUAvPrZIpK8lql5WIjs6/REwRuc9s1m3YTgcmL3QVU19SJSXKzX04vNUscn
         Rcb8Fq54cHIR/Q2j3LR7nS+I3U25dZ4fgtlepSj4TuvKgLMf/Qe35QB75hhWgqYOi662
         ic5iuHSx+1tuRRM1iFPJl4Jfhpw1VJjkvu+gaARkOOHIxw4aVGuhhEu2UZyERRUbTEzC
         W+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547341; x=1697152141;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnnQkZcbskEopBJnxGh+Vcp7ouLVD/1W8b2XeUOooQY=;
        b=TZ5a6iZAuqkoagfRpEIhdCgIVR+9qPoLW5Bwz+vcUqH3gQ1TyhE3B3RAFeD+3CwVGV
         znKgqpKCTucVnA8O5oguCbvuPO8ryErPGW8yFufKZBfaGmEDiewJYw1Fre/DosR92F27
         xUiTuyhTgFr4FlZ+oRfUlw11nkaKMtp7Qu8Gt/f0BAelnp3OrApSVbE+s2ldXMN4gvF9
         z6noVh+C8zBUigJ4Dc1v4lTAv2f5F0kUV+9+unND9JEsat2ZQoykKIjzfcsDT2pHvt4k
         gKyAys/HHYNAbsfXjqxDCaRQQDg+CkudXIZ3vm2hkzOpWPDvyh/ZcVYP+bKwD6UHmBgK
         cC3w==
X-Gm-Message-State: AOJu0YzMJzn45I13RlKal2xmsMGUDcLcErM05Q5WcgWG3zvRCFgVAV2M
        KASerzprGP65woPA9MNYtKkmn3VLTMgV
X-Google-Smtp-Source: AGHT+IEq5EgGgGfFQhFuBi8DznGe/koY92/hRN8c1uDlC9VFhaJLStShPDnueShOCjNEO4Bz7a83VK6LLkIx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a5b:584:0:b0:d7b:94f5:1301 with SMTP id
 l4-20020a5b0584000000b00d7b94f51301mr103920ybp.9.1696547341616; Thu, 05 Oct
 2023 16:09:01 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:35 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-3-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 02/18] gen_compile_commands: Sort output compile commands
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
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
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

