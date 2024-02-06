Return-Path: <linux-kernel+bounces-55631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020B84BF46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E02F288F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA21BC20;
	Tue,  6 Feb 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOWrY5b4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CCC1B948;
	Tue,  6 Feb 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255308; cv=none; b=KgEJYEufEyMQH5S5Is56YaGWKpx6ASnA7+GdVh5kNI0o93MRNRZc1osUNcMDq3FJHmBjk3JsgmdXiwB5m4Nq7w9b507rngHqN4WsvWlSzjEHlEJ9tbPoR3PHEI1JlOYVfRNY3fdH68Z4IvC9mKBFBbnLUZHpuvxvSI+unjFfScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255308; c=relaxed/simple;
	bh=rr/hPIdz9YF1upX8c63vIbNM3CVYYgvg2FMo79z6LIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiD5xnZabDUFJAMlGS97LltX3wkhbr4gxfflbFFnPaC3889wg3q86QyCo2NbLFxisbA/6BA/uDBGKRpSgXEuaATsIELKtYy+9g0wYnsqaZ1oisRZyyQDsNRYVmrMzvq4pSFANa+6YtenNT3qUFj3hmtUdI3yBebfTckkZVjylbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOWrY5b4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5791C433C7;
	Tue,  6 Feb 2024 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707255307;
	bh=rr/hPIdz9YF1upX8c63vIbNM3CVYYgvg2FMo79z6LIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GOWrY5b47iT4mKzyDPHR0JRz6J5EsBcjLr+v3Fg08Skw9EGIs+0EiX+i9TrvdpHjU
	 L46hYS6kKoWK5FqbJXUIyLRILcam3f+VXrV5J27laeqT9QBQFCEZAnvABFZqIb6kVU
	 gejg9/GP6HfKCC+FUEzO1RPScf8W0/4wXkiaS3pAde8JqKK8xDUpNLbcfilBV3ghAN
	 YGKNvH1EFXi903Rho4gGFyFGB1Fu+uhgKCW+m96gK5O/fqCA51/BThqK4/iyTgFijb
	 jfvURDF2X7e626aY1GOvoCAx7b/MVgbTNvxYeHXu3CpCuzXZObak2aPbSltiaTKR34
	 AA4jkbovPE1Yw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so42885061fa.2;
        Tue, 06 Feb 2024 13:35:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWJ8/woEsXreperR9l5gJtOpe6A/Sbx3JlQU8jBiuwje+uq4unto4pfOKmdC8PoxwaQOzn9Rwm68dFS/UInxkUB81ZmF4rEnA9vXBcvAc4jwL0ITDZEdppiqq13dnKoWMN+lGjMBArWBe1IZJONus4InWGsSWJh7kkieiAZUkEEA==
X-Gm-Message-State: AOJu0YwAwxIFUtragEGKeap8Y2dILyQ9RSMLn5Bn0s7rzLlGEXK92UwL
	6Qp6ZmOsFDO+1fB+S5g5BV6yUjEZBMkTSJgpNKutAQYooWzuyVbOl8PFtRdZzTTtwB6c1btu86b
	xwQikvjXsrKFk0WHKGDotMDwR8Ko=
X-Google-Smtp-Source: AGHT+IFJboM11eyd2PkiAbygfHEoplzf1OwRSWc3+GsFaWo0jhHhq+xVPwCk62oL4zOKSy2ecMKHle5Bc1xBjANbGuY=
X-Received: by 2002:a2e:9b1a:0:b0:2d0:b2ce:a90f with SMTP id
 u26-20020a2e9b1a000000b002d0b2cea90fmr2595937lji.43.1707255306080; Tue, 06
 Feb 2024 13:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW58VdmZwigxP6t_fstkSDb34GB9+gTM0Sziet=n17HzQg@mail.gmail.com>
 <20240206205600.20788-1-dan@danm.net>
In-Reply-To: <20240206205600.20788-1-dan@danm.net>
From: Song Liu <song@kernel.org>
Date: Tue, 6 Feb 2024 13:34:54 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4n_=yL8PLj88x6ozFpUPmuayCiqCgtUYBQXrE70ivHbQ@mail.gmail.com>
Message-ID: <CAPhsuW4n_=yL8PLj88x6ozFpUPmuayCiqCgtUYBQXrE70ivHbQ@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, junxiao.bi@oracle.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:56=E2=80=AFPM Dan Moulding <dan@danm.net> wrote:
>
> > Dan, could you please run the test on this branch
> > (83cbdaf61b1ab9cdaa0321eeea734bc70ca069c8)?
>
> I'm sorry to report that I can still reproduce the problem running the
> kernel built from the md-6.9 branch (83cbdaf61b1a).
>
> But the only commit I see on that branch that's not in master and
> touches raid5.c is this one:
>
>     test@sysrescue:~/src/linux$ git log master..song/md-6.9 drivers/md/ra=
id5.c
>     commit 61c90765e131e63ead773b9b99167415e246a945
>     Author: Yu Kuai <yukuai3@huawei.com>
>     Date:   Thu Dec 28 20:55:51 2023 +0800
>
>         md: remove redundant check of 'mddev->sync_thread'
>
> Is that expected, or were you expecting additional fixes to be in there?

I don't expect that commit to fix the issue. It is expected to be merged to
master in the next merge window. I am curious why I cannot reproduce
the issue. Let me try more..

Thanks,
Song

