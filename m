Return-Path: <linux-kernel+bounces-104389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929587CD24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6959B1C21921
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DAD1C29B;
	Fri, 15 Mar 2024 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMLnLRu1"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEF1BF44
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505184; cv=none; b=QWXNT6wkN28kFocewXQAq3FGSnkskJWfXqZyVOjtRXKbaJaOMrIKQNa9oBs6veiLjZ332juK16y7d9Ni/X40KKap2xkFyya7wnGbd5/+RzX8czrVKHEepeQVI2dR+yGPDMiYpAwgxH1FQpOrgeyuGnSBTpHAetFMxXgf5hXtoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505184; c=relaxed/simple;
	bh=QyQptOt/A2+N+1FcbXKs6QUV1qHpAqBCMfYtR9NPPuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DihB2MagnTwTtkJ3SATiDfpwo1LBXkbDaRh1/cOzBsUNwbor6v0jNMISrj2EyHGyjAMCaPmuanbHerUlzepv1kZbSov7RyVKuJ2QBnEkXQSdAorfojKsZc9GEFSCMGm5KsvjQbSr6TlxRe0uyzQdK6ar0bQc448JsxY9Wi+Aq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMLnLRu1; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso1741439276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710505181; x=1711109981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyQptOt/A2+N+1FcbXKs6QUV1qHpAqBCMfYtR9NPPuU=;
        b=mMLnLRu185j2dD6BbZrKE9+r8duEvnkypngwZaxQCeV97cXeKJQfFbFIDqQ1BQNG5e
         MTvTaJoi8m74bte7eklqmMHTTv9ow5teggjdtV1cVe1dx7U9ympjQPWHz5I6cEDS1KLt
         Je5nCDK5bI/+0VSuO03SlYG9CHDEpBpSLG0UW4oKXcKpd8PSN7N9uz7fPIq/zTHvWK93
         f6oWyCfxU24wQHsHbhuCHtVfDwE5MK4inOdSvLI9kPih5kBnj5d/Kbcl5rH33HLf7REW
         Rz9CkAwtPmf0AznkMMg/Z5u8otClPt8nFdKajplft+jXm3emyLjo/2jFxIG0fQSEeKYv
         BMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710505181; x=1711109981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyQptOt/A2+N+1FcbXKs6QUV1qHpAqBCMfYtR9NPPuU=;
        b=oWqUFr5Wiop8YbIJmlcvfw8XFmb5tTbQiFjnqZVIXVZwTLpyC2VuG1mC9mJVG2KjKt
         kT99GPwvOgUscLAKl6qQKjF8dv3uLetCvhySLeE5+JBScCvdAOAz8VgQrbUfv2axBUqr
         mNYxNlDKqldN0vu+iYxmtyy3VDEtDpL0qSlSH74hpOp0gV4Sk3ZsWTfp+GiTQz1fqfDj
         Nn8c/+KXksRRIzCiKIocObyPPQD8T0zvOWQErQW3AiDs3oJVCAiWGPW7dHoYz/qjdegN
         nug6/aL5XeBOkarpFt5FJPN4iRLxKEfnexN5F8gNlBkWCml2yTmJZSe5k4JJzMjmsu41
         Bppg==
X-Forwarded-Encrypted: i=1; AJvYcCUzxI2OW58mXI/EglMud1CcGrif0WJt7qDS0Ck4RcLxKGpgZ1RA0joq+yIEkjI6hdS5hdiwavm8VHZjunXiQ0IQAKuWh6CwdjWbPVeH
X-Gm-Message-State: AOJu0YzShmklwDSvl1DuwqbORW/RY7QCU8Y2kcU4TyIvCY3jcWqdpLrT
	W6QU3MirSIdF1x8OD4TUqvoVxKkerhz0skWg4Yjzf2wc8TX8imcli+0S+OZLZ3roHwNbf9XLyYk
	dZFUZD8Iq6asrEzGYCoEdEVob/JY=
X-Google-Smtp-Source: AGHT+IFnnmzqQgVEPIQh1LiikkCiallcR8WNikpr0/DAgKIkVU3t8SMYkDr8CIa9XHE0fFSJIC3rmUuLZz3rj48MIxA=
X-Received: by 2002:a25:8412:0:b0:dcd:4878:1f9 with SMTP id
 u18-20020a258412000000b00dcd487801f9mr1833473ybk.8.1710505181541; Fri, 15 Mar
 2024 05:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315075946.587679-1-dqfext@gmail.com> <ff19df82-3fd4-9098-667c-0502b2452334@huawei.com>
In-Reply-To: <ff19df82-3fd4-9098-667c-0502b2452334@huawei.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Fri, 15 Mar 2024 20:19:30 +0800
Message-ID: <CALW65jbKBUDN8ybE1oqrNW5VK1QGpZ1RmnFCCzxjQCo4obaA4A@mail.gmail.com>
Subject: Re: [RFC PATCH] jffs2: fix recursive fs_reclaim deadlock
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhihao,

On Fri, Mar 15, 2024 at 7:19=E2=80=AFPM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
> I think it's a false positive warning. Jffs2 is trying to get root inode
> in process '#1', which means that the filesystem is not mounted
> yet(Because d_make_root is after jffs2_iget(sb,1), there is no way to
> access other inodes.), so it is impossible that jffs2 inode is being
> evicted in '#0'.
>

You're right that process '#1' is getting the root inode. However,
lockdep only records the stack of the first unique lock ordering (see
https://docs.kernel.org/locking/lockdep-design.html#performance ), and
there are many occasions where GFP_KERNEL is used inside a
jffs2_inode_info::sem 's critical section.

