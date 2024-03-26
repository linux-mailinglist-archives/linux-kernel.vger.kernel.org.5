Return-Path: <linux-kernel+bounces-119054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67CE88C352
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371B31F29AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CD74420;
	Tue, 26 Mar 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Muy2C9xX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124471756
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459608; cv=none; b=WM7ffiBWsI6XWdOMG4U070KzPZQJHJ1IiisWOci8l2kTbiPmE7yx9ekgGoI67FSrB5/akL5sG5ZYya2VXyX//URM/mSp0RBTeRYMBB1I7gnWaxZneq78UA9Tk6Zh9TNLa6z8h62aTkhw3hIY4oTboBVK6wqKNCSXRlTRVEPrraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459608; c=relaxed/simple;
	bh=0kw6iR740ltw/Bk8THQ5vcLvz+JxPSQJ1clEIKhdxPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUtslvtRH3A3vj54kEVbofNYr1WyNeLAZS651P97ZktNQ9Pz1zJbOrOhQhAegW7Ec2Y0KRifTEr8Ob3Q8YKmME2YmZx4qw6bZbR7a5csyy4WMSq9uEwsKDwJ34BSUk0uGYQizGkv9hC9KyoDPjNBh5Eb2MO8yRPzAlfB/+zzd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Muy2C9xX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711459604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHgAIu9Qni0T7nNxSUpgWLrDzwIAomPgMIaz+Kf9mws=;
	b=Muy2C9xXnREIWrMfJ/2ddXebNv1kaA/OpV0uGSl423Wpws6fdHi/m29HrFY4J7sBLOU+uT
	mb3FkIchnydwE9JBNIEv9bulJQo2UEfErKb4CLsSWxtEvKy0df9xCfQHlg3Tbv/8oqlEFr
	0pM1CNHOO9Hir0U6YY9xdC6K6VG1Q6E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-NbM5Rmm6PdiRT3xYndLVqg-1; Tue, 26 Mar 2024 09:26:43 -0400
X-MC-Unique: NbM5Rmm6PdiRT3xYndLVqg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29c7932c5f5so3929558a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711459601; x=1712064401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHgAIu9Qni0T7nNxSUpgWLrDzwIAomPgMIaz+Kf9mws=;
        b=jFCXdvdcxULGbmqK4hJsQG7jh07D6jNtmyQLSgYK2UZpqpYEht+4YtKV8/nhDRrSGp
         IRS42NlST0GYMULb3Ad8MbpX4XykpQWAxmftAN7Ef/SvnkZg19ybn1fJKqsUzpRApEmV
         N5Uw/Qujj8bJ2Qh+Cp9vBH/7KAlgtrJk6cb8vXtvcgHwFGzY3pnQsFDtjdUTuI6wjerx
         2DUTId0eBsngvrGlPvIWrFpS+YbmujK4XVe0P5U/XUXFpzVBf3zziZjQbNuwAkXrC6LB
         LpMW35VSGCbcAeJvRtM1vQ5aa6hqdaWDB5QmhClQYFlWLcV4lLO3sbPd9X52CuRrHFZr
         r5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUdbcTTjbuIR7mGiRjCK2QH6RQC2lDCOrzH4UGKte9PPY+ngpyYsevNou9SG7bMLHOgOSGrtvU3OZqGnZYCF3jbLBTVBaFRt1pEVKsE
X-Gm-Message-State: AOJu0YxQWD1KQjQYdqyY+zrIpO5AQxGTsFXJwi3EF8Ju9Syv0t+91I3G
	8PwNRFNZvID9N0qSn6NNMnWC6NxuSo7kXDdOXxzrbcQ+EPFS9mwuGPcJE5qUlbvyUQgvQ5/IaKb
	7hLMAE1Hsd4M0j4RSgYP9sUxglLS48iWFXE0sgvt7JXzqiaU5Yf7sD2puR69idsmIalI7CZ7w4V
	FZsVefb1f3y+ESLlPwh3JPy9lmb/KJuHPvBH/9GFaTU6gowoIFfg==
X-Received: by 2002:a17:90b:4b11:b0:2a0:8ccf:b45a with SMTP id lx17-20020a17090b4b1100b002a08ccfb45amr1580474pjb.4.1711459601368;
        Tue, 26 Mar 2024 06:26:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZMKSXNV7j3EUgkns9zCxvY3LF6mJLJfu5ZwmEvnMvWqryBaGLJJAnYbgwCL0IzNiZ1nVIMC2cmuvD9udHvtI=
X-Received: by 2002:a17:90b:4b11:b0:2a0:8ccf:b45a with SMTP id
 lx17-20020a17090b4b1100b002a08ccfb45amr1580447pjb.4.1711459600942; Tue, 26
 Mar 2024 06:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325152623.797099-1-chao@kernel.org>
