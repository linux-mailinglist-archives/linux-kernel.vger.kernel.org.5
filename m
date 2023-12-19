Return-Path: <linux-kernel+bounces-4561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B1817F55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0024B1F242F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A441FAA;
	Tue, 19 Dec 2023 01:40:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3615C3;
	Tue, 19 Dec 2023 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SvKBD1kdpz4f3jLZ;
	Tue, 19 Dec 2023 09:39:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 652DD1A087A;
	Tue, 19 Dec 2023 09:39:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xFn9IBlFywiEA--.41035S3;
	Tue, 19 Dec 2023 09:39:53 +0800 (CST)
Subject: Re: [PATCH v2 1/2] md: Fix overflow in is_mddev_idle
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, axboe@kernel.dk, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231215013931.3329455-1-linan666@huaweicloud.com>
 <20231215013931.3329455-2-linan666@huaweicloud.com>
 <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
 <be8d9147-4f7f-2fab-da2a-bb4cde46fd12@huaweicloud.com>
 <CAPhsuW6kv7FRB_1NoheiDqvmLmongiJ-ty9mYRNvFw3yecE_Ug@mail.gmail.com>
 <baf95bd0-0378-9b3a-9ab9-473baa35ebbc@huaweicloud.com>
 <CAPhsuW61yzkH5Tp0ku37DBjnQzT81yJUx0F4bag4xdq1rX5gsA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8713b617-db39-113a-377f-f97e123dbf9b@huaweicloud.com>
Date: Tue, 19 Dec 2023 09:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW61yzkH5Tp0ku37DBjnQzT81yJUx0F4bag4xdq1rX5gsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xFn9IBlFywiEA--.41035S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKr1fXF4ktF43uF18GFW8Xrb_yoW8JF1DpF
	Wav3Wjkrs8CF92y34ftwnrtr1rtw4UC3yrKFyFkr4xKr93W39xAFn7Kr1Y9r95Zws3uryY
	v3yagFW3A34qk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/12/19 0:04, Song Liu 写道:
> On Sun, Dec 17, 2023 at 5:39 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
> [...]
>>>
>>> We only use  this for idle or not check, the behavior is OK (I think).
>>> However, this logic is error prone.
>>>
>>> On 64-bit systems, there is a 4-byte hole behind sync_io. I think we can
>>> just use it for atomic64_t so that we don't have to worry about overflow.
>>
>> I'm not sure about this, because other than this ubsan warning, this
>> overflow doesn't have any impact on functionality to me.
> 
> Fixing warnings for zero or low cost is always a good idea. It helps boost
> the signal when UBSAN (and other debug features) detects real issues.
> 
>> If we care about this 'hole', there are lots of holes in gendisk, and
>> can be avoiled, for example, moving 'sync_io' near  to 'node_id'.
> 
> The point was not "let's fill the hole", but "we can use atomic64_t
> without extra memory cost". In general, I don't think we care too
> much about holes in "struct gendisk".
> 
> Does this make sense?

Of course, I don't have strong preference on this. Because our syzkaller
reported lots of UBSAN warnings, hence only fix real issues is how we do
it. For upstream, I'm good at fix this warning with zero or low cost.

Thanks,
Kuai

> 
> Thanks,
> Song
> .
> 


