Return-Path: <linux-kernel+bounces-117358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5BB88AA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348FA1FA0986
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF02E1BF24;
	Mon, 25 Mar 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDv+vRC9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B41BF3B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380394; cv=none; b=ff3CEyvICKLvqR0H93Mp9rxfgPu+hW/RHayrwK85uwD1ojsco/e8A0tiO55DAwKtGelnKLNDdRs85yauRiCRjyGjt/B+0HZ7zwb2fEKWMkY9aHJ09S6hnuBRYoNQpGsbZYsdJX0YbSbc89v23YihHDKhZtyw0ZWxqSyCTj++1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380394; c=relaxed/simple;
	bh=rnELyLxB9RlicAGQEI132YVsh8obrSUToWBaes05A0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gKf9s1Rk9a/cEENPXZlzhB/ujQIocRdXKGbJlvlUZMqp6AtN35kbRRxwY8vQKhvBRPgo9QeXWVyiO8fNPExap+UpAmJn8sakG338XMFW/GFKJpMLz/O28mSMiFqzvxQM8xZ9zkW+aa3SYEGsmCrkDxmxUwN1R0iAbAe/n/LrET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDv+vRC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8102DC433F1;
	Mon, 25 Mar 2024 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711380393;
	bh=rnELyLxB9RlicAGQEI132YVsh8obrSUToWBaes05A0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=jDv+vRC9YcwhOjFCWXp2py+lDhFM/Ke/AzwSnBOUNGa950nwQ89BttPuUBk4qwx91
	 xBftCng2ky+UuTElrzDa4NlDnVnxjRKqYH6ldrAmP7WPBx85AmBrtk5JGjQsYkIOtx
	 37DaDq6KpRWHES3f7MrkSsOOW4puIlmja4b717CcXm5pEZ9zCqtMQEEVNDQuXwiQRS
	 DeL6CfEbpNvU1wdq5oV/21WIt+EyUbDhPUURwvr+6IGw96l6mzYV3MwtlLwJg1i9tZ
	 B4XKd5sPghcZ1laIswf2ucbBmU9Kn2NpCqy0uwyLzUig1VPr3XaCLlc/fTTt5jtBLY
	 8K7e9L2+thMbQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] f2fs: multidev: fix to recognize valid zero block address
Date: Mon, 25 Mar 2024 23:26:23 +0800
Message-Id: <20240325152623.797099-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Yi Zhang in mailing list [1], kernel warning was catched
during zbd/010 test as below:

/check zbd/010
zbd/010 (test gap zone support with F2FS)                    [failed]
    runtime    ...  3.752s
    something found in dmesg:
    [ 4378.146781] run blktests zbd/010 at 2024-02-18 11:31:13
    [ 4378.192349] null_blk: module loaded
    [ 4378.209860] null_blk: disk nullb0 created
    [ 4378.413285] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw = (0/1)
    [ 4378.422334] scsi host15: scsi_debug: version 0191 [20210520]
                     dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
    [ 4378.434922] scsi 15:0:0:0: Direct-Access-ZBC Linux
scsi_debug       0191 PQ: 0 ANSI: 7
    [ 4378.443343] scsi 15:0:0:0: Power-on or device reset occurred
    [ 4378.449371] sd 15:0:0:0: Attached scsi generic sg5 type 20
    [ 4378.449418] sd 15:0:0:0: [sdf] Host-managed zoned block device
    ...
    (See '/mnt/tests/gitlab.com/api/v4/projects/19168116/repository/archive.zip/storage/blktests/blk/blktests/results/nodev/zbd/010.dmesg'

WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
CPU: 22 PID: 44011 Comm: fio Not tainted 6.8.0-rc3+ #1
RIP: 0010:iomap_iter+0x32b/0x350
Call Trace:
 <TASK>
 __iomap_dio_rw+0x1df/0x830
 f2fs_file_read_iter+0x156/0x3d0 [f2fs]
 aio_read+0x138/0x210
 io_submit_one+0x188/0x8c0
 __x64_sys_io_submit+0x8c/0x1a0
 do_syscall_64+0x86/0x170
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Shinichiro Kawasaki helps to analyse this issue and proposes a potential
fixing patch in [2].

Quoted from reply of Shinichiro Kawasaki:

"I confirmed that the trigger commit is dbf8e63f48af as Yi reported. I took a
look in the commit, but it looks fine to me. So I thought the cause is not
in the commit diff.

I found the WARN is printed when the f2fs is set up with multiple devices,
and read requests are mapped to the very first block of the second device in the
direct read path. In this case, f2fs_map_blocks() and f2fs_map_blocks_cached()
modify map->m_pblk as the physical block address from each block device. It
becomes zero when it is mapped to the first block of the device. However,
f2fs_iomap_begin() assumes that map->m_pblk is the physical block address of the
whole f2fs, across the all block devices. It compares map->m_pblk against
NULL_ADDR == 0, then go into the unexpected branch and sets the invalid
iomap->length. The WARN catches the invalid iomap->length.

This WARN is printed even for non-zoned block devices, by following steps.

 - Create two (non-zoned) null_blk devices memory backed with 128MB size each:
   nullb0 and nullb1.
 # mkfs.f2fs /dev/nullb0 -c /dev/nullb1
 # mount -t f2fs /dev/nullb0 "${mount_dir}"
 # dd if=/dev/zero of="${mount_dir}/test.dat" bs=1M count=192
 # dd if="${mount_dir}/test.dat" of=/dev/null bs=1M count=192 iflag=direct

.."

So, the root cause of this issue is: when multi-devices feature is on,
f2fs_map_blocks() may return zero blkaddr in non-primary device, which is
a verified valid block address, however, f2fs_iomap_begin() treats it as
an invalid block address, and then it triggers the warning in iomap
framework code.

Finally, as discussed, we decide to use a more simple and direct way that
checking (map.m_flags & F2FS_MAP_MAPPED) condition instead of
(map.m_pblk != NULL_ADDR) to fix this issue.

Thanks a lot for the effort of Yi Zhang and Shinichiro Kawasaki on this
issue.

[1] https://lore.kernel.org/linux-f2fs-devel/CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com/
[2] https://lore.kernel.org/linux-f2fs-devel/gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye/

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com/
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 1517c1a7a445 ("f2fs: implement iomap operations")
Fixes: 8d3c1fa3fa5e ("f2fs: don't rely on F2FS_MAP_* in f2fs_iomap_begin")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..5ef1874b572a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4185,7 +4185,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
 		return -EINVAL;
 
-	if (map.m_pblk != NULL_ADDR) {
+	if (map.m_flags & F2FS_MAP_MAPPED) {
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
-- 
2.40.1


