Return-Path: <linux-kernel+bounces-94068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618D87395D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCBF1F20FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BD11339A4;
	Wed,  6 Mar 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SHV5oe83"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66B133402;
	Wed,  6 Mar 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735920; cv=none; b=kvO2DfekhgMbVkOG6jb6GIeE2VLmUgAerXiGmreubC3DzCNFDMwX7dYA/5//g5Nj3mnL/WJJfUYy19M86EfxXqJkg9bp9Oaol3OO8fCiV1VNK7s6sFObdVuvZj7peCfamwM9B/5YG5nijf9p+ywe1HdIFLkbD3McP8qVlOX/79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735920; c=relaxed/simple;
	bh=Yf4MHxQthnFR/dx45jlpOzOaI1mqqpzufVpPExV2Tcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIh3dJxY9c9UiQ25Do7zoqWg0ZS71Bbg1EB8Pl0sHY1lT4b5OXsKQA4PW1ruyazZ9Q2JFpFAoP0N7bc1R4MunH2b3dHCUgr3iWMjBEPA+Vb+hdOowysnaF8MDkXhq5PqImrxh/HSH7W8YNu69hSV+r3avmiIzzOyT/gTAaZ1VTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SHV5oe83; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426EVCWd027065;
	Wed, 6 Mar 2024 14:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Yf4MHxQthnFR/dx45jlpOzOaI1mqqpzufVpPExV2Tcg=;
 b=SHV5oe83MarqzN1yoVQ5BAHkkXqofopRop3yAOjhtG5s1USePqLoiZr67pcRgH8eVZ06
 7LNL5WAXTiTdvemmyWzfpGiX/e0tsVFspn5aamoukNl4YYgqRNJyAc91hzUT1WtLL9F2
 7uMx7S8Ml/ABnRud/SUwHs7d50UexFUgFV7PBLfxyZRhyAG1bStKbTgyi4LRRxA+Rns9
 X2WOO70YVtkYCAIcs9O34knOPfNMxQzK6NcrpJ/tWzZshtCWk1AklG2pdhve6MGKHYn2
 emA1Wj6Wf57fVzogRt9sc+Iq34lV7/3HgS8VSvflFihuh76UQMvzdq44Px+wvzcIdpyO xQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpsw29331-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:38:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426D0S9j025375;
	Wed, 6 Mar 2024 14:38:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmetyqd3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:38:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426EcX2415139482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:38:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB8375806B;
	Wed,  6 Mar 2024 14:38:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F0D58058;
	Wed,  6 Mar 2024 14:38:33 +0000 (GMT)
Received: from [9.61.98.245] (unknown [9.61.98.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:38:32 +0000 (GMT)
Message-ID: <fc37513b-9e39-4a3e-8266-e3a6c4adb876@linux.ibm.com>
Date: Wed, 6 Mar 2024 09:38:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] s390/ap: Externalize AP bus specific bitmap
 reading function
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-2-jjherne@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240306140843.10782-2-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pbWj3b5wXpd-fICTVpnEToHASYpKEgUU
X-Proofpoint-GUID: pbWj3b5wXpd-fICTVpnEToHASYpKEgUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=776
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060117

On 3/6/24 9:08 AM, Jason J. Herne wrote:
> Rename hex2bitmap() to ap_hex2bitmap() and export it for external
> use. This function will be used by the implementation of the vfio-ap
> queue_configuration sysfs attribute.

Here as well.

s/queue_configuration/ap_config/



