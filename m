Return-Path: <linux-kernel+bounces-53078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDCF84A069
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F222DB2240D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECDB41218;
	Mon,  5 Feb 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHWMNv80"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C5405FF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153494; cv=none; b=ek9w9Y3xg9iJWoUQHnvDaa3EQTxS2EMKbJpX8j8+Y4w7SdcV8sFc8Qh+tXkSd36d4oGXfhB2GyE/IW/9d9UMePpdIVMLhl2q779UvKtuo2zJYigw8nDtk5qyqadb47ELHwPuPBMpdyGsQX32OFx+JMTb/zeuOLMYPTEFYB7FhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153494; c=relaxed/simple;
	bh=CyumhhrHla5qlVLb8PYoku4ZnpdwiWELhWWIcVR2E3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=vABEFvfgQ3XndVSjvC2HHMd4MulULs/gOFx60NDoPAja4Uf39ZL39ZBs4ClfQfKaFlQ6asH09DIUhko8hbKsovIExJgRCktrSy+Eb9mZ8vqbz6iQSWnDWIMIp1ZvEbQn4jKqg6lF1OtUxGn3ulAnKGegJajvMsBKYWmC7CLdhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHWMNv80; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a358ec50b7cso600530866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153491; x=1707758291; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RaYPHvXkobnpa/6f4ulwQBNQwVfT6AO5Tj9arok4IUM=;
        b=aHWMNv80t8YUsma+2ZoiLz05ZZvT66ZBN9WfYg6adgpGZGshJgiHdvFElEgWjhwSQ1
         QS2Vdfodn/h7CTru7o6Q7e8G1/cdct8kSGootFRYHsh5ijVIo5qjTxs9KuxmeKrUiNfg
         l0wqs3l1PQq2CCxynPEWRIZO/N1wKJFwSQJy2Z50C48nOZfT8nZDasKbsnHL2TnAhRI6
         xBBnTHL2yAOzU9VP/0KJU7Yz5o9vk7e1tRxdNydEQUaNyd7U3aunNRUPtbEFX589K/3s
         eJ2hArMyw6TjCWg03KVn0RsZMVbsPinsCLX4pxt7gj1CiDewanvpW9AaXamFES56GccU
         ErkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153491; x=1707758291;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaYPHvXkobnpa/6f4ulwQBNQwVfT6AO5Tj9arok4IUM=;
        b=FH8KbAF35/OU635iC8yYLxY1dD3qPt8Yngiop9m4TLy1MSn7lcUq7zWzRSSXl1/mao
         LulI7XBsO+dPC5b3biQ5EVwWA+/wL/KOwzzCv2vyXpZ/KuNpLwP6nurArStBi4eCRIO6
         4oTg9sgvolf1Ob+2o9TTlKNuPzVV8mAE3R0zjfDQmSYxYJqG7ufcJOxqm25S26+2yNmJ
         b8OE1VFNJ33su7YMlAHk58gx4Jvm2SC8zWEBAS3YZmU22ZmXgoB6SSGCTGrz+Bej2FeP
         kY16ps1uarJPTOlOZ7qpz2HgMa1BIUEhG8kgqMOflSX0H+NkQfomgJjGgLbrjVZB8Epz
         PNWA==
X-Gm-Message-State: AOJu0YzRHRAn4OhHQNlzCQJ2GkmC3LiHftCTYMRh2uoVjIPy0Cew+71T
	TVMMItwfnO15VhEZZ4tLCexOKwo/hTG7Lvc4pF56Ib6jVppfy/q4idqpZo9dfTFzW1s2FPvNJzh
	CQlDkH6laI6jvfmYLJg8GSHnwou2qUIDb5EE=
