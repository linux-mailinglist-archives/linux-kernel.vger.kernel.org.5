Return-Path: <linux-kernel+bounces-159640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A78B3173
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7581C220E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391013C3E7;
	Fri, 26 Apr 2024 07:34:51 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C413BAFA;
	Fri, 26 Apr 2024 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116891; cv=none; b=k/TQcttXejZxM+krrWGlYx536DY1SlnH7f4v4xQszRdKS86xVrivKvR35tcDEe1OymdM0ksI3OTR/eRssaq8E14B+5tBPiXnf7MhhGIvzMg+DolLgbyX10v3UddAMQFW/vGwj9PHod23OLfm8FBOorY4+TqHtpI1V0KzR4KyL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116891; c=relaxed/simple;
	bh=2nrxwp2YjUh24wBnc5J/BKpzCkny1EsZeH2Cz2T2t0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtYBtRJN4zPz1gPzPadEtdexG+mvLdeVzoO9iXpKYP0IpOoJNKOp03++5kJt/afKSQ8QE1AUrIcjtOlKLKr3BgUcCYxXtQeRuAF9uRZvKNIWw5ohIIN8UMUDwhZXYtYb55Ckd8HNW//O1EInT8sg7N8PkTAUqsz/mG0JfJ8CvxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQkZz1Rkjz9xGhJ;
	Fri, 26 Apr 2024 15:18:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id F081C140558;
	Fri, 26 Apr 2024 15:34:39 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3YycEWStmtzr3Bg--.56522S2;
	Fri, 26 Apr 2024 08:34:38 +0100 (CET)
Message-ID: <2b28414a7c7e4c53057ef8e527f85c05eb225d85.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v2 0/2] ima: Fix detection of read/write violations
 on stacked filesystems
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 zohar@linux.ibm.com,  roberto.sassu@huawei.com, miklos@szeredi.hu,
 brauner@kernel.org
Date: Fri, 26 Apr 2024 09:34:24 +0200
In-Reply-To: <CAOQ4uxjODtbaWPHS3bQvnEKuYAWTJa6kqsXCSzcsF1hJdThcsw@mail.gmail.com>
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
	 <CAOQ4uxgvHjU-n56ryOp5yWQF=yKz0Cfo0ZieypWJhqsBV4g-2w@mail.gmail.com>
	 <a8da6b9f57095be494b8c38ca46e2a102b8eafac.camel@huaweicloud.com>
	 <CAOQ4uxjODtbaWPHS3bQvnEKuYAWTJa6kqsXCSzcsF1hJdThcsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3YycEWStmtzr3Bg--.56522S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF13Aw47Ar15Jr43GryUWrg_yoWxAr1kpF
	W3AanFkw1Dtr1xAr92y3W8X3WFyrW8JFWUX34Y9ryUAa4qgrn3trWrKr4a9F9rCFn5Cw40
	qayjqrZrZr1DZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5zPXgACs+

On Thu, 2024-04-25 at 15:37 +0300, Amir Goldstein wrote:
> > On Thu, Apr 25, 2024 at 2:30=E2=80=AFPM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > >=20
> > > > On Tue, 2024-04-23 at 09:02 +0300, Amir Goldstein wrote:
> > > > > > On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stefanb@=
linux.ibm.com> wrote:
> > > > > > > >=20
> > > > > > > > This series fixes the detection of read/write violations on=
 stacked
> > > > > > > > filesystems. To be able to access the relevant dentries nec=
essary to
> > > > > > > > detect files opened for writing on a stacked filesystem a n=
ew d_real_type
> > > > > > > > D_REAL_FILEDATA is introduced that allows callers to access=
 all relevant
> > > > > > > > files involved in a stacked filesystem while traversing the=
 layers.
