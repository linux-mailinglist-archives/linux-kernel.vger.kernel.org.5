Return-Path: <linux-kernel+bounces-96422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DDC875BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CB6283983
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C590122619;
	Fri,  8 Mar 2024 01:12:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146A241EC;
	Fri,  8 Mar 2024 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860375; cv=none; b=m2XqGdY2lfG4hkoqk2doewHXz3m+pazooZ3bzqNtaG9rcUFnMKc2rG2phZ3ZaeU64HZ5l21ZOcMFTXdmVENiFO/0Rb21nH14x54SnZwsNH94gbWsvnyd8//dNp88MawHB7gm9/1S6YoG6TV9kXUDSs8GQbAFJNBc552wB2xjTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860375; c=relaxed/simple;
	bh=1mVky2Uh3EgdkppjS1jKSHp4wA7DmzZlK7zrUMGhcrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSvJPYb0JadhfY1l4ZhUp8j5IXItXps9CKnJMfuHEK08PpYrC2PsSzSc3ITNMGFiEiN0cinblZDCJMEYEMFCuvTzrcWtIuBt6FSTuV9qS02cJ+HdS+7aCqCXS2Q6bmfaDjKbNiYkOMA07VG+lm5Trs3JWKLQIhKniuNP6OA8Z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TrSny39Ghz4f3nT9;
	Fri,  8 Mar 2024 09:12:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 040E11A016E;
	Fri,  8 Mar 2024 09:12:46 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgC32w4MZuplPlyWGQ--.3947S3;
	Fri, 08 Mar 2024 09:12:45 +0800 (CST)
Message-ID: <1dec5d5d-fb4b-8203-82ca-dc1ee92132bb@huaweicloud.com>
Date: Fri, 8 Mar 2024 09:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/2] md: fix is_mddev_idle()
To: linan666@huaweicloud.com, song@kernel.org, axboe@kernel.dk
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20240117031946.2324519-1-linan666@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <20240117031946.2324519-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC32w4MZuplPlyWGQ--.3947S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYA7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvE
	ncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I
	8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0E
	jII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbI
	xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUU
	UUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

friendly ping ...

在 2024/1/17 11:19, linan666@huaweicloud.com 写道:
> From: Li Nan <linan122@huawei.com>
> 
> Changes in v4:
>   - patch 2, add the check of 'init', update last_events even if iostat
>     is disabled.
> 
> Li Nan (2):
>    md: Fix overflow in is_mddev_idle
>    md: don't account sync_io if iostats of the disk is disabled
> 
>   drivers/md/md.h        |  5 +++--
>   include/linux/blkdev.h |  2 +-
>   drivers/md/md.c        | 11 ++++++++---
>   3 files changed, 12 insertions(+), 6 deletions(-)
> 

-- 
Thanks,
Nan


