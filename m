Return-Path: <linux-kernel+bounces-43460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097C841420
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C071F23885
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595876048;
	Mon, 29 Jan 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ROQEn3dG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429B2E3F2;
	Mon, 29 Jan 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559803; cv=none; b=FXEOnBQzlbw64Ie6fCeAo8BJzm+7TXTOWaXuTyvwBe5NvoKAf7O3fkTNqWea4mg52j5upDf9ITHZOn5lDycfRvg6+iI2cq5EzlKX4JHc3ZfKzEPJnnUQQNRm1kGm96KE0P1WJxpfcQUvHcapGx/CApq27OjVpI37SeM0jGuowyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559803; c=relaxed/simple;
	bh=ng67tQAotflyJT8MM8DQxHPAa5NapeZ42TmR+0qZB6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuUVctlR+qfndQwXWFa6AS5dDxcW9YS3qydYgG7VEpV/jYfsdVGNjnzkKMY1Glh/El2m/99Fze4VV46qnNqLdBxvQ5BK7Pue6wbB0CBHmarR8FI+cAapo3cDLNTmOjUhTD/b6P9ROfSIQCTHmZFvk27Sb9y6kvtOU+EzJOPYEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ROQEn3dG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TK7uKL001881;
	Mon, 29 Jan 2024 20:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ng67tQAotflyJT8MM8DQxHPAa5NapeZ42TmR+0qZB6k=;
 b=ROQEn3dG+GKYUIHaYU/4KupMJ14NZ0Ca6gbllIpnW7IdtVbBCZFqqGrUMbzvsWiQ2onF
 jI5SJD+k6TJFbXWhXDj+BpI/t+qy2PQeWVRedURpb/J1gU0yBi+sALO73BbmJD850tyU
 IrNW8MJNTnGYcfC3WXhyePuaKWQpytOuwnXSkfpgQzZco74j2sF1IQr8NTrMaxE1Kfck
 tMqBj4KaQM8Vp5HQq2dThOXZjdU12A92ZWa8QvgJtr04miZR2HK9EtSXEyoheWHih43P
 mejqXeBJmGT5cLp/gpBKaDq4ht1Ou3HWcZd51E0bWZy/PXDtbLN0lqV/lAMAX6Ln8blf ag== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxjsk0axn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 20:23:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40TItE9l010887;
	Mon, 29 Jan 2024 20:23:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwecka3f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 20:23:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40TKNID939060028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 20:23:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FBAE58059;
	Mon, 29 Jan 2024 20:23:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1FC258055;
	Mon, 29 Jan 2024 20:23:17 +0000 (GMT)
Received: from [9.61.48.115] (unknown [9.61.48.115])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jan 2024 20:23:17 +0000 (GMT)
Message-ID: <4696b237-091a-437d-b1ba-d6327533ee22@linux.ibm.com>
Date: Mon, 29 Jan 2024 15:23:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] s390/vfio-ap: queue_configuration sysfs attribute for
 mdevctl automation
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com
References: <20240126143533.14043-1-jjherne@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240126143533.14043-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aO9YdwCOEvgUbllk-QKcH-KOTttOSGXX
X-Proofpoint-ORIG-GUID: aO9YdwCOEvgUbllk-QKcH-KOTttOSGXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_12,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=797 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290150

On 1/26/24 9:35 AM, Jason J. Herne wrote:
> Mdevctl requires a way to atomically query and atomically update a vfio-ap
> mdev's current state. This patch set creates the queue_configuration sysfs

s/queue_configuration/ap_config/

Same comment also for patch 1 commit description + patch 2 title.


