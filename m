Return-Path: <linux-kernel+bounces-154580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D78ADDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333211C2012B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6719E29429;
	Tue, 23 Apr 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="juBA2rPg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270F24B28;
	Tue, 23 Apr 2024 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855253; cv=none; b=m0sSKE5wEqR697zsIXVdNsUAiZnlpVKFLT3c9O/aTDxl12/2gMZ5xjYo7s1j75cnIbCP1vCgI/UhAKy8woNmfUy6RRUZrjp1HZhQxnDEKpSd7uiq+1kFJETCuysve/NOoWoSfdGPkHI9KHCm6ndq28qIBSzMCW5lfG+ShEHo2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855253; c=relaxed/simple;
	bh=z2OhGkc9weQ5UHWYoCKHRx1ylQpGsYDYkX+OUC/X4dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BNSlDQLuN1AkY0sfUkPif7INAfNTNUoFXQxAMSXXrGbwKhLdpDKLVCxsx7f/s7sPXalgkWJYpr2k+nqA6WKhRzaYDUt6ovkV1YyuBEJryoSKvVapnp2eUpFg1HcWh3+hWp8mOypajTQKv/ixL4zGv0QJxc4WHqn8yOfpbsnuFfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=juBA2rPg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N5avwa014566;
	Tue, 23 Apr 2024 06:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kNDizAUq6M15vjj8var0LsymdUc1J25H+tgaeUr6B08=;
 b=juBA2rPgoEbbna4DWIZKmnLW09kwO6C1V4vjLxa5e0taPVg2WCPxOqZW11vVC+R5jvCn
 NWUQtUKqGMaCR4eokI+t+tqy5mJs/uExpzdXgOTKKtoIOkxYGmfeWm+gxMwE+p0c3eC2
 lQwJhaxmAd8Hd9P0NGvkd60k77SxZc+zeK/IQwmn7fa0vBB/TvVjzv2Ccwkzpp+7mV2a
 ETbCkIdTCk8Q4R7O0vo+FgG3ey/AvZkutcu0dYdM5FWDxAnBb5YapCipSjh3J2cmaave
 8DzeubkS0dZz2+53MhrNcg+lplUen00BAGIQeeyC6B4RsaIqsIfS8o7YzLX1jK34LLm0 pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp6kn04qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:53:53 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6rril010204;
	Tue, 23 Apr 2024 06:53:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp6kn04qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:53:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N6cENZ029905;
	Tue, 23 Apr 2024 06:53:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmr1tcc9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:53:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43N6rm9M48562638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 06:53:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70E8A20040;
	Tue, 23 Apr 2024 06:53:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13EC820043;
	Tue, 23 Apr 2024 06:53:48 +0000 (GMT)
Received: from [9.152.212.121] (unknown [9.152.212.121])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 06:53:48 +0000 (GMT)
Message-ID: <c1c460ed-69c3-4fde-aa9b-be1051dae6ec@linux.ibm.com>
Date: Tue, 23 Apr 2024 08:53:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Assume sysfs event names are always lowercase
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jing Zhang
 <renyu.zj@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20240423031719.1941141-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20240423031719.1941141-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C-sYB4OKvXvGGOCPFpTQ0yOXzy0WeFK-
X-Proofpoint-ORIG-GUID: eqTvCTSzkt-rI3CgQxLWuUOx4C7Hfmvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230019

On 4/23/24 05:17, Ian Rogers wrote:
> By assuming sysfs events are lower case, the case insensitive event
> parsing can probe for the existence of a file rather then loading all
> events in a directory. When the event is a json event like
> inst_retired.any on Intel, this reduces the number of openat calls on
> a Tigerlake laptop from 325 down to 255.
> 

Ian, sorry for the late reply.
On s390 the events in the sysfs tree are all upper case:

[root@a35lp67 ~]# ls -l /sys/devices/cpum_cf/events/ | head -10
total 0
-r--r--r-- 1 root root 4096 Apr 17 14:47 AES_BLOCKED_CYCLES
-r--r--r-- 1 root root 4096 Apr 17 14:47 AES_BLOCKED_FUNCTIONS
-r--r--r-- 1 root root 4096 Apr 17 14:47 AES_CYCLES
-r--r--r-- 1 root root 4096 Apr 17 14:47 AES_FUNCTIONS
-r--r--r-- 1 root root 4096 Apr 17 14:47 BCD_DFP_EXECUTION_SLOTS
-r--r--r-- 1 root root 4096 Apr 17 14:47 CPU_CYCLES
-r--r--r-- 1 root root 4096 Apr 17 14:47 CRSTE_1MB_WRITES
-r--r--r-- 1 root root 4096 Apr 17 14:47 DCW_OFF_DRAWER
-r--r--r-- 1 root root 4096 Apr 17 14:47 DCW_OFF_DRAWER_MEMORY
[root@a35lp67 ~]# 

Same is true for all other PMUs (currently 5 and growing).

Is there a branch to pull to try out the effect of your patch on s390?

Thanks Thomas
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294


