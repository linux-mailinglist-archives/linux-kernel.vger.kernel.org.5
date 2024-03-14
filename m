Return-Path: <linux-kernel+bounces-103535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0C87C0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C85DB22887
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C873194;
	Thu, 14 Mar 2024 15:58:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652071B37;
	Thu, 14 Mar 2024 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431898; cv=none; b=J5F43Ik6WRv6bk84HdqmJaJFrkKtnSLFjUWcmI3BBqC+UWFN423mFb/w6TVqKoXnxNQTUjn2nfcckRaorFNcHvoghW+++yOGYOFiOI6ZdsCVHp6/Tzdv2uYBUAtToCEGS++oADR7FgKxC6/hKgBr70UqMJ9jQW/Z6rSnTmc0Q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431898; c=relaxed/simple;
	bh=DXQqwJJ63DZa7xAit6S7SqD2kBPUmGIXS/NWXgZYEwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCkNn9ETjCf6CiXzS3ovC7Y8ngSgqgNR/2nUIFZ2MGHdFdko01znAitKCow9QC/bKLB8nCofB6Zxzs1DXkZCV6w18GQnj3T1eHqEwJ3CqJOsKYgA0ue/90YwO7rKqYG5fJ6aCQ0WvOOGPOi6cdTsXf9Pqti9J2RQE6RFmctJNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E21BC433C7;
	Thu, 14 Mar 2024 15:58:16 +0000 (UTC)
Date: Thu, 14 Mar 2024 12:00:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Yufeng Mo <moyufeng@huawei.com>, Huazhong Tan
 <tanhuazhong@huawei.com>
Subject: Re: [PATCH] net: hns3: tracing: fix hclgevf trace event strings
Message-ID: <20240314120027.088e850d@gandalf.local.home>
In-Reply-To: <8607787b42e80503e0259f41e0bcc2d3ff770355.camel@redhat.com>
References: <20240313093454.3909afe7@gandalf.local.home>
	<8607787b42e80503e0259f41e0bcc2d3ff770355.camel@redhat.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Mar 2024 15:39:28 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On Wed, 2024-03-13 at 09:34 -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >=20
> > [
> >    Note, I need to take this patch through my tree, so I'm looking for =
acks. =20
>=20
> Note that this device driver is changing quite rapidly, so I expect
> some conflicts here later. I guess Liuns will have to handle them ;)

Well, it merges fine with linux-next and linus's current master. ;-)

>=20
> >    This causes the build to fail when I add the __assign_str() check, w=
hich
> >    I was about to push to Linus, but it breaks allmodconfig due to this=
 error.
> > ]
> >=20
> > The __string() and __assign_str() helper macros of the TRACE_EVENT() ma=
cro
> > are going through some optimizations where only the source string of
> > __string() will be used and the __assign_str() source will be ignored a=
nd
> > later removed.
> >=20
> > To make sure that there's no issues, a new check is added between the
> > __string() src argument and the __assign_str() src argument that does a
> > strcmp() to make sure they are the same string.
> >=20
> > The hclgevf trace events have:
> >=20
> >   __assign_str(devname, &hdev->nic.kinfo.netdev->name);
> >=20
> > Which triggers the warning:
> >=20
> > hclgevf_trace.h:34:39: error: passing argument 1 of =E2=80=98strcmp=E2=
=80=99 from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >    34 |                 __assign_str(devname, &hdev->nic.kinfo.netdev->=
name);
> >  [..]
> > arch/x86/include/asm/string_64.h:75:24: note: expected =E2=80=98const c=
har *=E2=80=99 but argument is of type =E2=80=98char (*)[16]=E2=80=99
> >    75 | int strcmp(const char *cs, const char *ct);
> >       |            ~~~~~~~~~~~~^~
> >=20
> >=20
> > Because __assign_str() now has:
> >=20
> > 	WARN_ON_ONCE(__builtin_constant_p(src) ?		\
> > 		     strcmp((src), __data_offsets.dst##_ptr_) :	\
> > 		     (src) !=3D __data_offsets.dst##_ptr_);	\
> >=20
> > The problem is the '&' on hdev->nic.kinfo.netdev->name. That's because
> > that name is:
> >=20
> > 	char			name[IFNAMSIZ]
> >=20
> > Where passing an address '&' of a char array is not compatible with str=
cmp().
> >=20
> > The '&' is not necessary, remove it.
> >=20
> > Fixes: d8355240cf8fb ("net: hns3: add trace event support for PF/VF mai=
lbox") =20
>=20
> checkpactch in strict mode complains the hash is not 12 char long.

Hmm, I wonder why my git blame gives me 13 characters in the sha. (I cut
and pasted it from git blame). My git config has:

[core] =20
        abbrev =3D 12


>=20
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org> =20
>=20
> FWIW
>=20
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks!

-- Steve

