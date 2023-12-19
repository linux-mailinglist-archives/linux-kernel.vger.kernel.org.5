Return-Path: <linux-kernel+bounces-4960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8299818464
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E363B1C23D11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C79713ADB;
	Tue, 19 Dec 2023 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k0mdVD3c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3386F15AC0;
	Tue, 19 Dec 2023 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ97PpM030485;
	Tue, 19 Dec 2023 09:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=w/p0k9EHg/9AzMA7j/JV2hgFJPlycLWZZ5QOcc3O3ns=;
 b=k0mdVD3ciDFj7A6oaxme8eXhIhxJShk+o3hUstpwLbkWgV5hGV0wbf7NNRfgVXk+gB4U
 Lg+bFdGzCZDdRQf13NGX7xo5peU5rlpjbbS+rQ4+wuXfXtqaHb3lfrwidhm0F8sQdrMY
 s6QrvVVArnQuIkPcH+BCQMTDx61wqIkejXYt5V0KGtwgqtNEgSIluHissU1R7vft/ySy
 jMPEJVfwb7yumUAhBFtus64EnwfRjNF7z+Jikm/LsxiDWPii8ggPvyYxWQqRbyGek3ul
 V7BqIKtieIBSZn1LHLHi9z5l4Oz05ffaqhdMtE+xu8ePfX5QVpc/w2wNyeqqu07gJ7Hs FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v388xrfgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:26:37 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ97MBb030354;
	Tue, 19 Dec 2023 09:26:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v388xrffx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:26:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ6pKJt029680;
	Tue, 19 Dec 2023 09:26:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1p7sev27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:26:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJ9QXoC35848682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 09:26:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60E7A2004D;
	Tue, 19 Dec 2023 09:26:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9000820040;
	Tue, 19 Dec 2023 09:26:28 +0000 (GMT)
Received: from [9.179.31.204] (unknown [9.179.31.204])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 09:26:28 +0000 (GMT)
Message-ID: <a0abfee5-4dcd-3eb5-82fe-1a0dcdade038@linux.ibm.com>
Date: Tue, 19 Dec 2023 14:56:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 0/7] Clean up perf mem
Content-Language: en-US
To: kan.liang@linux.intel.com, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
        will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com,
        renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com,
        ravi.bangoria@amd.com, atrajeev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20231213195154.1085945-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jT3173WQo5SQrJDBT0qoPS-L_4sIugFJ
X-Proofpoint-GUID: lJkxe_yYoab2cyfhmutpesPv5I8AIbDQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190070

Hi,
  I was trying to test this patchset on powerpc.

After applying it on top of acme's perf-tools-next branch, I am getting
below error:

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libsymbol_headers
  INSTALL libapi_headers
  INSTALL libbpf_headers
  CC      arch/powerpc/util/mem-events.o
In file included from arch/powerpc/util/mem-events.c:3:
arch/powerpc/util/mem-events.h:5:52: error: ‘PERF_MEM_EVENTS__MAX’
undeclared here (not in a function)
    5 | extern struct perf_mem_event
perf_mem_events_power[PERF_MEM_EVENTS__MAX];
      |
