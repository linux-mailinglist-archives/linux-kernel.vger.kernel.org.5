Return-Path: <linux-kernel+bounces-37143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895983AC04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861DD291EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483C512AAC4;
	Wed, 24 Jan 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PvU/KE12"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12177C08D;
	Wed, 24 Jan 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106593; cv=none; b=GhzQ6Fctnw2UT9C08hNj+792E7hyUw0LVqu7pZcCGF9DUYqiJ26I/urqosigR3a2aTx+3Q8IZ6KPmhit+x6AalEScZKPglDa1WwQejqe+H6xyHFdWpzC4sU6GfY8y/k9QKIH1TIlvquvCtSDYuUs69PU9V388sPhHJxHmG49lBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106593; c=relaxed/simple;
	bh=KkWbxEOL9fYn082VaDJyA7NHt5SNW51VNBbBhRcci8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfYUCbNQL0xOMsbdQFW4/IzssoRIZXxG+PU/UiU9LoYaW/dC/d/yJtR5DcqKTzvfB9eBgr9rwmsQzmDvwymrvKawtSS4xDFCNzkfy9gzgyGWoQ7V/5qKX5Hn9Q4zcM7XE4k/HP/y7hSJHnmzE9oEPW4s2R9AhSqWAQnx49NiPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PvU/KE12; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OEMd1L019770;
	Wed, 24 Jan 2024 14:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=id03GCOMuuz9E+q8wpa1mZrFPdzbBKrJ0mBS2dIBSSo=;
 b=PvU/KE12Bt4bH/E2Y0YdSC27EbEBMgwG+Le0UEm5f63nDQAHXobz1vIi1+KvIMnEMYOU
 o9xF9xPsqnJ+pRfUTcfiZI2qnBHYntVVD9a3YFz3oiR/TqeHY8cJ5Y9al+7NKhIkD2i/
 ehW3KlOxOJsLD4C49+CbYXINTml14eB3AZfcr3XFXzOKZkKyhOg/RKeX1JC7VD+++568
 OD2BW/SE8lJmzSYojQp1uafpKixTd5dg2NNF92BENSkftFbCEHkJgGg70iEb10GCjwRe
 i6eIGF8L3c8k53sMi9lxvzoKhni92l7ZNv+Olm9Ygd4pr9LNg9e7dJ7n/4+dJzg6u2TD cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu0ta5tfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:29:41 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40OETCh7001571;
	Wed, 24 Jan 2024 14:29:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu0ta5tce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:29:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBuS8a025268;
	Wed, 24 Jan 2024 14:29:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkdxdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 14:29:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OETRKM44565084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 14:29:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3372F20043;
	Wed, 24 Jan 2024 14:29:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D249420040;
	Wed, 24 Jan 2024 14:29:26 +0000 (GMT)
Received: from [9.152.224.38] (unknown [9.152.224.38])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jan 2024 14:29:26 +0000 (GMT)
Message-ID: <13579588-eb9d-4626-a063-c0b77ed80f11@linux.ibm.com>
Date: Wed, 24 Jan 2024 15:29:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION] v6.8 SMC-D issues
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20231219142616.80697-8-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qt1EOrmfVf_sdqbTImWI7_I6a3wI5IV9
X-Proofpoint-GUID: Q2MCPmrpkI3XR9Uka3rzJtqmHUwMkJkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=911
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240105

Hello Wen Gu,

our colleague Matthew reported that SMC-D is failing in certain scenarios on
kernel v6.8 (thx Matt!). He bisected it to 
b40584d ("net/smc: compatible with 128-bits extended GID of virtual ISM device")
I think the root cause could also be somewhere else in the SMC-Dv2.1 patchset.

I was able to reproduce the issue on a 6.8.0-rc1 kernel.
I tested iperf over smc-d with:
smc_run iperf3 -s
smc_run iperf3 -c <IP@>

1) Doing an iperf in a single system using 127.0.0.1 as IP@
(System A=iperf client=iperf server)
2) Doing iperf to a remote system (System A=client; System B=iperf server)

The second iperf fails with an error message like:
"iperf3: error - unable to receive cookie at server: Bad file descriptor" on the server"

If I do first 2) (iperf to remote) and then 1) (iperf to local), then the
iperf to local fails.

I can do multiple iperf to the first server without problems.

I ran it on a debug server with KASAN, but got no reports in the Logfile.

I will try to debug further, but wanted to let you all know.

Kind regards
Alexandra

Reported-by: Matthew Rosato <mjrosato@linux.ibm.com>



