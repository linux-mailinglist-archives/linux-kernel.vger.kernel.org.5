Return-Path: <linux-kernel+bounces-80467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908828668BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10A31C2168A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBF13AE2;
	Mon, 26 Feb 2024 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmKKdgaO"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9C817
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708917955; cv=none; b=BLDjT0bGNDWv6EqXpBY9NjhrXcnngsjCZHIgJeioc8g54HsQMZ3QchMg9pknnMG/RqWoBGoylrC3Zlh/4gqjVFcg3mMZ4aoL4r1Nwwrk4FwtUUnEhgH1DGqjPSxfqpQCiuHOZGahYElJKOgefQ9FTU0Kwd8W8luIkt7j9PqFawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708917955; c=relaxed/simple;
	bh=duT572XOOEkkBhzaW7HcX6gYMtYqbYqQiUV3SLf49tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL9FDEwtwohrIButeRaVj2rFSvlcTIu8HNMQaI1THmGBchu1vVLNwNMLVHi36aX7DOGs7t/B69mA6LwODUtF46NeFprYvhNC4BLkwmAEOa6t2OskdvUOKu+dZijt+51j1otnp5EsEoYGGcjslPq3QnCF8w3EZh+TaAXzvftqiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmKKdgaO; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso2443569a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708917952; x=1709522752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv+mmadT0JQ+7Y3ValYOoMlPEhfNnmPZVmHayZdTOLM=;
        b=XmKKdgaOnWGloUpkG/jg8kIqJTF3YeYydSeiMBw4UwlLNebPF+BAO7KcoUcY3evR/9
         Uu4siqcIVGp2HsfZ9fFkXTUdv8DHcVWpP477YFBySeOsllo3hsRQ1L930M1kBlg9V8bD
         +GjlEJQQe3nkH66hqzkNI/NGGuAnt/hrlYy171zCnxggwhuh0Wsd16p9VOvLYeGabgzZ
         AyVsloydlLXPE/T6VgXcW68wI5qqAMI9urCbivlQrFhtBH1vRJb/EJrC4spWtUo08cJn
         Y3a5c8v+0RjP29nBwys70XROmrWkEJvGCwhI9p/xxt/2KD1BiyqtGeCalZhf6hKGJv07
         gnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708917952; x=1709522752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv+mmadT0JQ+7Y3ValYOoMlPEhfNnmPZVmHayZdTOLM=;
        b=hUfxka+vmpa1jFK1j8zDwzgzAkpWuzmn8n3b5FOWDWa4/UQLvlbaz/pT6feXaOB7YX
         lMsjwK4Q+ArgIJuzPZSAG5oY8Xp82/gPB57nvvFL/1r+EVGvFi66we2S8/XzA6pZmyGm
         qabg2ekUPhMHR0LJG6DjHsWjEsZy7cHeA8FCSTKWlE8dlO7yek2w4XiwKlZjaysZiSt1
         aMYK6AbwZuLHN01/gOcBhSkO0t7I2yxtTIith4l5OahhjvYFtaWcO4BGsbz7zQ3Gdetq
         Yddv0lZH6XnmEvk6rGOYy7jqApMmK8j4Co9ZPx2DZk6a3t4Q3SqDi8fkuG6hFB5ZYC5q
         IeuA==
X-Forwarded-Encrypted: i=1; AJvYcCW4zA4y/rA5xHdloasDMVS5pHby4aGJR1BTf7k+ieVkOznuCEVDOSVRMsb9/3r/2VmMHW42UxYaR0K5Os0uQZgUVbyGO8g5TcpGkdY5
X-Gm-Message-State: AOJu0YyE+/VtjpQ1cI3Y7QLOvsnAZLDxMD/LrhRQX5Ju3Jj3D6yavOES
	mWtshQKz9Wpa6ZDLuaTVeNyKRghklvlGrRjOR+IgYM/X9XIT/t8tF0ZrqS+JuI+GE5L5QNzUWNf
	xSjoYgywY2zs8L8rNqnP+VQtDrYY=
X-Google-Smtp-Source: AGHT+IFi4b/hbrcnzky8HJU7iITztodUBp5pYxopxYUYWyt65hJ2g5BsxCmiTqKPPsnbj2h4HpymNMadRQbdybaRrPw=
X-Received: by 2002:aa7:d5d5:0:b0:564:3392:e9db with SMTP id
 d21-20020aa7d5d5000000b005643392e9dbmr3387824eds.33.1708917951542; Sun, 25
 Feb 2024 19:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org> <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
 <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org>
In-Reply-To: <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 26 Feb 2024 11:25:40 +0800
Message-ID: <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Chao,

On Fri, Feb 23, 2024 at 10:38=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/2/23 10:01, Zhiguo Niu wrote:
> >
> >
> > On Thu, Feb 22, 2024 at 8:30=E2=80=AFPM Chao Yu <chao@kernel.org <mailt=
o:chao@kernel.org>> wrote:
> >
> >     On 2024/2/7 10:01, Zhiguo Niu wrote:
> >      > A panic issue happened in a reboot test in small capacity device
> >      > as following:
> >      > 1.The device size is 64MB, and main area has 24 segments, and
> >      > CONFIG_F2FS_CHECK_FS is not enabled.
> >      > 2.There is no any free segments left shown in free_segmap_info,
> >      > then another write request cause get_new_segment get a out-of-bo=
und
> >      > segment with segno 24.
> >      > 3.panic happen in update_sit_entry because access invalid bitmap
> >      > pointer.
> >
> >     Zhiguo,
> >
> >     Can you please try below patch to see whether it can fix your probl=
em?
> >
> >     https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-ch=
ao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121851.8831=
41-3-chao@kernel.org>
> >
> >     Thanks,
> >
> >
> > Dear Chao,
> > I need to coordinate the testing resources. The previous testing has be=
en stopped because it was fixed with the current patch. In addition, this r=
equires stability testing to reproduce, so it will take a certain amount of=
 time. If there is any situation, I will tell you in time.
>
> Zhiguo, thank you!

We tested this patch  this weekend on the previous version with
problem, and it can not reproduce panic issues,
so this patch should fix the original issue.
thanks=EF=BC=81

>
> BTW, I've tested this patch for a while, and it looks there is no issue w=
/
> FAULT_NO_SEGMENT fault injection is on.
>
> > btw, Why can=E2=80=99t I see this patch on your branch^^?
> > https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=
=3Ddev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git=
/log/?h=3Ddev-test>
>
> Too lazy to push patches in time, will do it in this weekend. :P
>
> > thanks=EF=BC=81
> >
> >
> >      >
> >      > More detail shown in following patch sets.
> >      > The three patches are splited here because the modifications are
> >      > relatively independent and more readable.
> >      >
> >      > ---
> >      > Changes of v2: stop checkpoint when get a out-of-bound segment
> >      > ---
> >      >
> >      > Zhiguo Niu (4):
> >      >    f2fs: correct counting methods of free_segments in __set_inus=
e
> >      >    f2fs: fix panic issue in update_sit_entry
> >      >    f2fs: enhance judgment conditions of GET_SEGNO
> >      >    f2fs: stop checkpoint when get a out-of-bounds segment
> >      >
> >      >   fs/f2fs/file.c          |  7 ++++++-
> >      >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
> >      >   fs/f2fs/segment.h       |  7 ++++---
> >      >   include/linux/f2fs_fs.h |  1 +
> >      >   4 files changed, 27 insertions(+), 9 deletions(-)
> >      >
> >

