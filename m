Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECCF7E6FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbjKIRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjKIRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:06:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7492726
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699549560; x=1731085560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5/RMAKu+i9jH0jqbckGtja20iqvG/TpYZA34SiapWbw=;
  b=Afl/pfDRa1iWnLixhR1A12wcXhBqx7bF5TGg3cmA1YwhKVtMvwlgf7fx
   wmmBpV7fEPePncxlh2TLqpO4Czm1QCC7LfMqu6bLyjlm8jk7/3+8XK+Dx
   e77gWciixRiY4G6OfHiGzrLf02CtdtZTkYRdMqLcMAl6DpJYf62B4A2MO
   N3nImR4WGy7lWT7A88lPEORrt1nTe/Uiq1CWNAut2mK4hor3yuSP1gXFB
   ry8WgkJIqu7v5S34quKwkebLBm9oGaW6LgjOQw2e4lfUqdIRT5yLFSSac
   8FAoc7seh0wUadnFu4fCL4hLs5gT0W+cf3xBe0bk66GCQbEP5Q3bJsrJ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="370233570"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="370233570"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4777646"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:05:31 -0800
Received: from [10.212.120.254] (kliang2-mobl1.ccr.corp.intel.com [10.212.120.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1A25F580DB0;
        Thu,  9 Nov 2023 09:05:29 -0800 (PST)
Message-ID: <7243048f-5f45-4f3d-9abb-626568359536@linux.intel.com>
Date:   Thu, 9 Nov 2023 12:05:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
 <ZUlWuROfYcYJlRn4@kernel.org>
 <fb1ebf48-ac2f-499a-b480-ba8474b12200@linux.intel.com>
 <ZUpTtoCzJFHhnSdh@kernel.org> <ZUv+G+w5EvJgQS45@kernel.org>
 <a40ff4eb-5507-45b9-9f21-1d153a544e16@linux.intel.com>
 <ZU0MvXe1GF6xejlf@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZU0MvXe1GF6xejlf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-09 11:45 a.m., Arnaldo Carvalho de Melo wrote:
> Em Thu, Nov 09, 2023 at 11:14:31AM -0500, Liang, Kan escreveu:
>>
>>
>> On 2023-11-08 4:31 p.m., Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Nov 07, 2023 at 12:11:50PM -0300, Arnaldo Carvalho de Melo es=
creveu:
>>>> Em Mon, Nov 06, 2023 at 04:19:13PM -0500, Liang, Kan escreveu:
>>>>> On 2023-11-06 4:12 p.m., Arnaldo Carvalho de Melo wrote:
>>>>>> Em Wed, Oct 25, 2023 at 01:16:20PM -0700, kan.liang@linux.intel.co=
m escreveu:
>>>>> Ian has already reviewed the tool parts.
>>>
>>>>> But I still owe a test case for the feature. I will post a patch la=
ter.
>>>>> https://lore.kernel.org/lkml/acbb895a-475e-4679-98fc-6b90c05a00af@l=
inux.intel.com/
>>>
>>>> I saw Ian's suggestion, and agree with it, we need to pair new featu=
res
>>>> with regression tests in 'perf test', thanks for working on it!
>>>
>>> Kan,
>>>
>>> 	I still have to bisect, but can you check if this works for you?
>>
>> The branch counters feature requires all the events to belong to a
>> group. There is no problem for the normal perf usage which usually
>> initializes an evlist even for a single evsel.
>> But perf test is special, which may not initialize an evlist. The Samp=
le
>> parsing test case is one of the examples. It crashes with the
>> !evsel->evlist.
>>
>> The below change should fix it. I will post a complete patch shortly.
>=20
> Thanks for the quick response, if all that is needed are the checks
> below, I'll fold it into your original patch:
>=20
> 2ae01908298426e4 perf tools: Add branch counter knob
>=20
> So that we don't regress, ok?

Sure.

I also post the patch to
https://lore.kernel.org/lkml/20231109164007.2037721-1-kan.liang@linux.int=
el.com/
Either folding it or using the new patch is fine for me.

BTW: the new perf test case for the feature is posted here.
I think Ian is reviewing it.
https://lore.kernel.org/lkml/20231107184020.1497571-1-kan.liang@linux.int=
el.com/

Thanks,
Kan
>=20
> I'll add a note and the Link tag points to this discussion in case
> people want to do historical digs in the future :-)
>=20
> - Arnaldo
> =20
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 58a9b8c82790..7a6a2d1f96db 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2355,6 +2355,10 @@ static inline bool
>> evsel__has_branch_counters(const struct evsel *evsel)
>>  {
>>         struct evsel *cur, *leader =3D evsel__leader(evsel);
>>
>> +       /* The branch counters feature only supports group */
>> +       if (!leader || !evsel->evlist)
>> +               return false;
>> +
>>         evlist__for_each_entry(evsel->evlist, cur) {
>>                 if ((leader =3D=3D evsel__leader(cur)) &&
>>                     (cur->core.attr.branch_sample_type &
>> PERF_SAMPLE_BRANCH_COUNTERS))
>>
>> Thanks,
>> Kan
>>
>>>
>>>
>>> (gdb) run test -F -v 27
>>> Starting program: /root/bin/perf test -F -v 27
>>>
>>>  27: Sample parsing                                                  =
:
>>> --- start ---
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x00000000004e4aa6 in evsel.parse_sample ()
>>> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.=
0.8-13.fc38.x86_64 cyrus-sasl-lib-2.1.28-9.fc38.x86_64 elfutils-debuginfo=
d-client-0.189-3.fc38.x86_64 elfutils-libelf-0.189-3.fc38.x86_64 elfutils=
-libs-0.189-3.fc38.x86_64 glib2-2.76.5-2.fc38.x86_64 glibc-2.37-13.fc38.x=
86_64 keyutils-libs-1.6.1-6.fc38.x86_64 krb5-libs-1.21-3.fc38.x86_64 libb=
abeltrace-1.5.11-2.fc38.x86_64 libbrotli-1.0.9-11.fc38.x86_64 libcap-2.48=
-6.fc38.x86_64 libcom_err-1.46.5-4.fc38.x86_64 libcurl-8.0.1-5.fc38.x86_6=
4 libevent-2.1.12-8.fc38.x86_64 libgcc-13.2.1-4.fc38.x86_64 libidn2-2.3.4=
-2.fc38.x86_64 libnghttp2-1.52.0-2.fc38.x86_64 libpfm-4.11.0-11.fc38.x86_=
64 libpsl-0.21.2-2.fc38.x86_64 libselinux-3.5-1.fc38.x86_64 libssh-0.10.5=
-1.fc38.x86_64 libstdc++-13.2.1-4.fc38.x86_64 libtraceevent-1.7.2-1.fc38.=
x86_64 libunistring1.0-1.0-1.fc38.x86_64 libunwind-1.6.2-7.fc38.x86_64 li=
buuid-2.38.1-4.fc38.x86_64 libxcrypt-4.4.36-1.fc38.x86_64 libzstd-1.5.5-1=
=2Efc38.x86_64 opencsd-1.3.3-1.fc38.x86_64 openldap-2.6.6-1.fc38.x86_64 o=
penssl-libs-3.0.9-2.fc38.x86_64 perl-libs-5.36.1-497.fc38.x86_64 popt-1.1=
9-2.fc38.x86_64 python3-libs-3.11.6-1.fc38.x86_64 slang-2.3.3-3.fc38.x86_=
64 zlib-1.2.13-3.fc38.x86_64
>>> (gdb) bt
>>> #0  0x00000000004e4aa6 in evsel.parse_sample ()
>>> #1  0x00000000004b28dc in do_test ()
>>> #2  0x00000000004b2acd in test.sample_parsing ()
>>> #3  0x0000000000495348 in test_and_print.isra ()
>>> #4  0x0000000000495f5d in cmd_test ()
>>> #5  0x00000000004c2a29 in run_builtin ()
>>> #6  0x000000000041053f in main ()
>>> (gdb)
>>>
>=20
