Return-Path: <linux-kernel+bounces-42636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CC0840423
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9100B1C22799
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16C5D8EC;
	Mon, 29 Jan 2024 11:51:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49FA56475
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529092; cv=none; b=Tq3i+dwaiB4Ka0hpxFtie+C0/D8o7IurUUGw+z09zQpRe57ym/V3Y4rQG8P6h8rPOFeyAL2DbCHzON/F3SkpI6tiyEpfbt5Ia1QsBfGQWi2+Xt0ph0CxugWNR9IbnbhegKmpEbGQRbu4QPzCY/S8ihNVYR2q3jWJtc0V/d4r3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529092; c=relaxed/simple;
	bh=W3WTD9rgCQYZxjHsbAV6Z1nuPR6Qq2MImtBt5WL8/MY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A48vz0ZrWi8xW+qvXsxCVgRy6sBJheAACAvnPUL33rJEeydRGCka63iPyOob16OQ13cld0aDkWl3FKjStspMMnNewIvcCKf6Be0lgqmmsMT6nlQvST02/LhI1/dD+dVxS9Ab5OMIrgr5KLXRT14vTItYK91EGaRzdMjHQhwoBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TNmnj56KtzsWhD;
	Mon, 29 Jan 2024 19:50:17 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DA6314011F;
	Mon, 29 Jan 2024 19:51:27 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 19:51:26 +0800
Subject: Re: [Linux Kernel Bug] memory leak in ubi_attach
To: Chenyuan Yang <chenyuan0y@gmail.com>
CC: <linux-mtd@lists.infradead.org>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>, Zijie Zhao
	<zzjas98@gmail.com>
References: <CALGdzuo8_EXr4aUAw6X9S+yzMPi25Y82netPLWsd+3n-Ov9Pnw@mail.gmail.com>
 <10779b09-3413-6374-b4a1-1efd8821c5f2@huawei.com>
 <CALGdzuryBbCqGAhox9ZWaQHD5dSQNApfGmCP+rYZ7O4MCRH+rw@mail.gmail.com>
 <7138a98c-1562-3059-07b6-4d918bec9d1a@huawei.com>
 <CALGdzuokUpWhUk7uvWcDT2tXRRMk07dmKGS-rFANOE6ZwZZW8w@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0171b6cc-95ee-3538-913b-65a391a446b3@huawei.com>
Date: Mon, 29 Jan 2024 19:51:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALGdzuokUpWhUk7uvWcDT2tXRRMk07dmKGS-rFANOE6ZwZZW8w@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="------------8DD6FF05027A65FB01502455"
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

--------------8DD6FF05027A65FB01502455
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/1/24 22:41, Chenyuan Yang 写道:
> Hi Zhihao,
> 
> Thanks very much for your reply and further exploration of this crash!
> 
> I have attached the config to reproduce this memory leak. For the
> command line, you can use qemu to boot the kernel (You need to build
> the bullseye-image first).
> ```
> mkdir -p logs
> qemu-system-x86_64 \
> -m 2G \
> -smp 2 \
> -kernel linux/arch/x86/boot/bzImage \
> -append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
> -drive file=image/bullseye-qemu.img,format=raw \
> -net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
> -net nic,model=e1000 \
> -enable-kvm \
> -nographic \
> -pidfile vm.pid \
> ```
> 
> In qemu, you can run
> ```
> gcc -pthread repro.c -o exe
> ./exe
> ```
> to reproduce the memory leak.
> 

The bad news is that I can't reproduce the problem with your kernel 
config. The good news is that I seem to find the cause of the problem by 
code reviewing:
alloc_ai -> kmem_cache_create -> kmem_cache_create_usercopy:
  s = __kmem_cache_alias
   s = find_mergeable // cannot find mergeable kmem_cache, s = NULL
  create_cache
   s = kmem_cache_zalloc
   __kmem_cache_create(s)
    sysfs_slab_add
     kobject_init_and_add(&s->kobj)
      kobject_init(kobj) // kobj->kref = 1
      kobject_add_varg
       kobject_set_name_vargs
        kvasprintf_const
         kstrdup_const
          kstrdup
           kmalloc_track_caller // allocated memory
        kobj->name = s  // assign allocated memory to kobj->name
       kobject_add_internal
        create_dir // failed caused by ENOMEM
        // kobj->name won't be released even 's' is released

