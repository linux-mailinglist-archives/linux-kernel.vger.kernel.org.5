Return-Path: <linux-kernel+bounces-159610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D18B3105
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCF91C22040
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06F13B2B0;
	Fri, 26 Apr 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eHONCeLC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D87567F;
	Fri, 26 Apr 2024 07:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114989; cv=none; b=umiyW4Hg/JaDs+teouq2qzZZmr2IgtmwJoCE2e4NVW+tNMYBEOPbr49y2j6y0LosfFvj5pyU/T3NQbusV01eUjABpYbiCG3csZPMFAk1Ea3fnaiKSWmAx89YI7y3tQdqyH7INKtEDseEHdAzMSEgrYBZ7rDb4Fk350KXZ7aMHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114989; c=relaxed/simple;
	bh=IvTH72RWSEFgKEux7+oDcRKaZa76lkq/3U0lfobgA7E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2Eb6l7e/gl0tVGHB+dCF05vvEi4LY01A1KemjxNwIFX73UND8cagdZcJcaXJGvdRQkd2zO1/ZnjaFbjinZFtnkkk0izcxso+lKKtFmJTtFLkaqpxsWtCYlPuo+NtNaYxJa/YPJgu3QLPB3A4Tmg7OnxMYENKvTKvFiLfU2ZSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eHONCeLC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q72RBA006163;
	Fri, 26 Apr 2024 07:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gn+OA+eWtFQ0TbrlYBUsxOrQSF+lCgWVOrEmHKbpjF0=;
 b=eHONCeLCatfKXfkK5H/0BHT4T0dp7zr9JqJN80e5/BCSJ/7Ek8ZgzQimbka5puTaBc5R
 k7j3ToaFJhFo3jpzAB20Lhpk5sn3tydZvkwixCJ/JincYI4j+5C4iDO6Mi621SFyrUOF
 7PxG+AniE/S5seInN0c8VQGGjPgA9r7mAyB6fhhK00pOwo5CzUHK1aw5Z4s81oVXnsoN
 5BwX/M7vcGap6toqkxG0ZgEzBKNxstmv/pJR2ctw45ySX/Z9jkbdEDeUtWx0oM0DsyP3
 JFrnZPtY6NtImqF6AbCwxkrbsSxzQ5mITRQR7HuGChYuh37v7Xbv1StgVmpWgr1M7vAa YA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr7h8r02h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 07:02:56 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43Q72uPT006995;
	Fri, 26 Apr 2024 07:02:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr7h8r02b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 07:02:56 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q5ZGnM015343;
	Fri, 26 Apr 2024 07:02:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmp6jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 07:02:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43Q72n4x54854034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 07:02:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B4CC2004F;
	Fri, 26 Apr 2024 07:02:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00E8C20063;
	Fri, 26 Apr 2024 07:02:48 +0000 (GMT)
Received: from [9.171.7.244] (unknown [9.171.7.244])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 07:02:47 +0000 (GMT)
Message-ID: <5f50bc62-f7d5-4094-94de-a77a103fc111@linux.ibm.com>
Date: Fri, 26 Apr 2024 09:02:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240414040304.54255-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S69eD35reIvaQmH81gvuG5azWnZJyWmN
X-Proofpoint-GUID: VXcwIiokXeiKQzTJsMTZqwouEkYfg2ba
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260043