> > > > > > > >=20
> > > > > >=20
> > > > > > Stefan,
> > > > > >=20
> > > > > > Both Miklos and myself objected to this solution:
> > > > > > https://lore.kernel.org/linux-unionfs/CAJfpeguctirEYECoigcAsJwp=
GPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com/
> > > > > >=20
> > > > > > Not sure what you are hoping to achieve from re-posting the sam=
e solution.
> > > > > >=20
> > > > > > I stopped counting how many times I already argued that *all* I=
MA/EVM
> > > > > > assertions,
> > > > > > including rw-ro violations should be enforced only on the real =
inode.
> > > > > > I know this does not work - so you should find out why it does =
not work and fix
> > > > > > the problem.
> > > > > >=20
> > > > > > Enforcing IMA/EVM on the overlayfs inode layer is just the wron=
g way IMO.
> > > > > > Not once have I heard an argument from IMA/EVM developers why i=
t is really
> > > > > > needed to enforce IMA/EVM on the overlayfs inode layer and not =
on the
> > > > > > real inode.
> > > >=20
> > > > Ok, I try to provide an example regarding this, and we see if it ma=
kes
> > > > sense.
> > > >=20
> > > > # echo test > test-file
> > > > # chown 2000 d/test-file
> > > > # ls -l a/test-file
> > > > -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
> > > >=20
> > > > Initially there is a file in the lower layer with UID 2000.
> > > >=20
> > > >=20
> > > > # mount -t overlay -olowerdir=3Da,upperdir=3Db,workdir=3Dc,metacopy=
=3Don overlay d
> > > > # chown 3000 d/test-file
> > > > # ls -l d/test-file
> > > > -rw-r--r--. 1 3000 root 25 Apr 25 10:50 d/test-file
> > > > # ls -l a/test-file
> > > > -rw-r--r--. 1 2000 root 25 Apr 25 10:50 a/test-file
> > > > # ls -l b/test-file
> > > > -rw-r--r--. 1 3000 root 25 Apr 25 10:50 b/test-file
> > > >=20
> > > > If I have a policy like this:
> > > >=20
> > > > # echo "measure fsname=3Doverlay fowner=3D3000" > /sys/kernel/secur=
ity/ima/policy
> > > >=20
> > > > there won't be any match on the real file which still has UID 2000.=
 But
> > > > what is observable by the processes through overlayfs is UID 3000.
> > > >=20
> >=20
> > ok, it is simple to write an ima policy that is not respected by overla=
yfs.
> >=20
> > My question is: under what circumstances is a policy like the above
> > useful in the real world?
> >=20
> > Correct me if I am wrong, but AFAIK, the purpose of IMA/EVM is to
> > mitigate attack vectors of tampering with files offline or after the
> > file's data/metadata were measured. Is that a correct description?

(For now I would talk about IMA, EVM can be considered separately).

The main purpose of IMA is to evaluate files being accessed, and record
the access together with a file digest in a measurement list,
allow/deny access to the file (appraisal), or add a new event to audit
logs.

How files are selected depends on the IMA policy. A rule can be
subject-based or object-based, depending on whether respectively
process or file attributes are matched. It can also be both.

A subject-based rule means that you identify a process/set of
processes, and you evaluate everything it/they read.

An object-based rule means that you identify a file/set of files, and
you evaluate any process accessing them.

Since processes normally would access the top most layer (overlayfs),
the IMA policy should be written in terms of metadata seen in that
layer (but not necessarily).

This is just for identifying the set of files to
measure/appraise/audit, not which file is going to be evaluated, which
will be always the persistent one.

I have to admit, things are not very clear also to me.

Suppose you have a file in the lower filesystem with SELinux label
user_t, and then on overlayfs with metadata copy, you change the label
of this file to unconfined_t.

What will happen exactly? On the overlayfs layer, you will have a
permission request with the new label unconfined_t, but when overlayfs
calls vfs_open(), there will be another permission request with the old
label.

It is kind of the same challenge we are facing with IMA, we can observe
the file operations at different layers. That is why I think having
stacked IMA calls is a good idea (other than really fixing the
violations).

The current problem, that is very difficult to solve, is that the
policy should cover all layers, or some events will be missed. Now we
have overlayfs-specific code to detect changes in the backing inode,
while with stacked IMA calls, we can detect the change at the layer
where it happened (and we can remove the overlayfs-specific code).

Ideally, what I would do to cover all layers is that if there is a
match at one layer, the lower layers should automatically match too,
but it is not that easy since after the vfs_open() recursive calls we
start calling IMA in the botton most layer first.

(What I did with the stacked IMA calls is just an experiment to see how
far we can go, but still we didn't make any decision with Mimi).

> > AFAIK, IMA/EVM policy is system-wide and not namespace aware
> > so the policy has to be set on the container's host and not inside
> > containers. Is that correct?

I know that overlayfs is primarily aiming at containers, but I would
suggest to not add that complexity yet and just consider the host.

> > If those statements are true then please try to explain to me what is
> > the thread model for tampering with overlayfs files, without tampering
> > with the real upper and/or lower files.

I hope at this point is clear that what we care about is that, or the
process is reading the content of the file whose digest is recorded in
the measurement list, or we must signal to remote verifiers concurrent
accesses that make the statement above false.

> > My thesis is that if an IMA/EVM policy is good enough to prevent
> > tampering with the real lower/upper files, then no extra measures
> > are needed to protect the virtual overlayfs files against tampering.

What you say is correct, but the way you identify files to
measure/appraise/audit can be different.

Thanks

Roberto

> > Is my thesis flawed?
> > I'm pretty sure that it is, but I never got a satisfying answer why.
> >=20
> > Thanks,
> > Amir.


