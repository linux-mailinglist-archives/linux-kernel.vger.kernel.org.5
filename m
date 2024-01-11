Return-Path: <linux-kernel+bounces-23008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E600182A64B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 04:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D7228AE50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980B15D5;
	Thu, 11 Jan 2024 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfHJFtxd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335F15A1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE71C433C7;
	Thu, 11 Jan 2024 03:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704942328;
	bh=ZLl7kGhUGnW8PU9f96aUKCXnoo6LveMARPa7a8KWG2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nfHJFtxdOgtxfL8bGvcbya4xrqDfq0X4ap6ZPPhlccn+oCJlmfee52k5DxySQrQ7I
	 gnofBMPaGIDJHzG1qy/pgIKOPetWaJ9ZEXEuxpXgnh03m/XP0j5x1OIYjqOZb+ey0I
	 yRGUOnzuPqvKvsCZ67Dmed4EWbcTjwy7IrLprXyiYOrLPHYrtQrmMkdRQrmjm2ys5c
	 +RDg+ZzYaQgPQmp3IMZlMQQRQDj0U+SN199y+yfQ55xoTXs7xB/rn+tOjQcAZy/Uxh
	 T6Ev7JBQZ7HjmffMQ5PsKeYwIv7ph2z61h16w+qR3+dYK+R+LQvKcrepo0m+5PvosT
	 Oej4YjptoMV6Q==
Message-ID: <70a44ec7-8842-47d3-86d4-67dd173f9d82@kernel.org>
Date: Thu, 11 Jan 2024 11:05:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] f2fs: introduce FAULT_BLKADDR_INCONSISTENCE
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231228143152.1543509-1-chao@kernel.org>
 <20231228143152.1543509-6-chao@kernel.org> <ZZR4Tup3Lm3zh2V1@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZZR4Tup3Lm3zh2V1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/3 4:55, Jaegeuk Kim wrote:
> On 12/28, Chao Yu wrote:
>> We will encounter below inconsistent status when FAULT_BLKADDR type
>> fault injection is on.
>>
>> Info: checkpoint state = d6 :  nat_bits crc fsck compacted_summary orphan_inodes sudden-power-off
>> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c100 has i_blocks: 000000c0, but has 191 blocks
>> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1c100] i_blocks=0x000000c0 -> 0xbf
>> [FIX] (fsck_chk_inode_blk:1269)  --> [0x1c100] i_compr_blocks=0x00000026 -> 0x27
>> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1cadb has i_blocks: 0000002f, but has 46 blocks
>> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1cadb] i_blocks=0x0000002f -> 0x2e
>> [FIX] (fsck_chk_inode_blk:1269)  --> [0x1cadb] i_compr_blocks=0x00000011 -> 0x12
>> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c62c has i_blocks: 00000002, but has 1 blocks
>> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1c62c] i_blocks=0x00000002 -> 0x1
>>
>> After we inject fault into f2fs_is_valid_blkaddr() during truncation,
>> a) it missed to increase @nr_free or @valid_blocks
>> b) it can cause in blkaddr leak in truncated dnode
>> Which may cause inconsistent status.
>>
>> This patch separates FAULT_BLKADDR_INCONSISTENCE from FAULT_BLKADDR,
>> so that we can:
>> a) use FAULT_BLKADDR_INCONSISTENCE in f2fs_truncate_data_blocks_range()
>> to simulate inconsistent issue independently,
>> b) FAULT_BLKADDR fault will not cause any inconsistent status, we can
>> just use it to check error path handling in kernel side.
> 
> How about defining FAULT_BLKADDR_VALIDITY and FAULT_BLKADDR_CONSISTENCY?

Better, :)

Thanks,