X-Google-Smtp-Source: AGHT+IGCf/2T7fbv87BeYDVWJz+788X4MMPPJTKOuEBPh303EM14LzP1OLVvWQHHhfOdyOAo67Lkh2EVaqioVNq0Kms=
X-Received: by 2002:a17:906:378f:b0:a35:3eb8:2f6e with SMTP id
 n15-20020a170906378f00b00a353eb82f6emr251706ejc.33.1707153490633; Mon, 05 Feb
 2024 09:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8BazD5JxGOxPU7bOQED4nn_ZbBqWLtYnPQSqQHKFn81Xj=0Q@mail.gmail.com>
 <CAF8BazBk9xZAZ8SV2jkM6D-ZaYLTSx0xHb7H=+KbzfJZyZpToQ@mail.gmail.com>
In-Reply-To: <CAF8BazBk9xZAZ8SV2jkM6D-ZaYLTSx0xHb7H=+KbzfJZyZpToQ@mail.gmail.com>
From: Aleksey Midenkov <midenok@gmail.com>
Date: Mon, 5 Feb 2024 20:32:32 +0300
Message-ID: <CAF8BazAQNnpaF0k9=iOd6NidAsDGVNqouoHXtc9pYXVRbKoQBA@mail.gmail.com>
Subject: IMSM (Intel Matrix Storage Manager) device is not detected by
 6.6.x/6.7.x but works in 5.19.17
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In 6.x.x /dev/md/imsm0 does not appear at boot.
The only difference I see in dmesg which seems to be relevant:

  block device autoloading is deprecated and will be removed.

Printed in 5.x.x, but not in 6.x.x.

/proc/mdstat in 5.x.x:

Personalities : [raid0] [linear] [multipath] [raid1] [raid6] [raid5]
[raid4] [raid10]
md126 : active raid0 sdb[1] sda[0]
     937698304 blocks super external:/md127/0 128k chunks

md127 : inactive sdb[1](S) sda[0](S)
     4784 blocks super external:imsm

/proc/mdstat in 6.x.x:

Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
[raid4] [raid10]
unused devices: <none>

Kernel config is the same regarding MD and RAID. Trying to manually
assemble RAID in 6.x.x leads to:

mdadm: looking for devices for /dev/md0
mdadm: No OROM/EFI properties for /dev/sda
mdadm: no RAID superblock on /dev/sda
mdadm: /dev/sda has no superblock - assembly aborted

While superblock is correctly displayed by 6.x.x as well:

/dev/sda:
         Magic : Intel Raid ISM Cfg Sig.
       Version : 1.0.00
   Orig Family : 38d93728
        Family : 38d93728
    Generation : 0000018b
 Creation Time : Unknown
    Attributes : All supported
          UUID : b762ef98:7900e4ea:f6395076:47a40d15
      Checksum : 4c2193cc correct
   MPB Sectors : 1
         Disks : 2
  RAID Devices : 1

 Disk01 Serial : YG952401WA480BGN
         State : active
            Id : 00000000
   Usable Size : 937698304 (447.13 GiB 480.10 GB)

[Vortex]:
      Subarray : 0
          UUID : b41d5d94:b2438127:629eca5c:4a65945a
    RAID Level : 0
       Members : 2
         Slots : [UU]
   Failed disk : none
     This Slot : 1
   Sector Size : 512
    Array Size : 1875396608 (894.26 GiB 960.20 GB)
  Per Dev Size : 937698568 (447.13 GiB 480.10 GB)
 Sector Offset : 0
   Num Stripes : 3662884
    Chunk Size : 128 KiB
      Reserved : 0
 Migrate State : idle
     Map State : normal
   Dirty State : clean
    RWH Policy : off
     Volume ID : 1

 Disk00 Serial : YG952300KC480BGN
         State : active
            Id : 00000001
   Usable Size : 937698304 (447.13 GiB 480.10 GB)

Any info on what happened with IMSM driver in 6.x.x?

I guess CONFIG_MD_AUTODETECT is responsible for that, which is Y in
both kernels (as well as CONFIG_BLOCK_LEGACY_AUTOLOAD).
--
@midenok

