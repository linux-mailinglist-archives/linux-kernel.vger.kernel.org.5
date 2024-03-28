Return-Path: <linux-kernel+bounces-122388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0488F610
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D35C1C23DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25F376FE;
	Thu, 28 Mar 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFO1jJQP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1357B648;
	Thu, 28 Mar 2024 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598046; cv=none; b=Hbh+1coSv7babcX7kd5Y5C9G1qjORnzeYNSUklRUfmG3aPM/Oadpn35GQEcli7NfONaftUHYN8IdKA7iKyT6GUA5fAkyoVSynz9cVMQtwmvo54kMAh8y6x4MfxDi7MtxM6VBBLlB4d9LGXOI+hlxr0wXRAKB61a3Aw7q97picBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598046; c=relaxed/simple;
	bh=d7DAnNkChIkptoS7gUUEUP7m6gppueYlQCJ672hkuHk=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:From:
	 Message-ID:In-Reply-To; b=Y0CRHOHrkfWn4YRRFcEVPEpI13Q/MQ5V4ZLNMGmCpT7rbU6glP/S/dTEcFpJfMuWhK8si6LQkprbyb3hbk00Ptqpnv2j2APZZy4acH8p5nrvrU6X1qRt0Y6DMHm4J1ElE48CGJK6rAHthllYDQNyiT8VXo0ri/WzsAL8A7W0OjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFO1jJQP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711598045; x=1743134045;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=d7DAnNkChIkptoS7gUUEUP7m6gppueYlQCJ672hkuHk=;
  b=SFO1jJQPEML/BjZecnq81QL/4YnfaQqI+V6xeE24/MgfdVcTvsxmhu/k
   wwv4TQcL/7pMRieA6eiz7huvC/96fxx/vOJ5z17dB6JzlQTPP7uiXB6cU
   dTkirDEo/3M297lFeUQ/EhKYW6nYQq66nfDgJpSGm4vjOUWX+HJMCTE9Z
   AysrF6wjy65dDPXO5oGZUhgCKFem2pEteNhqPj5L53LnYzO9LGZsYOFx9
   wR6RqTH/GJDUt0aQTdk3rxGvlf65L3MDp2+RfnAw2jdFkEATIMn4mVK82
   uPOJNQvAGf4J7iOI8ioEZaexoQ+4lvlEVZ+BvruYDwy8iZiJLFNMEZ7ph
   w==;
X-CSE-ConnectionGUID: tKFb1aAzRUmTijMPHbfHCw==
X-CSE-MsgGUID: hDdGHbDdRWeoGmXl/r+wiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6845802"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6845802"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 20:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21170891"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.17.168])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 27 Mar 2024 20:54:03 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To: dave.hansen@linux.intel.com, tj@kernel.org, mkoutny@suse.com,
 linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org, x86@kernel.org,
 cgroups@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, sohil.mehta@intel.com, tim.c.chen@linux.intel.com, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
 zhanb@microsoft.com, anakrish@microsoft.com, mikko.ylinen@linux.intel.com,
 yangjie@microsoft.com, chrisyan@microsoft.com
Subject: Re: [PATCH v9 15/15] selftests/sgx: Add scripts for EPC cgroup
 testing
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
 <20240205210638.157741-16-haitao.huang@linux.intel.com>
 <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
Date: Wed, 27 Mar 2024 22:54:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2lbrsagbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <4be7b291010973c203ed8c7bcd25b626c1290231.camel@kernel.org>
User-Agent: Opera Mail/1.0 (Win32)

