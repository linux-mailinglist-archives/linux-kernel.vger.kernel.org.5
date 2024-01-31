Return-Path: <linux-kernel+bounces-46122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D2843AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E53B2952D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF356D1A4;
	Wed, 31 Jan 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwnoMehK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F96BB5F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692518; cv=none; b=RR5j645Kn1Uj6Pj0hvkpFlRhneR+kWd8rIkUeDsPMxvJE/OBlnZBHvVNujuydnoZ5+RgDOQFJT5nBUr+ttpH06rxTsV8s3EB1lNrhuKJtvAek3IvTPTAgf4JQxSO4D1EJ088Mo/WqYCKXMSyP0DpSO9gJJazBErcPmI0X/g9PUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692518; c=relaxed/simple;
	bh=rel9kp2wCfHethVLtNU+XogRWEnxAQDGHmynpr6/DiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfphTsR3CPkSKZoXWnbRV+yIGfLx67JzekKd/PHTjTWBw149isnKaWB4jSp59HPUZ3+kulQ/HNgt4oqeFAKGq/L5s0Qc+uZJSu6n8yuVdFRsP85wJWAVtwFGav2BGePc5IFXMMgbxVMEtDatxvQsfs8y+XJ15FXNQuQqyWArVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwnoMehK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zVE9X83gqobsrB0a/mw410bQ65+c1o8t1YRdIwGIX+U=;
	b=HwnoMehKt+fyvZj1RCInvzGfW8sJNTYCpJBZwpR+rZn8XZPwUk3Ce5/ocRHPyFsHMTWwbw
	KKhAWRgq/YXyCKj+eiJDFcIzG+8aD94uNFiXs8T+TLsmSglypw1uyqxVRDfzr32YoOG95+
	XBSZ1v0eS/JSGBhZN62JBLhHNsY1oiA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-PtAbY4I0OyKq-pcbXd3rPg-1; Wed, 31 Jan 2024 04:15:14 -0500
X-MC-Unique: PtAbY4I0OyKq-pcbXd3rPg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ae7046cd0so1621033f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692513; x=1707297313;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVE9X83gqobsrB0a/mw410bQ65+c1o8t1YRdIwGIX+U=;
        b=RcTdc7USv4F1cbBWClDPqU9TdXGv98n5SbnG0nrG67R2rn8shTX31Dqb7saj4Il4HW
         XcZNH1cpkFFii3Ke2/TEp8uOfJNj4HpoeKi9/5DXexV6V2YQCmsLN7NzqkxMGr/utUcv
         eyiDqCyaQJBiXOY3bTYtTmNfoYo5teFVkrbpdnplTHaScwMKOOq3vKzn31Q/4ambsE3d
         7I7in5gNfuJbw/cU6YiQtrpi+mId9Aau0WepAeucK+8CKeEJgeheyYca30cv1cIWUSMG
         t3ITng94GzLEl8g273pBHrlzhgpQc0DOLvhHQeBG0fqP4lp/xKmkGkA4+1+6ePAnbCof
         5fdQ==
X-Gm-Message-State: AOJu0Yyq65op/vQdtgpbiIoqEDaQBoZRPRM3C7Ud9WYWwr4QY2AwRxpO
	AlU+vDPQ98KW+yyElS6yeGCk+uZDlL3ykOlaOCh+5zeSbuc+78iGd2J2obHMx+z1J4ijbMAgAwv
	rdyUMhKavcVrsah4Iiqawt75328LltlJL50SlWpTkhrXTUVdW4h4XV69+AILGdA==
X-Received: by 2002:a5d:610b:0:b0:337:9d3b:c180 with SMTP id v11-20020a5d610b000000b003379d3bc180mr757153wrt.4.1706692512850;
        Wed, 31 Jan 2024 01:15:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWszE55Z6tFi55TgjuN2dhhiLGrelmBc2a2c4PtEq5/nmxBvW1b/Zmqj9lX2zBaGIX6bV6jA==
X-Received: by 2002:a5d:610b:0:b0:337:9d3b:c180 with SMTP id v11-20020a5d610b000000b003379d3bc180mr757127wrt.4.1706692512356;
        Wed, 31 Jan 2024 01:15:12 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id by5-20020a056000098500b0033afef9bdfbsm2098982wrb.8.2024.01.31.01.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 01:15:11 -0800 (PST)
