Return-Path: <linux-kernel+bounces-154927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCD8AE322
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD40B20FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5E078C6E;
	Tue, 23 Apr 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mnOHMW3L"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F825762EB;
	Tue, 23 Apr 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869637; cv=none; b=YLCQDmPITiQB3aKZMLhYCKfT/Cl4rNkcGFKRjNCl5yKn48qJrvp/6OVKSgRnJnUrImmKWWA+1nnpq3HdVrLxEPPVgXKae6iqiQfEBbPuazOFYq1PDZtMWZp7SLn/rTGkevW0aM7hncvEa4ugUkxjDij8EvOATi4bwDlBrSM6rTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869637; c=relaxed/simple;
	bh=v/MnNKfPf2UxE/AeWBCU0So5tHhCb33++anZ1EvsT88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0tN6zEgt6r6pEmBAGnE0+WIInhpJg2wmzvFlI2XWExi1UVVx3TLhMjs0+pPfvo2vUPy5uPEhGHK+5nhS2wpn+XQD4zd8XwxRFSrXY2vPmxEwT9pGYwzukeezqsMQ25VD9aRW8FCso6OaZ31ckoZWXe6gP0rurS+dyVDHp04L6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mnOHMW3L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NA3R0m025316;
	Tue, 23 Apr 2024 10:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1ji91CIGqetCWhV6BnbSd4ejvs7Zy4xxJczLSZVIAIM=;
 b=mnOHMW3LnRh3gjUH/nJ/L+cXprTwV6RtZQmvE7JAVdxNtn7tNEJq8vGpkn7AYDsxGuea
 btGBxl1cl8tR4j4w5g00Rsi2lv+NVa2dWGe5if42BS4dh0E8j2fGbIYj8So6wbfzuctB
 ykv3J0z3fMz1MTpHcYX881jFM1ePHSijX62F98fLVzSMrlgJMQnou2XLVNf4DkQIxVbW
 Qm3YdqcsxVe9ouyG/zF2hdfmI+eSIjvDl7gPSWXYYSQ7zK7aR/MgMlcw3ZA9/bVgIKmR
 uaJXDt06Rw7rGzizBQluOb5UVt0U6KPZIt2Nyyi+ymCvMbvcTRBBojwo7FrHCxZ9NZwj Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpaw302tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:53:46 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NArjGL010095;
	Tue, 23 Apr 2024 10:53:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpaw302th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:53:45 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N847el023068;
	Tue, 23 Apr 2024 10:53:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1nw3pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:53:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43NArgdC6423168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 10:53:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A934D58059;
	Tue, 23 Apr 2024 10:53:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7AD25804B;
	Tue, 23 Apr 2024 10:53:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 10:53:41 +0000 (GMT)
Message-ID: <370f9aa6-ef55-469a-ad42-94bf535e0eb8@linux.ibm.com>
Date: Tue, 23 Apr 2024 06:53:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations on
 stacked filesystems
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, miklos@szeredi.hu, brauner@kernel.org
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KgyvGzNTVDgZXbleLvvP1tXFu30p9Uqv
X-Proofpoint-GUID: Mdd4vI1AK8TyMyLwNPe0WwQq3zIpXCVF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=665 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230029



On 4/23/24 02:02, Amir Goldstein wrote:
> On Mon, Apr 22, 2024 at 6:07 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> This series fixes the detection of read/write violations on stacked
>> filesystems. To be able to access the relevant dentries necessary to
>> detect files opened for writing on a stacked filesystem a new d_real_type
>> D_REAL_FILEDATA is introduced that allows callers to access all relevant
>> files involved in a stacked filesystem while traversing the layers.
>>
> 
> Stefan,
> 
> Both Miklos and myself objected to this solution:
> https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com/

Thanks, the RFC has achieved its objective now.

    Stefan

