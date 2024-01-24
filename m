Return-Path: <linux-kernel+bounces-37199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C8183ACB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF581B35450
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403D811E4;
	Wed, 24 Jan 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gTmPgO9w"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA060BA8;
	Wed, 24 Jan 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107510; cv=none; b=kOe41ndTiOBpGkHovPTJed39kUTlQ+THm+F11kL2V9a71barY6xS1bbb6cGLbbjYDvKlPzkzCuCnyvji8/tzpXHjLIfAOMbX6dB98T6oXVeRckoG/EvDXcDCWz/Eaxi3uaph6h52z350MlJBDIQ/fMT1YythC6J72yWTz7A7K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107510; c=relaxed/simple;
	bh=6hqy0a4sGpuNFGT9XQmGQQHyoSvs8w4hXCSZapMZQHY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y/XGm60eYlv4VOkG2hboxaa2Q2vEOUGQC5I7vIZ0VEJkudX8vzSMC+JQ3DMZgw22V2MccPmFRM6jaWjfpye7Hcev3uWKVhR0OEToLbG3D4JquoO7TTZPKJWdGAb7HeF8xAvD+iF8TzMXDZ/VVu/NRIHITqQ7ch3/7UhmIfLcuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gTmPgO9w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ODbtMF008712;
	Wed, 24 Jan 2024 14:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Z75rsvyQVvkzyLp3paQEXb4qLlOHXspm/NAl7MHlZug=;
 b=gTmPgO9wG0RDw1ra346Vzi4kr+KCjkY1po2ycIuyMaro2seOywZgfCsEhzF929s2Aryi
 yApg3jg8UyAYwIjmdptJFrJfUPn3/aGaNxAR6ADvFE2z8T+woYBoOeA0JR5fbBKHy2ZL
 mI8eZcJl/vUkxDbO9zxt9DiqZI48bPlT4LaEECQ739HmFVAjz49PCNgXVJlJ6t8XdUDJ
 cRg8goADKa/Ov7UmdLvn8Zf4GX7ajOXmEqe+uoO6WIvb5NF9/VefQP74pGL7BBsspfaJ
 H2ISYA0Cxfxwi+QeIhb0yhRakroXWwuPFMdDUjz74N2uNh8WMx3gbGAunPMCQvGZCoeI yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu3kpsnby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:45:02 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40OEYuZc002004;
	Wed, 24 Jan 2024 14:45:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu3kpsnb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:45:02 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEEj7I022413;
	Wed, 24 Jan 2024 14:45:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0m66kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:45:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OEiwBT46400212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:44:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09D682004B;
	Wed, 24 Jan 2024 14:44:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75CC720043;
	Wed, 24 Jan 2024 14:44:57 +0000 (GMT)
Received: from [9.152.224.38] (unknown [9.152.224.38])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 14:44:57 +0000 (GMT)
Message-ID: <951176ce-5fcc-4e5a-a25f-df0f7724e797@linux.ibm.com>
Date: Wed, 24 Jan 2024 15:44:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] v6.8 SMC-D issues
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
 <20231219142616.80697-8-guwen@linux.alibaba.com>
 <13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com>
In-Reply-To: <13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IzTTuGw3QYrqtDuD0CKB1gd2fQHJ1EP-
X-Proofpoint-ORIG-GUID: 03xzMTm12SCYFdK7jTpXF3hUiLXxyf8e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=846
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240107



On 24.01.24 15:29, Alexandra Winter wrote:
> Hello Wen Gu,
> 
> our colleague Matthew reported that SMC-D is failing in certain scenarios on
> kernel v6.8 (thx Matt!). He bisected it to 
> b40584d ("net/smc: compatible with 128-bits extended GID of virtual ISM device")
> I think the root cause could also be somewhere else in the SMC-Dv2.1 patchset.
> 
> I was able to reproduce the issue on a 6.8.0-rc1 kernel.
> I tested iperf over smc-d with:
> smc_run iperf3 -s
> smc_run iperf3 -c <IP@>
> 
> 1) Doing an iperf in a single system using 127.0.0.1 as IP@
> (System A=iperf client=iperf server)
> 2) Doing iperf to a remote system (System A=client; System B=iperf server)
> 
> The second iperf fails with an error message like:
> "iperf3: error - unable to receive cookie at server: Bad file descriptor" on the server"
> 
> If I do first 2) (iperf to remote) and then 1) (iperf to local), then the
> iperf to local fails.
> 
> I can do multiple iperf to the first server without problems.
> 
> I ran it on a debug server with KASAN, but got no reports in the Logfile.
> 
> I will try to debug further, but wanted to let you all know.
> 
> Kind regards
> Alexandra
> 
> Reported-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> 
> 

It seems the issue only occurs, when both client and server are on 6.8+
When either side is on an older kernel (6.5.6-300.fc39.s390x in my case),
I don't see the issue.

