Return-Path: <linux-kernel+bounces-28314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F982FCDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702D028DC69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A983609B;
	Tue, 16 Jan 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pBCDyTAq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D52031D;
	Tue, 16 Jan 2024 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441152; cv=none; b=aRN58YqO0b4adomtP9e2akTLNEw8NlKSY9gQGZIM0jOKpNuu86nAAvlEImJ3UEv0aW9b7jn4/Jt+oHmo/qv+dftMSoHA6vobpe/8PwvEtepXjGKz36cjB85jBHXi2k8GKGLbrQRym5aFhwlzfPdvSyavmCB34OMIzSY9/h7HYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441152; c=relaxed/simple;
	bh=9cVaDEGyE++XlGIZR4zuk6VP7XM32B9Tm1rS1HSDeWQ=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=qQr1HpIU9iSel7QLx3XO0MSfxy3K1/kAhI/W6I6CjKypWJHHUfuM3C998TymkCJLdePTZfa4c9zKUWuId8G3+UkhHyALTBgRhLf27QUHB5GyQ2jT/oxF7R7qfvdddByqIMhP8QlurC5qK6bBcgtHxd8YPnGhJ+Z1Tl9AD0ichcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pBCDyTAq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GLbCeX011034;
	Tue, 16 Jan 2024 21:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=C34bD3H/UW2o8lGJiE4Kl6JTQHvAgZThBzA+i3EkQj4=;
 b=pBCDyTAqmIHQUh+WookDoNH+IaXDelj8E17v4vrqhzDtkWmm7/W79f09VlO9RLAGsyDQ
 5XpT7BzXBzTjat8kOoLEtQhpr9KxbD+064D4h/Kv3zpIGju3wjpHoQsaR04CV45RsRLy
 mwDHnngbbdsjZJ4GoMXL9UeYcBYBpvvlqNYzpes9ouanXZZFKZJLU+y4Zn4mjexMEeC+
 J+JXb79X5lSv/4+BxOa9PQ1axgPBcfkRayp9wEdkfHZwtntkgxQ7MPF8hm3dI4B22KDu
 v1d0B+0w3llpJDEop1ib9yzyU1dw11yK3m8mXS4fZ3V3FytdkvKZTAW6yspngS4k46S2 ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp1vcg1jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 21:38:51 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GLcDTF016360;
	Tue, 16 Jan 2024 21:38:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp1vcg1hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 21:38:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GJ6ONT023421;
	Tue, 16 Jan 2024 21:38:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkh59q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 21:38:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GLcmas66912726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 21:38:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30145804B;
	Tue, 16 Jan 2024 21:38:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8250858055;
	Tue, 16 Jan 2024 21:38:47 +0000 (GMT)
Received: from [9.61.126.152] (unknown [9.61.126.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 21:38:47 +0000 (GMT)
Message-ID: <92007644-72e3-4312-b9e9-e93e5142e090@linux.ibm.com>
Date: Tue, 16 Jan 2024 13:38:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/42] drivers/scsi/ibmvscsi: Convert snprintf to
 sysfs_emit
Content-Language: en-US
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-23-lizhijian@fujitsu.com>
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20240116045151.3940401-23-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T9F9F6QalnDwMMGJCSEfB4HU9ZM759gq
X-Proofpoint-ORIG-GUID: s4AnZKTFZA-kPfDCUxWgqMxp7_K2Rqb-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=888 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160170

On 1/15/24 20:51, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
>> ./drivers/scsi/ibmvscsi/ibmvfc.c:3483:8-16: WARNING: please use sysfs_emit
>> ./drivers/scsi/ibmvscsi/ibmvfc.c:3493:8-16: WARNING: please use sysfs_emit
>> ./drivers/scsi/ibmvscsi/ibmvfc.c:3503:8-16: WARNING: please use sysfs_emit
>> ./drivers/scsi/ibmvscsi/ibmvfc.c:3513:8-16: WARNING: please use sysfs_emit
>> ./drivers/scsi/ibmvscsi/ibmvfc.c:3522:8-16: WARNING: please use sysfs_emit
>> ./drivers/scsi/ibmvscsi/ibmvfc.c:3530:8-16: WARNING: please use sysfs_emit
> 
> No functional change intended
> 
> CC: Tyrel Datwyler <tyreld@linux.ibm.com>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Nicholas Piggin <npiggin@gmail.com>
> CC: Christophe Leroy <christophe.leroy@csgroup.eu>
> CC: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> CC: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: "Martin K. Petersen" <martin.petersen@oracle.com>
> CC: linux-scsi@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>


