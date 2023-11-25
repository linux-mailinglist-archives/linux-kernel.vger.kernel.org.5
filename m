Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1F7F8DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjKYTKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjKYTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:10:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43DA7129;
        Sat, 25 Nov 2023 11:10:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A032CDA7;
        Sat, 25 Nov 2023 11:11:15 -0800 (PST)
Received: from [10.57.5.64] (unknown [10.57.5.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 446CA3F6C4;
        Sat, 25 Nov 2023 11:10:27 -0800 (PST)
Message-ID: <f0ac7523-edce-4b0b-a142-14c03c912720@arm.com>
Date:   Sat, 25 Nov 2023 19:10:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
To:     Leo Yan <leo.yan@linaro.org>, Michael Petlan <mpetlan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        vmolnaro@redhat.com
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <alpine.LRH.2.20.2311242037260.11297@Diego>
 <20231125030529.GB178091@leoy-huanghe>
Content-Language: en-GB
From:   Nick Forrington <nick.forrington@arm.com>
In-Reply-To: <20231125030529.GB178091@leoy-huanghe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/11/2023 03:05, Leo Yan wrote:
> Hi all,
>
> On Fri, Nov 24, 2023 at 08:57:52PM +0100, Michael Petlan wrote:
>> On Thu, 2 Nov 2023, Nick Forrington wrote:
>>> The current use of atomics can lead to test failures, as tests (such as
>>> tests/shell/record.sh) search for samples with "test_loop" as the
>>> top-most stack frame, but find frames related to the atomic operation
>>> (e.g. __aarch64_ldadd4_relax).
> I am confused by above description.  As I went through the script
> record.sh, which is the only test invoking the program 'test_loop',
> but I don't find any test is related with stack frame.
>
> Do I miss anything?  I went through record.sh but no clue why the
> failure is caused by stack frame.  All the testings use command:
>
>    if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
>      ...
>    fi
>
> @Nick, could you narrow down which specific test case causing the
> failure.
>
> [...]


All checks for ${testsym} in record.sh (including the example you 
provide) can fail, as the expected symbol (test_loop) is not the 
top-most function on the stack (and therefore not the symbol associated 
with the sample).


Example perf report output:

# Overhead  Command  Shared Object          Symbol
# ........  .......  ..................... .............................
#
     99.53%  perf     perf                   [.] __aarch64_ldadd4_relax

...


You can see the issue when recording/reporting with call stacks:

# Children      Self  Command  Shared Object          Symbol
# ........  ........  .......  ..................... 
..........................................................
#
     99.52%    99.52%  perf     perf                   [.] 
__aarch64_ldadd4_relax
             |
             |--49.77%--0xffffb905a5dc
             |          0xffffb8ff0aec
             |          thfunc
             |          test_loop
             |          __aarch64_ldadd4_relax

...

>
>> I believe that it was there to prevent the compiler to optimize the loop
>> out or some reason like that. Hopefully, it will work even without that
>> on all architectures with all compilers that are used for building perf...
> Agreed.
>
> As said above, I'd like to step back a bit for making clear what's the
> exactly failure caused by the program.


I don't think this loop could be sensibly optimised away, as it depends 
on "done", which is defined at file scope (and assigned by a signal 
handler).


Cheers,
Nick

>
> Thanks,
> Leo
>
