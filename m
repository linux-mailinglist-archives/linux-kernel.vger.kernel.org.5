Return-Path: <linux-kernel+bounces-42602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9128403A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57352857DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F885B5A5;
	Mon, 29 Jan 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MloQDblJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80685B5B0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527015; cv=none; b=NdF+bpPBVmLC3jGrI+eBvpY37+xd9ynHY6l/OCCndCIK4PIoh33pXTPSOPCTmssdz5DThzo32gsBJ3ALgYI0ZisK4D2y88ZXhtHSu6OqvV+7PtqvYMkneCnOo1bZY0Gzt1yIe+I2PJKtzURHVGyfeje66Qgu9Mw58SI2I/zKE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527015; c=relaxed/simple;
	bh=S9RgsTiinDPCOsZbeFEA2HpDxwJGkw8/kTFTAURjfYY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D3T61yvb/ldFDfMydePNsZP+JqJe9MXnyttaT/iz+LjVSapv11wNEtpKKf6CR4wOT1ll5smTLy+EaWOauPDJGbvgZmdzPtVIni4EnFEPmxafkLvFQUfzDx0y5hMezTQmG/IJT4CFfuNpDiV4s/7hgkUgPj9ZlpBCT5IP8csfbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MloQDblJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2414C433F1;
	Mon, 29 Jan 2024 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706527015;
	bh=S9RgsTiinDPCOsZbeFEA2HpDxwJGkw8/kTFTAURjfYY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MloQDblJX8MmBA9g95QdxAITc2g2x/5JFsfZaXmWxhROVFlStuSOEUO1A35qQRyuX
	 l2XiE0bvoUtN6Kpft3NYUPEu4RJvADWhpIA3LyQWMwweowwNX4MTvVhxsZzZBO95UP
	 KqMzgAQueECLGs5aBg9UJZ1H0zrCuSE+xcSU0ZbaXhx3ExAOhw1L4L5mJdiwM4k28+
	 8DWEYB4Sh6r+nW9t2xUK2Z53w1mlNg+p+QG0ASXiMtTGva/EnxNP8JfOlzzP+S7sLp
	 j3axAlq48y0MfuA/qB3QchQd4amMnGid+awTNDRkA5dqc1GcwW5EArVYD7N8hq2qeT
	 0QcWnpS2NhKWA==
Message-ID: <0f356116-9e67-4abb-8bc2-65e63a936c17@kernel.org>
Date: Mon, 29 Jan 2024 19:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix NULL pointer dereference in
 f2fs_submit_page_write()
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, hustqwj@hust.edu.cn,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240116141138.1245-1-qwjhust@gmail.com>
 <d379bc01-ca31-41e6-9d85-7fca846af491@kernel.org>
In-Reply-To: <d379bc01-ca31-41e6-9d85-7fca846af491@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/29 18:27, Chao Yu wrote:
> On 2024/1/16 22:11, Wenjie Qi wrote:
>> BUG: kernel NULL pointer dereference, address: 0000000000000014
>> RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
>> Call Trace:
>> <TASK>
>> ? show_regs+0x6e/0x80
>> ? __die+0x29/0x70
>> ? page_fault_oops+0x154/0x4a0
>> ? prb_read_valid+0x20/0x30
>> ? __irq_work_queue_local+0x39/0xd0
>> ? irq_work_queue+0x36/0x70
>> ? do_user_addr_fault+0x314/0x6c0
>> ? exc_page_fault+0x7d/0x190
>> ? asm_exc_page_fault+0x2b/0x30
>> ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
>> ? f2fs_submit_page_write+0x736/0x780 [f2fs]
>> do_write_page+0x50/0x170 [f2fs]
>> f2fs_outplace_write_data+0x61/0xb0 [f2fs]
>> f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
>> f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
>> f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
>> ...
>> It is possible that other threads have added this fio to io->bio
>> and submitted the io->bio before entering f2fs_submit_page_write().
>> At this point io->bio = NULL.
>> If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
>> then an NULL pointer dereference error occurs at bio_get(io->bio).
>> The original code for determining zone end was after "out:",
>> which would have missed some fio who is zone end. I've moved
>>   this code before "skip:" to make sure it's done for each fio.
>>

Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")

>> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