In-Reply-To: <20240325152623.797099-1-chao@kernel.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 26 Mar 2024 21:26:28 +0800
Message-ID: <CAHj4cs8vWQ2YRTKKETWX5sJduYO1BJ8NPSwo8mw3LqqRfsns1g@mail.gmail.com>
Subject: Re: [PATCH] f2fs: multidev: fix to recognize valid zero block address
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I confirmed the issue was fixed now, thanks.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Mon, Mar 25, 2024 at 11:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> As reported by Yi Zhang in mailing list [1], kernel warning was catched
> during zbd/010 test as below:
>
> ./check zbd/010
> zbd/010 (test gap zone support with F2FS)                    [failed]
>     runtime    ...  3.752s
>     something found in dmesg:
>     [ 4378.146781] run blktests zbd/010 at 2024-02-18 11:31:13
>     [ 4378.192349] null_blk: module loaded
>     [ 4378.209860] null_blk: disk nullb0 created
>     [ 4378.413285] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> poll_queues to 0. poll_q/nr_hw =3D (0/1)
>     [ 4378.422334] scsi host15: scsi_debug: version 0191 [20210520]
>                      dev_size_mb=3D1024, opts=3D0x0, submit_queues=3D1, s=
tatistics=3D0
>     [ 4378.434922] scsi 15:0:0:0: Direct-Access-ZBC Linux
> scsi_debug       0191 PQ: 0 ANSI: 7
>     [ 4378.443343] scsi 15:0:0:0: Power-on or device reset occurred
>     [ 4378.449371] sd 15:0:0:0: Attached scsi generic sg5 type 20
>     [ 4378.449418] sd 15:0:0:0: [sdf] Host-managed zoned block device
>     ...
>     (See '/mnt/tests/gitlab.com/api/v4/projects/19168116/repository/archi=
ve.zip/storage/blktests/blk/blktests/results/nodev/zbd/010.dmesg'
>
> WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
> CPU: 22 PID: 44011 Comm: fio Not tainted 6.8.0-rc3+ #1
> RIP: 0010:iomap_iter+0x32b/0x350
> Call Trace:
>  <TASK>
>  __iomap_dio_rw+0x1df/0x830
>  f2fs_file_read_iter+0x156/0x3d0 [f2fs]
>  aio_read+0x138/0x210
>  io_submit_one+0x188/0x8c0
>  __x64_sys_io_submit+0x8c/0x1a0
>  do_syscall_64+0x86/0x170
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Shinichiro Kawasaki helps to analyse this issue and proposes a potential
> fixing patch in [2].
>
> Quoted from reply of Shinichiro Kawasaki:
>
> "I confirmed that the trigger commit is dbf8e63f48af as Yi reported. I to=
ok a
> look in the commit, but it looks fine to me. So I thought the cause is no=
t
> in the commit diff.
>
> I found the WARN is printed when the f2fs is set up with multiple devices=
,
> and read requests are mapped to the very first block of the second device=
 in the
> direct read path. In this case, f2fs_map_blocks() and f2fs_map_blocks_cac=
hed()
> modify map->m_pblk as the physical block address from each block device. =
It
> becomes zero when it is mapped to the first block of the device. However,
> f2fs_iomap_begin() assumes that map->m_pblk is the physical block address=
 of the
> whole f2fs, across the all block devices. It compares map->m_pblk against
> NULL_ADDR =3D=3D 0, then go into the unexpected branch and sets the inval=
id
> iomap->length. The WARN catches the invalid iomap->length.
>
> This WARN is printed even for non-zoned block devices, by following steps=
.
>
>  - Create two (non-zoned) null_blk devices memory backed with 128MB size =
each:
>    nullb0 and nullb1.
>  # mkfs.f2fs /dev/nullb0 -c /dev/nullb1
>  # mount -t f2fs /dev/nullb0 "${mount_dir}"
>  # dd if=3D/dev/zero of=3D"${mount_dir}/test.dat" bs=3D1M count=3D192
>  # dd if=3D"${mount_dir}/test.dat" of=3D/dev/null bs=3D1M count=3D192 ifl=
ag=3Ddirect
>
> ..."
>
> So, the root cause of this issue is: when multi-devices feature is on,
> f2fs_map_blocks() may return zero blkaddr in non-primary device, which is
> a verified valid block address, however, f2fs_iomap_begin() treats it as
> an invalid block address, and then it triggers the warning in iomap
> framework code.
>
> Finally, as discussed, we decide to use a more simple and direct way that
> checking (map.m_flags & F2FS_MAP_MAPPED) condition instead of
> (map.m_pblk !=3D NULL_ADDR) to fix this issue.
>
> Thanks a lot for the effort of Yi Zhang and Shinichiro Kawasaki on this
> issue.
>
> [1] https://lore.kernel.org/linux-f2fs-devel/CAHj4cs-kfojYC9i0G73PRkYzcxC=
Tex=3D-vugRFeP40g_URGvnfQ@mail.gmail.com/
> [2] https://lore.kernel.org/linux-f2fs-devel/gngdj77k4picagsfdtiaa7gpgnup=
6fsgwzsltx6milmhegmjff@iax2n4wvrqye/
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-f2fs-devel/CAHj4cs-kfojYC9i0G73PRkY=
zcxCTex=3D-vugRFeP40g_URGvnfQ@mail.gmail.com/
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 1517c1a7a445 ("f2fs: implement iomap operations")
> Fixes: 8d3c1fa3fa5e ("f2fs: don't rely on F2FS_MAP_* in f2fs_iomap_begin"=
)
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d9494b5fc7c1..5ef1874b572a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4185,7 +4185,7 @@ static int f2fs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
>         if (WARN_ON_ONCE(map.m_pblk =3D=3D COMPRESS_ADDR))
>                 return -EINVAL;
>
> -       if (map.m_pblk !=3D NULL_ADDR) {
> +       if (map.m_flags & F2FS_MAP_MAPPED) {
>                 iomap->length =3D blks_to_bytes(inode, map.m_len);
>                 iomap->type =3D IOMAP_MAPPED;
>                 iomap->flags |=3D IOMAP_F_MERGED;
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang


