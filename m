Return-Path: <linux-kernel+bounces-94072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BF873967
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398891C21675
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2307280605;
	Wed,  6 Mar 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="exAp0xZo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD97FBBD;
	Wed,  6 Mar 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735969; cv=none; b=A0n5qa3XmslSMEgKF/88Rt5++Xyd+ADKk48LaZX+aG7EVqro+/W9JHr/+y+BrF3g2dhRSlmSi+Gnx+ebiUckbUmFkkOHlAornJQ1RTYWsTaP+9Skkt3mjGPMrp19N0gQkSbZlXArq4Ki+AkgVDrKMdEjnOulIOp+RlYPSYZWG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735969; c=relaxed/simple;
	bh=uFNis3ZWg2J/Icfb5EGQhrnU/IkLtqwD+T1BNDd78sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t49JOSp/aQx1+uz6Dx3Km351ZYRhoFdxXWl5hTbHnSrBby5lMl7XMQp1PITkYba+0brmUBoTBMdq80F6F8QXMVgPcSCeBhkH+DgVPiyQbd5Yjxyn/AL1LmBA3kHqa+Z8oL7IweiZwWVjVMuWEIxDRF0WHW3FInqsPyu5ksIPsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=exAp0xZo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426EIPM1022810;
	Wed, 6 Mar 2024 14:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9MjMXHKy6jWDZUtSI72fGNzKWYqZG5VrNR0uZ6ohfeQ=;
 b=exAp0xZoDuNdX7ofueejvtV0vntwTLMov5XrjHaWPjIlaR2LFq3ywY8n1Q1LY4JoKcY6
 A72NAxs2bzdl4xMX2ivjLifU1lcZ5HdCDeO7OQlwc778cqk2B4hxXiKJj3SXdUQaB5q5
 8aC3QzbE4DGsLp3gFH2TES+C8Exb/EKjDL+3/QuQ+CxclZchX7Nj2PlsuSXL6zhZneQq
 WSKplnnLF0tD9U6Sd3p0THwtQ9VCW0DaNdUNY/xICFVj9sPYO9XDuN/XYm0yzi3Pi+ha
 KhNwUmJ+ybCmcVg0Qq0M7xh3wxqbFK4oiLReDeyWJH9/tusQhlo9wIvCvPyusigbwLsg Qw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpt4mgpmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:39:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426CCtb3006045;
	Wed, 6 Mar 2024 14:38:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeet7g2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:38:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426EchwR27132668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:38:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EB5458064;
	Wed,  6 Mar 2024 14:38:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABFC758067;
	Wed,  6 Mar 2024 14:38:42 +0000 (GMT)
Received: from [9.61.98.245] (unknown [9.61.98.245])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:38:42 +0000 (GMT)
Message-ID: <2fa94183-b015-4247-986b-562f3ed0306f@linux.ibm.com>
Date: Wed, 6 Mar 2024 09:38:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] s390: doc: Update doc
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-6-jjherne@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240306140843.10782-6-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nOtbj2hp6mfA_tsExe9TLW3hdsNoCCZm
X-Proofpoint-GUID: nOtbj2hp6mfA_tsExe9TLW3hdsNoCCZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=684 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060117

On 3/6/24 9:08 AM, Jason J. Herne wrote:
> fix me

^^ Oops, just needs a small message here. 



