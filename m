Return-Path: <linux-kernel+bounces-112547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDCE887B60
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31961F2213B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2E28FC;
	Sun, 24 Mar 2024 02:11:22 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA717C8;
	Sun, 24 Mar 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246281; cv=none; b=tJKGz2jwVwj5tDyYc3Ibyc7HgBeYH8qpKaxbuwDWoimNyYMhogx7DUOhBi5rtbCnKyk8FXmS+WIFHSluSCZU2r6t18eui2kXP9fx763GXjopV3pbyGteKpeU/nk5YFSTecMCYr/mXQYLW7BYO0KpKVfQc72O7s0lpywPkJ+T/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246281; c=relaxed/simple;
	bh=NDITpm+Io5eF73wa40dDzJ4n6hWGDX3M2JytLekCKDc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PCr8slMkFFMyVazJyhm6zzzyUPzs45weePZhse/4xwGj0XTZZRc9tstVd1urzYzM+aR3Ykaf7BQoUByfpojD/RcXoj7AHdlZ/q5zMhwtLxvniSmr2fPWkxE1Ck1LsnOotzzD/rsC9KUcZkilZKttsOnewwCRbSLcqMWe4MgZ+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V2KL63s7Sz4f3jYg;
	Sun, 24 Mar 2024 10:11:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7C7E91A0C00;
	Sun, 24 Mar 2024 10:11:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDAi_9l6YOUHw--.39150S3;
	Sun, 24 Mar 2024 10:11:14 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <abb0af09-e9bb-4781-176b-b4b98726c211@huaweicloud.com>
Date: Sun, 24 Mar 2024 10:11:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zf79w4Ip3fzSMCWh@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDAi_9l6YOUHw--.39150S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4DGF4Dur17tryxAw4xJFb_yoW3AFX_ur
	yv9a4UJ3W7JF1aq3WUGF1fZrZrG34fGrZxX3y7XFWUAr1kXFWSgFs5Kas7uF45Aa1jqF1S
	k34ftF4xArW2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

ÔÚ 2024/03/24 0:05, Mike Snitzer Ð´µÀ:
> On Fri, Mar 22 2024 at 11:59P -0400,
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> 
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Now that blk-mq also use per_cpu counter to trace inflight as bio-based
>> device, they can be replaced by part_in_flight() and part_in_flight_rw()
>> directly.
> 
> Please reference the commit that enabled this, e.g.:
> 
> With commit XXXXX ("commit subject") blk-mq was updated to use per_cpu
> counters to track inflight IO same as bio-based devices, so replace
> blk_mq_in_flight* with part_in_flight() and part_in_flight_rw()
> accordingly.

Patch 1 in this set do this, so there is no commit xxx yet.

Thanks,
Kuai

> 
> (I'm not seeing the commit in question, but I only took a quick look).
> 
> Mike
> .
> 