^~~~~~~~~~~~~~~~~~~~
make[6]: *** [/home/kajol/linux/tools/build/Makefile.build:105:
arch/powerpc/util/mem-events.o] Error 1
make[5]: *** [/home/kajol/linux/tools/build/Makefile.build:158: util]
Error 2
make[4]: *** [/home/kajol/linux/tools/build/Makefile.build:158: powerpc]
Error 2
make[3]: *** [/home/kajol/linux/tools/build/Makefile.build:158: arch]
Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile.perf:693: perf-in.o] Error 2
make[1]: *** [Makefile.perf:251: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

It seems some headerfiles are missing from arch/powerpc/util/mem-
events.c

Thanks,
Kajol Jain

On 12/14/23 01:21, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V2:
> - Fix the Arm64 building error (Leo)
> - Add two new patches to clean up perf_mem_events__record_args()
>   and perf_pmus__num_mem_pmus() (Leo)
> 
> Changes since V1:
> - Fix strcmp of PMU name checking (Ravi)
> - Fix "/," typo (Ian)
> - Rename several functions with perf_pmu__mem_events prefix. (Ian)
> - Fold the header removal patch into the patch where the cleanups made.
>   (Arnaldo)
> - Add reviewed-by and tested-by from Ian and Ravi
> 
> As discussed in the below thread, the patch set is to clean up perf mem.
> https://lore.kernel.org/lkml/afefab15-cffc-4345-9cf4-c6a4128d4d9c@linux.intel.com/
> 
> Introduce generic functions perf_mem_events__ptr(),
> perf_mem_events__name() ,and is_mem_loads_aux_event() to replace the
> ARCH specific ones.
> Simplify the perf_mem_event__supported().
> 
> Only keeps the ARCH-specific perf_mem_events array in the corresponding
> mem-events.c for each ARCH.
> 
> There is no functional change.
> 
> The patch set touches almost all the ARCHs, Intel, AMD, ARM, Power and
> etc. But I can only test it on two Intel platforms.
> Please give it try, if you have machines with other ARCHs.
> 
> Here are the test results:
> Intel hybrid machine:
> 
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e cpu_atom/mem-loads,ldlat=50/P -e cpu_core/mem-loads,ldlat=50/P
> 
> $perf mem record -v
> calling: record -e cpu_atom/mem-loads,ldlat=30/P -e cpu_atom/mem-stores/P -e cpu_core/mem-loads,ldlat=30/P -e cpu_core/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu_atom/mem-stores/P -e cpu_core/mem-stores/P
> 
> 
> Intel SPR:
> $perf mem record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> $perf mem record -e ldlat-loads -v --ldlat 50
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=50/}:P
> 
> $perf mem record -v
> calling: record -e {cpu/mem-loads-aux/,cpu/mem-loads,ldlat=30/}:P -e cpu/mem-stores/P
> 
> $perf mem record -t store -v
> calling: record -e cpu/mem-stores/P
> 
> Kan Liang (7):
>   perf mem: Add mem_events into the supported perf_pmu
>   perf mem: Clean up perf_mem_events__ptr()
>   perf mem: Clean up perf_mem_events__name()
>   perf mem: Clean up perf_mem_event__supported()
>   perf mem: Clean up is_mem_loads_aux_event()
>   perf mem: Clean up perf_mem_events__record_args()
>   perf mem: Clean up perf_pmus__num_mem_pmus()
> 
>  tools/perf/arch/arm/util/pmu.c            |   3 +
>  tools/perf/arch/arm64/util/mem-events.c   |  39 +---
>  tools/perf/arch/arm64/util/mem-events.h   |   7 +
>  tools/perf/arch/powerpc/util/mem-events.c |  13 +-
>  tools/perf/arch/powerpc/util/mem-events.h |   7 +
>  tools/perf/arch/powerpc/util/pmu.c        |  11 ++
>  tools/perf/arch/s390/util/pmu.c           |   3 +
>  tools/perf/arch/x86/util/mem-events.c     |  99 ++--------
>  tools/perf/arch/x86/util/mem-events.h     |  10 +
>  tools/perf/arch/x86/util/pmu.c            |  19 +-
>  tools/perf/builtin-c2c.c                  |  45 ++---
>  tools/perf/builtin-mem.c                  |  48 ++---
>  tools/perf/util/mem-events.c              | 217 +++++++++++++---------
>  tools/perf/util/mem-events.h              |  19 +-
>  tools/perf/util/pmu.c                     |   4 +-
>  tools/perf/util/pmu.h                     |   7 +
>  tools/perf/util/pmus.c                    |   6 -
>  tools/perf/util/pmus.h                    |   1 -
>  18 files changed, 278 insertions(+), 280 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
> 

