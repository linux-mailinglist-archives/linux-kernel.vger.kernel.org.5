Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF61C808ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443336AbjLGOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjLGOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:41:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC69DAC;
        Thu,  7 Dec 2023 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701960125; x=1733496125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vLqATef+nIbcTZFucleeWysxy0TTQdwHZ88h8SHZ8vg=;
  b=mqfvnj+jw3dk/Sxem+YgKIQsyE83XLyes+fJ4+W889D4mmM3hXhVU9QA
   Bc8ltNfcbctUN4o2vtpePqIsQRNE96tsMMATngfq9BuJeRZrzD7iOJpXC
   PSQ5TLv/gAGFy0Ke1MncpMw1x13cNjS434pJol9qh94VokiwvZPmLcpa5
   DI5lDFwJEKuLTdd0sEKNKW+nUjVMr9blqhdi8vvs/AB8n37fNg5MNBmTw
   4CRNJ20JgNKrm8LgzvggETE9sbZ2x7Hjz+JuSzA+kenrVcVvbKzWaiody
   vUvPn7R9nDhGfpJ7mbgh6v+05e7rmtYeLqSiz5Y2X7tTKYNv/oHsIbt2P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397031013"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="397031013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:42:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="13128488"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:42:06 -0800
Received: from [10.212.103.45] (kliang2-mobl1.ccr.corp.intel.com [10.212.103.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EA7D0580201;
        Thu,  7 Dec 2023 06:42:02 -0800 (PST)
Message-ID: <b4e6f20c-9845-4114-8f48-ef1f46869a09@linux.intel.com>
Date:   Thu, 7 Dec 2023 09:42:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] perf mem: Clean up perf_mem_events__ptr()
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <20231206201324.184059-3-kan.liang@linux.intel.com>
 <CAP-5=fUhaOgMZuhhsmjkTL6QqEQzcjq9GjJyteLG5RTWuBQ0gg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUhaOgMZuhhsmjkTL6QqEQzcjq9GjJyteLG5RTWuBQ0gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-06 4:04 p.m., Ian Rogers wrote:
>>                  * The load and store operations are required, use the event
>>                  * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
>> @@ -3289,15 +3303,15 @@ static int perf_c2c__record(int argc, const char **argv)
>>                         e->record = true;
>>                         rec_argv[i++] = "-W";
>>                 } else {
>> -                       e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
>> +                       e = perf_mem_events__ptr(pmu, PERF_MEM_EVENTS__LOAD);
> Fwiw, it seems strange in cases like this that the function isn't:
> perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD)

Not just this one. The PMU is also added into other functions.
I will change the name for all of them in V2.

diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 8c5694b2d0b0..0ad301a2e424 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -36,14 +36,15 @@ enum {
 extern unsigned int perf_mem_events__loads_ldlat;
 extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];

-int perf_mem_events__parse(const char *str);
-int perf_mem_events__init(void);
+int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
+int perf_pmu__mem_events_init(struct perf_pmu *pmu);

 const char *perf_mem_events__name(int i, const char *pmu_name);
-struct perf_mem_event *perf_mem_events__ptr(int i);
+struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu,
int i);
+struct perf_pmu *perf_mem_events_find_pmu(void);
 bool is_mem_loads_aux_event(struct evsel *leader);

-void perf_mem_events__list(void);
+void perf_pmu__mem_events_list(struct perf_pmu *pmu);
 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
                                 char **rec_tmp, int *tmp_nr);

Thanks,
Kan

