Return-Path: <linux-kernel+bounces-95026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A4B874857
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696A01F21636
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405F1D547;
	Thu,  7 Mar 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rc7hJr/e"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCC1D529
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794253; cv=none; b=nKDoZ9zyzS1UKtV1IkLhWVHBlIGFmbAPdDGwTwV/Ipv25zYdu5ugw6zbktC3PetaiJrV68ceIIgM/+Ar9joYfEo+vZG/YFBx3rLE5HO2l+h8J9FxCrCegA0vYostOCiMB1iTZAWQcvS59n4iBRpdnqIi0sbZseEden1cxCW1Y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794253; c=relaxed/simple;
	bh=eQrpwo06VO8ypUToEjdn3jAKqbI8tJ6tgBTUHxh+17M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdCgPJLyNYYSFGq2+j4+J668c/+EL31WsCu7vZpV2COybp7gtc1zKyntxb97Y91CPPJF5T/QzGA7wTZzW9WD3iK1H8FQXnWFNJzvBG+NlMEZJ2hXug0DyzQW3lmucguUdy/SMQsVfAPAnsbe+RjGCW8C42A7rUQIgj2wUKc0x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rc7hJr/e; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709794242; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VjKpKALca+cRV+EtKGDHobe2Vrr2piVSSVolsSe4T+I=;
	b=Rc7hJr/eraH72NM8VLeNCPfMLmqyDJJEJP13GbNfDlJ9sUGtOP7OMwmWT6UGpSN0+yYYdXo/Bo3eKgGOiDZkkDCZrY+Vr3ucwG8/nnxqmM5g00znSnvv11V66JezRwUiQ7d8fLY8ZbK1RmrTM4XViTUx7g5HfqGF5uTB929GGvo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W1zqQ-3_1709794240;
Received: from 30.97.48.224(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1zqQ-3_1709794240)
          by smtp.aliyun-inc.com;
          Thu, 07 Mar 2024 14:50:41 +0800
Message-ID: <b6d800fc-b5f7-4a2e-9d7d-f57196717341@linux.alibaba.com>
Date: Thu, 7 Mar 2024 14:50:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
To: Baokun Li <libaokun1@huawei.com>, Jingbo Xu <jefflexu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, chengzhihao1@huawei.com
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <f9e30004-6691-4171-abc5-7e286d9ccec6@linux.alibaba.com>
 <7e262242-d90d-4f61-a217-f156219eaa4d@linux.alibaba.com>
 <65d09bbe-9389-4502-1504-8c1557fe5e52@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <65d09bbe-9389-4502-1504-8c1557fe5e52@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/3/7 14:46, Baokun Li wrote:
> On 2024/3/7 11:41, Jingbo Xu wrote:
>> Hi Baokun,
>>

..

> Thank you for your feedback!
> 
> If I understand you correctly, you mean to remove erofs_pseudo_mnt
> directly to avoid this false positive, and use anon_inode_create_getfile()
> to create the required anonymous inode.
As Al pointed out, you could just follow his ideas
since it's mainly a VFS POV...

Thanks,
Gao Xiang

> 

