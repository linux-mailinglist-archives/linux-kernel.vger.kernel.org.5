Return-Path: <linux-kernel+bounces-9270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734E81C332
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC38D1C2433A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93615A7;
	Fri, 22 Dec 2023 02:53:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020F9444;
	Fri, 22 Dec 2023 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SxBgX494Jz4f3lD2;
	Fri, 22 Dec 2023 10:53:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D13841A027C;
	Fri, 22 Dec 2023 10:53:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDX2Q8c+oRl+5kzEQ--.48355S3;
	Fri, 22 Dec 2023 10:53:17 +0800 (CST)
Subject: Re: [PATCH] md/raid5: fix atomicity violation in raid5_cache_count
To: 20 39 <2045gemini@gmail.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: song@kernel.org, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
 BassCheck <bass@buaa.edu.cn>, "yukuai (C)" <yukuai3@huawei.com>
References: <20231221104343.5557-1-2045gemini@gmail.com>
 <abc324aa-1ccc-c8fd-1437-a77465f6e4be@huaweicloud.com>
 <CAOPYjvbfGZObUa+P5Bo_syLMpyMNEPU6SNm6xJPSqSZYREmNfw@mail.gmail.com>
 <CAOPYjvYhEzeF3vdd9GXCX+k_-OmsE1yP7VNozcMt4vOyFLDAfw@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ae9fc764-4765-8c13-8d59-56bc8582c094@huaweicloud.com>
Date: Fri, 22 Dec 2023 10:53:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOPYjvYhEzeF3vdd9GXCX+k_-OmsE1yP7VNozcMt4vOyFLDAfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX2Q8c+oRl+5kzEQ--.48355S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDury7Gw4kJrWxAw18Zrb_yoW8Cr17pF
	Z8W3WUXr4FqwnayFyqvws5G34SkwsayF1xJws8X3s5ZasYgFZ3JFW7Kw1Yk34rKr48GFy0
	qFyY93s3Zr1qyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2023/12/22 10:34, 20 39 写道:
> Hi Kuai,
> 
> Thank you for your patience. This email is essentially the same as my
> previous one, only now adjusted to plain text format. I apologize for
> any inconvenience caused earlier.
> 
> Thanks for your email and the insightful points you've raised. Let me
> clarify a few aspects regarding the raid5_cache_count() and
> raid5_set_cache_size() functions.
> 
> 1. Callback Function in setup_conf(): You mentioned that
> raid5_cache_count() is called from setup_conf() where reconfig_mutex
> is held. While this is true, it's important to note that
> raid5_cache_count() is actually initialized as a callback function in
> setup_conf(), as described in /include/linux/shrinker.h. This means it
> could be invoked later in a context where the reconfig_mutex isn't
> necessarily held. The documentation in shrinker.h indicates potential
> invocation scenarios beyond the initial setup context.

Yes, you're right. I misread the code. Then this patch looks good to me,
just one nit below.

>>>> @@ -7390,11 +7390,12 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
>>>>                                       struct shrink_control *sc)
>>>>    {
>>>>        struct r5conf *conf = shrink->private_data;
>>>> -
>>>> -     if (conf->max_nr_stripes < conf->min_nr_stripes)
>>>> +     int max_stripes = conf->max_nr_stripes;
>>>> +     int min_stripes = conf->min_nr_stripes;

Since read and write can concurrent, I'll suggest to use READ_ONCE() and
WRITE_ONCE() for max/min_nr_stripes.

Thanks,
Kuai
>>>> +     if (max_stripes < min_stripes)
>>>>                /* unlikely, but not impossible */
>>>>                return 0;
>>>> -     return conf->max_nr_stripes - conf->min_nr_stripes;
>>>> +     return max_stripes - min_stripes;
>>>>    }
>>>>
>>>>    static struct r5conf *setup_conf(struct mddev *mddev)
>>>>
>>>
> .
> 


