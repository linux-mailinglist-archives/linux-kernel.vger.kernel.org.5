Return-Path: <linux-kernel+bounces-119088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C788C408
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321B2308D79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA977FBAD;
	Tue, 26 Mar 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teLviXGM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2082768FE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460632; cv=none; b=O6maIq+uR0PjJGyvGwGD8S3zebcJPU8qIdN3I8/0kLfNuBBO823M+i8ma2F0BAd+l4JZZpL7GIXU755rmap6LdeFBJBQOEBUHn7QpkD/PbPrhSnXpB4Ty5O/gjP/sdEBcwjm6JmBCBHJ0O1JC728YMTiAbc6bTVZEm91WTm0bAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460632; c=relaxed/simple;
	bh=MpdHKo/pfARWrNEUHGDFnEqINIOljO1DHUfimSXa2V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yo9cKE3MbJUUUXE3e/SvX4NQ0FQioROZFBaLTs5/Oths+N+ZXiyXA70P0Ew8ZCyEe3zuaK2fLVnE0qGUKa6V6ScVISjAxpmvRBdDHj/De1AC6lEfEI7C0oKukrs1WUSpz8jEe+Oa1Tim1lVDEFUhvK9OGgOCH3NmwBQESD94yH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teLviXGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7C8C433C7;
	Tue, 26 Mar 2024 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711460631;
	bh=MpdHKo/pfARWrNEUHGDFnEqINIOljO1DHUfimSXa2V4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=teLviXGM1CEIFpViliftf4YncsY+PMH3k7xzGBav3T1W5z1hdGtU7zxnZtaQ1Ypa8
	 n1pXW7caq/cMSiB7VF8lUNt+mhDRbOenFCHrtfQKwH1OrZkpDpgXHHxYtRjMmeiOkM
	 SA3hC/q16H8r0t3LLWjncpGfCUbbfaNGgmGemEqD+t8aFluGUPFA2r0PNTQ/7fhRDj
	 wTeYk2C4jXUVy5vs05/huSDJ/NYQjU2koYHuIYcKWuSU+VFI0S1V/daQ/DnbcKqVkA
	 b/c9XB2268syaXbQENT38Du2IBG7nsW+bGNFjQNnpaB00flEBuYmGRJumvRzDutKD7
	 2X7zvRAVDBQlg==
Message-ID: <a0f95756-aaeb-43d7-93cc-a8befee2ec78@kernel.org>
Date: Tue, 26 Mar 2024 21:43:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: multidev: fix to recognize valid zero block address
To: Yi Zhang <yi.zhang@redhat.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240325152623.797099-1-chao@kernel.org>
 <CAHj4cs8vWQ2YRTKKETWX5sJduYO1BJ8NPSwo8mw3LqqRfsns1g@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <CAHj4cs8vWQ2YRTKKETWX5sJduYO1BJ8NPSwo8mw3LqqRfsns1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/26 21:26, Yi Zhang wrote:
> I confirmed the issue was fixed now, thanks.
> 
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

Yi, thanks for the test.

Thanks,

