Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2313807DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443068AbjLGBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442958AbjLGBTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:19:21 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70826AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:50 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d988d69812so2008767b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911929; x=1702516729; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpIxg4nqFiCoM7pb7LX1eOoCjvBevBq2O8IO0Pdf/d8=;
        b=zFns5eF/J7nWm3yb3m0c7b7QTNuhSpntBvAZhyVKMBGL/6KrZkX6K3Fih1hykC7T8+
         OstSZNXAMN2DDtkYIhizIGX7EyCj7Qnp3MW27OHT+mTgEK1rIUYvnRuldS3lL0kmU8gZ
         Fygrs5SltVxomP3tPBu2Icu0FlPBgsJsIU/iv9f28yN+Oq537Xm5T1WsXaOkRSAJ1zyX
         lxsLKwy/mNsRcDYB9VLG1uHuh3eXQFwoCm24WLditXnvztm+nuN5VkwvclBl67KCarPc
         qX3eX1A185fxBYZT1xf/5ieBfxAsq24Mdp40acCm+QK5sfJzbmXMHa8cHBt2wyta4FPu
         bNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911929; x=1702516729;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpIxg4nqFiCoM7pb7LX1eOoCjvBevBq2O8IO0Pdf/d8=;
        b=uJcSuNHaNp2LPJWAYptGsTLtdW381mCIJ2jgl8faRN/Cv/7VH2Iyluhw61qsYBpgnM
         eHlv7lniBDJdJ9t9m7giz+zs+56XWpqmUUFFnLe2YcFkt0NzEZvsA+KPVVfrV0hVg4FN
         kM8luBxmzXU73QRZoGg9lgTSglceXCXmns1TzCApbDI0QYvztmSM4UOiY7+LBGpqZ6li
         LdUcEuWURrjpxBkUcdH8L/4oTq5GyZw3DyF6ps3mPza8/qF8Yi6/nJ5N09XGPku/+2N/
         xJZyWyE9Hz0DWEaDo0tCmJkCazLza0j1clRN646GQbVKLRVRfU3wXbvlzRdsNDYItFa6
         KFHg==
X-Gm-Message-State: AOJu0YzfMcH/PYcaj9NupVIn6gKEGy7JlT6C7JlwpeIZUvLME4jc1WfH
        eVe1Dey3VVgVqjwdJQg1V+gqUIb2ukmM
X-Google-Smtp-Source: AGHT+IGtbxDmn4dp4bvZz8MF8EKrsVbUvpFnaIZDxuseidIJVznot8lanb2j5lGnira4v+d8lCr0BOKV5s+J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:af28:0:b0:5d8:eec5:f57c with SMTP id
 n40-20020a81af28000000b005d8eec5f57cmr28157ywh.4.1701911928989; Wed, 06 Dec
 2023 17:18:48 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:17:09 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-36-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 35/47] perf threads: Reduce table size from 256 to 8
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.43.0.rc2.451.g8631bc7472-goog

