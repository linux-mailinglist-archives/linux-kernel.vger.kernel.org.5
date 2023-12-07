Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F8807DAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441990AbjLGBR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441968AbjLGBRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:17:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F3F10D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:17:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d7e7e10231so1128767b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911849; x=1702516649; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwUZYyK0Ujy/qNX/TFIi+04XnhZ1QaUR4WIBvLcrqEc=;
        b=av+IemWZ1ObNifkU9XUiDGYnbgA7KZxdubWFjauvMpPdmtrrEpccv3lLGrt4XC1sVd
         Zhu0Ul6FryaOfFSG2KLabjS9r2qNlPFE2cT2d7sViiDxThHn+0HFBF9umBj0qBm/MvY8
         GCq7rJgTUfeQTkRMqYYap4RAydaUecwaibByJCVEktb6tZDPQxqolOoMIFEclm/rQEP7
         7VB2X0j0WoSJROu1zwCOz01dRaB2zYOBb5nhhYDsg9rTyO7doG0WOdm5vfKdBOPAhgOC
         tmH/NBZSSEM0N9o/1fEmwN/ivoxeGmzoFNsIJIqkE3JsWWY+NT2UMIa1ydPz11Sjlj+8
         WbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911849; x=1702516649;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwUZYyK0Ujy/qNX/TFIi+04XnhZ1QaUR4WIBvLcrqEc=;
        b=tzotBOy3w321oh+CewVHQn0c68Taz3Lv5GlWBgo7I4m1l4onUXPblZA5eBvSkf4/9K
         zcqOEO8JGkb+oWGXjOmtzHOdiCyDIn9C6giEP+F5onTAQVVDOVi8e1eOOZF4YcyMS3cE
         TJRnVhIJQSWJu1sirNIDF5SQVhcUkIla7s3lGvJ+rndMab8ukb/oKMMy/TiH3ysAG5tK
         ERVIr1sPAqjzxEMD8iwy4H8/maNrq3lbuUL7NYiyBNdHX0zMUXa+lD7WlmUsydjq2mSL
         d4puXCwB8kFqLE/NaAWuDrJwSuqzuPG/8lfT3KkdgS0qU9w21d1ny8HiOG2wRiAYYue3
         hIgw==
X-Gm-Message-State: AOJu0YxDsaY+aipl2BCjk+/MrF4DpCqB8yYenGEfGvMQezUiJDR891JP
        azfJekIuVdm+usEFigp6qRFcbxnZ3FRZ
X-Google-Smtp-Source: AGHT+IHvn4MNpMVKgpm4EqbTDNH7nndDq/7QojZH52C5pszqDkaNVs/YfjgX2hoGBWPXTOfpK9M5fqytqSL0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:b658:0:b0:5d3:ffa2:56ec with SMTP id
 h24-20020a81b658000000b005d3ffa256ecmr126424ywk.1.1701911849559; Wed, 06 Dec
 2023 17:17:29 -0800 (PST)
Date:   Wed,  6 Dec 2023 17:16:35 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-2-irogers@google.com>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 01/47] perf map: Improve map/unmap parameter names
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

The u64 values are either absolute or relative, try to hint better in
the parameter names.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 3a3b7757da5f..49756716cb13 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -105,25 +105,25 @@ static inline u64 map__dso_map_ip(const struct map *map, u64 ip)
 }
 
 /* dso rip -> ip */
-static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
+static inline u64 map__dso_unmap_ip(const struct map *map, u64 rip)
 {
-	return ip + map__start(map) - map__pgoff(map);
+	return rip + map__start(map) - map__pgoff(map);
 }
 
-static inline u64 map__map_ip(const struct map *map, u64 ip)
+static inline u64 map__map_ip(const struct map *map, u64 ip_or_rip)
 {
 	if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
-		return map__dso_map_ip(map, ip);
+		return map__dso_map_ip(map, ip_or_rip);
 	else
-		return ip;
+		return ip_or_rip;
 }
 
-static inline u64 map__unmap_ip(const struct map *map, u64 ip)
+static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip)
 {
 	if ((RC_CHK_ACCESS(map)->mapping_type) == MAPPING_TYPE__DSO)
-		return map__dso_unmap_ip(map, ip);
+		return map__dso_unmap_ip(map, ip_or_rip);
 	else
-		return ip;
+		return ip_or_rip;
 }
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
-- 
2.43.0.rc2.451.g8631bc7472-goog

