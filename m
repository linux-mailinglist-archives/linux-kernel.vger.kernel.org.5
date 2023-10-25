Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6307D7356
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjJYSfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJYSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:35:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540B111;
        Wed, 25 Oct 2023 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698258914; x=1729794914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oaYHGFnltjKVxa0IyIyg4So3Eyo7jYfErQk25FAvYl4=;
  b=hLkA/5F+1/z5PxGwmxMx4PPEcXnxnNRFF++qDpl2R+0sMjQ/cEqrVSz7
   pYlXCJeemL0A8lEGPNfAVlOu6OzORqJ7Rm1L6N2Q+9p7bCIIzPXJQpJPT
   sSVO8YogBT/pMRnedmf9qqL+neKGZ5dqr/di1JfQ+dbZea3EDUz1RdjPH
   oYFjV7fPPQRc/5fwELqTTPmkYzHyEsHS4tyCaUUgo9qOKcB9WhqqKbDwZ
   YsvSYmNqRzMOJXspRsrzfbxP66DDQlHIwoIEADKRMupxTi0P1eirv4qIp
   KmKNRO4hiLnJwZQvTV3fVB1/qoM4Edrkme4fa5nABzVtFOtCbu9JNJtan
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384584102"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384584102"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1006109244"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1006109244"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.107])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:35:06 -0700
Message-ID: <739ae8a0-e3fc-4281-bfc2-41d97a876739@intel.com>
Date:   Wed, 25 Oct 2023 21:35:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/50] perf record: Lazy load kernel symbols
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231024222353.3024098-1-irogers@google.com>
 <20231024222353.3024098-13-irogers@google.com>
 <CAM9d7cjsnEQ5Ns45HbFfDbOtFerAhFnzasyRP2Qow-=vOAJTwQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cjsnEQ5Ns45HbFfDbOtFerAhFnzasyRP2Qow-=vOAJTwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/23 21:25, Namhyung Kim wrote:
> Hi Ian,
> 
> On Tue, Oct 24, 2023 at 3:24 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
>> changed it so that loading a kernel dso would cause the symbols for
>> the dso to be eagerly loaded. For perf record this is overhead as the
>> symbols won't be used. Add a symbol_conf to control the behavior and
>> disable it for perf record and perf inject.
> 
> I'm curious if it can simply move to lazy loading unconditionally.
> In most cases, the code calls machine__resolve() which calls
> thread__find_map() and map__find_symbol() to load symbols.
> 
> So I think it's unnecessary to do it in the thread__find_map().
> If it needs a symbol, it should call map__find_symbol() first
> and it'll load the symbol table.
> 
> Adrian, what's special in inject or Intel-PT on this?

Was a long time ago.  Apart from what the commit says below,
I think there might also be other changes to the kernel maps
that happen at loading, but I would have to have a look.

commit 5b7ba82a75915e739709d0ace4bb559cb280db09
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Wed Aug 7 14:38:46 2013 +0300

    perf symbols: Load kernel maps before using
    
    In order to use kernel maps to read object code, those maps must be
    adjusted to map to the dso file offset.  Because lazy-initialization is
    used, that is not done until symbols are loaded.  However the maps are
    first used by thread__find_addr_map() before symbols are loaded.  So
    this patch changes thread__find_addr() to "load" kernel maps before
    using them.



> 
> Thanks,
> Namhyung
> 
> 
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/builtin-inject.c   | 6 ++++++
>>  tools/perf/builtin-record.c   | 2 ++
>>  tools/perf/util/event.c       | 4 ++--
>>  tools/perf/util/symbol_conf.h | 3 ++-
>>  4 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>> index c8cf2fdd9cff..eb3ef5c24b66 100644
>> --- a/tools/perf/builtin-inject.c
>> +++ b/tools/perf/builtin-inject.c
>> @@ -2265,6 +2265,12 @@ int cmd_inject(int argc, const char **argv)
>>                 "perf inject [<options>]",
>>                 NULL
>>         };
>> +
>> +       if (!inject.itrace_synth_opts.set) {
>> +               /* Disable eager loading of kernel symbols that adds overhead to perf inject. */
>> +               symbol_conf.lazy_load_kernel_maps = true;
>> +       }
>> +
>>  #ifndef HAVE_JITDUMP
>>         set_option_nobuild(options, 'j', "jit", "NO_LIBELF=1", true);
>>  #endif
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index dcf288a4fb9a..8ec818568662 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -3989,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
>>  # undef set_nobuild
>>  #endif
>>
>> +       /* Disable eager loading of kernel symbols that adds overhead to perf record. */
>> +       symbol_conf.lazy_load_kernel_maps = true;
>>         rec->opts.affinity = PERF_AFFINITY_SYS;
>>
>>         rec->evlist = evlist__new();
>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> index 923c0fb15122..68f45e9e63b6 100644
>> --- a/tools/perf/util/event.c
>> +++ b/tools/perf/util/event.c
>> @@ -617,13 +617,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>>         if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
>>                 al->level = 'k';
>>                 maps = machine__kernel_maps(machine);
>> -               load_map = true;
>> +               load_map = !symbol_conf.lazy_load_kernel_maps;
>>         } else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
>>                 al->level = '.';
>>         } else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
>>                 al->level = 'g';
>>                 maps = machine__kernel_maps(machine);
>> -               load_map = true;
>> +               load_map = !symbol_conf.lazy_load_kernel_maps;
>>         } else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
>>                 al->level = 'u';
>>         } else {
>> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
>> index 0b589570d1d0..2b2fb9e224b0 100644
>> --- a/tools/perf/util/symbol_conf.h
>> +++ b/tools/perf/util/symbol_conf.h
>> @@ -42,7 +42,8 @@ struct symbol_conf {
>>                         inline_name,
>>                         disable_add2line_warn,
>>                         buildid_mmap2,
>> -                       guest_code;
>> +                       guest_code,
>> +                       lazy_load_kernel_maps;
>>         const char      *vmlinux_name,
>>                         *kallsyms_name,
>>                         *source_prefix,
>> --
>> 2.42.0.758.gaed0368e0e-goog
>>

