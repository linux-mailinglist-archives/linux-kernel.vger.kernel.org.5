Return-Path: <linux-kernel+bounces-159817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889978B347D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA942838EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300913F454;
	Fri, 26 Apr 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJmZmVwP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F913F45D;
	Fri, 26 Apr 2024 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125114; cv=none; b=SW6khAySvfwyhvW/aTgxzw41DibuYZ9dh7Y6U58Om7d+r3WFndsxncI07KbutlOLEDYbG3zcma70pfSMmOwSgsgZ1Q/DGEz7GWitA4W2MtRJvbXAkdw70ZI+4c336ZcHtAtZ2VNzxcpW6ADTP2t513dWjOK5XHN+jmgGvahiqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125114; c=relaxed/simple;
	bh=dIDG2iYF5HLaFwFDbKGoDav/c3YPpuOOU31GP40Rv8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIMhiBzweGJqodULneFIT6Cgsfa83HEYwCCz6SBLO7MnSxAZylHieQocAULnW5iJaOQ5oqyhu/8NQkvFKq40nvztwrYIzWGkPLgzqFf3w+v8gmBSA+KJTQVpUmT2geI0OXNW6LTeFv+41MrZg+WTOVAv0+8+1Welt/w8yNYBm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJmZmVwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A52C2BD10;
	Fri, 26 Apr 2024 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714125113;
	bh=dIDG2iYF5HLaFwFDbKGoDav/c3YPpuOOU31GP40Rv8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJmZmVwPQJC6JJeQmopKAArEKSHT/1u6oyBQTfjCRiatmfc4EnTFBPeofeh2Sc0+6
	 0qjYGTQj9qgWd6mbDpBJLesSr46/ai6doM+pUJl6GwAYSI0DqEHdjp17Z89Dva/lT2
	 ycehrsByxdt4nv1xz/yiFFUYIozkbjOroKeSsAr7UkwC2PPBq1kVv7F/9fGWxe/Td1
	 J6C651MtP2q6591o9ltaM7rAK9cPeyl73RfxM4v7CDSFafSNOkrIBss2VHCNV96hB/
	 1aS7w7powVY+H/djq9Oa75eWG24Kfg+RY2JLG4Tz8SKbxlLrX2sXS8iX9OYRwVGzxq
	 x/AOa5wWhMJUw==
Date: Fri, 26 Apr 2024 11:51:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations
 on stacked filesystems
Message-ID: <20240426-norden-langzeitfolgen-611c816b02c4@brauner>
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
 <a74b1c3c49b74aa6062c57bd99b48bdddc256ebf.camel@huaweicloud.com>
 <CAOQ4uxitkN=Jchmp30RKGMVH-RDR5GGy-7J74vMQt0oecAK2bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxitkN=Jchmp30RKGMVH-RDR5GGy-7J74vMQt0oecAK2bg@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:30:52PM +0300, Amir Goldstein wrote:
> On Tue, Apr 23, 2024 at 4:21 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > On Tue, 2024-04-23 at 09:02 +0300, Amir Goldstein wrote:
> > > On Mon, Apr 22, 2024 at 6:07 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
> > > >
> > > > This series fixes the detection of read/write violations on stacked
> > > > filesystems. To be able to access the relevant dentries necessary to
> > > > detect files opened for writing on a stacked filesystem a new d_real_type
> > > > D_REAL_FILEDATA is introduced that allows callers to access all relevant
> > > > files involved in a stacked filesystem while traversing the layers.
> > > >
> > >
> > > Stefan,
> > >
> > > Both Miklos and myself objected to this solution:
> > > https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com/
> > >
> > > Not sure what you are hoping to achieve from re-posting the same solution.
> > >
> > > I stopped counting how many times I already argued that *all* IMA/EVM
> > > assertions,
> > > including rw-ro violations should be enforced only on the real inode.
> >
> > I have hopefully a better idea. We should detect violations at each
> > level of the stack independently. And IMA should be invoked each time
> > overlayfs uses an underlying layer.
> >
> > That is currently not easy, from the IMA policy perspective, because
> > there are filesystem-specific rules, such as fsname= or fsuuid=. At the
> > moment, I'm not planning to solve this, but I'm thinking to use for
> > example FMODE_BACKING to ignore the filesystem-specific keywords and
> > match the rule anyway.
> >
> > For now, I'm only addressing the call to underlying layers. To make
> > sure that IMA evaluates every layer, I added a rule that checks the
> > inode UID:
> >
> > measure fowner=2000 mask=MAY_READ
> >
> >
> > I just investigated a bit, and I made some changes (for now, I'm just
> > making it work, and you tell me what you think).
> 
> I did not examine this up close, but this seems like a change in the right
> direction.
> Will need Christian's approval that this does not break any assumptions
> made on backing files.

