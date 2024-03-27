Return-Path: <linux-kernel+bounces-120170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1AD88D3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727DE1F340DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DDC1CFA9;
	Wed, 27 Mar 2024 01:18:10 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341062901;
	Wed, 27 Mar 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502290; cv=none; b=LcKbtGyhAI1vqNsY6jr036wgrnHdxX/DSJE1WeN+8kTELYHPvax02PSb1vunVU3C/VRI2BawbrXAR7ujtzTgkmgSjAS/MZdveAQLGARTdCOQHsBIC4dov7zSoTaWBfFKDmDHgODVusb/2PQlrGpTJhnZgS0Ll3+M7PZApBgC9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502290; c=relaxed/simple;
	bh=Z5wI9KmQz3Xr0Tko4bQCdV4Jx5c8BoA5ZukqaeDCNnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZpjOejgQ3Ik3rTq/3QEU3//NCyxYuq91WGma8VxDFbzJysJdEY3qplE2GV3E49WDcjN4uiLcN3x3xdv6WYEpr8m87xyA2HYvc06DGvPwmAi5acPIbfBj01SyLmRXfmHFgq5yX6o9hMBY0xjqs9ez8DfHGVowaiKyHyDw+TpELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V481H2bDTz4f3lVg;
	Wed, 27 Mar 2024 09:17:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 78CCB1A06E6;
	Wed, 27 Mar 2024 09:18:03 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAvJcwNmRFhyIQ--.6093S3;
	Wed, 27 Mar 2024 09:18:03 +0800 (CST)
Message-ID: <a123d813-bdef-202d-2980-fb74c5a715e5@huaweicloud.com>
Date: Wed, 27 Mar 2024 09:18:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5.10 033/238] md: implement ->set_read_only to hook into
 BLKROSET processing
To: Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-raid <linux-raid@vger.kernel.org>, Li Nan <linan666@huaweicloud.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20240324234027.1354210-1-sashal@kernel.org>
 <20240324234027.1354210-34-sashal@kernel.org> <20240325010435.GA23652@lst.de>
 <ZgFfc2b6VsX_QSu4@sashalap> <20240326074029.GB9773@lst.de>
 <CAPhsuW7FREFLrAnt2iYDRoJG0d=OXm-5vy3OCJ7MOJDp2SE9GQ@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW7FREFLrAnt2iYDRoJG0d=OXm-5vy3OCJ7MOJDp2SE9GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnmAvJcwNmRFhyIQ--.6093S3
X-Coremail-Antispam: 1UD129KBjvJXoWruw4kGFy3Cr4kWFWDCF1fXrb_yoW8JrWrpF
	9Fya1jyr4Dtry7C3WIyw4Sqr1Iv3ykJry5W3s5XrZ3A39Y9rWfJr1UKr1qgFyDKrn7Z34Y
	va12gw1ayrWkAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/3/26 16:46, Song Liu 写道:
> Hi Li Nan,
> 
> Could you please look into this (back port 9674f54e41ff to older stable
> kernels)? If there is no clean back port, I would recommend we not do
> the back port.
> 

There are some conflicts to back port, which are not related to the
modification of this patch. If necessary, let me know and I can adapt and
send it :)

> Thanks,
> Song
> 
> On Tue, Mar 26, 2024 at 12:40 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Mon, Mar 25, 2024 at 07:26:43AM -0400, Sasha Levin wrote:
>>> On Mon, Mar 25, 2024 at 02:04:35AM +0100, Christoph Hellwig wrote:
>>>> How did we end up backporting all these block layer API changes?
>>>
>>> They were brought in as a dependency for 9674f54e41ff ("md: Don't clear
>>> MD_CLOSING when the raid is about to stop").
>>>
>>> It's possible to work around bringing them during backport, but I
>>> preferred to bring the dependencies instead.
>>
>> I really don't see what these giant backports bring us.  If people
>> want all the changes they'd just be better off on a modern kernel
>> rather than these frankenkernels.  The automatic backporting is
>> gettind way out of hand.  If the MD maintainers want
>> 9674f54e41ff, maybe they can send a tailor made backport?
> 
> .

-- 
Thanks,
Nan