You can reproduce it by executing ubiattach -m0 with reproduce.diff applied:
[root@localhost ~]# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff88813b488080 (size 16):
   comm "ubiattach", pid 9535, jiffies 4294943095
   hex dump (first 16 bytes):
     3a 30 30 30 30 30 35 36 00 00 00 00 00 00 00 00  :0000056........
   backtrace (crc 8a117ab9):
     [<ffffffff815f91c2>] __kmalloc_node_track_caller+0x322/0x420
     [<ffffffff81575efc>] kstrdup+0x3c/0x70
     [<ffffffff81575f8f>] kstrdup_const+0x5f/0x70
     [<ffffffff82535426>] kvasprintf_const+0xc6/0x110
     [<ffffffff84b88cb0>] kobject_set_name_vargs+0x40/0xd0
     [<ffffffff84b8911b>] kobject_init_and_add+0x8b/0xf0
     [<ffffffff815faba9>] sysfs_slab_add+0x119/0x1e0
     [<ffffffff815fc2dc>] __kmem_cache_create+0x41c/0x590
     [<ffffffff81586019>] kmem_cache_create_usercopy+0x169/0x300
     [<ffffffff815861c1>] kmem_cache_create+0x11/0x20
     [<ffffffff82ec8896>] ubi_attach+0xc6/0x1de0
     [<ffffffff82eb77a3>] ubi_attach_mtd_dev+0x8a3/0x1120
     [<ffffffff82eb8bfc>] ctrl_cdev_ioctl+0x1fc/0x270
     [<ffffffff816ca312>] __x64_sys_ioctl+0xf2/0x140
     [<ffffffff84bc3970>] do_syscall_64+0x50/0x140
     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

There are two ways to fix it:
1. Release kobj->name directly in the error baranch of 
kobject_add_internal() after calling create_dir().
2. Put kobj's refcnt in the error baranch of kobject_add_internal() 
after calling create_dir().
I'm not sure which one is better or whether there are other fix methods, 
maybe you can send an email in kobj related mailiing lists to confirm 
the problem.