In principle I don't care if IMA wants to call yet another security hook
in the backing file layer. I suspect it will impact performace if IMA is
enabled. So that's something to keep in mind. But it's certainly better
than blatantly abusing the dcache to achieve this.

> > diff --git a/fs/backing-file.c b/fs/backing-file.c
> > index 740185198db3..8016f62cf770 100644
> > --- a/fs/backing-file.c
> > +++ b/fs/backing-file.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/backing-file.h>
> >  #include <linux/splice.h>
> >  #include <linux/mm.h>
> > +#include <linux/security.h>
> >
> >  #include "internal.h"
> >
> > @@ -40,12 +41,16 @@ struct file *backing_file_open(const struct path
> > *user_path, int flags,
> >         if (IS_ERR(f))
> >                 return f;
> >
> > +       f->f_mode |= OPEN_FMODE(flags);
> > +
> >         path_get(user_path);
> >         *backing_file_user_path(f) = *user_path;
> >         error = vfs_open(real_path, f);
> >         if (error) {
> >                 fput(f);
> >                 f = ERR_PTR(error);
> > +       } else {
> > +               security_file_post_open(f, ACC_MODE(flags));
> >         }
> >
> >         return f;
> >
> >
> > Setup:
> >
> > # mount -t overlay -olowerdir=a,upperdir=b,workdir=c overlay d
> >
> > open is a tool with the following syntax:
> >
> > open <path> <perm>
> >
> > It performs the open, and waits for user input before closing the file.
> >
> >
> >
> > ToMToU (Time of Measurement - Time of Use):
> >
> > Same fs (overlayfs)
> >
> > # /root/open /root/test-dir/d/test-file r (terminal 1)
> > # /root/open /root/test-dir/d/test-file w (terminal 2)
> >
> > This works:
> >
> > 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> > 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> > 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 test-file
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 /root/test-dir/d/test-file
> >
> > This is the result of calling IMA at both layers, and the violation of
> > course happens twice.
> >
> > This is also confirmed in the logs:
> >
> > Apr 23 14:52:45 fedora audit[994]: INTEGRITY_PCR pid=994 uid=0 auid=0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=ToMToU comm="open" name="test-file" dev="sda3" ino=995512 res=1 errno=0
> > Apr 23 14:52:45 fedora audit[994]: INTEGRITY_PCR pid=994 uid=0 auid=0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=ToMToU comm="open" name="/root/test-dir/d/test-file" dev="overlay" ino=995512 res=1 errno=0
> >
> >
> > Different fs (overlayfs, btrfs)
> >
> > # /root/open /root/test-dir/d/test-file r (terminal 1)
> > # /root/open /root/test-dir/b/test-file w (terminal 2)
> >
> > Again, this works despite the read is in overlayfs, and the write is in
> > btrfs:
> >
> > 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> > 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> > 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 /root/test-dir/b/test-file
> >
> > The difference from the previous example is that now there is only one
> > violation, which is detected only in the upper layer. The logs have:
> >
> > Apr 23 15:01:15 fedora audit[985]: INTEGRITY_PCR pid=985 uid=0 auid=0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=ToMToU comm="open" name="/root/test-dir/b/test-file" dev="sda3" ino=995512 res=1 errno=0
> >
> >
> > Different fs (btrfs, overlayfs)
> >
> > # /root/open /root/test-dir/b/test-file r (terminal 2)
> > # /root/open /root/test-dir/d/test-file w (terminal 1)
> >
> > 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> > 10 d7a692e19158820d2755542a8d31b49ac7ac2729 ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/b/test-file
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 test-file
> >
> > Works too. There is only one measurement, since that is done only for
> > the upper layer.
> >
> > Apr 23 15:05:40 fedora audit[982]: INTEGRITY_PCR pid=982 uid=0 auid=0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=ToMToU comm="open" name="test-file" dev="sda3" ino=995512 res=1 errno=0
> >
> >
> >
> > Open writers
> >
> > Same fs (overlayfs)
> >
> > # /root/open /root/test-dir/d/test-file w (terminal 1)
> > # /root/open /root/test-dir/d/test-file r (terminal 2)
> >
> > 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 test-file
> > 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 /root/test-dir/d/test-file
> > 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file
> >
> > Apr 23 15:10:46 fedora audit[983]: INTEGRITY_PCR pid=983 uid=0 auid=0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=open_writers comm="open" name="test-file" dev="sda3" ino=995512 res=1 errno=0
> > Apr 23 15:10:46 fedora audit[983]: INTEGRITY_PCR pid=983 uid=0 auid=0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=open_writers comm="open" name="/root/test-dir/d/test-file" dev="overlay" ino=995512 res=1 errno=0
> >
> >
> > Different fs (overlayfs, btrfs)
> >
> > # /root/open /root/test-dir/d/test-file w (terminal 1)
> > # /root/open /root/test-dir/b/test-file r (terminal 2)
> >
> > 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 /root/test-dir/b/test-file
> > 10 d7a692e19158820d2755542a8d31b49ac7ac2729 ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/b/test-file
> >
> > Apr 23 15:12:58 fedora audit[984]: INTEGRITY_PCR pid=984 uid=0 auid=0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=open_writers comm="open" name="/root/test-dir/b/test-file" dev="sda3" ino=995512 res=1 errno=0
> >
> >
> > Different fs (btrfs, overlayfs)
> >
> > # /root/open /root/test-dir/b/test-file w (terminal 1)
> > # /root/open /root/test-dir/d/test-file r (terminal 2)
> >
> > 10 35435d0858d895b90097306171a2e5fcc7f5da9e ima-ng sha256:0e4acf326a82c6bded9d86f48d272d7a036b6490081bb6466ecc2a0e416b244a boot_aggregate
> > 10 0000000000000000000000000000000000000000 ima-ng sha256:0000000000000000000000000000000000000000000000000000000000000000 test-file
> > 10 cef529d5d1032ffb6d3e2154664c83ba18cf2576 ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 test-file
> > 10 694277487b9753db78446192231b59b7be7c03ad ima-ng sha256:f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2 /root/test-dir/d/test-file
> >
> > Apr 23 15:16:37 fedora audit[983]: INTEGRITY_PCR pid=983 uid=0 auid=0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=invalid_pcr cause=open_writers comm="open" name="test-file" dev="sda3" ino=995512 res=1 errno=0
> >
> > Roberto
> >
> > > I know this does not work - so you should find out why it does not work and fix
> > > the problem.
> > >
> > > Enforcing IMA/EVM on the overlayfs inode layer is just the wrong way IMO.
> > > Not once have I heard an argument from IMA/EVM developers why it is really
> > > needed to enforce IMA/EVM on the overlayfs inode layer and not on the
> > > real inode.
> > > I am sorry that we are failing to communicate on this matter, but I am not
> > > sure how else I can help.
> > >
> > > Thanks,
> > > Amir.
> >

