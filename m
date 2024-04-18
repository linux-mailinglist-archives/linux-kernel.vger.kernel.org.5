Return-Path: <linux-kernel+bounces-149545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9668A92A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08AA283785
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437858129;
	Thu, 18 Apr 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R05Xlx7k"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732054F98
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419696; cv=none; b=DESSatY75lGe7VuMZF4QgJ9lDi/gbAxVS0WkXJhSIUq7WNh2/3UMg09I6xr8/wkywzZU8FSk9qQoow1drBXVyQAGtocxbVG1Oy6K42d8JaaqFA8YlYuHlqOCLvi/Eh8b1jOoquA63m3lHWRgtCLsIYLx/K93deDU7zulYHL6DS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419696; c=relaxed/simple;
	bh=Dta0vAJakl9ltAvBEQo9z+tomPKR2apLFH5KibMRsic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7mezYojNJHVyVGPsK3GMDUVGW9vVtsJCiV5LiTCe1YYZSFxSBddDz3tQV17dAV/x1P0Z3O+gXmdgP+5s+mNgfxvHHCDIeY3bVYVguu05dktx0jNNveU08dJBE3Ig1/RfaGpPdl0exAA4JMd1JBdLMQyNWjCVO8wOSTZ9Xcdx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R05Xlx7k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I5hw2L025359;
	Thu, 18 Apr 2024 05:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=zji4ieS8KZrrkR5S0nDFSvldaGepLRbNNPwX/3FqofQ=;
 b=R05Xlx7kYiTIIE+ixpECAbFxmg4DznjGQKm6V0sTN6gq1Kowk3+xdLnErSKUacE/yhWR
 sxe6GBffRHQFdtL03bqRf/C2ZFQTe+pltn6XPBgrd7HAcuep2RZJXNg3lx5CJFl4A/th
 INY2m3tOVK/eoO6iiHtfQPmASvIpgIsbvC9x6ADkzueAu6/sXoZskiRtVqGeezXGmfe2
 8SoRWzxlh2cbPbci8Sm5jf8VkXpTlB7MllRh+TvL7wL3s+Ey2VA6+unGzQDJrIOKodin
 SZE7h3/RpdelGMis9noQdrLBvXFfKwD2xcqsRTT9gMDX3SlVB8Goc+ciS1Mh3OeBH2EL XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjwm5r0mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:54:43 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43I5shR4013277;
	Thu, 18 Apr 2024 05:54:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjwm5r0mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:54:43 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3mQ1Z027292;
	Thu, 18 Apr 2024 05:54:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4s09393-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:54:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43I5sbkJ52953542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 05:54:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5A3C2004E;
	Thu, 18 Apr 2024 05:54:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0ED2004D;
	Thu, 18 Apr 2024 05:54:37 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Apr 2024 05:54:37 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
In-Reply-To: <ZiB9rYBu-0qjsCbF@slm.duckdns.org> (Tejun Heo's message of "Wed,
	17 Apr 2024 15:55:57 -1000")
References: <20240415053550.538722-1-svens@linux.ibm.com>
	<Zh8EfxdVdiIj_27H@slm.duckdns.org> <yt9dpluogfw9.fsf@linux.ibm.com>
	<ZiB9rYBu-0qjsCbF@slm.duckdns.org>
Date: Thu, 18 Apr 2024 07:54:37 +0200
Message-ID: <yt9djzkvfc6a.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h9g76LQhiScCVJ6WSnsVVYL1jmPc983-
X-Proofpoint-GUID: pe_poYMMyp9JXmhABOKx908XPirAl4JQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_04,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxlogscore=738
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180039

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Wed, Apr 17, 2024 at 05:36:38PM +0200, Sven Schnelle wrote:
>> > This generally seems like a good idea but isn't this still racy? The CPU may
>> > go down between setting p->wake_cpu and wake_up_process().
>> 
>> Don't know without reading the source, but how does this code normally
>> protect against that?
>
> Probably by wrapping determining the wake_cpu and the wake_up inside
> cpu_read_lock() section.

Thanks. Should i send a v2 and incorporate your additional changes or do
you want to do that?

