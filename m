Return-Path: <linux-kernel+bounces-144451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B128A4691
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34FD282A88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1DE134C4;
	Mon, 15 Apr 2024 01:32:10 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6220EEC5;
	Mon, 15 Apr 2024 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713144730; cv=none; b=Cw5dreMFvhfev5HhWqdXzEe393+lhBN1+iscvTYP0EYjcfUy0MUIUtIUQDN498ic++UeirmKQvpx9gyu6JhEaLyPeK4Ny3+4y0uGzCwzHoDw7pXDGd9C66wpF9Mh2kcQgGQuc64pfpzVHR7tq/QHADh5LEz7475fH5MKJbYOxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713144730; c=relaxed/simple;
	bh=VFW33vDHGTXeQaLA3wRaK502MGTYFMQVW63K4ku22JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi+ASYi7LFECBGZXATfSMQjWaDMrBgJIdxV5fFlgj2azN6mfWtsmdIjxfgBiw4AYxt0s0IxhtPsUUlLkAy5b0kFzLrvSCPDTx4R7ESaiTJ4WPPCTG4wCs2CE6jvnNRBFyz6RFyaHIJKcViDt3PadEzLzWpxGfI0oxAmNBeLpE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VHqQZ4RPqz4f3kpC;
	Mon, 15 Apr 2024 09:31:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AB72E1A01D4;
	Mon, 15 Apr 2024 09:31:57 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAuKgxxmNlDvKA--.9408S3;
	Mon, 15 Apr 2024 09:31:56 +0800 (CST)
Message-ID: <b8dbcc3d-f0ec-ba59-4ebc-01476029aa80@huaweicloud.com>
Date: Mon, 15 Apr 2024 09:31:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ubi: block: fix memleak in ubiblock_create()
To: Markus Elfring <Markus.Elfring@web.de>, linux-mtd@lists.infradead.org,
 kernel-janitors@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Hou Tao <houtao1@huawei.com>,
 Yang Erkun <yangerkun@huawei.com>, Yu Kuai <yukuai3@huawei.com>,
 Zhang Yi <yi.zhang@huawei.com>
References: <20231208074629.1656356-1-linan666@huaweicloud.com>
 <22f324ce-552a-4f6a-b4e5-2d84a00010aa@web.de>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <22f324ce-552a-4f6a-b4e5-2d84a00010aa@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnmAuKgxxmNlDvKA--.9408S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw15WFW8Cw4Uuw18CFy5twb_yoWxKFgEk3
	48JF97J34xtF10yanaga1fArnxWay3J3Wjva48JwnIg34fWFnxGFZxGr98Z3Z3Xas5ZFWD
	Cr43t34Fvw1SqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
	AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3
	Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU1VOJ7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/4/14 17:16, Markus Elfring 写道:
> Can it be nicer to use the term “memory leak” instead of “memleak”
> in the patch subject?
> 
> 
> …
>> 'gd' will not be put anymore. Fix it by putting 'gd' directly.
> 
> Would the following wording variant be more desirable?
> 
>     … anymore.
>     Thus pass the variable “gd” to a put_disk() call directly.
> 
> 
> Would you like to add the tag “Fixes” accordingly?
> 

The patch has already been applied:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adbf4c4954e33e623897058a617c583d65a177f6

Thank you very much for your suggestion. I will pay attention to them in
future patches.

> Regards,
> Markus
> .

-- 
Thanks,
Nan


