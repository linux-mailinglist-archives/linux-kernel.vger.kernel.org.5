Return-Path: <linux-kernel+bounces-37891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C083B730
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F103B227F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D3D5CA1;
	Thu, 25 Jan 2024 02:37:09 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F380B;
	Thu, 25 Jan 2024 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150228; cv=none; b=L6uLi+OpgxFQYob6b9dbe1ZqRNSXlaEOSsOqVXektQshu1e4ThE74su2aJK7wvnHdMyPHAyt8lTHV9uStQiRBFBzVcVAOjTY9dHxYYfYfpmALnssGRTt93edDy9N+EpaJdXytFI3gpdAXzJ+vRtRIqPCSGyfzSTsx2IbOJ5Pr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150228; c=relaxed/simple;
	bh=lDDLv4BPTm8yumQdbsY6WoNyjCvSi8wZiQ/g5fu6+Ls=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iMoVwrDIiJ5sd6lgvLxIJAUu/VpKKcOxn4AEMBXm8Pnooa7zA/fYG/6l/HeaXY/5RUThxikIx4Dxzo14et044Y1u0lsu4qf8TMYbb4QLDtkJvgPgW+hbZo72fL92A+wyjRSqyirrwT08ed9a9dkRmO8L0gFipGF5bYIAT3Uny3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TL4j31WD3z4f3lVm;
	Thu, 25 Jan 2024 10:36:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 81ACD1A0272;
	Thu, 25 Jan 2024 10:37:01 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFLybFlhGKUBw--.55533S3;
	Thu, 25 Jan 2024 10:37:01 +0800 (CST)
Subject: Re: [PATCH v2 00/11] dm-raid: fix v6.7 regressions
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, dm-devel@lists.linux.dev, snitzer@kernel.org,
 agk@redhat.com, xni@redhat.com, jbrassow@f14.redhat.com, neilb@suse.de,
 heinzm@redhat.com, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
 <CAPhsuW4aqpQfQvBaeDaiJwOOOy-XspdDjAdvQVfFBEvHN-WUQA@mail.gmail.com>
 <216fbc61-4f71-3796-5ec1-2e4cfa815ced@huaweicloud.com>
 <CAPhsuW4KpPo7gvmZX-MgMZ160=1q1Xn9BQnBUH+idWM575ECbA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <68713dca-20a9-c498-bb89-af5430c0672d@huaweicloud.com>
Date: Thu, 25 Jan 2024 10:36:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4KpPo7gvmZX-MgMZ160=1q1Xn9BQnBUH+idWM575ECbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFLybFlhGKUBw--.55533S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF1rKFyxKrW3GrWUAr4kXrb_yoWDKrb_Jw
	13Xrs8G3yrWFZrW3WqyF1kAr4DWa9ru392yrWjgay0kr1jqa4xJa4DZ3s0qrnFgrW8CFn7
	ta1FqF47ArZxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/25 9:51, Song Liu 写道:
> Hmm.. maybe it is caused by different .config? Attached is the
> output from the test and the config file I used.

Looks like your test differs from mine here:

| [ 0:16.663] aux wait_for_sync $vg $lv
| [ 0:17.002] #lvconvert-raid-reshape-linear_to_raid6-single-type.sh:67+ 
aux wait_for_sync LVMTEST2056vg LV
| [ 0:17.002] LVMTEST2056vg/LV (raid5_ls) in-sync, but 'a' characters in 
health status
| [ 0:17.200] LVMTEST2056vg/LV (raid5_ls) in-sync, but 'a' characters in 
health status

Mine:
[ 0:08.875] #lvconvert-raid-reshape-linear_to_raid6-single-type.sh:67+ 
aux wait_for_sync LVMTEST2826329vg LV
[ 0:08.876] LVMTEST2826329vg/LV (raid5_ls) is in-sync     0 98304 raid 
raid5_ls 4 AAAA 32768/32768 idle 0 0 -
[ 0:08.940] fsck -fn "$DM_DEV_DIR/$vg/$lv"
[ 0:08.943] #lvconvert-raid-reshape-linear_to_raid6-single-type.sh:68+ 
fsck -fn /mnt/test/LVMTEST2826329.RgRdke29n8/dev/LVMTEST2826329vg/LV

However, the we all enabled dm and raid related config, I have no clue
yet. :(

Thanks,
Kuai


