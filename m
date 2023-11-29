Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3DD7FE1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjK2VPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjK2VPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:15:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203DC1A8;
        Wed, 29 Nov 2023 13:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701292521; x=1732828521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LYQJ2kxOs+ySL55VSSD9xEF2a/IPV5Ke9VnU2n5ULHs=;
  b=Fl5mDbWG5qtn19VBcDC/kDohvy+FDxawOBW4iLAfZmRxMsZ9Vumth8rF
   lE0QLNyp/3NxFFh+QGiu9ETuf3y4tibJKyGDjIyob5oyEs75pN1ij8NHS
   kTw9pTc2jvKPSR45DJe5euVYnvp/sos4Kbkqh7i8L9xnYSZiixIKscCJs
   j2mpIcAkvGgh7Sj+OBYuRwYNOkSCj3UmAoKLdAPHxYVXbx65l3NP2Budh
   ZbG82a7ACucMR0swfgpdgDTe0rSRz2flkoGynKzv9jc33jUQYhkj/4aZG
   i3JGZgECGA79kFl6PdULPK3FYvzZIzOo6pairuBCVxTuoD7v6c58cAssf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="396036034"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="396036034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 13:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="912971018"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="912971018"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 13:15:20 -0800
Received: from [10.213.167.24] (kliang2-mobl1.ccr.corp.intel.com [10.213.167.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3F6205807E2;
        Wed, 29 Nov 2023 13:15:18 -0800 (PST)
Message-ID: <f5112f5e-c77c-4a9a-ac3b-66772adba471@linux.intel.com>
Date:   Wed, 29 Nov 2023 16:15:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf mem: Fix perf mem error on hybrid
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        mark.rutland@arm.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ammy Yi <ammy.yi@intel.com>
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
 <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com>
 <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com>
 <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-29 11:17 a.m., Ian Rogers wrote:
> On Wed, Nov 29, 2023 at 5:52 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-11-29 1:24 a.m., Ian Rogers wrote:
>>> On Tue, Nov 28, 2023 at 12:39 PM <kan.liang@linux.intel.com> wrote:
>>>>
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> The below error can be triggered on a hybrid machine.
>>>>
>>>>  $ perf mem record -t load sleep 1
>>>>  event syntax error: 'breakpoint/mem-loads,ldlat=30/P'
>>>>                                 \___ Bad event or PMU
>>>>
>>>>  Unable to find PMU or event on a PMU of 'breakpoint'
>>>>
>>>> In the perf_mem_events__record_args(), the current perf never checks the
>>>> availability of a mem event on a given PMU. All the PMUs will be added
>>>> to the perf mem event list. Perf errors out for the unsupported PMU.
>>>>
>>>> Extend perf_mem_event__supported() and take a PMU into account. Check
>>>> the mem event for each PMU before adding it to the perf mem event list.
>>>>
>>>> Optimize the perf_mem_events__init() a little bit. The function is to
>>>> check whether the mem events are supported in the system. It doesn't
>>>> need to scan all PMUs. Just return with the first supported PMU is good
>>>> enough.
>>>>
>>>> Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
>>>> Reported-by: Ammy Yi <ammy.yi@intel.com>
>>>> Tested-by: Ammy Yi <ammy.yi@intel.com>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>> ---
>>>>  tools/perf/util/mem-events.c | 25 ++++++++++++++-----------
>>>>  1 file changed, 14 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
>>>> index 954b235e12e5..3a2e3687878c 100644
>>>> --- a/tools/perf/util/mem-events.c
>>>> +++ b/tools/perf/util/mem-events.c
>>>> @@ -100,11 +100,14 @@ int perf_mem_events__parse(const char *str)
>>>>         return -1;
>>>>  }
>>>>
>>>> -static bool perf_mem_event__supported(const char *mnt, char *sysfs_name)
>>>> +static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *pmu,
>>>> +                                     struct perf_mem_event *e)
>>>>  {
>>>> +       char sysfs_name[100];
>>>>         char path[PATH_MAX];
>>>>         struct stat st;
>>>>
>>>> +       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
>>>
>>> Not sure if this is right. Looking at sysfs_name values:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/mem-events.c?h=perf-tools-next#n23
>>> "cpu/events/mem-loads" and "cpu/events/mem-stores", so won't pmu->name
>>> never be used?
>>> Is there a missed change to change the cpu to %s?
>>
>> There is a X86 specific perf_mem_events__ptr(), which uses the
>> "%s/mem-loads,ldlat=%u/P" and "%s/events/mem-loads" for Intel platforms.
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/mem-events.c?h=perf-tools-next#n20
>> The pmu->name is used especially for the hybrid platforms.
> 
> Right, that seems wrong. For one thing we're losing the compiler's
> format string argument checking, but hardcoding PMU names just seems
> to be something that will keep needing maintenance. This patch set
> looks to fix an Intel issue but in general it is increasing tech debt
> (or at least churning it) that will need cleaning up to do something
> with better error checking and more generic. perf_mem_event looks like
> a bad abstraction and then there are the integers whose special values
> hold meaning. Could this fix come with some cleanup? It wouldn't seem
> wrong to me to add notions of memory events to the PMU abstraction. As
> it stands this scnprintf looks wrong in non-Intel cases.
>

The problem is that different ARCHs check different things. Arm and AMD
checks the PMU name, while Intel and Power checks the specific events.
It's hard to have a unified scnprintf.

But we can abstract them into two cases, PMU name and event name. We use
a different scnprintf to handle them.
How about something as below?

diff --git a/tools/perf/arch/x86/util/mem-events.c
b/tools/perf/arch/x86/util/mem-events.c
index 191b372f9a2d..4ef70fb9132b 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -17,8 +17,8 @@ static char mem_stores_name[100];
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }

 static struct perf_mem_event
perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
-	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
+	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"events/mem-loads"),
+	E("ldlat-stores",	"%s/mem-stores/P",		"events/mem-stores"),
 	E(NULL,			NULL,				NULL),
 };

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3a2e3687878c..ba88cb3d804f 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -8,6 +8,7 @@
 #include <unistd.h>
 #include <api/fs/fs.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include "map_symbol.h"
 #include "mem-events.h"
 #include "debug.h"
@@ -20,8 +21,8 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }

 static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
+	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"events/mem-loads"),
+	E("ldlat-stores",	"cpu/mem-stores/P",		"events/mem-stores"),
 	E(NULL,			NULL,				NULL),
 };
 #undef E
@@ -103,12 +104,14 @@ int perf_mem_events__parse(const char *str)
 static bool perf_mem_event__supported(const char *mnt, struct perf_pmu
*pmu,
 				      struct perf_mem_event *e)
 {
-	char sysfs_name[100];
 	char path[PATH_MAX];
 	struct stat st;

-	scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
-	scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
+	if (strstarts(e->sysfs_name, "event/"))
+		scnprintf(path, PATH_MAX, "%s/devices/%s/%s", mnt, pmu->name,
e->sysfs_name);
+	else
+		scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, e->sysfs_name);
+
 	return !stat(path, &st);
 }


Thanks,
Kan

> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>>
>>> Thanks,
>>> Ian
>>>
>>>>         scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
>>>>         return !stat(path, &st);
>>>>  }
>>>> @@ -120,7 +123,6 @@ int perf_mem_events__init(void)
>>>>
>>>>         for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
>>>>                 struct perf_mem_event *e = perf_mem_events__ptr(j);
>>>> -               char sysfs_name[100];
>>>>                 struct perf_pmu *pmu = NULL;
>>>>
>>>>                 /*
>>>> @@ -136,12 +138,12 @@ int perf_mem_events__init(void)
>>>>                  * of core PMU.
>>>>                  */
>>>>                 while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>>>> -                       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->name);
>>>> -                       e->supported |= perf_mem_event__supported(mnt, sysfs_name);
>>>> +                       e->supported |= perf_mem_event__supported(mnt, pmu, e);
>>>> +                       if (e->supported) {
>>>> +                               found = true;
>>>> +                               break;
>>>> +                       }
>>>>                 }
>>>> -
>>>> -               if (e->supported)
>>>> -                       found = true;
>>>>         }
>>>>
>>>>         return found ? 0 : -ENOENT;
>>>> @@ -167,13 +169,10 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
>>>>                                                     int idx)
>>>>  {
>>>>         const char *mnt = sysfs__mount();
>>>> -       char sysfs_name[100];
>>>>         struct perf_pmu *pmu = NULL;
>>>>
>>>>         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>>>> -               scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
>>>> -                         pmu->name);
>>>> -               if (!perf_mem_event__supported(mnt, sysfs_name)) {
>>>> +               if (!perf_mem_event__supported(mnt, pmu, e)) {
>>>>                         pr_err("failed: event '%s' not supported\n",
>>>>                                perf_mem_events__name(idx, pmu->name));
>>>>                 }
>>>> @@ -183,6 +182,7 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
>>>>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>>>>                                  char **rec_tmp, int *tmp_nr)
>>>>  {
>>>> +       const char *mnt = sysfs__mount();
>>>>         int i = *argv_nr, k = 0;
>>>>         struct perf_mem_event *e;
>>>>
>>>> @@ -211,6 +211,9 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>>>>                         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
>>>>                                 const char *s = perf_mem_events__name(j, pmu->name);
>>>>
>>>> +                               if (!perf_mem_event__supported(mnt, pmu, e))
>>>> +                                       continue;
>>>> +
>>>>                                 rec_argv[i++] = "-e";
>>>>                                 if (s) {
>>>>                                         char *copy = strdup(s);
>>>> --
>>>> 2.35.1
>>>>
> 