> 
> On Mon, Mar 25, 2024 at 11:26 PM Chao Yu <chao@kernel.org> wrote:
>>
>> As reported by Yi Zhang in mailing list [1], kernel warning was catched
>> during zbd/010 test as below:
>>
>> ./check zbd/010
>> zbd/010 (test gap zone support with F2FS)                    [failed]
>>      runtime    ...  3.752s
>>      something found in dmesg:
>>      [ 4378.146781] run blktests zbd/010 at 2024-02-18 11:31:13
>>      [ 4378.192349] null_blk: module loaded
>>      [ 4378.209860] null_blk: disk nullb0 created
>>      [ 4378.413285] scsi_debug:sdebug_driver_probe: scsi_debug: trim
>> poll_queues to 0. poll_q/nr_hw = (0/1)
>>      [ 4378.422334] scsi host15: scsi_debug: version 0191 [20210520]
>>                       dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
>>      [ 4378.434922] scsi 15:0:0:0: Direct-Access-ZBC Linux
>> scsi_debug       0191 PQ: 0 ANSI: 7
>>      [ 4378.443343] scsi 15:0:0:0: Power-on or device reset occurred
>>      [ 4378.449371] sd 15:0:0:0: Attached scsi generic sg5 type 20
>>      [ 4378.449418] sd 15:0:0:0: [sdf] Host-managed zoned block device
>>      ...
>>      (See '/mnt/tests/gitlab.com/api/v4/projects/19168116/repository/archive.zip/storage/blktests/blk/blktests/results/nodev/zbd/010.dmesg'
>>
>> WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
>> CPU: 22 PID: 44011 Comm: fio Not tainted 6.8.0-rc3+ #1
>> RIP: 0010:iomap_iter+0x32b/0x350
>> Call Trace:
>>   <TASK>
>>   __iomap_dio_rw+0x1df/0x830
>>   f2fs_file_read_iter+0x156/0x3d0 [f2fs]
>>   aio_read+0x138/0x210
>>   io_submit_one+0x188/0x8c0
>>   __x64_sys_io_submit+0x8c/0x1a0
>>   do_syscall_64+0x86/0x170
>>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>
>> Shinichiro Kawasaki helps to analyse this issue and proposes a potential
>> fixing patch in [2].
>>
>> Quoted from reply of Shinichiro Kawasaki:
>>
>> "I confirmed that the trigger commit is dbf8e63f48af as Yi reported. I took a
>> look in the commit, but it looks fine to me. So I thought the cause is not
>> in the commit diff.
>>
>> I found the WARN is printed when the f2fs is set up with multiple devices,
>> and read requests are mapped to the very first block of the second device in the
>> direct read path. In this case, f2fs_map_blocks() and f2fs_map_blocks_cached()
>> modify map->m_pblk as the physical block address from each block device. It
>> becomes zero when it is mapped to the first block of the device. However,
>> f2fs_iomap_begin() assumes that map->m_pblk is the physical block address of the
>> whole f2fs, across the all block devices. It compares map->m_pblk against
>> NULL_ADDR == 0, then go into the unexpected branch and sets the invalid
>> iomap->length. The WARN catches the invalid iomap->length.
>>
>> This WARN is printed even for non-zoned block devices, by following steps.
>>
>>   - Create two (non-zoned) null_blk devices memory backed with 128MB size each:
>>     nullb0 and nullb1.
>>   # mkfs.f2fs /dev/nullb0 -c /dev/nullb1
>>   # mount -t f2fs /dev/nullb0 "${mount_dir}"
>>   # dd if=/dev/zero of="${mount_dir}/test.dat" bs=1M count=192
>>   # dd if="${mount_dir}/test.dat" of=/dev/null bs=1M count=192 iflag=direct
>>
>> ..."
>>
>> So, the root cause of this issue is: when multi-devices feature is on,
>> f2fs_map_blocks() may return zero blkaddr in non-primary device, which is
>> a verified valid block address, however, f2fs_iomap_begin() treats it as
>> an invalid block address, and then it triggers the warning in iomap
>> framework code.
>>
>> Finally, as discussed, we decide to use a more simple and direct way that
>> checking (map.m_flags & F2FS_MAP_MAPPED) condition instead of
>> (map.m_pblk != NULL_ADDR) to fix this issue.
>>
>> Thanks a lot for the effort of Yi Zhang and Shinichiro Kawasaki on this
>> issue.
>>
>> [1] https://lore.kernel.org/linux-f2fs-devel/CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com/
>> [2] https://lore.kernel.org/linux-f2fs-devel/gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye/
>>
>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>> Closes: https://lore.kernel.org/linux-f2fs-devel/CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com/
>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Fixes: 1517c1a7a445 ("f2fs: implement iomap operations")
>> Fixes: 8d3c1fa3fa5e ("f2fs: don't rely on F2FS_MAP_* in f2fs_iomap_begin")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index d9494b5fc7c1..5ef1874b572a 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -4185,7 +4185,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>          if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
>>                  return -EINVAL;
>>
>> -       if (map.m_pblk != NULL_ADDR) {
>> +       if (map.m_flags & F2FS_MAP_MAPPED) {
>>                  iomap->length = blks_to_bytes(inode, map.m_len);
>>                  iomap->type = IOMAP_MAPPED;
>>                  iomap->flags |= IOMAP_F_MERGED;
>> --
>> 2.40.1
>>
> 
> 

