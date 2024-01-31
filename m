Return-Path: <linux-kernel+bounces-45628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C88843334
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D112FB25F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A655684;
	Wed, 31 Jan 2024 02:13:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F75223;
	Wed, 31 Jan 2024 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667218; cv=none; b=SdHorBbL/VUey2dSAbHdhI6jUXNeQ3Oz/6ulxpJCriUaXiv5hm9tYTEevjCHXbY46t5KfDMSVcPYxmTklaTE+HJil1ypAv0FvxV6ObWf5vEqADVvHz4DFHvqyGUjWBi9rLGUFjFXM9iImHEr4oyqrg4cGUKriiXo9Jjen/5mTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667218; c=relaxed/simple;
	bh=Jqb6stvltBCpUMye9AFTj1l51864WjZbIVuEqovK1zY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qHh+EMtpoNXnVUdlsN4rwQrtd7G56J0QquDi6kCLwXBNXAS2Ux528yRInbNbcUCVSuPcs1ZS5u7DMuZj/h0n2A0fhD+0069JpBUsD9/8bMsv2RPwSRN+mrNICWt4d5rZO92VLO4Eil9HBbH/qgDRIOb9KFNu2/U1yJxenvnz9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TPlv93bxbz4f3lCm;
	Wed, 31 Jan 2024 10:13:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F3DC21A016E;
	Wed, 31 Jan 2024 10:13:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDJrLll9_IECg--.62077S3;
	Wed, 31 Jan 2024 10:13:31 +0800 (CST)
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Song Liu <song@kernel.org>, Blazej Kucman
 <blazej.kucman@linux.intel.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Dan Moulding <dan@danm.net>, carlos@fisica.ufpr.br,
 gregkh@linuxfoundation.org, junxiao.bi@oracle.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <ZbMnZnvyIyoWeIro@fisica.ufpr.br>
 <20240126154610.24755-1-dan@danm.net>
 <20240130172524.0000417b@linux.intel.com>
 <CAPhsuW5S7H-P9NiBxk=EVrzYSC6esBxiEg-pR=QMeASWh_S5GA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cb0e6b82-1a09-4539-2d72-f0f1b07e8ea8@huaweicloud.com>
Date: Wed, 31 Jan 2024 10:13:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5S7H-P9NiBxk=EVrzYSC6esBxiEg-pR=QMeASWh_S5GA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDJrLll9_IECg--.62077S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1rAw4DXFyxZw4Dur48JFb_yoWktFc_ZF
	W5Cr98Wa1Fyw1xXa1DJr4Yvrs2yrs8ua4jqrZ5ZrW2y34ruan29FZFkw1rA3W5uryUKF1a
	y34Uu343XrZ7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/31 9:26, Song Liu 写道:
>> Scenario:
>> 1. Create raid10:
>> mdadm --create /dev/md/r10d4s128-15_A --level=10 --chunk=128
>> --raid-devices=4 /dev/nvme6n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme0n1
>> --size=7864320 --run
>> 2. Create FS
>> mkfs.ext4 /dev/md/r10d4s128-15_A
>> 3. Set faulty one raid member:
>> mdadm --set-faulty /dev/md/r10d4s128-15_A /dev/nvme3n1
> With a failed drive, md_thread calls md_check_recovery() and kicks
> off mddev->sync_work, which is ﻿﻿md_start_sync().
> md_check_recovery() also sets MD_RECOVERY_RUNNING.
> 
> md_start_sync() calls mddev_suspend() and waits for
> mddev->active_io to become zero.
> 
>> 4. Stop raid devies:
>> mdadm -Ss
> This command calls stop_sync_thread() and waits for
> MD_RECOVERY_RUNNING to be cleared.
> 
> Given we need a working file system to reproduce the issue, I
> suspect the problem comes from active_io.

I'll look into this. But I don't understand the root cause yet.
Who grab the 'active_io' and why doesn't release it?

Thanks,
Kuai

> 
> Yu Kuai, I guess we missed this case in the recent refactoring.
> I don't have a good idea to fix this. Please also take a look into
> this.


