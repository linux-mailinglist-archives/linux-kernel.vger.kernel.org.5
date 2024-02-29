Return-Path: <linux-kernel+bounces-85989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805186BE22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A481E1C23703
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0472C868;
	Thu, 29 Feb 2024 01:14:47 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6815D4;
	Thu, 29 Feb 2024 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169287; cv=none; b=m4z2zqqIYBlO3H138DWoXSQm/ubvGji93PfRcP3/LgkzPbN76aD74YuAHoKtoKnvb+2dIcOek/xffSvowZu12EsllAl1iabU1oE9u4W2q1kU6hsoh/LR1S5woNU9uaiZQSBNHdxQPY089x3r5sg9WhiRsCtxm/Jen8pD3dNiguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169287; c=relaxed/simple;
	bh=jvzwDYNMl5w8ktvjCOLH/IA6mhdUthHTHBdZ65FsKWw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V8io/2PIcbpl7+uKtSvGGEHiE316bwxsHM5l/4GSwLn1KDRpsYLKEtvnjb8SpGzKF4A+Xg4dxY+PSTSyz487vNi0cXMSzpNaV+RfBT4y/a+QjWmskiFm1Fv/pYzHDW8dTCkAdXkKU+o717dN0Gri9dAd5a1LuZ8P4K1F+LnIIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlYCs2nXvz4f3lDF;
	Thu, 29 Feb 2024 09:14:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B64FF1A0232;
	Thu, 29 Feb 2024 09:14:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBF+2t9lmqThFQ--.56717S3;
	Thu, 29 Feb 2024 09:14:40 +0800 (CST)
Subject: Re: [PATCH md-6.9 v3 00/11] md/raid1: refactor read_balance() and
 some minor fix
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: xni@redhat.com, paul.e.luse@linux.intel.com, shli@fb.com, neilb@suse.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240228114333.527222-1-yukuai1@huaweicloud.com>
 <CAPhsuW5cJZdvia0HSDcn7v+62E04AP5P=UaqUW4LKDMqm33PAQ@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4da77457-6eb7-1977-4686-28e4a7aab8e2@huaweicloud.com>
Date: Thu, 29 Feb 2024 09:14:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5cJZdvia0HSDcn7v+62E04AP5P=UaqUW4LKDMqm33PAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBF+2t9lmqThFQ--.56717S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW3Zw1xWF4xWrW8ur1kAFb_yoWkGrbEg3
	Z0v348GwnxJF42kF47GF4xXFW0q3W5uw1UZayqvr1fXFykZ3WkGrWktrs7Wa4fXayrtFna
	kFW8uF4IqwsrAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/29 5:23, Song Liu 写道:
> On Wed, Feb 28, 2024 at 3:49 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v3:
>>   - add patch 2, and fix that setup_conf() is missing in patch3;
>>   - add some review tag from Xiao Ni(other than patch 2,3);
> 
> It appears that v3 causes mdadm test "01replace" to run forever.
> I haven't figured out why, but v2 doesn't seem to have this issue.

I'm running tests while sending this version, and I found that too this
morning. :(

I'll check out what's wrong and update soon.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
>> Changes in v2:
>>   - add new conter in conf for patch 2;
>>   - fix the case choose next idle while there is no other idle disk in
>>   patch 3;
>>   - add some review tag from Xiao Ni for patch 1, 4-8
>>
>> The original idea is that Paul want to optimize raid1 read
>> performance([1]), however, we think that the original code for
>> read_balance() is quite complex, and we don't want to add more
>> complexity. Hence we decide to refactor read_balance() first, to make
>> code cleaner and easier for follow up.
> 
> .
> 