Message-ID: <ff3058bc-e683-4aa6-833e-6dd6aa92d2bf@redhat.com>
Date: Wed, 31 Jan 2024 10:15:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Syzkaller & bisect] There is BUG: unable to handle kernel paging
 request in fuse_copy_one in intel-6.8-rc2
To: Pengfei Xu <pengfei.xu@intel.com>, rppt@kernel.org
Cc: rdunlap@infradead.org, akpm@linux-foundation.org, heng.su@intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com
References: <ZbmqEy+8iOREMPmU@xpf.sh.intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZbmqEy+8iOREMPmU@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.01.24 03:01, Pengfei Xu wrote:
> Hi Mike,
> 
> Greeting!
> 
> There is "unable to handle kernel paging request in fuse_copy_one" BUG in
> intel-6.8-rc2:
> 
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240130_184751_fuse_copy_one
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.c
> Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.prog
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/bisect_info.log
> Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/41bccc98fb7931d63d03f326a746ac4d429c1dd3_dmesg.log
> bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240130_184751_fuse_copy_one/bzImage_v6.8-rc2.tar.gz
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/kconfig_origin
> 
> Bisected and found first bad commit is:
> b758fe6df50da mm/secretmem: make it on by default

Sounds like we manage to access a page that has its direct map removed 
-- either because it's actual secretmem memory, or because we fail to 
restore the direct map.

> 
> Reverted above commit on top of v6.8-rc2, above issue was gone.
> 
> Syzkaller rpro.report: https://github.com/xupengfe/syzkaller_logs/blob/main/240130_184751_fuse_copy_one/repro.report
> BUG: unable to handle page fault for address: ffff8880119a5040
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 9c01067 P4D 9c01067 PUD 9c02067 PMD 11d62063 PTE 800fffffee65a060
> Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 751 Comm: syz-executor148 Not tainted 6.8.0-rc1-2024-01-22-intel-next-e32989111619+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:memcpy+0xc/0x20 arch/x86/lib/memcpy_64.S:38
> Code: f7 e7 49 01 d5 eb ba 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 48 89 f8 48 89 d1 <f3> a4 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90
> RSP: 0018:ffff88800e2af878 EFLAGS: 00010293
> RAX: ffff88800e2afa80 RBX: 0000000000000010 RCX: 0000000000000010
> RDX: 0000000000000010 RSI: ffff8880119a5040 RDI: ffff88800e2afa80
> RBP: ffff88800e2af8c0 R08: ffff888013b14a00 R09: 0000000000000001
> R10: fffffbfff0ef68c4 R11: ffffffff877b4627 R12: ffff88800e2af8f8
> R13: ffff88800e2af938 R14: ffff88800e2afc38 R15: 0000000000000010
> FS:  000000000100c480(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff8880119a5040 CR3: 000000000f6ca000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   fuse_copy_one+0x11e/0x1a0 fs/fuse/dev.c:1007
>   fuse_dev_do_write+0x186/0x26b0 fs/fuse/dev.c:1863
>   fuse_dev_write+0x15f/0x200 fs/fuse/dev.c:1960
>   call_write_iter include/linux/fs.h:2085 [inline]
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write fs/read_write.c:590 [inline]
>   vfs_write+0xa5a/0x1120 fs/read_write.c:570
>   ksys_write+0x13a/0x270 fs/read_write.c:643
>   __do_sys_write fs/read_write.c:655 [inline]
>   __se_sys_write fs/read_write.c:652 [inline]
>   __x64_sys_write+0x7c/0xc0 fs/read_write.c:652
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0x74/0x150 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x4504ed
> Code: db 48 89 d8 5b 5d 41 5c 41 5d 41 5e c3 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff15c70d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004504ed
> RDX: 0000000000000050 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 00000000ffffffff R08: 00000000ffffffff R09: 0000000000000000
> R10: 00007fff15c70d70 R11: 0000000000000246 R12: 0000000000412190
> R13: 0000000000000000 R14: 00000000004004e8 R15: 0000000000000000
>   </TASK>
> Modules linked in:
> CR2: ffff8880119a5040
> ---[ end trace 0000000000000000 ]---
> 
> 
> Hope it's helpful.
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>    // You could change the bzImage_xxx as you want
>    // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
> 
> Best Regards,
> Thanks!
> 

-- 
Cheers,

David / dhildenb


