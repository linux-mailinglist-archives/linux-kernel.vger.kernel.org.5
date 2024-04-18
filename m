Return-Path: <linux-kernel+bounces-149594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6578A933E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB7D1C20BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634332BB0A;
	Thu, 18 Apr 2024 06:40:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709E125D6;
	Thu, 18 Apr 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422401; cv=none; b=H1Dn5ccYgOiPzpo2Y+1ZfSpgtuFovRLPwlwhZlsmO48hEUAfg0H8Utb5B3susJ7UQ2bL978FZOc7yZ0nTW6x38T0Fl99zEdRHuM3asaz9Lh+IKE0DbB5XgA5P2CEn4s0sJrmsnDsNVlI8RfShXeIAWAJ2RGV1QaTCaB0fYy335c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422401; c=relaxed/simple;
	bh=pC89AagWu2You0KtbPjpaU08FxSfXSL8O/XwdhWm7gA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NWNooYnVOUgKBLSmRRIaG8dzRjjwwPbBcH8xCIhnTeb9cci0J4/dVm/OQEkidZ3TTKvgTzjb6U/ezavqFpfE5croxoKFS28n0cBuzrZsIHuXKzXlXWZ93NCXClHhagKRRflbhA8+e/du43zfcR8MZuTFKsudphNqLFK7gRdHNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VKp6V0ffXz4f3n6f;
	Thu, 18 Apr 2024 14:39:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0D9BA1A0175;
	Thu, 18 Apr 2024 14:39:55 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBE5wCBmYPgmKQ--.31834S3;
	Thu, 18 Apr 2024 14:39:54 +0800 (CST)
Subject: Re: [PATCH v2 08/11] md: add atomic mode switching in RAID 1/10
To: tada keisuke <keisuke1.tada@kioxia.com>, "song@kernel.org"
 <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luse, Paul E" <paul.e.luse@intel.com>
References: <47c035c3e741418b80eb6b73d96e7e92@kioxia.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8d21354c-9e67-b19c-1986-b4c027dff125@huaweicloud.com>
Date: Thu, 18 Apr 2024 14:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <47c035c3e741418b80eb6b73d96e7e92@kioxia.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXaBE5wCBmYPgmKQ--.31834S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyDZFWfAF1rurWUZF1fJFb_yoW7GrWrp3
	yjqFyrAr4UX34jq3Z8GF4kCa4Yqw12kFW0krZIk34fu3WagFZ8Ja4UJFyjvryDAFy3Cw1a
	qw1UGrsrCayxGrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/18 13:44, tada keisuke 写道:
> This patch depends on patch 07.
> 
> All rdevs running in RAID 1/10 switch nr_pending to atomic mode.
> The value of nr_pending is read in a normal operation (choose_best_rdev()).
> Therefore, nr_pending must always be consistent.
> 
> Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
> Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
> ---
>   drivers/md/md.h     | 14 ++++++++++++++
>   drivers/md/raid1.c  |  7 +++++++
>   drivers/md/raid10.c |  4 ++++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index ab09e312c9bb..57b09b567ffa 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -236,6 +236,20 @@ static inline unsigned long nr_pending_read(struct md_rdev *rdev)
>   	return atomic_long_read(&rdev->nr_pending.data->count);
>   }
>   
> +static inline bool nr_pending_is_percpu_mode(struct md_rdev *rdev)
> +{
> +	unsigned long __percpu *percpu_count;
> +
> +	return __ref_is_percpu(&rdev->nr_pending, &percpu_count);
> +}
> +
> +static inline bool nr_pending_is_atomic_mode(struct md_rdev *rdev)
> +{
> +	unsigned long __percpu *percpu_count;
> +
> +	return !__ref_is_percpu(&rdev->nr_pending, &percpu_count);
> +}
> +
>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
>   			      sector_t *first_bad, int *bad_sectors)
>   {
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 12318fb15a88..c38ae13aadab 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -784,6 +784,7 @@ static int choose_best_rdev(struct r1conf *conf, struct r1bio *r1_bio)
>   		if (ctl.readable_disks++ == 1)
>   			set_bit(R1BIO_FailFast, &r1_bio->state);
>   
> +		WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev));
>   		pending = nr_pending_read(rdev);
>   		dist = abs(r1_bio->sector - conf->mirrors[disk].head_position);
>   
> @@ -1930,6 +1931,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   			if (err)
>   				return err;
>   
> +			percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
>   			raid1_add_conf(conf, rdev, mirror, false);
>   			/* As all devices are equivalent, we don't need a full recovery
>   			 * if this was recently any drive of the array
> @@ -1949,6 +1951,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   		set_bit(Replacement, &rdev->flags);
>   		raid1_add_conf(conf, rdev, repl_slot, true);
>   		err = 0;
> +		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);

I don't understand what's the point here, 'nr_pending' will be used when
the rdev issuing IO, and it's always used as atomic mode, there is no
difference.

Consider that 'nr_pending' must be read from IO fast path, use it as
atomic is something we must accept. Unless someone comes up with a plan
to avoid reading 'inflight' counter from fast path like generic block
layer, it's not ok to me to switch to percpu_ref for now.

+CC Paul

HI, Paul, perhaps you RR mode doesn't need such 'inflight' counter
anymore?

Thanks,
Kuai

>   		conf->fullsync = 1;
>   	}
>   
> @@ -3208,6 +3211,7 @@ static void raid1_free(struct mddev *mddev, void *priv);
>   static int raid1_run(struct mddev *mddev)
>   {
>   	struct r1conf *conf;
> +	struct md_rdev *rdev;
>   	int i;
>   	int ret;
>   
> @@ -3269,6 +3273,9 @@ static int raid1_run(struct mddev *mddev)
>   	/*
>   	 * Ok, everything is just fine now
>   	 */
> +	rdev_for_each(rdev, mddev) {
> +		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
> +	}
>   	rcu_assign_pointer(mddev->thread, conf->thread);
>   	rcu_assign_pointer(conf->thread, NULL);
>   	mddev->private = conf;
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index b91dd6c0be5a..66896a1076e1 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -808,6 +808,7 @@ static struct md_rdev *read_balance(struct r10conf *conf,
>   
>   		nonrot = bdev_nonrot(rdev->bdev);
>   		has_nonrot_disk |= nonrot;
> +		WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev));
>   		pending = nr_pending_read(rdev);
>   		if (min_pending > pending && nonrot) {
>   			min_pending = pending;
> @@ -2113,6 +2114,7 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   		p->recovery_disabled = mddev->recovery_disabled - 1;
>   		rdev->raid_disk = mirror;
>   		err = 0;
> +		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
>   		if (rdev->saved_raid_disk != mirror)
>   			conf->fullsync = 1;
>   		WRITE_ONCE(p->rdev, rdev);
> @@ -2127,6 +2129,7 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>   		err = mddev_stack_new_rdev(mddev, rdev);
>   		if (err)
>   			return err;
> +		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
>   		conf->fullsync = 1;
>   		WRITE_ONCE(p->replacement, rdev);
>   	}
> @@ -4028,6 +4031,7 @@ static int raid10_run(struct mddev *mddev)
>   	rdev_for_each(rdev, mddev) {
>   		long long diff;
>   
> +		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
>   		disk_idx = rdev->raid_disk;
>   		if (disk_idx < 0)
>   			continue;
> 


