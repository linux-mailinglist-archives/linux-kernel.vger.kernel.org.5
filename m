Return-Path: <linux-kernel+bounces-116364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D546E88987D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9010129D737
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A11C6AD9;
	Mon, 25 Mar 2024 05:00:15 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0637EF05;
	Mon, 25 Mar 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329350; cv=none; b=LPhFi9Qlk4ih0Uru5toBrm41ic9znfyqTmQUJFr0n5PCZjIklN5o9Iv7q1XCu3bnSmcxvGV/yx90uhkK+YwJylDN7eTrmAKlqUhHxtKspsuGYlwr1yTbOd9sHNF+rS3e5PmE182of/AlpSj+6jtMDcwK0nIPnGAfZ0sNaxayP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329350; c=relaxed/simple;
	bh=GYXJu2yl68SuEWp3lSZ6kOqLi9OGq8F6Clm24RXWl0o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JHcyTehPCvvoUlYvh/+PJ2baSVDDiQhcQWNnIP7eJLwN9H8KII1iirDPJXF9kes6pkAOU1c9V1j/oAFdLEMXW3XyAlS0dAHB/1qxAi10jJuu6cefVejrV2n1q6BwNOjkdvckoMIgWRqQxjl84XAyMWhKydC4sOGYrvP15ICT/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V2w3c0nhxz4f3k6f;
	Mon, 25 Mar 2024 09:15:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1A78A1A017A;
	Mon, 25 Mar 2024 09:15:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBE+0ABmMZD3Hw--.65354S3;
	Mon, 25 Mar 2024 09:15:43 +0800 (CST)
Subject: Re: [PATCH 2/2] block: remove blk_mq_in_flight() and
 blk_mq_in_flight_rw()
To: Mike Snitzer <snitzer@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
 mpatocka@redhat.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
 <20240323035959.1397382-3-yukuai1@huaweicloud.com>
 <Zf79w4Ip3fzSMCWh@redhat.com>
 <abb0af09-e9bb-4781-176b-b4b98726c211@huaweicloud.com>
 <ZgChym1BEpxUm_bL@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cc68915d-dbc2-e77e-a73e-ef289eb579cd@huaweicloud.com>
Date: Mon, 25 Mar 2024 09:15:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgChym1BEpxUm_bL@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBE+0ABmMZD3Hw--.65354S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1kWrWxuw45KryrZF4UCFg_yoWDuFg_Xr
	Wv9w1kJw47XF4aq3WDKr1fZrZrGas3JrZ3J3y7XrW5Awn5XF93Grs5K34xZr45Aay3KF1S
	krn2qF4xZr42gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
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

在 2024/03/25 5:57, Mike Snitzer 写道:
> On Sat, Mar 23 2024 at 10:11P -0400,
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> 
>> Hi,
>>
>> 在 2024/03/24 0:05, Mike Snitzer 写道:
>>> On Fri, Mar 22 2024 at 11:59P -0400,
>>> Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Now that blk-mq also use per_cpu counter to trace inflight as bio-based
>>>> device, they can be replaced by part_in_flight() and part_in_flight_rw()
>>>> directly.
>>>
>>> Please reference the commit that enabled this, e.g.:
>>>
>>> With commit XXXXX ("commit subject") blk-mq was updated to use per_cpu
>>> counters to track inflight IO same as bio-based devices, so replace
>>> blk_mq_in_flight* with part_in_flight() and part_in_flight_rw()
>>> accordingly.
>>
>> Patch 1 in this set do this, so there is no commit xxx yet.
>>
>> Thanks,
>> Kuai
> 
> Would've helped if I looked at 1/2, but please say:
> 
> With the previous commit blk-mq was updated to use per_cpu ...

OK, will pay attention to it later. :)

Thanks,
Kuai

> .
> 


