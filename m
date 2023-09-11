Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789579B68E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjIKVQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbjIKNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:44 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46583106;
        Mon, 11 Sep 2023 06:34:39 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Rknkd6rz6z9sZD;
        Mon, 11 Sep 2023 15:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694439273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L8zr++H2Eo56J7VdgsESHLcySXPIGTevKwUNRQXs9PU=;
        b=BJ+y9AmXpwXdxxUfOGWnGQJvpi4QcK7BPbNY6h62UuUNk6gZFYdrZfNiyrM/vz+yEdMYYE
        hMKC0LO2+5XMOPqgmxnUhnAGEBFXF/sOoQwGXTs4LwGmhi4Kwp39w2XEPVSZxhmCgsTVsJ
        nJn9vr+7MMwcA4uGB8tLcYRYliamhi8YqBZOtWyv5D8Le/2xvHiaPC+/VjUIBaea/A0bwr
        TqM68BkbLq8wDs6ZPvpCjkQUxuO9jfTtJRbLk0tLFqCpGAf5KZrEijdFusAZco9d5RTTtC
        Cjp0wc4aet9Nimm2ar+ewrFD3vP4pF24yKGVF6zFH/YG0Unj5fwDVk5k7ycN3w==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     minchan@kernel.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        p.raghav@samsung.com, linux-block@vger.kernel.org,
        kernel@pankajraghav.com, gost.dev@samsung.com
Subject: [PATCH 0/5] Improve zram writeback performance
Date:   Mon, 11 Sep 2023 15:34:25 +0200
Message-Id: <20230911133430.1824564-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Rknkd6rz6z9sZD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZRAM can have a backing device that could be used as a writeback device
for the pages in RAM. The current writeback code (writeback_store()) does
a synchronous single page size IO to the backing device.

This series implements IO batching while doing a writeback to a backing
device. The code still does synchronous IOs but with larger IO sizes
whenever possible. This crosses off one of the TODO that was there as a part
of writeback_store() function:
A single page IO would be inefficient for write...

The idea is to batch the IOs to a certain limit before the data is flushed
to the backing device. The batch limit is initially chosen based on the
bdi->io_pages value with an upper limit of 32 pages (128k on x86).

Batching reduces the time of writeback of 4G data to a nvme backing device
from 68 secs to 15 secs (more than **4x improvement**).

The first 3 patches are prep. 4th patch implements the main logic for IO
batching and the last patch is another cleanup.

Perf:

$ modprobe zram num_devices=1
$ echo "/dev/nvme0n1" > /sys/block/zram0/backing_dev
$ echo 6G > /sys/block/zram0/disksize
$ fio -iodepth=16 -rw=randwrite -ioengine=io_uring -bs=4k -numjobs=1 -size=4G -filename=/dev/zram0 -name=io_uring_1 > /dev/null
$ echo all > /sys/block/zram0/idle

Without changes:
$ time echo idle > /sys/block/zram0/writeback
real    1m8.648s         (68 secs)
user    0m0.000s
sys     0m24.899s
$ cat /sys/block/zram0/bd_stat
1048576        0  1048576

With changes:
$ time echo idle > /sys/block/zram0/writeback
real    0m15.496s       (15 secs)
user    0m0.000s
sys     0m7.789s
$ cat /sys/block/zram0/bd_stat
1048576        0  1048576

Testing:

A basic End-End testing (based on Sergey's test flow [1]):
1) configure zram0 and add a nvme device as a writeback device
2) Get the sha256sum of a tarball
3) mkfs.ext4 on zram0, cp tarball
4) idle writeback
5) cp tarball from zram0 to another device (reread writeback pages) and
   compare the sha256sum again
The sha before and after are verified to be the same.

Writeback limit testing:

1) configure zram0 and add a nvme device as a writeback device
2) Set writeback limit and enable
3) Do a fio that crosses the writeback limit
4) idle writeback
5) Verify the writeback is limited to the set writeback limit value

$ modprobe zram num_devices=1
$ echo "/dev/nvme0n1" > /sys/block/zram0/backing_dev
$ echo 4G > /sys/block/zram0/disksize
$ echo 1 > /sys/block/zram0/writeback_limit_enable
$ echo 1002 > /sys/block/zram0/writeback_limit

$ fio -iodepth=16 -rw=write -ioengine=io_uring -bs=4k -numjobs=1 -size=10M -filename=/dev/zram0 -name=io_uring_1

$ echo all > /sys/block/zram0/idle
$ echo idle > /sys/block/zram0/writeback
$ cat /sys/block/zram0/bd_stat
1002        0     1002

writeback is limited to the set value.

[1] https://lore.kernel.org/lkml/20230806071601.GB907732@google.com/

Pankaj Raghav (5):
  zram: move index preparation to a separate function in writeback_store
  zram: encapsulate writeback to the backing bdev in a function
  zram: add alloc_block_bdev_range() and free_block_bdev_range()
  zram: batch IOs during writeback to improve performance
  zram: don't overload blk_idx variable in writeback_store()

 drivers/block/zram/zram_drv.c | 318 ++++++++++++++++++++++------------
 1 file changed, 210 insertions(+), 108 deletions(-)


base-commit: 7bc675554773f09d88101bf1ccfc8537dc7c0be9
-- 
2.40.1

