Return-Path: <linux-kernel+bounces-14482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472B821DA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003341C22024
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384F11708;
	Tue,  2 Jan 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qoxBGGkr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C811194;
	Tue,  2 Jan 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402DiaPn028526;
	Tue, 2 Jan 2024 14:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=L9wsvGMZSJp3/jakokQi4h502LASYRmsodDRfbt57OQ=;
 b=qoxBGGkriObmkRHbAbAUQjd2XgP7A9KuX2IVb8ThgO+8eZk82+1qkhA7fLA02shbeD1g
 SXf6lQW4K3H0WpHfLQYY3jjIVhi2KBFOdSVls4KhaDAGMq85HbyHlVIfilwhr5x7/4aZ
 abodRpg1wXpQqQ1NijOVp7ACRxB2rXiI/tB/xO3Plw3otNAgTo8z5eyVo+Fz6n36FF3R
 q7HnW7L1j7wNkEt1utZgh5yXlazwgUtFzqSF/Od+PkmqhaeWcD8rq2/oiGYYUb18Idaw
 kVv1xNEdMQnFJyO1/6vhFPTxfXbSb06a8f2zc5/fcsbQCcWODDvTuZCjjulxabGNd2rS Vg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcjqut883-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:30:21 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402EKUji019424;
	Tue, 2 Jan 2024 14:30:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sce2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 14:30:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402EUKVX20841146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 14:30:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7427058057;
	Tue,  2 Jan 2024 14:30:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CC8A58058;
	Tue,  2 Jan 2024 14:30:20 +0000 (GMT)
Received: from localhost (unknown [9.61.111.122])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 14:30:20 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
        "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>,
        "mputtash@linux.vnet.com" <mputtash@linux.vnet.com>
Subject: Re: [Mainline/linux-next-netdev/net-next/scsi]Dlpar remove, drmgr
 phb and pci remove operations are failing
In-Reply-To: <2b1814f7-c7a2-4ea3-8bc7-abd8712ebef8@linux.vnet.ibm.com>
References: <2b1814f7-c7a2-4ea3-8bc7-abd8712ebef8@linux.vnet.ibm.com>
Date: Tue, 02 Jan 2024 08:30:20 -0600
Message-ID: <87v88breo3.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 95FaDXZkav18y2DRoiU7nROnM0bySmGv
X-Proofpoint-ORIG-GUID: 95FaDXZkav18y2DRoiU7nROnM0bySmGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020111

Hi,

Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com> writes:
>  =C2=A0[Mainline/linux-next-netdev/net-next/scsi]

What does this mean? Are you reporting this issue against four separate
trees?

> Dlpar remove, drmgr phb and=20
> pci remove operations are failing
>
> command ---> chhwres -r io --rsubtype slot -m "managed system name" -o r=
=20
> --id 6 -l 21030014
>
> output --->
>
> HSCL2929 The dynamic removal of I/O resources failed: The I/O slot=20
> dynamic partitioning operation failed.=C2=A0 Here are the I/O slot IDs th=
at=20
> failed and the reasons for failure:
>
> Jan 02 02:20:22 caDlparCommand:execv to drmgr
> Validating PHB DLPAR capability...yes.
> Could not find drc index 0x20000014 to add to phb list
> There are no DR capable slots on this system
> Could not find PHB PHB 20
>
> The OS return code is 3.

This isn't really a useful report to send to kernel mailing lists. This
is a mixture of output from the HMC (Hardware Management Console) and
output from drmgr, a powerpc-specific utility that the HMC invokes
remotely on the host. There's no indication of a kernel problem.

This is just a guess, but please ensure your powerpc-utils package
(which contains drmgr) is reasonably recent. Versions up until something
like 3-4 years ago don't understand the ibm,drc-info properties in the
device tree and may experience failures like this.

If that doesn't help, there is likely some other issue (kernel or not)
to investigate here. Your best route to a resolution is probably to file
an internal bug and make the test environment available to a developer
who can look into it.

