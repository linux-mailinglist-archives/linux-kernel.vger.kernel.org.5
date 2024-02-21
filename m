Return-Path: <linux-kernel+bounces-74369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDD85D322
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D2281B02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2E3D0B8;
	Wed, 21 Feb 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmOr2RZr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A313CF7C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506559; cv=none; b=H4ThRh01QvRFRoaQw7+ehdQcM+dIMDbq4gfAw0NHkTbENuItrdvFBEkMwj3Q7DZgWUazGzsCytvZvZha2Srws6o+nFLYz4/uFZTvMSdSIq7T46xEO6HGHzr4MHf1jyGZoCOL95FyXcJ0PlWzrWLQ1LkijQxKWEwkNKtZZ5t1AhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506559; c=relaxed/simple;
	bh=V50MhbAgj2t3eQ135zh2KbHdZLfImkdzrOqAzzel4fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4CrezdpvNlfO24+XUErHaM7uNr+V9tOMjgejnemyTkHY4PJUuWjowDLEzBbpJHw04G4/i3PmfWZ/Dppg21grjOLbNEg0+K++vNJUQsJ2Y2zTeNPoU21S2QKa1WoZE1+6fj988n9VmaM2ikMdChizA5WhVr/q+GCDrDUyzJR0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmOr2RZr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708506556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPz9Oee+mZmEKXhpJGWHPYtgekfSz/q0/tUQoxs5oro=;
	b=VmOr2RZreNRxX0NaKh3gbuY+qu563r30/fXAoPBo4wgOIrqrfmBtF56Jd+2QUHOcxFkZuK
	jk5KiaLLSMdL6g4BFMydWh/yect7Rjuc7T0axgPqsXtMWOB2BLaJ+2FqQKt/Qa4zs8tsT1
	uGKFL9HSKO+fLD854MAfWAWetd13jRs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-LPeOm3JJPi2AxzLqRyPJGA-1; Wed, 21 Feb 2024 04:09:15 -0500
X-MC-Unique: LPeOm3JJPi2AxzLqRyPJGA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41252993d8dso21654445e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708506552; x=1709111352;
        h=content-transfer-encoding:content-language:user-agent:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPz9Oee+mZmEKXhpJGWHPYtgekfSz/q0/tUQoxs5oro=;
        b=n9J+jO5Q67Cpp3vklHsa+sBtwCeC/k21f628B5M9YDZPH5y9713HghtnF1preZ1dIo
         35ptEVRJF1MF08X8YXQ6iFt5ZdiT+QwYuRvhD5vtnz9fnZxQRb8OCKfdYWKXPL/e7SQS
         nNDnJSEniIGQtJRMJJMglGSm/RIGeyeQU1/v1Oe1AQV4ILQWklowGoVY1USTFkA+caex
         8edWmUKSq+i8iegTS6YfE96wGsLG5jj80qEZgLV9GxBVaAt4iReEinSw30s7ei0oiQe3
         E9BsVZkBc3aygbykW/jhUkYrDtyaxzbT21RT5VwJnv1xhV1NBGFT0c8p0ybUrqxalR+M
         6E2w==
X-Forwarded-Encrypted: i=1; AJvYcCWhg1MMwVfyIXPMl1a3f/C++h9dUpzS06VI4Q+tyQxqEtlr1QHlRJaClZpPFuk8aYLXbCHEWV5HvH8r/V910dt9auCn3UGCToL2fjVn
X-Gm-Message-State: AOJu0YzL9rt6R3zqrD3h3qbXwD4IAqMAFtxV8r+TO+tkxdFpm82ZyXgW
	fYifCfHzZkpRIJkkP58hECjd6KdjRhLu/qEbPqmkB2DyvR/HE6hkyajboqlS/Dg4fddX1p8XSCJ
	8pmqwkaakuhLnQ1TuxgbqABj2t+i2tOhRxbsHNdVKE3JPpjU5JG+rK97sf3BOmQ==
X-Received: by 2002:a05:600c:1f81:b0:410:4a4:6cd0 with SMTP id je1-20020a05600c1f8100b0041004a46cd0mr13050990wmb.33.1708506552651;
        Wed, 21 Feb 2024 01:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAUkX8pBjEQRaeJbALwoXAbqwDbZC3snk7QBB66U9jz7fMcYKW69xFignKnSxq0ab2yc3exg==
X-Received: by 2002:a05:600c:1f81:b0:410:4a4:6cd0 with SMTP id je1-20020a05600c1f8100b0041004a46cd0mr13050968wmb.33.1708506552152;
        Wed, 21 Feb 2024 01:09:12 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b004124219a8c9sm17166240wmq.32.2024.02.21.01.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:09:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: cve@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d" [resend]