On 14/04/2024 06:02, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The first
> part can be referred from [2]), the updated things of this version are listed
> at the end.
> 
> - Background
> 
> SMC-D is now used in IBM z with ISM function to optimize network interconnect
> for intra-CPC communications. Inspired by this, we try to make SMC-D available
> on the non-s390 architecture through a software-implemented Emulated-ISM device,
> that is the loopback-ism device here, to accelerate inter-process or
> inter-containers communication within the same OS instance.
> 
> - Design
> 
> This patch set includes 3 parts:
> 
>   - Patch #1: some prepare work for loopback-ism.
>   - Patch #2-#7: implement loopback-ism device and adapt SMC-D for it.
>     loopback-ism now serves only SMC and no userspace interfaces exposed.
>   - Patch #8-#11: memory copy optimization for intra-OS scenario.
> 
> The loopback-ism device is designed as an ISMv2 device and not be limited to
> a specific net namespace, ends of both inter-process connection (1/1' in diagram
> below) or inter-container connection (2/2' in diagram below) can find the same
> available loopback-ism and choose it during the CLC handshake.
> 
>   Container 1 (ns1)                              Container 2 (ns2)
>   +-----------------------------------------+    +-------------------------+
>   | +-------+      +-------+      +-------+ |    |        +-------+        |
>   | | App A |      | App B |      | App C | |    |        | App D |<-+     |
>   | +-------+      +---^---+      +-------+ |    |        +-------+  |(2') |
>   |     |127.0.0.1 (1')|             |192.168.0.11       192.168.0.12|     |
>   |  (1)|   +--------+ | +--------+  |(2)   |    | +--------+   +--------+ |
>   |     `-->|   lo   |-` |  eth0  |<-`      |    | |   lo   |   |  eth0  | |
>   +---------+--|---^-+---+-----|--+---------+    +-+--------+---+-^------+-+
>                |   |           |                                  |
>   Kernel       |   |           |                                  |
>   +----+-------v---+-----------v----------------------------------+---+----+
>   |    |                            TCP                               |    |
>   |    |                                                              |    |
>   |    +--------------------------------------------------------------+    |
>   |                                                                        |
>   |                           +--------------+                             |
>   |                           | smc loopback |                             |
>   +---------------------------+--------------+-----------------------------+
> 
> loopback-ism device creates DMBs (shared memory) for each connection peer.
> Since data transfer occurs within the same kernel, the sndbuf of each peer
> is only a descriptor and point to the same memory region as peer DMB, so that
> the data copy from sndbuf to peer DMB can be avoided in loopback-ism case.
> 
>   Container 1 (ns1)                              Container 2 (ns2)
>   +-----------------------------------------+    +-------------------------+
>   | +-------+                               |    |        +-------+        |
>   | | App C |-----+                         |    |        | App D |        |
>   | +-------+     |                         |    |        +-^-----+        |
>   |               |                         |    |          |              |
>   |           (2) |                         |    |     (2') |              |
>   |               |                         |    |          |              |
>   +---------------|-------------------------+    +----------|--------------+
>                   |                                         |
>   Kernel          |                                         |
>   +---------------|-----------------------------------------|--------------+
>   | +--------+ +--v-----+                           +--------+ +--------+  |
>   | |dmb_desc| |snd_desc|                           |dmb_desc| |snd_desc|  |
>   | +-----|--+ +--|-----+                           +-----|--+ +--------+  |
>   | +-----|--+    |                                 +-----|--+             |
>   | | DMB C  |    +---------------------------------| DMB D  |             |
>   | +--------+                                      +--------+             |
>   |                                                                        |
>   |                           +--------------+                             |
>   |                           | smc loopback |                             |
>   +---------------------------+--------------+-----------------------------+
> 
> - Benchmark Test
> 
>   * Test environments:
>        - VM with Intel Xeon Platinum 8 core 2.50GHz, 16 GiB mem.
>        - SMC sndbuf/DMB size 1MB.
> 
>   * Test object:
>        - TCP: run on TCP loopback.
>        - SMC lo: run on SMC loopback-ism.
> 
> 1. ipc-benchmark (see [3])
> 
>   - ./<foo> -c 1000000 -s 100
> 
>                              TCP                  SMC-lo
> Message
> rate (msg/s)              79693                  148236(+86.01%)
> 
> 2. sockperf
> 
>   - serv: <smc_run> sockperf sr --tcp
>   - clnt: <smc_run> sockperf { tp | pp } --tcp --msg-size={ 64000 for tp | 14 for pp } -i 127.0.0.1 -t 30
> 
>                              TCP                  SMC-lo
> Bandwidth(MBps)         4815.18                 8061.77(+67.42%)
> Latency(us)               6.176                   3.449(-44.15%)
> 
> 3. nginx/wrk
> 
>   - serv: <smc_run> nginx
>   - clnt: <smc_run> wrk -t 8 -c 1000 -d 30 http://127.0.0.1:80
> 
>                             TCP                   SMC-lo
> Requests/s           196555.02                263270.95(+33.94%)
> 
> 4. redis-benchmark
> 
>   - serv: <smc_run> redis-server
>   - clnt: <smc_run> redis-benchmark -h 127.0.0.1 -q -t set,get -n 400000 -c 200 -d 1024
> 
>                             TCP                   SMC-lo
> GET(Requests/s)       88711.47                120048.02(+35.32%)
> SET(Requests/s)       89465.44                123152.71(+37.65%)
> 
> 

Hi Wen Gu,

I did run the tests again with the v6 and reviewed the patchset. If you 
decide to address Simons nit feel free to add my:

Reviewed-and-tested-by: Jan Karcher <jaka@linux.ibm.com>

Thanks for your effort and contribution.
- J

