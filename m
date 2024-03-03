Return-Path: <linux-kernel+bounces-89947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085586F7E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7991C20967
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411437AE72;
	Sun,  3 Mar 2024 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dZgEPIAD"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F07AE45
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709510041; cv=none; b=ezM545qWNqrRNhTxSK37M9glOQ6vks/nux0/eQJ581ElZA3xDO1m32OppferIrd3aEcJgRGahgl+yfzy4RL0vJ7pfuKOvVf2Q8Adz/C09N1421+bwPZG9NebotZ7wXAltTc31kPh+o7AYmRloPoDUnXAvAgNdaBQuXish7Kbwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709510041; c=relaxed/simple;
	bh=mXvqgUp0q9phVgI3QgXoGpmKGgEZna8vXnpVftoxEAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guSUZCiHVtd6sS0hjpPURq79eS5XC9m78dhBA/Bk9x6dB5xqqhIN7nxz7XKhnKzcS0QvmJ21OseLdf9jEvwQWdNZW2ko8kt/0ajXPKH7ZRcG4K91pRx+UrZd5RaQr7vLwBmon1x3pYgZ5QZ1YmkvbypOLLNwmrOjzhnLZUT7psk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dZgEPIAD; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709510029; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Af5beNfEN0r7ORUFfnC+HrkG5+opfekQz/HhOQbFxAA=;
	b=dZgEPIADxS2WhdSRoH5dsVCN3kB/1Smog68BCsOKE9qaY00gMUJVx9qsP5U88Z3ruIsyQzO3ZmXG3cqzXK94LwaaYXH2IP1J4GQPWB206qlaeHRbNY7nAMk74XsOHKLs43XDw5fE2keaI2o9HvFwiufnRSfdA8008GFh2WvS1+U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W1haaCc_1709510028;
Received: from 192.168.71.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1haaCc_1709510028)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 07:53:49 +0800
Message-ID: <5ed37c5a-69ee-4b09-acd6-e39c3f0286d0@linux.alibaba.com>
Date: Mon, 4 Mar 2024 07:53:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <0000000000002be12a0611ca7ff8@google.com>
 <40746a9ae6d2e76d748ec0bf7710bba7e49a53ac.camel@huaweicloud.com>
 <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/3 22:54, Tetsuo Handa wrote:
> On 2024/02/20 19:40, Roberto Sassu wrote:
>> On Mon, 2024-02-19 at 22:41 -0800, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=135ba81c180000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=7bc44a489f0ef0670bd5
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
>> I would add the VFS people in CC, in case they have some ideas.
> 
> This is an erofs bug. Since the filesystem image in the reproducer
> is crafted, decompression generates bogus result and
> z_erofs_transform_plain() misbehaves.

Yes, thanks for looking into this.  It seems it was introduced by
a new commit 1ca01520148a this cycle, let me find more clues and
make a fix for this.

Thanks,
Gao Xiang

> 
> You can obtain a single-threaded reproducer from
> https://syzkaller.appspot.com/x/repro.c?x=1256096a180000 with below diff.
> 
> ----------------------------------------
> --- old/1256096a180000.c
> +++ new/1256096a180000.c
> @@ -676,6 +676,6 @@
>     syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>             /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>             /*offset=*/0ul);
> -  loop();
> +  execute_one();
>     return 0;
>   }
> ----------------------------------------
> 
> With CONFIG_EROFS_FS_DEBUG=y, the reproducer hits DBG_BUGON().
> With debug printk() shown below, you can get output shown below.
> 
> ----------------------------------------
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..f221133a0731 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
>   	u8 *kin;
>   
> -	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->outputsize > rq->inputsize) {
> +		pr_err("rq->inputsize=%u rq->outputsize=%u\n", rq->inputsize, rq->outputsize);
> +		pr_err("rq->pageofs_in=%u rq->pageofs_out=%u\n", rq->pageofs_in, rq->pageofs_out);
> +		pr_err("nrpages_in=%u nrpages_out=%u\n", nrpages_in, nrpages_out);
> +	}
>   	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
>   		cur = bs - (rq->pageofs_out & (bs - 1));
>   		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
> @@ -352,7 +356,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   		do {
>   			no = (rq->pageofs_out + cur + pi) >> PAGE_SHIFT;
>   			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
> -			DBG_BUGON(no >= nrpages_out);
> +			if (no >= nrpages_out)
> +				pr_err("no=%u nrpages_out=%u\n", no, nrpages_out);
>   			cnt = min(insz - pi, PAGE_SIZE - po);
>   			if (rq->out[no] == rq->in[ni]) {
>   				memmove(kin + po,
> @@ -366,7 +371,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
>   		} while (pi < insz);
>   		kunmap_local(kin);
>   	}
> -	DBG_BUGON(ni > nrpages_in);
> +	if (ni > nrpages_in)
> +		pr_err("ni=%u nrpages_in=%u\n", ni, nrpages_in);
>   	return 0;
>   }
>   
> ----------------------------------------
> 
> ----------------------------------------
> [  138.991810][ T2983] loop0: detected capacity change from 0 to 16
> [  139.804002][ T2983] erofs: (device loop0): mounted with root inode @ nid 36.
> [  139.810464][   T87] erofs: rq->inputsize=4096 rq->outputsize=8194
> [  139.821540][   T87] erofs: rq->pageofs_in=0 rq->pageofs_out=0
> [  139.824347][   T87] erofs: nrpages_in=1 nrpages_out=3
> [  139.827008][   T87] erofs: ni=3 nrpages_in=1
> [  139.873777][ T2983] =====================================================
> [  139.881268][ T2983] BUG: KMSAN: uninit-value in ima_add_template_entry+0x626/0xa80
> ----------------------------------------
> 
> #syz set subsystems: erofs

