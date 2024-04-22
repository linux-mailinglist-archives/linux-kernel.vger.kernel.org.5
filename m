Return-Path: <linux-kernel+bounces-153239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F308ACB44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CAC1F211EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE1E14388E;
	Mon, 22 Apr 2024 10:53:17 +0000 (UTC)
Received: from mail-m92235.xmail.ntesmail.com (mail-m92235.xmail.ntesmail.com [103.126.92.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004C13E04E;
	Mon, 22 Apr 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783196; cv=none; b=F2EF4RQqu+i2Z//U8S4NDv+PBGpoqXqJewRCAIvTl3Bm/C3DhU69gvXEijgP5HaF6RadGs9oVxKjFMrr6XUwsBZ/m5T5emq/6mSgZiPX+lua/ZoCFAbB1Z9ftTGFECAkF7ipiUIQy6OgaEOnTXfx7PMMxR8XlGWxud3rltI8i+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783196; c=relaxed/simple;
	bh=K79cvz4ri6eGIn1tRK20a+cX/JmTe0QhWg+PhhVgv1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q61cSssVRn7tBUeC2oVb0QQNrwYH8WFUe7fHuL7ye4upXSGNKo1EmKhzOrzCsOfLQcnZXghyY0pJzuAcBi89HvNbgWqu/qnjywmSCBDvqxm5o+VYx2L6+q5aWAiZWidZlZ9iZQ6B9J97Da7jb7VaKWwYsovhdo0iij5jGxxEj+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=103.126.92.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id D4580860242;
	Mon, 22 Apr 2024 15:16:08 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dan.j.williams@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang.linux@gmail.com>
Subject: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
Date: Mon, 22 Apr 2024 07:15:59 +0000
Message-Id: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQktKVhkaT0tOTkMdSEJLHlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f04a982ff023ckunmd4580860242
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OT46DBw6GDcyGRxCSDY0CywC
	LEkKCh9VSlVKTEpITExLSk1CTUNLVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBSkJLTkk3Bg++

From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>

Hi all,
	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
	https://github.com/DataTravelGuide/linux

(1) What is cbd:
	As shared memory is supported in CXL3.0 spec, we can transfer data
via CXL shared memory. CBD means CXL block device, it use CXL shared memory
to transfer command and data to access block device in different
host, as shown below:

┌───────────────────────────────┐                               ┌────────────────────────────────────┐
│          node-1               │                               │              node-2                │
├───────────────────────────────┤                               ├────────────────────────────────────┤
│                               │                               │                                    │
│                       ┌───────┤                               ├─────────┐                          │
│                       │ cbd0  │                               │ backend0├──────────────────┐       │
│                       ├───────┤                               ├─────────┤                  │       │
│                       │ pmem0 │                               │ pmem0   │                  ▼       │
│               ┌───────┴───────┤                               ├─────────┴────┐     ┌───────────────┤
│               │    cxl driver │                               │ cxl driver   │     │ /dev/sda      │
└───────────────┴────────┬──────┘                               └─────┬────────┴─────┴───────────────┘
                         │                                            │                               
                         │                                            │                               
                         │        CXL                         CXL     │                               
                         └────────────────┐               ┌───────────┘                               
                                          │               │                                           
                                          │               │                                           
                                          │               │                                           
                                      ┌───┴───────────────┴────---------------─┐                                     
                                      │   shared memory device(cbd transport)  │                                     
                                      └──────────────────────---------------───┘                                     

any read/write to cbd0 on node-1 will be transferred to node-2 /dev/sda. It works similar with
nbd (network block device), but it transfer data via CXL shared memory rather than network.

(2) Layout of transport:

┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                           cbd transport                                                                                       │
├────────────────────┬───────────────────────┬───────────────────────┬──────────────────────┬───────────────────────────────────┤
│                    │       hosts           │      backends         │       blkdevs        │        channels                   │
│ cbd transport info ├────┬────┬────┬────────┼────┬────┬────┬────────┼────┬────┬────┬───────┼───────┬───────┬───────┬───────────┤
│                    │    │    │    │  ...   │    │    │    │  ...   │    │    │    │  ...  │       │       │       │   ...     │
└────────────────────┴────┴────┴────┴────────┴────┴────┴────┴────────┴────┴────┴────┴───────┴───┬───┴───────┴───────┴───────────┘
                                                                                                │                                
                                                                                                │                                
                                                                                                │                                
                                                                                                │                                
          ┌─────────────────────────────────────────────────────────────────────────────────────┘                                
          │                                                                                                                      
          │                                                                                                                      
          ▼                                                                                                                      
    ┌───────────────────────────────────────────────────────────┐                                                                
    │                     channel                               │                                                                
    ├────────────────────┬──────────────────────────────────────┤                                                                
    │    channel meta    │              channel data            │                                                                
    └─────────┬──────────┴────────────────────────────────-─────┘                                                                
              │                                                                                                                  
              │                                                                                                                  
              │                                                                                                                  
              ▼                                                                                                                  
    ┌──────────────────────────────────────────────────────────┐                                                                 
    │                 channel meta                             │                                                                 
    ├───────────┬──────────────┬───────────────────────────────┤                                                                 
    │ meta ctrl │  comp ring   │       cmd ring                │                                                                 
    └───────────┴──────────────┴───────────────────────────────┘                                                                 

The shared memory is divided into five regions:

    a) Transport_info:
	Information about the overall transport, including the layout of the transport.
    b) Hosts:
	Each host wishing to utilize this transport needs to register its own information within a host entry in this region.
    c) Backends:
	Starting a backend on a host requires filling in information in a backend entry within this region.
    d) Blkdevs:
	Once a backend is established, it can be mapped to any associated host. The information about the blkdevs is then filled into the blkdevs region.
    e) Channels:
	This is the actual data communication area, where communication between blkdev and backend occurs. Each queue of a block device uses a channel, and each backend has a corresponding handler interacting with this queue.
    f) Channel:
	Channel is further divided into meta and data regions.
	The meta region includes cmd rings and comp rings. The blkdev converts upper-layer requests into cbd_se and fills them into the cmd ring.
	The handler accepts the cbd_se from the cmd ring and sends them to the local actual block device of the backend (e.g., sda).
	After completion, the results are formed into cbd_ce and filled into the comp ring.
	The blkdev then receives the cbd_ce and returns the results to the upper-layer IO sender.

    Currently, the number of entries in each region and the channel size are both set to default values. In the future, they will be made configurable.

(3) Naming of CBD:
	Actually it is not strictly depends on CXL, any shared memory can be used for cbd, but
I did not find out a better name, maybe smxbd(shared memory transport block device)? I choose
CBD as it sounds more concise and elegant. Any suggestion?

(4) dax is not supported yet:
	same with famfs, dax device is not supported here, because dax device does not support
dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.

(5) How do blkdev and backend interact through the channel?
	a) For reader side, before reading the data, if the data in this channel may be modified by the other party, then I need to flush the cache before reading to ensure that I get the latest data. For example, the blkdev needs to flush the cache before obtaining compr_head because compr_head will be updated by the backend handler.
	b) For writter side, if the written information will be read by others, then after writing, I need to flush the cache to let the other party see it immediately. For example, after blkdev submits cbd_se, it needs to update cmd_head to let the handler have a new cbd_se. Therefore, after updating cmd_head, I need to flush the cache to let the backend see it.

(6) race between management operations:
	There may be a race condition, for example: if we use backend-start on different nodes at the same time,
it's possible to allocate the same backend ID. This issue should be handled by the upper-layer
manager, ensuring that all management operations are serialized, such as acquiring a distributed lock.

(7) What's Next?
	This is an first version of CBD, and there is still much work to be done, such as: how to recover a backend service when a backend node fails? How to gracefully stop associated blkdev when a backend service cannot be recovered? How to clear dead information within the transport layer? For non-volatile memory transport, it may be considered to allocate a new area as a Write-Ahead Log (WAL).

(8) testing with qemu:
	We can use two QEMU virtual machines to test CBD by sharing a CXLMemDev:

  a)  Start two QEMU virtual machines, sharing a CXLMemDev.

	root@qemu-2:~# cxl list
	[
	  {
	    "memdev":"mem0",
	    "pmem_size":536870912,
	    "serial":0,
	    "host":"0000:0d:00.0"
	  }
	]

	root@qemu-1:~# cxl list
	[
	  {
	    "memdev":"mem0",
	    "pmem_size":536870912,
	    "serial":0,
	    "host":"0000:0d:00.0"
	  }
	]

  b)  Register a CBD transport on node-1 and add a backend, specifying the path as /dev/ram0p1.
	root@qemu-1:~# cxl create-region -m mem0 -d decoder0.0 -t pmem
	{
	  "region":"region0",
	  "resource":"0x1890000000",
	  "size":"512.00 MiB (536.87 MB)",
	  "type":"pmem",
	  "interleave_ways":1,
	  "interleave_granularity":256,
	  "decode_state":"commit",
	  "mappings":[
	    {
	      "position":0,
	      "memdev":"mem0",
	      "decoder":"decoder2.0"
	    }
	  ]
	}
	cxl region: cmd_create_region: created 1 region
	root@qemu-1:~# ndctl create-namespace -r region0 -m fsdax --map dev -t pmem

	{
	  "dev":"namespace0.0",
	  "mode":"fsdax",
	  "map":"dev",
	  "size":"502.00 MiB (526.39 MB)",
	  "uuid":"618e9627-4345-4046-ba46-becf430a1464",
	  "sector_size":512,
	  "align":2097152,
	  "blockdev":"pmem0"
	}
	root@qemu-1:~# echo "path=/dev/pmem0,hostname=node-1,force=1,format=1" >  /sys/bus/cbd/transport_register
	root@qemu-1:~# echo "op=backend-start,path=/dev/ram0p1" > /sys/bus/cbd/devices/transport0/adm

  c)  Register a CBD transport on node-2 and add a blkdev, specifying the backend ID as the backend on node-1.
	root@qemu-2:~# cxl create-region -m mem0 -d decoder0.0 -t pmem
	{
	  "region":"region0",
	  "resource":"0x390000000",
	  "size":"512.00 MiB (536.87 MB)",
	  "type":"pmem",
	  "interleave_ways":1,
	  "interleave_granularity":256,
	  "decode_state":"commit",
	  "mappings":[
	    {
	      "position":0,
	      "memdev":"mem0",
	      "decoder":"decoder2.0"
	    }
	  ]
	}
	cxl region: cmd_create_region: created 1 region
	root@qemu-2:~# ndctl create-namespace -r region0 -m fsdax --map dev -t pmem -b 0
	{
	  "dev":"namespace0.0",
	  "mode":"fsdax",
	  "map":"dev",
	  "size":"502.00 MiB (526.39 MB)",
	  "uuid":"a7fae1a5-2cba-46d7-83a2-20a76d736848",
	  "sector_size":512,
	  "align":2097152,
	  "blockdev":"pmem0"
	}
	root@qemu-2:~# echo "path=/dev/pmem0,hostname=node-2" > /sys/bus/cbd/transport_register
	root@qemu-2:~# echo "op=dev-start,backend_id=0,queues=1" > /sys/bus/cbd/devices/transport0/adm

  d)  On node-2, you will get a /dev/cbd0, and all reads and writes to cbd0 will actually read from and write to /dev/ram0p1 on node-1.
	root@qemu-2:~# mkfs.xfs -f /dev/cbd0
	meta-data=/dev/cbd0              isize=512    agcount=4, agsize=655360 blks
		 =                       sectsz=4096  attr=2, projid32bit=1
		 =                       crc=1        finobt=1, sparse=1, rmapbt=0
		 =                       reflink=1    bigtime=0 inobtcount=0
	data     =                       bsize=4096   blocks=2621440, imaxpct=25
		 =                       sunit=0      swidth=0 blks
	naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
	log      =internal log           bsize=4096   blocks=2560, version=2
		 =                       sectsz=4096  sunit=1 blks, lazy-count=1
	realtime =none                   extsz=4096   blocks=0, rtextents=0


Thanx

Dongsheng Yang (7):
  block: Init for CBD(CXL Block Device)
  cbd: introduce cbd_transport
  cbd: introduce cbd_channel
  cbd: introduce cbd_host
  cbd: introuce cbd_backend
  cbd: introduce cbd_blkdev
  cbd: add related sysfs files in transport register

 drivers/block/Kconfig             |   2 +
 drivers/block/Makefile            |   2 +
 drivers/block/cbd/Kconfig         |   4 +
 drivers/block/cbd/Makefile        |   3 +
 drivers/block/cbd/cbd_backend.c   | 254 +++++++++
 drivers/block/cbd/cbd_blkdev.c    | 375 +++++++++++++
 drivers/block/cbd/cbd_channel.c   | 179 +++++++
 drivers/block/cbd/cbd_handler.c   | 261 +++++++++
 drivers/block/cbd/cbd_host.c      | 123 +++++
 drivers/block/cbd/cbd_internal.h  | 830 +++++++++++++++++++++++++++++
 drivers/block/cbd/cbd_main.c      | 230 ++++++++
 drivers/block/cbd/cbd_queue.c     | 621 ++++++++++++++++++++++
 drivers/block/cbd/cbd_transport.c | 845 ++++++++++++++++++++++++++++++
 13 files changed, 3729 insertions(+)
 create mode 100644 drivers/block/cbd/Kconfig
 create mode 100644 drivers/block/cbd/Makefile
 create mode 100644 drivers/block/cbd/cbd_backend.c
 create mode 100644 drivers/block/cbd/cbd_blkdev.c
 create mode 100644 drivers/block/cbd/cbd_channel.c
 create mode 100644 drivers/block/cbd/cbd_handler.c
 create mode 100644 drivers/block/cbd/cbd_host.c
 create mode 100644 drivers/block/cbd/cbd_internal.h
 create mode 100644 drivers/block/cbd/cbd_main.c
 create mode 100644 drivers/block/cbd/cbd_queue.c
 create mode 100644 drivers/block/cbd/cbd_transport.c

-- 
2.34.1


