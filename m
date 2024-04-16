Return-Path: <linux-kernel+bounces-146930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E258A6D24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011E71C21F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B012CD8E;
	Tue, 16 Apr 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mzbtWPQZ"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353012CD8C;
	Tue, 16 Apr 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275902; cv=none; b=cLnJq15wro8IYxTlJDyx5i0GEJ0dyKeCUND+wQzUVrDcW2f276JS9rDMgU4vTuNGeFw3/6KPN2snOQs9oN6DhwXxHJLzZXpLMSBSdFMbJ9+BsiNlpH/cetUikt6iKjbZAqi2C0EzHiEFuwFH7rjh+hSIQYxMaEMFPvCK1bGe74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275902; c=relaxed/simple;
	bh=bVObwWVu5VNJo3NA5gkLnTyvUBGMjZWlseKPTAVlCq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z47IONXB9Gp048cXWgM7D+jrqIV0xlL4KYLZnntfYGTCAwVVz08YxpzfiUqD+BDMJuCwKz9d2c/rb9o49aY3lbM3IHC1dAR468yh4OVWljQR9ExRoIF2ggRAlE4VQwBVAR0Q3h2gOawYUSvQRJKGXR8tgcR237pcxKhcINTTkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mzbtWPQZ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713275896; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BC/5DvwfhJ3cE4ERIBbj5/0ioEzu3C+4IXCq9AiJ8bA=;
	b=mzbtWPQZynN6PjHdJA97ssE/mFs5wimFZhqo0KD7WxQzD+uc6Zm+1WfVw/wBaOiDCUMw8I8xF4Na/WIPd1EX6RUWemSNElLK7r3xHpUgllpftpJXfz0N9i6Hys26Zjr6jj19CMAHiEv9PCYzBLcNrEfAqC/mgEMzcva5bqZI0gw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W4i82Hn_1713275893;
Received: from 30.213.156.135(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W4i82Hn_1713275893)
          by smtp.aliyun-inc.com;
          Tue, 16 Apr 2024 21:58:15 +0800
Message-ID: <46c56be1-a8a5-4ad4-9a58-5b3e5f629eeb@linux.alibaba.com>
Date: Tue, 16 Apr 2024 21:58:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 01/11] net/smc: decouple ism_client from SMC-D
 DMB registration
To: Alexandra Winter <wintera@linux.ibm.com>, twinkler@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240414040304.54255-1-guwen@linux.alibaba.com>
 <20240414040304.54255-2-guwen@linux.alibaba.com>
 <c7f6be91-6591-4b00-95c3-48417bf98ac1@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <c7f6be91-6591-4b00-95c3-48417bf98ac1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/15 16:41, Alexandra Winter wrote:
> 
> 
> On 14.04.24 06:02, Wen Gu wrote:
>> The struct 'ism_client' is specialized for s390 platform firmware ISM.
>> So replace it with 'void' to make SMCD DMB registration helper generic
>> for both Emulated-ISM and existing ISM.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
> 
> Just a thought:
> The client concept is really specific to s390 platform firmware ISM.
> So wouldn't it be nice to do something like:
> 
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index 78cca4839a31..37dcdf2bc044 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -747,10 +747,9 @@ static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>          return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
>   }
> 
> -static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
> -                            struct ism_client *client)
> +static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
>   {
> -       return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, client);
> +       return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, &smc_ism_client);
>   }
> 
>   static int smcd_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
> 
> --------------
> 
> This is not a real patch, just a sketch, but I hope you
> get the idea.
> 
> 
> This may be a step in the direction of moving the ism_client concept from
> net/smc/smc_ism.c to drivers/s390/net/ism*
> 
> 
> I know that there are several dependencies to consider.

Yeah.. I think so too. The move of ism_client concept may involve much work.

> And I haven't looked at the other patches in this series yet in detail, to see how you solve
> things like smcd_register_dev. Seems like smcd_register_dmb() is the only one of the smcd_ops
> that you need for loopback and uses ism_client.
> 

loopback-ism uses smcd_lo_register_dev instead. And yes, smcd_register_dmb() is
the only one of smcd_ops that use ism_client in its function argument.

> 
> 
> Wenjia, Gerd, and others what do you think?

