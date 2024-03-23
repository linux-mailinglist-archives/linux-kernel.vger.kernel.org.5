Return-Path: <linux-kernel+bounces-112221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C9887708
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6707B22C28
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181B46A2;
	Sat, 23 Mar 2024 04:08:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BA3212;
	Sat, 23 Mar 2024 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711166938; cv=none; b=Uae1vjxcIKIhPPVDYq70v6QX7gTHZLl+znvGQeHcl2PNGBIFQOy9R+n73QKgBl8+hyID43dEvknU0GVct5IHWphtmMaxCMCPP7MtP2ipMcpAsy/+2wfdivm5AYg3OX0IcF1jYeGtZXczVvzh+KrVKpVw5aCaQaoWWnfsP/KF7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711166938; c=relaxed/simple;
	bh=4oRX4Cx6hyqDJYWs38u+gDzw5PT4IwJPW1kcvG1ZjSs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gRzco7/k+sWizfUoaXaNXgXL4e65eyki/m3edZAefu3ep0RwhNmn3p7f4/HoAkgYeC0F7YxarFDy/TbbEPX6e2P8PbaZwF/ofBdHxBeA2ZaMspeolf5SygiqsYo6eUBpdo3Ls3bquCcNNm0v2Fkd0lg2HkqAnRxr6R+Jhx7naOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V1m0J6QRPz4f3jkl;
	Sat, 23 Mar 2024 12:08:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D0AAA1A017A;
	Sat, 23 Mar 2024 12:08:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RHSVf5luFc2Hw--.52606S3;
	Sat, 23 Mar 2024 12:08:52 +0800 (CST)
Subject: Re: [PATCH 0/2] block: support to account io_ticks precisely
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, hch@lst.de,
 bvanassche@acm.org, axboe@kernel.dk, mpatocka@redhat.com, snitzer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
 <20240323035959.1397382-4-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dd50fb4c-ab03-4c15-de4e-93ce2e8a52a0@huaweicloud.com>
Date: Sat, 23 Mar 2024 12:08:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240323035959.1397382-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RHSVf5luFc2Hw--.52606S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYy7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20E
	Y4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

Sorry that I somehow send this set twice... Please ignore the additional
set.

Thanks,
Kuai

ÔÚ 2024/03/23 11:59, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Yu Kuai (2):
>    block: support to account io_ticks precisely
>    block: remove blk_mq_in_flight() and blk_mq_in_flight_rw()
> 
>   block/blk-core.c  |  9 +++++----
>   block/blk-merge.c |  2 ++
>   block/blk-mq.c    | 36 ++++--------------------------------
>   block/blk-mq.h    |  5 -----
>   block/blk.h       |  1 +
>   block/genhd.c     | 20 ++++----------------
>   6 files changed, 16 insertions(+), 57 deletions(-)
> 


