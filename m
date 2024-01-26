Return-Path: <linux-kernel+bounces-40132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E952083DAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A567A285809
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FA1B94D;
	Fri, 26 Jan 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mDkR5jfR"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3531B80A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275836; cv=none; b=seVitpddFVkT6nlr2FDhakvYYePf9ialKyPEgK0BlVgS3h1FL6x9rJnbGoInUkFUaeIFe1Esiwxb+kOzqjGNyJjLYSSsyYaSU8LtUlLue/LHwUhKt86yfXFQTtRz0G25wa6BTc0vXVM1gxMEFFLOukD8ZMMRFIl02rgwCIKDvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275836; c=relaxed/simple;
	bh=Cf1srHkbVmdczQQSvVcYaIQj++mOd6FYYHilb6oPBMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePYKkqaL0TP7+FIbBKzG3+zo/GQNyajh8jdHYc6yEGevrILBmZGUXyEgcYKH6hWrHdBier8VmG8McqdS2mUYRaiPHtfM3C49kZMhNDUgoRRrLX1kdei8Mxt31pd44gdpAS6+FFJdGHdFb6Qpfc4h17cJUrxfiGOs+om/qF7LlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mDkR5jfR; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706275828; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KcBBGTYzSlZxLROYC6wPY4xQ8FciqyL6apQ3SBO84Ro=;
	b=mDkR5jfRFGlwKm6ZtptSpJjU5++aSJHRiD6yw4lJ1hh08IgbbiVp2ZYLMDwIgVP7SinX7CAlUv0i+wpHRqSoSMI+oFM9a52dNhLURIn7VkerP2LAICUt9zwJyS1qekKgeM/5+69xRZgWv+LzQMUzZgOOggc4a9HIs4zyI92aFLg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.Nsj5c_1706275826;
Received: from 30.27.78.222(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W.Nsj5c_1706275826)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 21:30:27 +0800
Message-ID: <5b5387e8-3251-4750-844e-5c34b36eee87@linux.alibaba.com>
Date: Fri, 26 Jan 2024 21:30:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: relaxed temporary buffers allocation on
 readahead
To: Yue Hu <zbestahu@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Chunhai Guo <guochunhai@vivo.com>
References: <TY2PR06MB3342D2245C5E515028C33FD4BE792@TY2PR06MB3342.apcprd06.prod.outlook.com>
 <20240126053616.3707834-1-hsiangkao@linux.alibaba.com>
 <20240126184656.0000561c.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240126184656.0000561c.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yue,

On 2024/1/26 18:46, Yue Hu wrote:
> On Fri, 26 Jan 2024 13:36:16 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 

..

>>   	/*
>> @@ -1276,7 +1280,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>   					.inplace_io = overlapped,
>>   					.partial_decoding = pcl->partial,
>>   					.fillgaps = pcl->multibases,
>> +					.gfp = pcl->besteffort ?
>> +						GFP_KERNEL | __GFP_NOFAIL :
>> +						GFP_NOWAIT | __GFP_NORETRY
>>   				 }, be->pagepool);
>> +	pcl->besteffort = false;
> 
> reposition it following `pcl->multibases = false`?

Good idea! Let me update this.

Thanks,
Gao Xiang

