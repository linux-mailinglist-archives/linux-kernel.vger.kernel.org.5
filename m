Return-Path: <linux-kernel+bounces-157137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA3F8B0D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD1A1C20E01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037315EFBC;
	Wed, 24 Apr 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB1G3Ttt"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022115E802;
	Wed, 24 Apr 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970460; cv=none; b=p6976yZcqdZSIHT+MpxsqWmAQuiMijsP7ywW3Po4iSxuREPprLn6/k5va9HQHq5EEaCRtDgekpLN5YS79nraw1QZDMz7N5K/X/41jnV3A21uFjVwx+ZHRsPB5+ksvS8unmX1u1J2bKm3qipUh1flaJQxy5k4DflXp4og23joirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970460; c=relaxed/simple;
	bh=uXJCumUlxTxHWrN5eeUyifZZYEzii/3yS0/w9Zg/rsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egEK5llDM58EnCOjTzLVLknrOveJzTA16wu0/MWPwXtqMdEICxC2I6zWrGbr7wUPI9nX4tFx8ICYDtr/MyYd7k3Ny/Iu2AAIqzMcDsLclqTHis8MYz0ry5ll+a9v1W/yYBv8kmp5xbRhW6pcNzxR1usrrUSriOf9GK2k8idqzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB1G3Ttt; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57232e47a81so61a12.0;
        Wed, 24 Apr 2024 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713970457; x=1714575257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+9IQLCN7DH23nxy4mYuyF9NGEY2ALiGsS8ZLweky1c=;
        b=FB1G3TttSjmMHeaCk0ybMrSKwdrvboaFAgaII5GNMYKVukMwUC1iUKIzXLOyBaSNwv
         cnyWRSOsf41qF0MDsCRXC1f9ZtNchE5VMZ4zpvgTFrm1cMnJ0T2s7leUkRd1UVYxCm6C
         aMvJ0mn56RWVXwX9tW1iTiL14r6kBD5Z9qc8UQFHBKaxapVcM3J+HywOQb0dtUCEFPkS
         dULudyWCwe+LysIsoy9r8CRH9qcldjOTe8XFotsKRaVysxErjMzPZez19qWjsOB7jfLt
         X0RexRSBZI9qoyXYuYSTB5KeGeRt2Ozph80uE8DC4rvUZrPRXuO0k3K+tn1jwsUy6WqI
         sB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970457; x=1714575257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+9IQLCN7DH23nxy4mYuyF9NGEY2ALiGsS8ZLweky1c=;
        b=Nv3hK2cD33nQ31xHu1Tpc3EVeJq2QRzZpWb2eXJDuP6+h7mUe6z1kG7wFgbyuOEt06
         ZluN3yLFV/i587Ma0tvECN0hRam/w28JV100ZeNjcaRp2sW4c61SiOTaV0zF6bYdzmKY
         N+USGOMJSN9Uz77yMtlZQ2iwTvaU4vnEzfNXcHispziXzHefGvcWNTb/4YPHlAYRYH+J
         MlMfhGw9faT/KOL14HiF7U7KNWaykiLBNQOhMKoiGHNDIEQS9sRVWFZOkAODmrAAtFq5
         yJTyIBRcqMsOsH+NbaDBCY+kNZQN/e1P5j2fLG3lhhEM9waXewKyBu7kyQf9rd1hJ5tk
         rxOg==
X-Forwarded-Encrypted: i=1; AJvYcCWTFoEEqnGcZjaDlPpRt5Lx9knhSQ7WzThjXBP/m2vou+MgBIgT5muEKMMXNxQPpfypL/7UjHK/H8+R1agUkmEz8vkiAQ+4zz2b2ZblKKREm9d2LDfaQ/1F+uqgCmijtyxTSb795UxG1vI=
X-Gm-Message-State: AOJu0Yzx7zPUXzNNpO/3MFUVUclZ9pK6d2whEreKGDv20bNkW1lS0FVA
	y7NktPKdnDeVe16uK6XWB4M1BLIhdM8eLYD9vG3LuBLpdzv8FVyR9RdqsiihAI5g/+laiqBVi2S
	JSjXzK5lN5A23c1vFJadrMBll+5I=
