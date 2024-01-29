Return-Path: <linux-kernel+bounces-42537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7848402C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E07E28525C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E456B84;
	Mon, 29 Jan 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ6H4eTW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AFB5647A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524066; cv=none; b=A4zyqZTiRtAezAsQHyyEL60MBY0tM3DecrByx5TkIEiYMqston0h1KDTfzbhWJJ5h/Cp03tKlBpZjlxIQnoPPhRzZGRIGfdE8/Js1E0Sn6duC/eAE9gLcDb8S0DFsj/SPluCP3ZXcdg0sDkmK5asYsV0ZFvVtZLu2IT5VOjnlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524066; c=relaxed/simple;
	bh=dJ3bS5oGG9PHms+736cFAZX/JO0z5fQy3JzWxPCMyqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y80DSbMtAEvtl7WNdNsI/VU7Ld0vZ7JCQgyMQ0WLd0JSpzxRLxzWkkW7iesiVCdYuMnAWagiXgRKsqaD52Fp1pscXY7OBg2jKjkbr84EbyE/b63k2Ou5rZOVY5aDNhMLhKZkeiPOkUSQE1HzF+FK+3ztDQx7LD3OXx9tZJYuq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ6H4eTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ABAC43390;
	Mon, 29 Jan 2024 10:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706524065;
	bh=dJ3bS5oGG9PHms+736cFAZX/JO0z5fQy3JzWxPCMyqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qJ6H4eTWCM1WSFpRsizOIHNUQefYGhckq73mSh80dT/GCCrPohIBd/BZx+8MvPhsX
	 Ue74dpfnWa2meEEYCbKyugyVLUwDszjvrJfgtp4xHfD+aJKlnLvJfoniYMMgtADO73
	 xk/810eY/grQ3XUkPY2G9WwTiUUj88VXkgV7eIPIv8jh6xGy7yQ1+M3HutW8fLndsw
	 9YymWyTvOywHyNpTmJg8Q4rDBojS0F5cf+Vbci4SgNQ8cX28DwvIMrhTl73M+wjY0C
	 u5nU48uBa/pfIs405Q7rL+akEn86Tv3WUQybJ0IGJqff2yPfevc/Ms2eKbzT2Tjslo
	 qHoxhRyLbmBkA==
Message-ID: <d379bc01-ca31-41e6-9d85-7fca846af491@kernel.org>
Date: Mon, 29 Jan 2024 18:27:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] f2fs: fix NULL pointer dereference in
 f2fs_submit_page_write()
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
Cc: hustqwj@hust.edu.cn, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20240116141138.1245-1-qwjhust@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240116141138.1245-1-qwjhust@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 22:11, Wenjie Qi wrote:
> BUG: kernel NULL pointer dereference, address: 0000000000000014
> RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> Call Trace:
> <TASK>
> ? show_regs+0x6e/0x80
> ? __die+0x29/0x70
> ? page_fault_oops+0x154/0x4a0
> ? prb_read_valid+0x20/0x30
> ? __irq_work_queue_local+0x39/0xd0
> ? irq_work_queue+0x36/0x70
> ? do_user_addr_fault+0x314/0x6c0
> ? exc_page_fault+0x7d/0x190
> ? asm_exc_page_fault+0x2b/0x30
> ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> ? f2fs_submit_page_write+0x736/0x780 [f2fs]
> do_write_page+0x50/0x170 [f2fs]
> f2fs_outplace_write_data+0x61/0xb0 [f2fs]
> f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
> f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
> f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
> ...
> It is possible that other threads have added this fio to io->bio
> and submitted the io->bio before entering f2fs_submit_page_write().
> At this point io->bio = NULL.
> If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
> then an NULL pointer dereference error occurs at bio_get(io->bio).
> The original code for determining zone end was after "out:",
> which would have missed some fio who is zone end. I've moved
>   this code before "skip:" to make sure it's done for each fio.
> 
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

