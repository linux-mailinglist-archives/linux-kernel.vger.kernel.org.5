Return-Path: <linux-kernel+bounces-148830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFEA8A87DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6AB1C21D12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672B15D5D6;
	Wed, 17 Apr 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sLrGmXBv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63C1E4A8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368208; cv=none; b=LfOERtx2O5L0QfivhfSMrENVSqWq2N7xljCbF3A0ucuhbTpZOZT1IaGMUWCMMhfn4OUN93l+N17GF+8z+6H40VU6uiL8JvhXJaBTaeeI8ya3zSPZF/ruMoEepEyqzsqdUzvbx17nHM12SomSzRXoSgGPx7Uk3xKovqYTmz4NEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368208; c=relaxed/simple;
	bh=owGat6Mu5fO9cWahPM+lcjOAn1FXNYcwqZxx6gKuYf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8u2m2k6bGTb6weBnDQy9kJ3XyIKqLEcrJ8ylUbPGEEevY257xPuiBH1x5ixsgB2HbgunNYauQA2wKXChjNL8Ybg7v5ZObdSHb3ghpZEQzH1yhWzxWtK9zZqGAwWzzFdyoeIC8dwiMCue9k9gZ63znylE8NXUpwj3zCgcteKGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sLrGmXBv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFXg1c025547;
	Wed, 17 Apr 2024 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=aOKo+eCl/oXHennbdRCEZwxJ7TsgtErfOrGVE7Zdnww=;
 b=sLrGmXBvT+EywmaiURHgJDxFgKdrzuiIjar2ahx+/0gOgRHsyuv83zmldkltuD0pqu/8
 ps70BH+8Gxn3TNBJeSslq+FSmB1PFa+B7T6Swz8kzsS+PaGLclcVKD1KrzX0ToeWCTDe
 7e9fkqpNKTCnNGeCePgSws8g5GF0rLwlP/EuGag47YGltFQ+KN6BTD5uaKXcwM1W0xlW
 DVdZUc7UmTuLeli7OjC8agCiiFmHfyGBmpfnDZAXIw9nxavAtztTPRPiyWsPdXmrbeMR
 Sx+mJAwkOfpKh5nEVIrsFiqkdmTEJyzNOi1dyGfgSBJkvkXEdgkYBl2mKQ7TjThyLtWf fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjh5u007f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:36:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43HFXqAO025675;
	Wed, 17 Apr 2024 15:36:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjh5u007e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:36:43 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFC6oI023575;
	Wed, 17 Apr 2024 15:36:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cp59df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 15:36:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HFadwQ46137848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 15:36:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDB352004D;
	Wed, 17 Apr 2024 15:36:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4E932004B;
	Wed, 17 Apr 2024 15:36:38 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Apr 2024 15:36:38 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix selection of wake_cpu in kick_pool()
In-Reply-To: <Zh8EfxdVdiIj_27H@slm.duckdns.org> (Tejun Heo's message of "Tue,
	16 Apr 2024 13:06:39 -1000")
References: <20240415053550.538722-1-svens@linux.ibm.com>
	<Zh8EfxdVdiIj_27H@slm.duckdns.org>
Date: Wed, 17 Apr 2024 17:36:38 +0200
Message-ID: <yt9dpluogfw9.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yuziOVqoBL4DFF93nE53pnSgb6LLmQEn
X-Proofpoint-ORIG-GUID: VLeRhIIlRvSaVMhAdPvzklHZm-AnIDCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_12,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170107

Tejun Heo <tj@kernel.org> writes:

> On Mon, Apr 15, 2024 at 07:35:49AM +0200, Sven Schnelle wrote:
>> @@ -1277,7 +1277,8 @@ static bool kick_pool(struct worker_pool *pool)
>>  	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
>>  		struct work_struct *work = list_first_entry(&pool->worklist,
>>  						struct work_struct, entry);
>> -		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
>> +		p->wake_cpu = cpumask_any_and_distribute(pool->attrs->__pod_cpumask,
>> +							 cpu_online_mask);
>
> I think this can still race with the last CPU in the pod going down and
> return nr_cpu_ids. Maybe something like the following would be better?
>
> 	int wake_cpu;
>
> 	wake_cpu = cpumask_any_distribute_and(...);
> 	if (wake_cpu < nr_cpus_ids) {
> 		p->wake_cpu = wake_cpu;
> 		// update stat;
> 	}
>
> This generally seems like a good idea but isn't this still racy? The CPU may
> go down between setting p->wake_cpu and wake_up_process().

Don't know without reading the source, but how does this code normally
protect against that?

Thanks
Sven

