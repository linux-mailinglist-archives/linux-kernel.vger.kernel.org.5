Return-Path: <linux-kernel+bounces-144776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8A8A4A97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D122B1F23FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BAE3B297;
	Mon, 15 Apr 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+D8zPfb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC23FE5D;
	Mon, 15 Apr 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170507; cv=none; b=hP1y2SnRI5FsI0PQaGy5AFqSroLMRXGhNZs5pCRG8t6idQa56KZ1QSoToYiqkKqBwHr38xpOrMdrNHikGrYNlnEIuSE8O/k/BZEAbIbG4gtuhx7mUM9UkB/2m3aIYm+HHoCNtm8E+Vsz1LcVCQdlBpJZOXU2ci9nVDn4R2FesV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170507; c=relaxed/simple;
	bh=7SORiU4shsWpZ0cGSl/ZJwxVqtAvvRLpEiZ0sdTzGuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiFaIkvaktuaYNXMzKqNnoTQvbYOHB1xU+/suM8w4Lzb1gjX4cl0TOh7Q1aEp+sv8x0jXsG8lKXOHdNZWecGX7n1xBgTHkKsl+TFDdBLX9q9p3QVlBGU1hUhAI7nWkoteNHr12IJtICq/hJV9RsLZ8HJyiSDJs5vt3zxRIO4iAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+D8zPfb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43F3PK4C023259;
	Mon, 15 Apr 2024 08:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=egqo3iTg7vXMcfRfDBzI5al7YP7luBSca8DUzS4Mp8A=;
 b=L+D8zPfb6fU46rTtaTkxZ4nCRlftT+hXJZxP3BSbsbzb+4ZSxLuHkbAyQdXO+neP5ZZU
 nAvJBcuuRyxW49kAqJITqjdiMODmkpEVA6eGkI3mkdRROeyKPiDhUH//SH9k8kXMVCTZ
 iz+1a6kKNKfshw8iZg8+jTA2gwf8E4IfDn12EPeAucpwxRnIvJcAfgsFBQhKdRQ2Omwv
 BfOb8VHS9fOXVKjfDV5gVRzhIbSXr0Jrs1+/dtVbdbzbs7kNnV5/GBbk6A6bMeX4ZJva
 GeCCfkuib38WlvklNCcvviEIqXQujm9cs8vox8WANjIbIARyjofMrnvX6/DuMeMM5snv iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhsd3ees-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:41:40 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F8feVX029314;
	Mon, 15 Apr 2024 08:41:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhsd3eem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:41:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43F7UxAT011111;
	Mon, 15 Apr 2024 08:41:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg7326cfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:41:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43F8fXQF47907286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 08:41:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7376020043;
	Mon, 15 Apr 2024 08:41:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 808C620040;
	Mon, 15 Apr 2024 08:41:32 +0000 (GMT)
Received: from [9.171.17.66] (unknown [9.171.17.66])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 08:41:32 +0000 (GMT)
Message-ID: <c7f6be91-6591-4b00-95c3-48417bf98ac1@linux.ibm.com>
Date: Mon, 15 Apr 2024 10:41:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 01/11] net/smc: decouple ism_client from SMC-D
 DMB registration
To: Wen Gu <guwen@linux.alibaba.com>, twinkler@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-2-guwen@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240414040304.54255-2-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VyKdymiKN2yGTsfh4upxcjoyes97lM_-
X-Proofpoint-ORIG-GUID: SoDffycIF7sHlVzV8EEaVAgQ31Cj4La0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404150057



On 14.04.24 06:02, Wen Gu wrote:
> The struct 'ism_client' is specialized for s390 platform firmware ISM.
> So replace it with 'void' to make SMCD DMB registration helper generic
> for both Emulated-ISM and existing ISM.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

Just a thought:
The client concept is really specific to s390 platform firmware ISM.
So wouldn't it be nice to do something like:

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 78cca4839a31..37dcdf2bc044 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -747,10 +747,9 @@ static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
        return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
 }

-static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
-                            struct ism_client *client)
+static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 {
-       return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, client);
+       return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, &smc_ism_client);
 }

 static int smcd_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)

--------------

This is not a real patch, just a sketch, but I hope you
get the idea.


This may be a step in the direction of moving the ism_client concept from 
net/smc/smc_ism.c to drivers/s390/net/ism*


I know that there are several dependencies to consider. 
And I haven't looked at the other patches in this series yet in detail, to see how you solve
things like smcd_register_dev. Seems like smcd_register_dmb() is the only one of the smcd_ops
that you need for loopback and uses ism_client.



Wenjia, Gerd, and others what do you think?

