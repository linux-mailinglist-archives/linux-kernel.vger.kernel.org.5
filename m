Return-Path: <linux-kernel+bounces-85029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8F86AF57
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C724B21ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82D1474D8;
	Wed, 28 Feb 2024 12:44:22 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6A73501;
	Wed, 28 Feb 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124262; cv=none; b=qOr3zZwYXvYTMh55sWlzBXQTAF2YPyWs3JvFm3FnNXBjjv8a8qvOZ6SRmpc+5EKH8En11bo0M/MBPEjXltU1dnRnEHYW+8KnP+JdJ/7StqJ/fAf8qyxRoesSICVgLFB+0RmDT5dL7cGe8sMQiAEGS7838nhCa4nYWdi89IijTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124262; c=relaxed/simple;
	bh=tMfjGrNNnmV18hIOHIViOfsG4BhwJXfeXyLAD8Hz/QA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h4gYKukPubgMC0r1C+DgaY2W0Lf/GAiPzio/Fuana7sV4q7htF6nwgSdO7oc4wvXRgJbcqlIWyE5azRPLERi4YNTFb3pwyIGzel03JN3VTDeZWbk4HLYq42AY2yDTAjfZxFeDCVh2OC6B3KgGwuG6DwS4yZnW64X7VbyFGIliUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlDZ45b1Sz4f3k6D;
	Wed, 28 Feb 2024 20:44:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 274B71A0199;
	Wed, 28 Feb 2024 20:44:16 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6eKt9lT+aqFQ--.9951S3;
	Wed, 28 Feb 2024 20:44:15 +0800 (CST)
Subject: Re: [PATCH v5 04/14] md: don't register sync_thread for reshape
 directly
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, neilb@suse.de, shli@fb.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-5-yukuai1@huaweicloud.com>
 <d233fc29-e3ab-4761-9368-c203efc0466e@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <40ac6914-7c1f-00b7-f480-25c9786482fc@huaweicloud.com>
Date: Wed, 28 Feb 2024 20:44:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d233fc29-e3ab-4761-9368-c203efc0466e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g6eKt9lT+aqFQ--.9951S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtF15Jw1UtF1UCFyfAF4fXwb_yoW8JrWkp3
	yxXFy3Ar4YvF4UZ39rJa4DAF1rZw12qay7CrW7C3yrAw17K3yYqrW2yF98tayDuFyfJa15
	ua1rGa9xua1v9rJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
	Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/28 20:07, Xiao Ni 写道:
> I have a question here. Is it the reason sync_thread can't run 
> md_do_sync because kthread_should_stop, so it doesn't have the chance to 
> set MD_RECOVERY_DONE? Why creating sync thread in md_check_recovery 
> doesn't have this problem? Could you explain more about this?

raid10_run() only register sync_thread, without calling
md_wakeup_thread() to set the bit 'THREAD_WAKEUP', md_do_sync() will not
be executed.

raid5 defines 'pers->start' hence md_start() will call
md_wakeup_thread().

md_start_sync() will always call md_wakeup_thread() hence there is no
such problem.

BTW, this patch fix the same problem as you mentioned in your other
thread:

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 2266358d8074..54790261254d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4904,6 +4904,7 @@ static void stop_sync_thread(struct mddev *mddev, 
bool locked, bool check_seq)
  	 * never happen
  	 */
  	md_wakeup_thread_directly(mddev->sync_thread);
+	md_wakeup_thread(mddev->sync_thread);
  	if (work_pending(&mddev->sync_work))
  		flush_work(&mddev->sync_work);

However, I think the one to register sync_thread is responsible to wake
it up.

Thanks,
Kuai


