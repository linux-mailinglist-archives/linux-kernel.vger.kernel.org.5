Return-Path: <linux-kernel+bounces-111427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC90886C39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990731C22A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6514437A;
	Fri, 22 Mar 2024 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cZZtxJS6"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5863FB96;
	Fri, 22 Mar 2024 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110981; cv=none; b=AXbTIrP75LL7dfZDvgLmHK+JiLlvfJeY5gKz0Yg2O8LpVyyC7kuJWY94XKsaFLfYv/POw6uFtGAP2YF5dOFLJRxmADL7JOqjs7toNb7RAx3zcfMavjC/T05mbUkrD3JgUsKVsaTkIHRBrxtDDcXJKY13zEbj3zoaTkGQl4W5/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110981; c=relaxed/simple;
	bh=46+MbcH6/2XtZO0kyuX6fQE2ZJEcgUiMfitkn6aFCCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldhC5m3+FyJZ+Rogxv7gXDo+MGo2OUWGxwTSQWmoGQHtdwPNC2sHacuXSmVBUUUt0OaoASfLFsBLi4nyg4cnLAuPmdyTDpcXUFcXRFdO69FBG4fNRvcVxF3ZccIfwJZqbhQHZEnTJXnFkJV3vvxaatmXUG9kJW2bDNyyUK1rYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cZZtxJS6; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711110970; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XfZj9US84yM/qjVGE3bAu52GWkM6deEkJ38pjN8jC+g=;
	b=cZZtxJS619Y1QEMaUZDKHq1HWVY/MPeZaHnl1XtCeKkH0Tw61rjZORzA3CdT+nhxxz/Xq0r/gRspM0w0du3305FQqNHB8lV5saoCH1Wh6vAcei1YmW3i8rC5pdazupWvMiSc9nLcPbvqYwB4/BGcInKA8RPaDhiQAzaJkui1R8U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W328IUR_1711110969;
Received: from 30.221.130.60(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W328IUR_1711110969)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 20:36:10 +0800
Message-ID: <6043954e-b361-468e-8ed9-5f14478027a9@linux.alibaba.com>
Date: Fri, 22 Mar 2024 20:36:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <3b6c41e5-ef2c-4c75-a444-afc130fe2529@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <3b6c41e5-ef2c-4c75-a444-afc130fe2529@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/21 16:11, Jan Karcher wrote:
> 
> 
> On 17/03/2024 11:05, Wen Gu wrote:
>> This patch set acts as the second part of the new version of [1] (The first
>> part can be referred from [2]), the updated things of this version are listed
>> at the end.
> 
> Hi Wen Gu,
> 
> thanks for the v4. Please see my comments for the patches.
> Testing looks good so far on s390.
> 
> Thanks
> - Jan
> 

Thank you very much for the time and comments!
I will collect these points and send a new version.

Thanks,
Wen Gu

