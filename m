Return-Path: <linux-kernel+bounces-129644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11C896DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7941F28643
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79E14199C;
	Wed,  3 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dcL+CNGP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186071736;
	Wed,  3 Apr 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142627; cv=none; b=GJOUlFu6LUYExCyqV4yjaIVXqsw5lfOp770NwK8lGlgqUrmOxlnFwLD62WU9J9U6QHjejhsvGZs7+3zEeZz5IZSl47RN/At/wI8K6hI9YA+wEotGBujqlQDKa7XJJhnAgY4I30BAeXozLeeQYto7LFNQFe0B4HHRxj1PIvXQ1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142627; c=relaxed/simple;
	bh=PXKwheSMBDHAhole9euixLRVwgV5Y8aJZfZi6SaclZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7Xsqd1jP/GRifX5IFfj6qG/G4QDTyffIsK1tgl7XdsZlgKqUHEkEyfjCtlwAXbsFbet8KHPLrNgDUmo8ykQMdn/zB9hBloUwRuIprnamI+/uZRbYTfi9ZktxlTIOdGTTryhsjJS2UtKF3WDzYQ7b3W8RlSm1q615BEpTKjtbRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dcL+CNGP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433B7kJp010399;
	Wed, 3 Apr 2024 11:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PXKwheSMBDHAhole9euixLRVwgV5Y8aJZfZi6SaclZ0=;
 b=dcL+CNGP7Eadz1zNz40SHzP4iD9G4+GZkntxxtjeyhRMzy4/LcilendHiNNhltu99x7B
 0v1Y15/Ok6YWwGGIoZU3s8ciYZDo8+VvJGym+B2h8paV11kPlDgk40roeoFqMMNkcCFd
 elvGVratBa2rCY2maudjLjxtXhtL0M5ikzVREQK73Vpit/kkfkwh68hII8+1IjB4VyBu
 qokUmsZ6zx8z6ZgITgfr30Nfwnzcbn/o8rnplON41PIgzZkjR/hkaNY0Ao08RrtEhJ79
 VyavQIDlegdWU3Ar0YVTPyRA5U4vgiU4lya/dlWCm1y1YA/tLUP8Mg5Zp5bx55GXtI6U Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x95y3r07d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:10:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 433BAJdM015185;
	Wed, 3 Apr 2024 11:10:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x95y3r076-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:10:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4338hKvA025753;
	Wed, 3 Apr 2024 11:10:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6x2pcuhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 11:10:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433BACJ152494712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 11:10:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6824B2004B;
	Wed,  3 Apr 2024 11:10:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5237120040;
	Wed,  3 Apr 2024 11:10:11 +0000 (GMT)
Received: from [9.171.60.51] (unknown [9.171.60.51])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 11:10:11 +0000 (GMT)
Message-ID: <27deaa5dbb30c467fcdaa0667ef39da86bcee03f.camel@linux.ibm.com>
Subject: Re: [RFC PATCH net-next v5 00/11] net/smc: SMC intra-OS shortcut
 with loopback-ism
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Date: Wed, 03 Apr 2024 13:10:11 +0200
In-Reply-To: <ae3ea4bc-4a9c-416e-a593-2885fea96ae5@linux.alibaba.com>
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
	 <ae3ea4bc-4a9c-416e-a593-2885fea96ae5@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ce7qubRAeV5EEZsVKMQkzEKCIjVunFNz
X-Proofpoint-GUID: XoV1yXKEtnqtlaIox7kFaZuWPWP8Qgya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404030077

On Wed, 2024-04-03 at 14:35 +0800, Wen Gu wrote:
>=20
>=20
> On 2024/3/24 21:55, Wen Gu wrote:
> > This patch set acts as the second part of the new version of [1]
> > (The first
> > part can be referred from [2]), the updated things of this version
> > are listed
> > at the end.
>=20
> > Change log:
> >=20
> > RFC v5->RFC v4:
> > - Patch #2: minor changes in description of config SMC_LO and
> > comments.
> > - Patch #10: minor changes in comments and
> > if(smc_ism_support_dmb_nocopy())
> > =C2=A0=C2=A0 check in smcd_cdc_msg_send().
> > - Patch #3: change smc_lo_generate_id() to smc_lo_generate_ids()
> > and SMC_LO_CHID
> > =C2=A0=C2=A0 to SMC_LO_RESERVED_CHID.
> > - Patch #5: memcpy while holding the ldev->dmb_ht_lock.
> > - Some expression changes in commit logs.
> >=20
>=20
> Hi, Jan. Do you have any comments on this version and should I post a
> new patch series without 'RFC'? Thank you.

Hi Wen,

Jan has been out sick for a little while now, and Wenjia is expected
back from a longer vacation tomorrow. So if you could hold off until
begin of next week, Wenjia might have some more feedback.

In the meantime, I'm looking at your patchset...

Thank you, Gerd