On Wed, 27 Mar 2024 07:55:34 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon, 2024-02-05 at 13:06 -0800, Haitao Huang wrote:
>> The scripts rely on cgroup-tools package from libcgroup [1].
>>
>> To run selftests for epc cgroup:
>>
>> sudo ./run_epc_cg_selftests.sh
>>
>> To watch misc cgroup 'current' changes during testing, run this in a
>> separate terminal:
>>
>> ./watch_misc_for_tests.sh current
>>
>> With different cgroups, the script starts one or multiple concurrent
>> SGX
>> selftests, each to run one unclobbered_vdso_oversubscribed test.Each
>> of such test tries to load an enclave of EPC size equal to the EPC
>> capacity available on the platform. The script checks results against
>> the expectation set for each cgroup and reports success or failure.
>>
>> The script creates 3 different cgroups at the beginning with
>> following
>> expectations:
>>
>> 1) SMALL - intentionally small enough to fail the test loading an
>> enclave of size equal to the capacity.
>> 2) LARGE - large enough to run up to 4 concurrent tests but fail some
>> if
>> more than 4 concurrent tests are run. The script starts 4 expecting
>> at
>> least one test to pass, and then starts 5 expecting at least one test
>> to fail.
>> 3) LARGER - limit is the same as the capacity, large enough to run
>> lots of
>> concurrent tests. The script starts 8 of them and expects all pass.
>> Then it reruns the same test with one process randomly killed and
>> usage checked to be zero after all process exit.
>>
>> The script also includes a test with low mem_cg limit and LARGE
>> sgx_epc
>> limit to verify that the RAM used for per-cgroup reclamation is
>> charged
>> to a proper mem_cg.
>>
>> [1] https://github.com/libcgroup/libcgroup/blob/main/README
>>
>> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
>> ---
>> V7:
>> - Added memcontrol test.
>>
>> V5:
>> - Added script with automatic results checking, remove the
>> interactive
>> script.
>> - The script can run independent from the series below.
>> ---
>>  .../selftests/sgx/run_epc_cg_selftests.sh     | 246
>> ++++++++++++++++++
>>  .../selftests/sgx/watch_misc_for_tests.sh     |  13 +
>>  2 files changed, 259 insertions(+)
>>  create mode 100755
>> tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>>  create mode 100755
>> tools/testing/selftests/sgx/watch_misc_for_tests.sh
>>
>> diff --git a/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> new file mode 100755
>> index 000000000000..e027bf39f005
>> --- /dev/null
>> +++ b/tools/testing/selftests/sgx/run_epc_cg_selftests.sh
>> @@ -0,0 +1,246 @@
>> +#!/bin/bash
>
> This is not portable and neither does hold in the wild.
>
> It does not even often hold as it is not uncommon to place bash
> to the path /usr/bin/bash. If I recall correctly, e.g. NixOS has
> a path that is neither of those two.
>
> Should be #!/usr/bin/env bash
>
> That is POSIX compatible form.
>

Sure

> Just got around trying to test this in NUC7 so looking into this in
> more detail.

Thanks. Could you please check if this version works for you?

https://github.com/haitaohuang/linux/commit/3c424b841cf3cf66b085a424f4b537fbc3bbff6f

>
> That said can you make the script work with just "#!/usr/bin/env sh"
> and make sure that it is busybox ash compatible?

Yes.

>
> I don't see any necessity to make this bash only and it adds to the
> compilation time of the image. Otherwise lot of this could be tested
> just with qemu+bzImage+busybox(inside initramfs).
>

will still need cgroup-tools as you pointed out later. Compiling from its  
upstream code OK?


> Now you are adding fully glibc shenanigans for the sake of syntax
> sugar.
>
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright(c) 2023 Intel Corporation.
>> +
>> +TEST_ROOT_CG=selftest
>> +cgcreate -g misc:$TEST_ROOT_CG
>
> How do you know that cgcreate exists? It is used a lot in the script
> with no check for the existence. Please fix e.g. with "command -v
> cgreate".
>
>> +if [ $? -ne 0 ]; then
>> +    echo "# Please make sure cgroup-tools is installed, and misc
>> cgroup is mounted."
>> +    exit 1
>> +fi
>
> And please do not do it this way. Also, please remove the advice for
> "cgroups-tool". This is not meant to be debian only. Better would be
> to e.g. point out the URL of the upstream project.
>
> And yeah the whole message should be based on "command -v", not like
> this.
>

OK

