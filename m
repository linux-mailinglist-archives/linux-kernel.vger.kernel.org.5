Return-Path: <linux-kernel+bounces-56159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D00884C6CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA483287AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA920B04;
	Wed,  7 Feb 2024 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dYAb6Uzd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D3208CB;
	Wed,  7 Feb 2024 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296517; cv=none; b=F+fFaDV9f/g1pVaYTpOa+ul9unmsEDeq/1q/PXPOtExWADbxfzrFGfEx15ezmT9aPu8+KWGTnzpltsqfALerhGF66sckm2eDbAlmzduNuThu9PBYVzrmtcskGUn3z0IWUG5GgJDui8GtPRW1A5gFPHTY6TlfLgymgRPr4HXqy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296517; c=relaxed/simple;
	bh=Zj2QIX8l4a+3oazGzkW/WNaFptGujW6IhZq4Jt8IOGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZVlWRifnrQI+ExDjhn60+11gMlgwyZUuoZkrFO0yltw54cYsfcQIxg65EwTVxyT8zOzl4N7yaVGBUSPK3DigQUZVSfFBKUgf118Qqnm0cEWvQW7BeBJWO6iOmxdjFkC54l3r6hSiJKktik8u8CwXPN7FaAQDjYOqJt7SmdM8hmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dYAb6Uzd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4177uIlZ006238;
	Wed, 7 Feb 2024 09:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JJC/QrB0rQVjHWSV3wo0MWhhs0IRMlFhHbrgcuk3FHM=;
 b=dYAb6UzdUKBYWiNmlKa35j2MBm66PwHxoTzolmaxOuPaWav9tFqPjqi1/WZfWkOpPJdA
 lx9+Glm21CoTomcQdSmmMgtne1XU+xatQcP9ayOX+0nptAr93E326VJSsjWQhxlg6MjH
 alJSRTK/9TCJHjTJIkYb4KKjdAMZSnyuTBswNOVELJBdO+UumAHpgaWFrHfEiDa93dHR
 xAQg7JsRzD8e+aMmiyrlJrhX39nbO6SWsUHOFYJXVVWb/pjvg6zcPqO2AFzi7LFq+LE2
 n2UlWjedzHj1UW7Q3glde63XdAA0TFpZysgoQsnKRpb9H+DkwKAOoQG0kHuPxI1iOglS yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w45wm1r3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:01:49 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4178Znw2014074;
	Wed, 7 Feb 2024 09:01:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w45wm1r31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:01:48 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4178Fk3W005430;
	Wed, 7 Feb 2024 09:01:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21akmjg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:01:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41791lj813500936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 09:01:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1B785805C;
	Wed,  7 Feb 2024 09:01:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40A1158064;
	Wed,  7 Feb 2024 09:01:45 +0000 (GMT)
Received: from [9.171.63.25] (unknown [9.171.63.25])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Feb 2024 09:01:45 +0000 (GMT)
Message-ID: <e3128bac-3b84-4c94-978e-13cd5d3a030d@linux.ibm.com>
Date: Wed, 7 Feb 2024 10:01:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: change the term virtual ISM to
 Emulated-ISM
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240205033317.127269-1-guwen@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240205033317.127269-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B72NncwvoQ9_tatSul8v4R527_Yd7QIF
X-Proofpoint-GUID: mAYV4nrZDB_upUAteNv2zPn6AHla-Tjd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=797 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070066



On 05.02.24 04:33, Wen Gu wrote:
> According to latest release of SMCv2.1[1], the term 'virtual ISM' has
> been changed to 'Emulated-ISM' to avoid the ambiguity of the word
> 'virtual' in different contexts. So the names or comments in the code
> need be modified accordingly.
> 
> [1] https://www.ibm.com/support/pages/node/7112343
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

It looks good to me, thank you!
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