X-Google-Smtp-Source: AGHT+IEAaL8HzUDGp+9KU4r+vu6pC/oTqS8n5nfkqM3dTXstIgOstxWocIe41WpymO7HJ75Msr+qjdwdCh5TnlvAPfs=
X-Received: by 2002:a50:d490:0:b0:571:b82f:630d with SMTP id
 s16-20020a50d490000000b00571b82f630dmr2916994edi.0.1713970457343; Wed, 24 Apr
 2024 07:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jyC1+s80etZgWteps0Q0yEsR2NE23+Bf+Daa7zgJ2qKBA@mail.gmail.com>
 <2c9182cc-9d7e-0108-90bc-5e66da966bdb@huaweicloud.com>
In-Reply-To: <2c9182cc-9d7e-0108-90bc-5e66da966bdb@huaweicloud.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Wed, 24 Apr 2024 07:54:06 -0700
Message-ID: <CAJg=8jwn5NDWmo4=prnFbZJuq7N3kdmt2evkQ9uEJCWi0Bs8dg@mail.gmail.com>
Subject: Re: INFO: task hung in bdev_open
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai,

I see, thanks so much for the explanation!

Best,
Marius

On Mon, 22 Apr 2024 at 23:51, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2024/04/21 9:19, Marius Fleischer =E5=86=99=E9=81=93:
> > INFO: task syz-executor.2:32444 blocked for more than 143 seconds.
> >     Not tainted 6.9.0-rc4-dirty #3
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:syz-executor.2  state:D stack:25264 pid:32444 tgid:32417
> > ppid:8232   flags:0x00004006
> > Call Trace:
> >   <TASK>
> >   context_switch kernel/sched/core.c:5409 [inline]
> >   __schedule+0xd23/0x5bc0 kernel/sched/core.c:6746
> >   __schedule_loop kernel/sched/core.c:6823 [inline]
> >   schedule+0xe7/0x350 kernel/sched/core.c:6838
> >   io_schedule+0xbf/0x130 kernel/sched/core.c:9044
> >   folio_wait_bit_common+0x397/0x9c0 mm/filemap.c:1283
> >   folio_put_wait_locked mm/filemap.c:1447 [inline]
> >   do_read_cache_folio+0x2db/0x520 mm/filemap.c:3729
> >   read_mapping_folio include/linux/pagemap.h:894 [inline]
> >   read_part_sector+0xf7/0x440 block/partitions/core.c:715
> >   adfspart_check_POWERTEC+0x82/0x710 block/partitions/acorn.c:454
> >   check_partition block/partitions/core.c:138 [inline]
> >   blk_add_partitions block/partitions/core.c:582 [inline]
> >   bdev_disk_changed+0x891/0x15f0 block/partitions/core.c:686
> >   blkdev_get_whole+0x18b/0x260 block/bdev.c:667
> >   bdev_open+0x2eb/0xe90 block/bdev.c:880
> >   blkdev_open+0x181/0x200 block/fops.c:620
> >   do_dentry_open+0x6d3/0x18e0 fs/open.c:955
> >   do_open fs/namei.c:3642 [inline]
> >   path_openat+0x1b23/0x2670 fs/namei.c:3799
> >   do_filp_open+0x1c7/0x410 fs/namei.c:3826
> >   do_sys_openat2+0x164/0x1d0 fs/open.c:1406
> >   do_sys_open fs/open.c:1421 [inline]
> >   __do_sys_openat fs/open.c:1437 [inline]
> >   __se_sys_openat fs/open.c:1432 [inline]
> >   __x64_sys_openat+0x140/0x1f0 fs/open.c:1432
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xce/0x250 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> So this thread hold 'open_mutex' to issued IO to scan partitons, and
> such IO never complete, consider that you are using nbd to test, and
> nbd doesn't handle timeout by default, I really suspect this is not a
> real issue, and this looks like nbd server side doesn't reply to
> nbd-client.
>
> Thanks,
> Kuai
>

