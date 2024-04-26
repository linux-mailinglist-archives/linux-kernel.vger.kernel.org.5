Return-Path: <linux-kernel+bounces-160362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED018B3C86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7942B26732
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61215575F;
	Fri, 26 Apr 2024 16:12:59 +0000 (UTC)
Received: from mail-m24106.xmail.ntesmail.com (mail-m24106.xmail.ntesmail.com [45.195.24.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2815624D;
	Fri, 26 Apr 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147979; cv=none; b=HEif2LsGdnZbwq6qfD9ugyllIOcCrNp2FJvBselDEQatic+48EQMZdR4RgmLh9zKokyjYfXED7rClo92r1faa8ZOzScBvK6c3Ke1gr86g2UaGjVyib+4gvltoo4dNEbbp5E+NcFLtKh8LA9SEaCCD4AhMW6feWJj6DV7uQkaBAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147979; c=relaxed/simple;
	bh=N0X94kNzWw2q0Lpb3KDr/8sbEe3G/viabZlzQ8Tfe4c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r5Ni1gQfFpHVhsg8TRI13Vu5Js2QtjedgYU5g93acfzit9rH5aytfwuWIHLk8b/LIqkCsls5M42c90t7bm9UJ6tvTV2+QRWKOhBZ7QLKXwng41/2gK3uuHoq7t+xmcjhnbJODfqqkWmkk9C1k5OLCb/sQd0SIzb3kkmQ5ykKdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.24.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.122.189] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 235B9860231;
	Fri, 26 Apr 2024 22:53:45 +0800 (CST)
Subject: Re: [PATCH RFC 0/7] block: Introduce CBD (CXL Block Device)
To: Gregory Price <gregory.price@memverge.com>
Cc: Dan Williams <dan.j.williams@intel.com>, axboe@kernel.dk,
 John Groves <John@groves.net>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <66288ac38b770_a96f294c6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ef34808b-d25d-c953-3407-aa833ad58e61@easystack.cn>
 <ZikhwAAIGFG0UU23@memverge.com>
 <bbf692ec-2109-baf2-aaae-7859a8315025@easystack.cn>
 <ZiuwyIVaKJq8aC6g@memverge.com>
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
Message-ID: <98ae27ff-b01a-761d-c1c6-39911a000268@easystack.cn>
Date: Fri, 26 Apr 2024 22:53:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZiuwyIVaKJq8aC6g@memverge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUgaVk9ITB1MSh5CSUwfTVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8f1ae5e640023ckunm235b9860231
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6KDo*MTc8PxQRPy5CMQEK
	DDIKCRNVSlVKTEpPSk9ISUlOQ0hIVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBQ0JMTjcG



在 2024/4/26 星期五 下午 9:48, Gregory Price 写道:
> On Fri, Apr 26, 2024 at 09:25:53AM +0800, Dongsheng Yang wrote:
>>
>>
>> 在 2024/4/24 星期三 下午 11:14, Gregory Price 写道:
>>> On Wed, Apr 24, 2024 at 02:33:28PM +0800, Dongsheng Yang wrote:
>>>>
>>>>
>>>> 在 2024/4/24 星期三 下午 12:29, Dan Williams 写道:
>>>>> Dongsheng Yang wrote:
>>>>>> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
>>>>>>
>>>>>> Hi all,
>>>>>> 	This patchset introduce cbd (CXL block device). It's based on linux 6.8, and available at:
>>>>>> 	https://github.com/DataTravelGuide/linux
>>>>>>
>>>>> [..]
>>>>>> (4) dax is not supported yet:
>>>>>> 	same with famfs, dax device is not supported here, because dax device does not support
>>>>>> dev_dax_iomap so far. Once dev_dax_iomap is supported, CBD can easily support DAX mode.
>>>>>
>>>>> I am glad that famfs is mentioned here, it demonstrates you know about
>>>>> it. However, unfortunately this cover letter does not offer any analysis
>>>>> of *why* the Linux project should consider this additional approach to
>>>>> the inter-host shared-memory enabling problem.
>>>>>
>>>>> To be clear I am neutral at best on some of the initiatives around CXL
>>>>> memory sharing vs pooling, but famfs at least jettisons block-devices
>>>>> and gets closer to a purpose-built memory semantic.
>>>>>
>>>>> So my primary question is why would Linux need both famfs and cbd? I am
>>>>> sure famfs would love feedback and help vs developing competing efforts.
>>>>
>>>> Hi,
>>>> 	Thanks for your reply, IIUC about FAMfs, the data in famfs is stored in
>>>> shared memory, and related nodes can share the data inside this file system;
>>>> whereas cbd does not store data in shared memory, it uses shared memory as a
>>>> channel for data transmission, and the actual data is stored in the backend
>>>> block device of remote nodes. In cbd, shared memory works more like network
>>>> to connect different hosts.
>>>>
>>>
>>> Couldn't you basically just allocate a file for use as a uni-directional
>>> buffer on top of FAMFS and achieve the same thing without the need for
>>> additional kernel support? Similar in a sense to allocating a file on
>>> network storage and pinging the remote host when it's ready (except now
>>> it's fast!)
>>
>> I'm not entirely sure I follow your suggestion. I guess it means that cbd
>> would no longer directly manage the pmem device, but allocate files on famfs
>> to transfer data. I didn't do it this way because I considered at least a
>> few points: one of them is, cbd_transport actually requires a DAX device to
>> access shared memory, and cbd has very simple requirements for space
>> management, so there's no need to rely on a file system layer, which would
>> increase architectural complexity.
>>
>> However, we still need cbd_blkdev to provide a block device, so it doesn't
>> achieve "achieve the same without the need for additional kernel support".
>>
>> Could you please provide more specific details about your suggestion?
> 
> Fundamentally you're shuffling bits from one place to another, the
> ultimate target is storage located on another device as opposed to
> the memory itself.  So you're using CXL as a transport medium.
> 
> Could you not do the same thing with a file in FAMFS, and put all of
> the transport logic in userland? Then you'd just have what looks like
> a kernel bypass transport mechanism built on top of a file backed by
> shared memory.
> 
> Basically it's unclear to me why this must be done in the kernel.
> Performance? Explicit bypass? Some technical reason I'm missing?


In user space, transferring data via FAMFS files poses no problem, but 
how do we present this data to users? We cannot expect users to revamp 
all their business I/O methods.

For example, suppose a user needs to run a database on a compute node. 
As the cloud infrastructure department, we need to allocate a block 
storage on the storage node and provide it to the database on the 
compute node through a certain transmission protocol (such as iSCSI, 
NVMe over Fabrics, or our current solution, cbd). Users can then create 
any file system they like on the block device and run the database on 
it. We aim to enhance the performance of this block device with cbd, 
rather than requiring the business department to adapt their database to 
fit our shared memory-facing storage node disks.

This is why we need to provide users with a block device. If it were 
only about data transmission, we wouldn't need a block device. But when 
it comes to actually running business operations, we need a block 
storage interface for the upper layer. Additionally, the block device 
layer offers many other rich features, such as RAID.

If accessing shared memory in user space is mandatory, there's another 
option: using user space block storage technologies like ublk. However, 
this would lead to performance issues as data would need to traverse 
back to the kernel space block device from the user space process.

In summary, we need a block device sharing mechanism, similar to what is 
provided by NBD, iSCSI, or NVMe over Fabrics, because user businesses 
rely on the block device interface and ecosystem.
> 
> 
> Also, on a tangential note, you're using pmem/qemu to emulate the
> behavior of shared CXL memory.  You should probably explain the
> coherence implications of the system more explicitly.
> 
> The emulated system implements what amounts to hardware-coherent
> memory (i.e. the two QEMU machines run on the same physical machine,
> so coherency is managed within the same coherence domain).
> 
> If there is no explicit coherence control in software, then it is
> important to state that this system relies on hardware that implements
> snoop back-invalidate (which is not a requirement of a CXL 3.x device,
> just a feature described by the spec that may be implemented).

In (5) of the cover letter, I mentioned that cbd addresses cache 
coherence at the software level:

(5) How do blkdev and backend interact through the channel?
	a) For reader side, before reading the data, if the data in this 
channel may be modified by the other party, then I need to flush the 
cache before reading to ensure that I get the latest data. For example, 
the blkdev needs to flush the cache before obtaining compr_head because 
compr_head will be updated by the backend handler.
	b) For writter side, if the written information will be read by others, 
then after writing, I need to flush the cache to let the other party see 
it immediately. For example, after blkdev submits cbd_se, it needs to 
update cmd_head to let the handler have a new cbd_se. Therefore, after 
updating cmd_head, I need to flush the cache to let the backend see it.


This part of the code is indeed implemented, however, as you pointed 
out, since I am currently using qemu/pmem for emulation, the effects of 
this code cannot be observed.

Thanx
> 
> ~Gregory
> .
> 

