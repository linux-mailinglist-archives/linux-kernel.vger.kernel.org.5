Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93B807DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442154AbjLGBWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443028AbjLGBWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:22:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C07D69
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:18:19 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d8da78a5fbso1682717b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911898; x=1702516698; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=080Vne9luGbMZqG9+uC+XiM2BHOgF/5Ti1/3JRRVPt4=;
        b=p4eqo5INaoPbamFeVR49NReo+CxMmLU6+CG2r0+wdu5piDGHizYYEydMgsHRprRqzk
         7cE6EhfJu3s0tPKjPHVl/ZuIfIkdCYHyXvZMshC0CobrumfOTBKVblmEfHQl88XgHdq0
         yk954OC3RXiFjUHqhm3DOlDF/qmBQIlLkvNoBbNT23D2fbA9qEP6de1JqiU2lvH1KuJx
         lAGFB8eZ3lhsYaLC0trDhYpO6akM+YDoeJkxH6X/2tv2RMiA2KLDZGzQ5zx9NJQwa1NZ
         DN9Or8a4R+/J1R1VPEcCxMe5tEOVhB+qm7u2toDmgt++f7527HXsYg7nQfiqp6AAGIkd
         f+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911898; x=1702516698;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=080Vne9luGbMZqG9+uC+XiM2BHOgF/5Ti1/3JRRVPt4=;
        b=PhfG9K4beF0om+CpYbfaknXLRfi4FoEyCUV+c13/Fv+eKWXzsMpQsLAscj2Jlj5C0H
         NUut0dPhBOZSMKcVVBKrV9KHqbjsnlEGAjOwWQp/5fr3T8CyA1Xas5kghihk3l7eE1nA
         64nn1bOKdZvthelTlHRNfseJlbgW0CJqCCoveMfJGbrAkMYyREsHuHWdpCHYPTbenmM8
         u3tHrmUx0tWT7P2DlHmbi5Ibb0OAYsD2jmO5OS/EB0YAlQVy1Jve5idMt042CRWhXtHf
         ITPHnsfmtI+VmTOkxYretIQYZ1/bEQnuJI9kZcN4gt6T+ddB+Y4I9jmxpT/sagUj90Ns
         UNYA==
X-Gm-Message-State: AOJu0YxbTrz5UdRsXheFkO1zkig1fQAsUbsd90Dxubm7kyvsxJT/h4GK
        C00UL1hRV6SWwSm07EQuk4+lNlihl0ug
X-Google-Smtp-Source: AGHT+IF5aaRbwcv0XllHz91G60ZUSyZ9fr+69hP1CaRKexRfy4nKX+GDDlUbzuh4LVjq4Xl1k73n/zEbsEk3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:ad24:0:b0:5d9:20ac:5126 with SMTP id
 l36-20020a81ad24000000b005d920ac5126mr26333ywh.4.1701911898601; Wed, 06 Dec
 2023 17:18:18 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:56 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-23-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 22/47] perf maps: Fix up overlaps during fixup_end
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maps are sometimes made overlapping, in particular kernel maps. If the
end of a map overlaps the start of the next, shorten the overlapping
map. This should remove potential non-determinism in maps__find, ie
finding maps by address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index dcd67384d877..0334fc18d9c6 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -701,7 +701,7 @@ void maps__fixup_end(struct maps *maps)
 	down_write(maps__lock(maps));
 
 	maps__for_each_entry(maps, curr) {
-		if (prev != NULL && !map__end(prev->map))
+		if (prev && (!map__end(prev->map) || map__end(prev->map) > map__start(curr->map)))
 			map__set_end(prev->map, map__start(curr->map));
 
 		prev = curr;
-- 
2.43.0.rc2.451.g8631bc7472-goog

