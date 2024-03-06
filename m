Return-Path: <linux-kernel+bounces-94066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBF873959
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C9E1F2135B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93E133994;
	Wed,  6 Mar 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jwh/NWSx"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6089132C0C;
	Wed,  6 Mar 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735901; cv=none; b=KvM7e8qExEEF5usYZFI8C/t+KDYhvT/CHV4HmEDDdb/Y5eNkzRBeXLPrhZNm59dsswRSqPLdjwrxyrKaiehhlRExgJ5CocGCt2q+mMZsGy9YKWxBHP7CWoVFS1lfHbdnqewS91L39vYa+7/ER+3K1SZZPdhSmlHcX0qrMLk9g1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735901; c=relaxed/simple;
	bh=MPbTgE3wEX5Gq5cxMoyeMt07mKpUEazcQ9bpo7e/Bgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2bg5zxWmSnETsyL1YoY9Wo10sXlMPbS7Ktfcmig3YyP/eGx6lT/YX6wSPL5tWLRbnmg3psLSjASh1IiFWiAai5DFy5qWZSKQbTnGWPb2eqpBtKWz15CY8kc1gfbRYvXcbqAxWQJhTAxWhYO+Aewmu/+vnXkWiaIXCY1s8ltAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jwh/NWSx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426EWmQD015711;
	Wed, 6 Mar 2024 14:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MPbTgE3wEX5Gq5cxMoyeMt07mKpUEazcQ9bpo7e/Bgw=;
 b=jwh/NWSxdrS4gxykgRpV6I97opFm119RI/1HqeRzqlUREY/HXbqkf1dz155EfEiSBr0j
 /aFtn8836RqlQKQ5SOiIIcFI5lTrqaGZDBt/cZqNizxlJJgSBz44+aYb1g7nHuFgBF4n
 hkjpEIKG6P9zR0Pnnd4L/eooxVa7ENrDKg29grjviDWMr/MVoL9H7j8jVNk5K4spEC2t
 ja8QGC60aF9z4CCx3k3clhu3j2QFIvLLkbzwLhLCClIcWuOkZKBSz5EXeribufD3NTMr
 WhaOOETzJ3VMWnwRolfsDEnp5yi4v+xaYhr0baXUDZfU9Cu53iL/KTf2fKm+7BeeFPzf Uw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wptba85xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:38:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426BlJ3Q010907;
	Wed, 6 Mar 2024 14:38:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52esjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:38:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426EcEJY34996606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:38:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A636658062;
	Wed,  6 Mar 2024 14:38:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1274F58058;
	Wed,  6 Mar 2024 14:38:14 +0000 (GMT)
Received: from [9.61.98.245] (unknown [9.61.98.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:38:13 +0000 (GMT)
Message-ID: <af844258-135c-45a4-a796-766c496c4018@linux.ibm.com>
Date: Wed, 6 Mar 2024 09:38:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] s390/vfio-ap: Add sysfs attr, queue_configuration,
 to export mdev state
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-3-jjherne@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240306140843.10782-3-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y47MD88-TAPze6iVO1nLMIkwLLKfMLXb
X-Proofpoint-ORIG-GUID: Y47MD88-TAPze6iVO1nLMIkwLLKfMLXb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=958 lowpriorityscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060117

On 3/6/24 9:08 AM, Jason J. Herne wrote:
> Add ap_config sysfs attribute. This will provide the means for

Title of patch is wrong due to attribute being renamed.

s/queue_configuration/ap_config/



