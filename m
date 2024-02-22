Return-Path: <linux-kernel+bounces-75833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE6285EFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914C8287122
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC491A27D;
	Thu, 22 Feb 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="tI4er3YQ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572D1799F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571171; cv=none; b=H+XHhSiMkhWtw1BdMLkShRAwuyEENehyZgGMUfDMZtQh5zJ8q8UlvT7i8CaxctQXPoqxuPrQgalKMTQKWHMUoL4vvaQVqit7LGy/JmtGAX5I+63NN6XYwzxndAUXGbYf4egOGVHnPjE7vXgcEtQiG/e8hKjUZyuim/03OGWThyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571171; c=relaxed/simple;
	bh=HEszjr9riqrF8sIkIpSH4NuJEBM42ahASmQDnRDEUcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWsrA6GcNCPrNzDWwKz4y9jzoY1K9A4S3p3M37TTCTNpUJdO+AHn+boPvB4243fd/koGZJoPmYcMhb36ZU0i6KmISY4/59KD1di3mpRPYSOHAX13ag69JUMxdeHfTx0LRcKWiVIxwg5OgmenWj+7yot8N7CZ4UrQCr0HR1vlVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=tI4er3YQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512aafb3ca8so4579591e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708571168; x=1709175968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GL2/sftRMsFbU6bQC3gRHQ7BmHWi2vLJ5w2sAuGFyA=;
        b=tI4er3YQz2sSdpElO6NDHOez0LSsiB6aPssKxhpboqvaX4iXRQpo3JZmpxgpITJKcX
         akk54uB28ovOQUtKYVgfmb3Oc9AGBXbGGlmAl9sikutP53Zo7/FQdCDjEKZucd2mQqeo
         1p7dfzPW11/eN4x6gjqXMeCjv/0SJ+zSD7D8cwEmHJjf7smFJdvNCV81iR65KqEqlzqQ
         znV2kZmu+hHtkB7GPeBMtVKh1ZO2/b9D8c16vTsEQLUyzg2TnkVOC1y524BAlMLhwfhk
         TTVAmtrJbXvsuO1vc+GPvT1seSJAMWwpZEsA/KHod+e+TOhsJlqD/o7TazWbWwzhyMTv
         aNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571168; x=1709175968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GL2/sftRMsFbU6bQC3gRHQ7BmHWi2vLJ5w2sAuGFyA=;
        b=CJZVAIPnJsxXUgkElsRcPWPzwfu/p4RTF8fI9kyaRjjCsVQycVb+FiOV+83y6l+BST
         WdBBXaG7p7/TjzDbfl3UHnFZwwzPjhvDk+/NFT+mwYRVvF9dr8aGUZRz4k0JqbWepKWL
         kkFKWn4vIoXzzpo09QrY6l5kYlfXvqfqwRVfGXOXaArnosinYytBzrC3Io2iksuex7dr
         O4fJF6BwvZ/0XEe5nZBl/3ApKxO1A4hlAT34iEw+lbbpU0MUrhZ3K9RLrSB0YZmqyetg
         eQ7VoxP+tlC6Wjj9880sowC+pbnmCIL1A7+JxU79yluSeXuXigo08C35Ie9Xwia1FgbD
         u35Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz1FcCNdxKtwJ7720StgnvdhGkXLszT9xeZMbk2pNsZVmb1Xn+QqTUsJqgX86jCjFGqP38OLN8ad2uhseFOQ2PVAuwL0yHhI5Sauij
X-Gm-Message-State: AOJu0YyGQU2VP7Rwm8LsB3tjpPW28oBtIq6YZjpHoBlpfHdnM0IXgRXi
	xYEaUpLDsPRH2EFUiMbUIMnXj9/aZS79dZvsm2tkSHGC3D315YZyrPjexlyFjG+Zx1Ye+s4ngbf
	Z5vF7sa6yzuU1a+lAb5q3ZjQYzQUFitxcrOo7Aw==
X-Google-Smtp-Source: AGHT+IHz0DfQ7WdFHoTKTh9/wLbZNCERaKaIUmP7DD8KvxAVOcVA9iSxnJxQBzg99vO8r8oNniJubxT+p4NBkkZFDZg=
X-Received: by 2002:a05:6512:ba1:b0:512:bda4:bf47 with SMTP id
 b33-20020a0565120ba100b00512bda4bf47mr7020110lfv.4.1708571166733; Wed, 21 Feb
 2024 19:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
 <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
In-Reply-To: <77a58302766cb6c8fac45682ede63569df80cd5d.camel@hammerspace.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Thu, 22 Feb 2024 11:05:53 +0800
Message-ID: <CAPKjjnpvO_VUwgxEKu1JP8xNnt0hct6koTtOSxZ0bN1D_55JGg@mail.gmail.com>
Subject: Re: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "chuck.lever@oracle.com" <chuck.lever@oracle.com>, "tom@talpey.com" <tom@talpey.com>, 
	"anna@kernel.org" <anna@kernel.org>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>, 
	"kolga@netapp.com" <kolga@netapp.com>, "huangping@smartx.com" <huangping@smartx.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forced unmount is used in a casual way to some degree by our team. We
will adjust the usage of forced unmount and multiple mount points for
the same export.

As you said, all of the above is well known. Actually, this phenomenon
is unexpected for us. Could you give some more information?  Are they
issues? And if they are issues, is there any plan to fix them?

Best regards,
Zhitao Li, in SmartX.

On Wed, Feb 21, 2024 at 9:48=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Wed, 2024-02-21 at 16:20 +0800, Zhitao Li wrote:
> > [You don't often get email from zhitao.li@smartx.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi, everyone,
> >
> > - Facts:
> > I have a remote NFS export and I mount the same export on two
> > different directories in my OS with the same options. There is an
> > inflight IO under one mounted directory. And then I unmount another
> > mounted directory with force. The inflight IO ends up with "Unknown
> > error 512", which is ERESTARTSYS.
> >
>
> All of the above is well known. That's because forced umount affects
> the entire filesystem. Why are you using it here in the first place? It
> is not intended for casual use.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

