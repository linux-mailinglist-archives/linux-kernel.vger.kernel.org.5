Return-Path: <linux-kernel+bounces-90184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2C86FB75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B681F22BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3E171CE;
	Mon,  4 Mar 2024 08:15:53 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F7134B7;
	Mon,  4 Mar 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540153; cv=none; b=YZqP5zJ87aUh3Uv4uhBZwVvY0D9AopnvOM5o4W6IsAFMRaBhTDZ2/hrjXZsbaZZj84SAiRRVzOo7LozDd9Pl8YNTKGuBx/vmQ63VRMexkqVkwByjsLI3vOWZlGXFtZEL64JJbtRlixlQ51SJqcg8lnRLKJcifVUJcLZwBPbXchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540153; c=relaxed/simple;
	bh=pP51C4sP9CSG8FOpmcCbOPSbjYojvwquvBvojm83E1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2/7zMDYyDoNyhjezd+kdj4lECI12p8S3+GBz8KXdB7ocA/fjmMyVWriyylZAyRsgF8OG9GuRL7zWOdy/FvO8/vrQYg7oHQjUK/UwAo8GRZ8AL9cE0t26esFm+BHnXwZVPijNQZ6RX0rYC4AXNK5gg5n+yxR0RrtV+g0Zpl6HLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TpB1w5YTQz9yLsw;
	Mon,  4 Mar 2024 16:00:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 38161140796;
	Mon,  4 Mar 2024 16:15:36 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCHvSEdg+Vlt+imAw--.57242S2;
	Mon, 04 Mar 2024 09:15:35 +0100 (CET)
Message-ID: <51ee454cf93c24afbfc9f159a1b8428d9d6e3be7.camel@huaweicloud.com>
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, syzbot
	 <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>, 
	syzkaller-bugs@googlegroups.com, Gao Xiang <xiang@kernel.org>, Chao Yu
	 <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, Jeffle Xu
	 <jefflexu@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Date: Mon, 04 Mar 2024 09:15:21 +0100
In-Reply-To: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
References: <0000000000002be12a0611ca7ff8@google.com>
	 <40746a9ae6d2e76d748ec0bf7710bba7e49a53ac.camel@huaweicloud.com>
	 <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCHvSEdg+Vlt+imAw--.57242S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw15tFyxZw47Gw4kCw4UArb_yoWrWr4fpF
	ZIgFWxAr48Jry8Jr1xJw1qgw17KryvkrWUGw18J34Iv3W0yry7Jr18tryrXrZrGryUAF4v
	yr4xZryUKr1xZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj5rvpAAAsp

On Sun, 2024-03-03 at 23:54 +0900, Tetsuo Handa wrote:
> On 2024/02/20 19:40, Roberto Sassu wrote:
> > On Mon, 2024-02-19 at 22:41 -0800, syzbot wrote:
> > > Hello,
> > >=20
> > > syzbot found the following issue on:
> > >=20
> > > HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.ker=
nel.o..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D135ba81c1=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De3dd779fb=
a027968
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7bc44a489f0=
ef0670bd5
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
>=20
> > I would add the VFS people in CC, in case they have some ideas.
>=20
> This is an erofs bug. Since the filesystem image in the reproducer
> is crafted, decompression generates bogus result and
> z_erofs_transform_plain() misbehaves.

Thank you Tetsuo, and Gao Xiang for fixing it!

Roberto

> You can obtain a single-threaded reproducer from
> https://syzkaller.appspot.com/x/repro.c?x=3D1256096a180000 with below dif=
f.
>=20
> ----------------------------------------
> --- old/1256096a180000.c
> +++ new/1256096a180000.c
> @@ -676,6 +676,6 @@
>    syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=
=3D*/0ul,
>            /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=
=3D*/-1,
>            /*offset=3D*/0ul);
> -  loop();
> +  execute_one();
>    return 0;
>  }
> ----------------------------------------
>=20
> With CONFIG_EROFS_FS_DEBUG=3Dy, the reproducer hits DBG_BUGON().
> With debug printk() shown below, you can get output shown below.
>=20
> ----------------------------------------
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..f221133a0731 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,11 @@ static int z_erofs_transform_plain(struct z_erofs_de=
compress_req *rq,
>  	unsigned int cur =3D 0, ni =3D 0, no, pi, po, insz, cnt;
>  	u8 *kin;
> =20
> -	DBG_BUGON(rq->outputsize > rq->inputsize);
> +	if (rq->outputsize > rq->inputsize) {
> +		pr_err("rq->inputsize=3D%u rq->outputsize=3D%u\n", rq->inputsize, rq->=
outputsize);
> +		pr_err("rq->pageofs_in=3D%u rq->pageofs_out=3D%u\n", rq->pageofs_in, r=
q->pageofs_out);
> +		pr_err("nrpages_in=3D%u nrpages_out=3D%u\n", nrpages_in, nrpages_out);
> +	}
>  	if (rq->alg =3D=3D Z_EROFS_COMPRESSION_INTERLACED) {
>  		cur =3D bs - (rq->pageofs_out & (bs - 1));
>  		pi =3D (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
> @@ -352,7 +356,8 @@ static int z_erofs_transform_plain(struct z_erofs_dec=
ompress_req *rq,
>  		do {
>  			no =3D (rq->pageofs_out + cur + pi) >> PAGE_SHIFT;
>  			po =3D (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
> -			DBG_BUGON(no >=3D nrpages_out);
> +			if (no >=3D nrpages_out)
> +				pr_err("no=3D%u nrpages_out=3D%u\n", no, nrpages_out);
>  			cnt =3D min(insz - pi, PAGE_SIZE - po);
>  			if (rq->out[no] =3D=3D rq->in[ni]) {
>  				memmove(kin + po,
> @@ -366,7 +371,8 @@ static int z_erofs_transform_plain(struct z_erofs_dec=
ompress_req *rq,
>  		} while (pi < insz);
>  		kunmap_local(kin);
>  	}
> -	DBG_BUGON(ni > nrpages_in);
> +	if (ni > nrpages_in)
> +		pr_err("ni=3D%u nrpages_in=3D%u\n", ni, nrpages_in);
>  	return 0;
>  }
> =20
> ----------------------------------------
>=20
> ----------------------------------------
> [  138.991810][ T2983] loop0: detected capacity change from 0 to 16
> [  139.804002][ T2983] erofs: (device loop0): mounted with root inode @ n=
id 36.
> [  139.810464][   T87] erofs: rq->inputsize=3D4096 rq->outputsize=3D8194
> [  139.821540][   T87] erofs: rq->pageofs_in=3D0 rq->pageofs_out=3D0
> [  139.824347][   T87] erofs: nrpages_in=3D1 nrpages_out=3D3
> [  139.827008][   T87] erofs: ni=3D3 nrpages_in=3D1
> [  139.873777][ T2983] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  139.881268][ T2983] BUG: KMSAN: uninit-value in ima_add_template_entry=
+0x626/0xa80
> ----------------------------------------
>=20
> #syz set subsystems: erofs