Date: Wed, 21 Feb 2024 10:09:05 +0100
Message-ID: <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024022009-subsoil-halt-4b28@gregkh>
References: <2024022009-subsoil-halt-4b28@gregkh>
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id p24-20020a05600c1d9800b0041273e84fe1sm1936094wms.25.2024.02.21.01.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 01:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Resending with LKML in Cc, since posting to the linux-cve-announce=0D
mailing list is restricted to moderators.=0D
=0D
On 2/20/24 19:34, Greg Kroah-Hartman wrote:=0D
> Description=0D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
>=0D
> In the Linux kernel, the following vulnerability has been resolved:=0D
>=0D
> Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"=0D
>=0D
> This reverts commit 5e2cf333b7bd5d3e62595a44d598a254c697cd74.=0D
>=0D
> That commit introduced the following race and can cause system hung.=0D
>=0D
>   md_write_start:             raid5d:=0D
>   // mddev->in_sync =3D=3D 1=0D
>   set "MD_SB_CHANGE_PENDING"=0D
>                              // running before md_write_start wakeup it=0D
>                               waiting "MD_SB_CHANGE_PENDING" cleared=0D
>                               >>>>>>>>> hung=0D
>   wakeup mddev->thread=0D
>   ...=0D
>   waiting "MD_SB_CHANGE_PENDING" cleared=0D
>   >>>> hung, raid5d should clear this flag=0D
>   but get hung by same flag.=0D
>=0D
> The issue reverted commit fixing is fixed by last patch in a new way.=0D
=0D
Sometimes less than optimal descriptions end up even in Linux commit=0D
messages, and I understand that you're "not going to be adding anything=0D
additional to the report" other than the git commit message. [1]  But=0D
this description is not just "suboptimal" English, it also makes zero=0D
sense since it refers to a "last patch" that does not exist.=0D
=0D
There are dozens of distros, both commercial and non-commercial, whose=0D
users need a *real* description of what is being fixed.  By writing CVE=0D
descriptions that make no sense, you're creating more work for everyone=0D
involved, without putting in place a process to clarify these things=0D
except through "the maintainers of the relevant subsystem=0D
affected"---who are not CC'd to these messages and therefore might not=0D
even know that the CVE announcement exists.=0D
=0D
My suggestion is to CC the author of the fix and the maintainer, and if=0D
possible even go through a pre-verification phase similar to what's done=0D
for AUTOSEL patches.  If some commit messages are irredeemable, or some=0D
situations are just too complex, and no one is willing to put the work=0D
that's required to do the work properly, the maintainer should have the=0D
possibility to NACK the creation of an unusable CVE entry like this one.=0D
=0D
(Somewhat related to this, how are you going to handle patch=0D
dependencies?  Sasha's GSD updates has a separate entry for each commit,=0D
the result being "vulnerabilities" with "no functional change" in their=0D
description.  Are they instead going to be rolled into a single entry=0D
like this one now that you're actually creating CVEs?)=0D
=0D
I am cautiously optimistic that this can be worked out and I agree with=0D
you that lots of bug fixes going into stable have potential security=0D
impact.  But as this example shows, there's still more than a few kinks=0D
to be ironed out.=0D
=0D
> The Linux kernel CVE team has assigned CVE-2023-52437 to this issue.=0D
>=0D
>=0D
> Affected and fixed versions=0D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0D
>=0D
> 	Issue introduced in 5.15.75 with commit 9e86dffd0b02 and fixed in 5.15.1=
48 with commit 84c39986fe6d=0D
> 	Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.1.74 wit=
h commit bed0acf330b2=0D
> 	Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.1.75 wit=
h commit cfa468382858=0D
> 	Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.6.13 wit=
h commit e16a0bbdb7e5=0D
> 	Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.6.14 wit=
h commit aab69ef76970=0D
> 	Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.7.1 with=
 commit 0de40f76d567=0D
> 	Issue introduced in 6.1 with commit 5e2cf333b7bd and fixed in 6.7.2 with=
 commit 87165c64fe1a=0D
=0D
So which one is it of these 6.{1,6,7}.y releases that fixed the issue?=0D
=0D
> The Linux kernel CVE team recommends that you update to the latest=0D
> stable kernel version for this, and many other bugfixes.  Individual=0D
> changes are never tested alone, but rather are part of a larger kernel=0D
> release.  Cherry-picking individual commits is not recommended or=0D
> supported by the Linux kernel community at all.  If however, updating to=
=0D
> the latest release is impossible, the individual changes to resolve this=
=0D
> issue can be found at these commits:=0D
> 	https://git.kernel.org/stable/c/84c39986fe6dd77aa15f08712339f5d4eb7dbe27=
=0D
> 	https://git.kernel.org/stable/c/bed0acf330b2c50c688f6d9cfbcac2aa57a8e613=
=0D
> 	https://git.kernel.org/stable/c/cfa46838285814c3a27faacf7357f0a65bb5d152=
=0D
> 	https://git.kernel.org/stable/c/e16a0bbdb7e590a6607b0d82915add738c03c069=
=0D
> 	https://git.kernel.org/stable/c/aab69ef769707ad987ff905d79e0bd6591812580=
=0D
> 	https://git.kernel.org/stable/c/0de40f76d567133b871cd6ad46bb87afbce46983=
=0D
> 	https://git.kernel.org/stable/c/87165c64fe1a98bbab7280c58df3c83be2c98478=
=0D
> 	https://git.kernel.org/stable/c/bed9e27baf52a09b7ba2a3714f1e24e17ced386d=
=0D
=0D
Half of these are reverting the revert.  I understand that=0D
"cherry-picking individual commits is not recommended" but it looks like=0D
this is a bug in whatever scripts you are using.  Are they public, so=0D
that fixes can be developed in the open?=0D
=0D
Also, commit 87165c64fe1a9 (the revert of the revert) was marked 5.19+=0D
but 5.15.148 does have the original revert.  Does that mean that 5.15.148=0D
still has the "issue with raid5 with journal device" (another hang, see=0D
https://lore.kernel.org/linux-raid/20240123005700.9302-1-dan@danm.net/)=0D
mentioned in the commit message for 87165c64fe1a9?  If so, that=0D
contradicts the fact that updating to the latest release of a given LTS=0D
branch is the best course of action, since for some users 5.15.147 might=0D
be better than 5.15.148.=0D
=0D
Paolo=0D
=0D
[1] https://lwn.net/ml/linux-kernel/2024021518-stature-frightful-e7fc@gregk=
h/=0D
[2] https://lwn.net/ml/linux-kernel/2024021430-blanching-spotter-c7c8@gregk=
h/=0D
=0D