--------------8DD6FF05027A65FB01502455
Content-Type: text/plain; charset="UTF-8"; name="reproduce.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="reproduce.diff"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3ViaS9hdHRhY2guYyBiL2RyaXZlcnMvbXRkL3Vi
aS9hdHRhY2guYwppbmRleCBhZTVhYmU0OTJiNTIuLjM2OTRmZDUyYzUzMCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9tdGQvdWJpL2F0dGFjaC5jCisrKyBiL2RyaXZlcnMvbXRkL3ViaS9hdHRh
Y2guYwpAQCAtMTQ0Nyw2ICsxNDQ3LDcgQEAgc3RhdGljIGludCBzY2FuX2FsbChzdHJ1Y3Qg
dWJpX2RldmljZSAqdWJpLCBzdHJ1Y3QgdWJpX2F0dGFjaF9pbmZvICphaSwKIAlyZXR1cm4g
ZXJyOwogfQogCitleHRlcm4gaW50IGdfaW5qZWN0Owogc3RhdGljIHN0cnVjdCB1YmlfYXR0
YWNoX2luZm8gKmFsbG9jX2FpKHZvaWQpCiB7CiAJc3RydWN0IHViaV9hdHRhY2hfaW5mbyAq
YWk7CkBAIC0xNDYxLDkgKzE0NjIsMTEgQEAgc3RhdGljIHN0cnVjdCB1YmlfYXR0YWNoX2lu
Zm8gKmFsbG9jX2FpKHZvaWQpCiAJSU5JVF9MSVNUX0hFQUQoJmFpLT5hbGllbik7CiAJSU5J
VF9MSVNUX0hFQUQoJmFpLT5mYXN0bWFwKTsKIAlhaS0+dm9sdW1lcyA9IFJCX1JPT1Q7CisJ
Z19pbmplY3QgPSAxOwogCWFpLT5hZWJfc2xhYl9jYWNoZSA9IGttZW1fY2FjaGVfY3JlYXRl
KCJ1YmlfYWViX3NsYWJfY2FjaGUiLAogCQkJCQkgICAgICAgc2l6ZW9mKHN0cnVjdCB1Ymlf
YWluZl9wZWIpLAogCQkJCQkgICAgICAgMCwgMCwgTlVMTCk7CisJZ19pbmplY3QgPSAwOwog
CWlmICghYWktPmFlYl9zbGFiX2NhY2hlKSB7CiAJCWtmcmVlKGFpKTsKIAkJYWkgPSBOVUxM
OwpkaWZmIC0tZ2l0IGEvbGliL2tvYmplY3QuYyBiL2xpYi9rb2JqZWN0LmMKaW5kZXggNTlk
YmNiZGIxYzkxLi4zN2RhOGI3Njc1NTcgMTAwNjQ0Ci0tLSBhL2xpYi9rb2JqZWN0LmMKKysr
IGIvbGliL2tvYmplY3QuYwpAQCAtMjA0LDcgKzIwNCw4IEBAIHN0YXRpYyB2b2lkIGtvYmpl
Y3RfaW5pdF9pbnRlcm5hbChzdHJ1Y3Qga29iamVjdCAqa29iaikKIAlrb2JqLT5zdGF0ZV9p
bml0aWFsaXplZCA9IDE7CiB9CiAKLQorc3RydWN0IGtvYmplY3QgKmdfazsKK2ludCBnX2lu
amVjdDsKIHN0YXRpYyBpbnQga29iamVjdF9hZGRfaW50ZXJuYWwoc3RydWN0IGtvYmplY3Qg
KmtvYmopCiB7CiAJaW50IGVycm9yID0gMDsKQEAgLTIzNSw2ICsyMzYsMTMgQEAgc3RhdGlj
IGludCBrb2JqZWN0X2FkZF9pbnRlcm5hbChzdHJ1Y3Qga29iamVjdCAqa29iaikKIAkJIHBh
cmVudCA/IGtvYmplY3RfbmFtZShwYXJlbnQpIDogIjxOVUxMPiIsCiAJCSBrb2JqLT5rc2V0
ID8ga29iamVjdF9uYW1lKCZrb2JqLT5rc2V0LT5rb2JqKSA6ICI8TlVMTD4iKTsKIAorCWlm
IChnX2luamVjdCkgeworCQllcnJvciA9IC1FTk9NRU07IC8vIFNpbXVsYXRlIGZhaWx1cmUg
aW4gY3JlYXRlX2Rpci0+c3lzZnNfY3JlYXRlX2Rpcl9ucy0+a2VybmZzX2NyZWF0ZV9kaXJf
bnMtPmtlcm5mc19uZXdfbm9kZS0+X19rZXJuZnNfbmV3X25vZGUtLT5rbWVtX2NhY2hlX3ph
bGxvYy0+c2xhYl9hbGxvY19ub2RlLT5zbGFiX3ByZV9hbGxvY19ob29rLT5zaG91bGRfZmFp
bHNsYWIKKwkJZ19rID0ga29iajsKKwkJcHJfZXJyKCJpbmplY3QgZmFpbHVyZSwga29iaiBy
ZWYgJWRcbiIsIHJlZmNvdW50X3JlYWQoJmtvYmotPmtyZWYucmVmY291bnQpKTsKKwkJc21w
X3dtYigpOworCX0gZWxzZQorCiAJZXJyb3IgPSBjcmVhdGVfZGlyKGtvYmopOwogCWlmIChl
cnJvcikgewogCQlrb2JqX2tzZXRfbGVhdmUoa29iaik7CkBAIC02ODUsNiArNjkzLDEyIEBA
IHN0YXRpYyB2b2lkIGtvYmplY3RfY2xlYW51cChzdHJ1Y3Qga29iamVjdCAqa29iaikKIAkJ
CSBrb2JqZWN0X25hbWUoa29iaiksIGtvYmopOwogCX0KIAorCXNtcF9ybWIoKTsKKwlpZiAo
Z19rID09IGtvYmopIHsKKwkJcHJfZXJyKCJmcmVlIG5hbWUgJXNcbiIsIG5hbWUpOworCQlk
dW1wX3N0YWNrKCk7CisJfQorCiAJLyogZnJlZSBuYW1lIGlmIHdlIGFsbG9jYXRlZCBpdCAq
LwogCWlmIChuYW1lKSB7CiAJCXByX2RlYnVnKCInJXMnOiBmcmVlIG5hbWVcbiIsIG5hbWUp
OwpkaWZmIC0tZ2l0IGEvbW0vc2xhYl9jb21tb24uYyBiL21tL3NsYWJfY29tbW9uLmMKaW5k
ZXggMjM4MjkzYjFkYmUxLi5jNzYyNzcwMDRiZDAgMTAwNjQ0Ci0tLSBhL21tL3NsYWJfY29t
bW9uLmMKKysrIGIvbW0vc2xhYl9jb21tb24uYwpAQCAtMTU4LDEwICsxNTgsMTIgQEAgaW50
IHNsYWJfdW5tZXJnZWFibGUoc3RydWN0IGttZW1fY2FjaGUgKnMpCiAJcmV0dXJuIDA7CiB9
CiAKK2V4dGVybiBpbnQgZ19pbmplY3Q7CiBzdHJ1Y3Qga21lbV9jYWNoZSAqZmluZF9tZXJn
ZWFibGUodW5zaWduZWQgaW50IHNpemUsIHVuc2lnbmVkIGludCBhbGlnbiwKIAkJc2xhYl9m
bGFnc190IGZsYWdzLCBjb25zdCBjaGFyICpuYW1lLCB2b2lkICgqY3Rvcikodm9pZCAqKSkK
IHsKIAlzdHJ1Y3Qga21lbV9jYWNoZSAqczsKKwlzdGF0aWMgaW50IGVudGVyID0gMDsKIAog
CWlmIChzbGFiX25vbWVyZ2UpCiAJCXJldHVybiBOVUxMOwpAQCAtMTg0LDYgKzE4NiwxMSBA
QCBzdHJ1Y3Qga21lbV9jYWNoZSAqZmluZF9tZXJnZWFibGUodW5zaWduZWQgaW50IHNpemUs
IHVuc2lnbmVkIGludCBhbGlnbiwKIAkJaWYgKHNpemUgPiBzLT5zaXplKQogCQkJY29udGlu
dWU7CiAKKwkJaWYgKGdfaW5qZWN0ICYmICFlbnRlcikgeworCQkJZW50ZXIgPSAxOworCQkJ
YnJlYWs7CisJCX0KKwogCQlpZiAoKGZsYWdzICYgU0xBQl9NRVJHRV9TQU1FKSAhPSAocy0+
ZmxhZ3MgJiBTTEFCX01FUkdFX1NBTUUpKQogCQkJY29udGludWU7CiAJCS8qCg==
--------------8DD6FF05027A65FB01502455--

