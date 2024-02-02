Return-Path: <linux-kernel+bounces-50050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B48473B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079F91F2942F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C1146918;
	Fri,  2 Feb 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyUR9OT4"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0149C144612;
	Fri,  2 Feb 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889114; cv=none; b=Y8SEhgHrj1UrG+QlKQPsWMkOiBV4/ocAuQNiOgSti97ynJUAu7Btpk6MAehpJLw8PERvbBsVmQWIvQFpeTv3o2BZZF+vaUG2UqsEOB5gDwain9hwhT6XZj8mZqijHOUvCNr8LFC9VSwygZZC54z82lxgEa+qDEqMd6AdqKdG3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889114; c=relaxed/simple;
	bh=u62/JTjk2+l4AbxTmlSugZv8zdrDij9jIcMxmTQ3Cs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2Q6guC8vIEkYqeMEyWut46sbPFT9eSx9eRsQHf4VO0RxHym8d2d3c5/0/L+FwVAdpr3RBobOoQtBfLRP2LOBA+t88B7xiQgRE9GX4gWc1DxRge7tOOrMGZ5qKEiphm4oivIZXY8lnahJw465wTVusnIBb18KvDsZW2F4ZvUPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyUR9OT4; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c2f4c3282so10906286d6.3;
        Fri, 02 Feb 2024 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706889112; x=1707493912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjFTQhfyX4OpZ75eLCQsarAtUBHRYbyc/PAd9P4Y7CI=;
        b=OyUR9OT4w/TuRR1vUjSDfsYrkjacCh4Ud6K0piDSkhqBNlFzC9/C305eNPm2L74WFr
         6SlIXyp4t3psK6lvgUXsyY1JMpG64+cnQ+3Nct72E3dnNIcD8vl7ruLdG/Y245kjXIJQ
         yx6DtRAxGrZqzA9KYgbkIHrPKyXTO5K5vpr8S1D7a1MXAKxGFnSkdFOlVQTuuJG0cuGP
         08ftPKmUj7YzQbbi+vOIlQYVTn0MdWvSwnfvIFqIDA+st/2LXLsh//LyetxCcIxGFFBo
         YmIt9Rd0kJf0emsuARKy+yXAB6Ny5LlLmJgpTOxZ3JFR2EwFVufVKl6USPkc9qBM+JEy
         MZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889112; x=1707493912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjFTQhfyX4OpZ75eLCQsarAtUBHRYbyc/PAd9P4Y7CI=;
        b=oJsYihtzb7pXIOmtByWhk9KbWnlVwtdX163r66UXoaxvHYw9zd0xhL12EdZ9tPvTVN
         NtlQK/7emL5r6g2gpKCP1/SB0bSfdvx/cEi5ENyhlzCISMROxcyn5kuXWT4YYUQkg/gd
         HMz/8uK8JRKHlVwn0tPUouzI4Y8M4arlOwMf1XFaY+RR2qzU+IS/Cp85jAtTzfohdmD0
         ExYCWJnFUvlzqozIqT1k1TYKlJzENA5XcEp2HGLx5/9dlHcK4R345h7HJGRS7TdbWiso
         wslbMvc/pz8poUAXu7tQgsXdcYgMkj7OzV3fCvbIn6POE2K6sfptJiOiP3zDCS34uoDY
         gylw==
X-Gm-Message-State: AOJu0YxhnIYk07XkjbQWBS7kRpvyE4LI/Jrg9s8iWxXzW6qGw9uT9P6N
	dXQE4rVqa31UUYaWt3AlIt9WNTc+FZUewqAzPwEin4VagMiymCtq1sAMFxRwb4vqxtAuRSHrHJw
	4ZGbRGYq8wlY/4WifnPA+63C5jolWskOeT4Y=
X-Google-Smtp-Source: AGHT+IFUNcvFrtEeCkHxcUTQW9b1GdgYlbqRIehUQEHcaweXXXIXkS8cwExw7eL3LP5nnH+WGue4GtsNcAbNqRGPja0=
X-Received: by 2002:a0c:f1cd:0:b0:68c:8ac3:2acb with SMTP id
 u13-20020a0cf1cd000000b0068c8ac32acbmr842609qvl.41.1706889111860; Fri, 02 Feb
 2024 07:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com> <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
 <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com> <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
 <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com> <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
 <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com> <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
 <11abffea-15c5-4d13-9d0f-edbc54b09bf3@linux.ibm.com> <CAOQ4uxjZ6p9+H54G0LNTUnU56WRaoLtWOUj2nOaKJ4JvBGqLVg@mail.gmail.com>
 <427ce381-73fa-48f9-8e18-77e23813b918@linux.ibm.com>
In-Reply-To: <427ce381-73fa-48f9-8e18-77e23813b918@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 17:51:40 +0200
Message-ID: <CAOQ4uxggqa7j0NS1MN3KSvF_qG1FMVmFxacEYSTx+LuvuosJ5g@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:59=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
>
>
> On 2/2/24 04:24, Amir Goldstein wrote:
> > On Thu, Feb 1, 2024 at 10:35=E2=80=AFPM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
>
> >
> >>
> >> and your suggested change to this patch :
> >>
> >> -       struct inode *inode =3D d_real_inode(dentry);
> >> +       struct inode *inode =3D d_inode(d_real(dentry, false));;
> >>
> >
> > In the new version I change the API to use an enum instead of bool, e.g=
:
> >
> >         struct inode *inode =3D d_inode(d_real(dentry, D_REAL_METADATA)=
);
>
> Thanks. I will use it.
>
> >
> > This catches in build time and in run time, callers that were not conve=
rted
> > to the new API.
> >
> >> The test cases are now passing with and without metacopy enabled. Yay!
> >
> > Too soon to be happy.
> > I guess you are missing a test for the following case:
> > 1. file was meta copied up (change is detected)
> > 2. the lower file that contains the data is being changed (change is
> > not detected)
>
> Right. Though it seems there's something wrong with overlayfs as well
> after appending a byte to the file on the lower.
>
> -rwxr-xr-x    1 0        0               25 Feb  2 14:55
> /ext4.mount/lower/test_rsa_portable2
> -rwxr-xr-x    1 0        0               24 Feb  2 14:55
> /ext4.mount/overlay/test_rsa_portable2
> bb16aa5350bcc8863da1a873c846fec9281842d9
> /ext4.mount/lower/test_rsa_portable2
> bb16aa5350bcc8863da1a873c846fec9281842d9
> /ext4.mount/overlay/test_rsa_portable2
>
> We have a hash collision on a file with 24 bytes and the underlying one
> with 25 byte. (-;  :-)

https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-fi=
lesystems

If you modify the lower file underneath overlayfs, you get no
guarantee from overlayfs about expected results.

This makes your work more challenging.

Thanks,
Amir.

