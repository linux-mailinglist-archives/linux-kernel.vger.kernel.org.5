Return-Path: <linux-kernel+bounces-49081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519BF8465AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CD21F25750
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77733B643;
	Fri,  2 Feb 2024 02:12:23 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F253A1;
	Fri,  2 Feb 2024 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839943; cv=none; b=b4YuQLPjo1oVs2gqMk7sybAtA9Vi/IFNZw3jxeB1I/sqTdQI/Kzalxqwkc39B6wYWCUEtk/dijCpmO0obVwhqdDTN1ySaisDw1DDrFkTS802jx/L8zywZBhdd2Qd+Psp3js8a+3VPscnJygNiYE8sisLFRRGPxscLs10Uou512c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839943; c=relaxed/simple;
	bh=0DbKCyG8xW9CNIqWsSn+uXl6KUTolx5Hlo+TSCloLPE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OxnTSEDbOY5akhpvOJ8U5sIlnPEfcW0QxSyivf5c+IijxFboRPVXhiruf2BbbEcuqP4TDFhqOc/fygNoH8/O83VDMH7IPGoPTOYydrjAag9Qwb8bTWXaVYnYhhnif3CUxliaaThHI5Kf0EqDnmaF/OsYyPW2gcXybu9Ww4yVRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQzml58Sqz4f3kFf;
	Fri,  2 Feb 2024 10:12:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ED6AD1A038B;
	Fri,  2 Feb 2024 10:12:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RF5T7xlnLvRCg--.22766S3;
	Fri, 02 Feb 2024 10:12:11 +0800 (CST)
Subject: Re: [PATCH v5 7/8] md: sync blockdev before stopping raid or setting
 readonly
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com,
 mariusz.tkaczyk@linux.intel.com, shli@fb.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201063404.772797-1-linan666@huaweicloud.com>
 <20240201063404.772797-8-linan666@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8f6a305f-75ed-f103-4a52-9e88699d9289@huaweicloud.com>
Date: Fri, 2 Feb 2024 10:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201063404.772797-8-linan666@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RF5T7xlnLvRCg--.22766S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13uFWfKr13Xw1DXFyDtrb_yoW8ZFyxpa
	1vyFy5Wr1Ut3sxtw17ua1kWa45Ww1xtFWDKrWay348ZFy7AwnxGrs0gr4YqrykK34fCw4I
	qa15uFsagas7Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/02/01 14:34, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
> 
> Commit a05b7ea03d72 ("md: avoid crash when stopping md array races
> with closing other open fds.") added sync_block before stopping raid and
> setting readonly. Later in commit 260fa034ef7a ("md: avoid deadlock when
> dirty buffers during md_stop.") it is moved to ioctl. array_state_store()
> was ignored. Add sync blockdev to array_state_store() now.

You're not just adding sync_blockdev() here. Please rewrite the tittle
and commit message.

> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/md.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4c7a0225f77d..86becf0015f5 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4493,6 +4493,16 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
>   	case broken:		/* cannot be set */
>   	case bad_word:
>   		return -EINVAL;
> +	case clear:
> +	case readonly:
> +	case inactive:
> +	case read_auto:
> +		if (!mddev->pers || !md_is_rdwr(mddev))
> +			break;
> +		err = mddev_set_closing_and_sync_blockdev(mddev);

In this context, mddev->openers should be zero, and such check is in
do_md_stop() and md_set_readonly():

if (atomic_read(&mddev->openers) > !!bdev).

Thanks,
Kuai

> +		if (err)
> +			return err;
> +		break;
>   	default:
>   		break;
>   	}
> @@ -4518,6 +4528,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
>   		spin_unlock(&mddev->lock);
>   		return err ?: len;
>   	}
> +
>   	err = mddev_lock(mddev);
>   	if (err)
>   		return err;
> @@ -4592,6 +4603,11 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
>   		sysfs_notify_dirent_safe(mddev->sysfs_state);
>   	}
>   	mddev_unlock(mddev);
> +
> +	if (st == readonly || st == read_auto || st == inactive ||
> +	    (err && st == clear))
> +		clear_bit(MD_CLOSING, &mddev->flags);
> +
>   	return err ?: len;
>   }
>   static struct md_sysfs_entry md_array_state =
> 


