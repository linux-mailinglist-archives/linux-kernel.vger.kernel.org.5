Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDCE7FD28D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjK2J2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjK2J17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:27:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 211AC1FDB;
        Wed, 29 Nov 2023 01:27:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0746E2F4;
        Wed, 29 Nov 2023 01:28:45 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A2A93F6C4;
        Wed, 29 Nov 2023 01:27:56 -0800 (PST)
Message-ID: <03b314c6-ed6d-ae17-5bc5-0170139f7feb@arm.com>
Date:   Wed, 29 Nov 2023 09:27:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/2] perf test: Add basic list test
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20231129081004.1918096-1-irogers@google.com>
 <20231129081004.1918096-2-irogers@google.com>
 <a54d0a93-aacd-4c69-a34c-8628b0e18ee7@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a54d0a93-aacd-4c69-a34c-8628b0e18ee7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2023 09:00, Adrian Hunter wrote:
> On 29/11/23 10:10, Ian Rogers wrote:
>> Test that json output produces valid json.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100755 tools/perf/tests/shell/list.sh
>>
>> diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
>> new file mode 100755
>> index 000000000000..286879a9837a
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/list.sh
>> @@ -0,0 +1,29 @@
>> +#!/bin/sh
>> +# perf list tests
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +set -e
>> +err=0
>> +
>> +if [ "x$PYTHON" == "x" ]
>> +then
>> +	if which python3 > /dev/null
> 
> 'which' isn't always present.  Maybe
> 
> python3 --version >/dev/null 2>&1 && PYTHON=python3
> 

Now that we have shellcheck integrated into the build, we could enable
the POSIX mode test which would warn against this usage of which and
suggest the alternative.

At the moment though there are several other usages of which already in
the tests. And probably enabling POSIX mode would come with hundreds of
other warnings to fix.

I'm not saying we shouldn't change this instance though, just adding the
info for the discussion.

>> +	then
>> +		PYTHON=python3
>> +	elif which python > /dev/null
>> +	then
>> +		PYTHON=python
>> +	else
>> +		echo Skipping test, python not detected please set environment variable PYTHON.
>> +		exit 2
>> +	fi
>> +fi
>> +
>> +test_list_json() {
>> +  echo "Json output test"
>> +  perf list -j | $PYTHON -m json.tool
>> +  echo "Json output test [Success]"
>> +}
>> +
>> +test_list_json
>> +exit $err
> 
> 
