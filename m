Return-Path: <linux-kernel+bounces-110007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300CD8858D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB73283130
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9F76A00B;
	Thu, 21 Mar 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLne0evL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165159151
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022866; cv=none; b=ETQov6xmiacbVcIFW+GX9KDLkkG6V6T5NtDC1+N7NbY066b7TFI1zMs+7X3j5PjLPgpRZutQRVPsrJS6oBD6yGJidK12MmDRmcT4VcNjfCp8a9mTMXayzGUsd13qjlGqCdmmcgP5ZN27sA3yba9c6X2l6cbe/Jp8c//wFBdatEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022866; c=relaxed/simple;
	bh=X0tL/3FFAGPNviRZQumMrIGH7M5K6g7DYUNkbDET8/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnLdEiNO6xhPqPngYtrMo6XOCXDvxoJd7ZIPlq7lrcSBBTABmSEABAJ2znviHzYI3Ytt0SLTE7PZrY9LLWT5+zp4/laQVWLPkjo5YU4Isv+0LyGUrqZwe9vjsLetoWVcuORUsG3Qq7VqVIug19GTYiXyA6ezOMBL1v8CzvuLJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLne0evL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711022864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aE2vIOB5AxhtNUIPZE0VWth2YHNZEb1JCikNc71y+sE=;
	b=iLne0evLTkCPwAdUFogooUSy2HOsu/tRvLDm0mKWqMknBNTMPmmggulLkgBFUJmDNMo04q
	H4NeC10OpqzFoFapjx7zk5snfeUBdiysRsP9PpaiMwPQtdmg3ti+/9YA+J68FccPSxgNaR
	ALqEY6zpuowc3WvMet/3ZGOJkdU/VtE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-CxiE_PixOw6d_og37MHeuA-1; Thu,
 21 Mar 2024 08:07:40 -0400
X-MC-Unique: CxiE_PixOw6d_og37MHeuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36D121C01E8D;
	Thu, 21 Mar 2024 12:07:40 +0000 (UTC)
Received: from localhost (unknown [10.39.194.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60D843C20;
	Thu, 21 Mar 2024 12:07:39 +0000 (UTC)
Date: Thu, 21 Mar 2024 08:07:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: syzbot <syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	michael.christie@oracle.com, mst@redhat.com, osalvador@suse.de,
	pbonzini@redhat.com, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [virtualization?] upstream boot error: WARNING:
 refcount bug in __free_pages_ok
Message-ID: <20240321120722.GC1465092@fedora>
References: <20240320113002.GA1178948@fedora>
 <000000000000e4b57b06141d250c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TO9rjoh4tmuqYx/1"
Content-Disposition: inline
In-Reply-To: <000000000000e4b57b06141d250c@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


--TO9rjoh4tmuqYx/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 01:08:02PM -0700, syzbot wrote:
> Hello,
>=20
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>=20
> Reported-and-tested-by: syzbot+70f57d8a3ae84934c003@syzkaller.appspotmail=
=2Ecom
>=20
> Tested on:
>=20
> commit:         4bedfb31 mm,page_owner: maintain own list of stack_rec..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D527195e149aa3=
091
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D70f57d8a3ae8493=
4c003
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>=20
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.
>=20

Good, that was the expected last working commit. Here is the next commit
(it should fail):

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 217b2119b9e260609958db413876f211038f00ee

--TO9rjoh4tmuqYx/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX8IvoACgkQnKSrs4Gr
c8gUEAf/UP1SqeIPex02ksQ+fvPCq8XcEw+bdapCwds2y2LtGptJziYCZMhzxZNw
z8LNojdyW3N/AJd1HH+UXBWjTQUm1pI8WQ0Ryb+BuwlVFA/jlkj8vXjADM/yHsLO
9PMZtQ6ESvKS14trV8XZglo8XcOAatHKjlLPUO5wOZscWiDJ0HWi4CUdfp2Ue+dP
cA3LRWfChQXTSoGJJGQaUGm/czzJP9iIX/FApyDgBuCM+zVAv7GKkdMQgvxG14on
uVk8P/IfhSM6P5vOt7FvujGfW10Wk3ABaLQ2UvooLR75Nt1jQP0QDsH3opDNqgYp
cD5ZF4ZCJznQyZE2UQ45+Gtt1Oq1Lg==
=7YIU
-----END PGP SIGNATURE-----

--TO9rjoh4tmuqYx/1--