>> +TEST_CG_SUB1=$TEST_ROOT_CG/test1
>> +TEST_CG_SUB2=$TEST_ROOT_CG/test2
>> +# We will only set limit in test1 and run tests in test3
>> +TEST_CG_SUB3=$TEST_ROOT_CG/test1/test3
>> +TEST_CG_SUB4=$TEST_ROOT_CG/test4
>> +
>> +cgcreate -g misc:$TEST_CG_SUB1
>
>
>
>> +cgcreate -g misc:$TEST_CG_SUB2
>> +cgcreate -g misc:$TEST_CG_SUB3
>> +cgcreate -g misc:$TEST_CG_SUB4
>> +
>> +# Default to V2
>> +CG_MISC_ROOT=/sys/fs/cgroup
>> +CG_MEM_ROOT=/sys/fs/cgroup
>> +CG_V1=0
>> +if [ ! -d "/sys/fs/cgroup/misc" ]; then
>> +    echo "# cgroup V2 is in use."
>> +else
>> +    echo "# cgroup V1 is in use."
>
> Is "#" prefix a standard for kselftest? I don't know this, thus asking.
>
>> +    CG_MISC_ROOT=/sys/fs/cgroup/misc
>> +    CG_MEM_ROOT=/sys/fs/cgroup/memory
>> +    CG_V1=1
>
> Have you checked what is the indentation policy for bash scripts inside
> kernel tree. I don't know what it is. That's why I'm asking.
>
Right. I looked around and found scripts using bash in cgroup selftests  
(at least it marked with "#!/bin/bash"). And that's why I used it  
initially.

I don't see any specific rule for testing scripts after searching through  
the documentation.

I do see bash is one of minimal requirement for compiling kernel:  
https://docs.kernel.org/process/changes.html?highlight=bash

Anyway, I think we can make it compatible with busybox if needed.

>> +fi
>> +
>> +CAPACITY=$(grep "sgx_epc" "$CG_MISC_ROOT/misc.capacity" | awk
>> '{print $2}')
>> +# This is below number of VA pages needed for enclave of capacity
>> size. So
>> +# should fail oversubscribed cases
>> +SMALL=$(( CAPACITY / 512 ))
>> +
>> +# At least load one enclave of capacity size successfully, maybe up
>> to 4.
>> +# But some may fail if we run more than 4 concurrent enclaves of
>> capacity size.
>> +LARGE=$(( SMALL * 4 ))
>> +
>> +# Load lots of enclaves
>> +LARGER=$CAPACITY
>> +echo "# Setting up limits."
>> +echo "sgx_epc $SMALL" > $CG_MISC_ROOT/$TEST_CG_SUB1/misc.max
>> +echo "sgx_epc $LARGE" >  $CG_MISC_ROOT/$TEST_CG_SUB2/misc.max
>> +echo "sgx_epc $LARGER" > $CG_MISC_ROOT/$TEST_CG_SUB4/misc.max
>> +
>> +timestamp=$(date +%Y%m%d_%H%M%S)
>> +
>> +test_cmd="./test_sgx -t unclobbered_vdso_oversubscribed"
>> +
>> +wait_check_process_status() {
>> +    local pid=$1
>> +    local check_for_success=$2  # If 1, check for success;
>> +                                # If 0, check for failure
>> +    wait "$pid"
>> +    local status=$?
>> +
>> +    if [[ $check_for_success -eq 1 && $status -eq 0 ]]; then
>> +        echo "# Process $pid succeeded."
>> +        return 0
>> +    elif [[ $check_for_success -eq 0 && $status -ne 0 ]]; then
>> +        echo "# Process $pid returned failure."
>> +        return 0
>> +    fi
>> +    return 1
>> +}
>> +
>> +wai
>> wait_and_detect_for_any() {
>
> what is "any"?
>
> Maybe for some key functions could have short documentation what they
> are and for what test uses them. I cannot possibly remember all of this
> just by hints such as "this waits for Any" ;-)
>

Will add comments

> I don't think there is actual kernel guideline to engineer the script
> to work with just ash but at least for me that would inevitably
> increase my motivation to test this patch set more rather than less
.
Ok

Thanks
Haitao

