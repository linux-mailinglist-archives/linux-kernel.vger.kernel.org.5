Return-Path: <linux-kernel+bounces-8183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B253E81B343
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1E728862B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB84F202;
	Thu, 21 Dec 2023 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GpskKh2J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C34D5A8;
	Thu, 21 Dec 2023 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL9uNme017134;
	Thu, 21 Dec 2023 10:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ViT8m07TWwZSGmStxAr6UmJf9XGZFaykiisXwcTomq8=;
 b=GpskKh2J5hMfNTvv8ieG6+KynvBqXj8NRfEn7QZJy8lwHcLJ0mUMybFkv2wgjvnHoMTn
 KxY/lPzhZXJRYkzB1GnV0Dp8jsXUJQiKmgAju2anol792q8HSf7ucnVgtN2yY7uJV/lf
 RFNqd2+mG0jHu32+p0rj/nJ6WUD9mcoV/THBFBN/l8Xn2XkgT76piJXAThEbWBES4SiK
 eG7BTnWk1W0bDaoEv6pDD1jjQmmbep13zv6ioBst6AstMMMgxWv6k4LM51pm3+OOqQnF
 uRQPa1RnmAzFxLzQ68sbgtEzO+PQ+xp5af+QE1axgxAiT9M+nBv/mYqqwsbIGcfyYubc uA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4ff53p4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 10:11:48 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BL9uY68018394;
	Thu, 21 Dec 2023 10:11:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4ff53p3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 10:11:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL9UABk010885;
	Thu, 21 Dec 2023 10:11:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nv7gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 10:11:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BLABhXX19530474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 10:11:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CE8C2006A;
	Thu, 21 Dec 2023 10:11:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD4022004E;
	Thu, 21 Dec 2023 10:11:34 +0000 (GMT)
Received: from [9.177.10.175] (unknown [9.177.10.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Dec 2023 10:11:34 +0000 (GMT)
Message-ID: <7a2623b2-2c56-43db-b19b-3e9488b4be6d@linux.ibm.com>
Date: Thu, 21 Dec 2023 15:41:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V0 RESEND] tools/perf: Add PVN for HX-C2000 CPU with
 Power8 Architecture
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231221060242.4532-1-jialong.yang@shingroup.cn>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20231221060242.4532-1-jialong.yang@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -c8gWX9710IZkgpB66xJqsnOEAA5LAL1
X-Proofpoint-GUID: zAXXQN6VfzqUwnSmcLWW8VBqmWAMDnnE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_04,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=687 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210075


On 12/21/23 11:32 AM, JiaLong.Yang wrote:
> HX-C2000 is a new CPU made by HEXIN Technologies Co., Ltd. And a new
> PVN 0x0066 has been applied from the OpenPower Community for this CPU. Here is
> a patch to make perf tool run in the CPU.
>
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>

Patch seems to be fine to me.

Reviewed-by: Madhavan Srinivasanan <maddy@linux.ibm.com>

> ---
> Here tells detail info.
> Link: https://lore.kernel.org/all/20231129075845.57976-1-ke.zhao@shingroup.cn/
>
>   tools/perf/pmu-events/arch/powerpc/mapfile.csv | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> index f4908af7ad66..599a588dbeb4 100644
> --- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> @@ -11,8 +11,7 @@
>   #
>   # Multiple PVRs could map to a single JSON file.
>   #
> -
> -# Power8 entries
>   0x004[bcd][[:xdigit:]]{4},1,power8,core
> +0x0066[[:xdigit:]]{4},1,power8,core
>   0x004e[[:xdigit:]]{4},1,power9,core
>   0x0080[[:xdigit:]]{4},1,power10,core

