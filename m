Return-Path: <linux-kernel+bounces-128657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3E2895D95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ED01C2243A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58A715D5C7;
	Tue,  2 Apr 2024 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CW9yCGB4"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0615D5AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089705; cv=none; b=Ul2U9y/tPB7l2e9+re6myE/aE8OfTCaux6+Tys8v1QeduHMRZpMNpo7RuyjE8RVKALj934bW9i5Jy6JDMY7NSDnPkrVzwr2sU1EzdgAGwLrP30GOxQ4Og50myofAHUGiQtlkx/5+w+HqdwVRAKNMdUue46VFf8pMpQ6is+nLbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089705; c=relaxed/simple;
	bh=LfVYX8aS+uGvfYiFPza5xfpJggy3wA1TMy/HX9tJed4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ+JjT5SLIw1c4OX4+xNK9lzD2uvcthyp6gg4RlsPd7tIXlL47/Jv+7tixico6IDvaII1CVT8MQo52gi9wMOyzW0WRqimbAgJ+cAunX6RU6KiD/1DRl5mHWu+tZwwLnaFyfdn5Yn2iV+hj3CbR0oDLn1pkVcwOl2M2ZYXJgUoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CW9yCGB4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6144369599bso32702627b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712089702; x=1712694502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=CW9yCGB4NsT7Ls+jy9a6DbYdVWYC6HEPWhP+LRjpxT8xZbfmT/2MlJpXWm41hFvCdP
         zJcJJbaBAJUmVDzLx+hbesZBDJqjxEXn44gC0Jz6qf5Q1jK9t7SmMdIWQtYqGGSg6nTt
         hwsNtV1wVZp12mAgDmTDKqNY/9b/yc+RBs82dlEuWi5kyKpFqVzlmrnUqznGfzPQ/XU8
         ntcMqkXDQamfcIVrut1I+Siwehow7GjMTqsb50uULbCq0hX9vWVPwwhvE3vqZJ2UU+hZ
         wlpdv5vqjuG+5w4Tik6p1gB66uVC+iXGqaJAmKZVpCoep2DV72fT3+g61GehW+I14v7W
         F4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089702; x=1712694502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoSv33fHX+PiwFO/k1mr+DGe32nj0k4cYvUK0De9J/g=;
        b=bquPeLB468wEZf1+PJCuGn+a/7kCx/geWa9VOWZb+M83gKkdUEgXF4jSy4uhEucTyR
         SXvTt9e6id1Ilw6cpPMDOqu6Vqpgvk3ubf2fzVSDjAmSSm1rTQ5fcrtPA2f+gLgM1Rsf
         O0ljlTr02OLyo9VC1BtITNJ/F5+OJPhuldwbzGIOnGmFhc5wHVmo8atW/4p1jnIMWjaa
         /TBUcnIj3+tskZqxPIQ3pEsDrkLfWAEg6/2rL49bvZUlUPpb2M7aF+XGW3Lq7Ojkkf7c
         MBQXvSjanwmUHQhejohmjqKSGUOFcalNMJ2npmGeKRe7krG6q40KywK4gYgBOMxpw/z9
         5dlA==
X-Forwarded-Encrypted: i=1; AJvYcCUwXiZuATq8dBZAPv6YnqDBsYXPm9vzO6gWpf3BT2G9rF5zgqR4/DaMSh41XhFGdCfhfVSj9OcAqhgWp2RhoF68Zc4gAbk8vHUvB24k
X-Gm-Message-State: AOJu0YwDBQ9MexQ1ZBJ24yFaE/+X49ox7ejEhCle//iZkFOCF0ASfa+H
	RCBOcSn+8X27l2PR8YKV/rzSSyPmkJZf15lNYv5QSrGUZ4dyBfRBzT3Z+AiJ6doLWMwB5Mwgmra
	QILmjJGSptPYq2ZJH57fYSTU4eUfGBdRAMEkc
X-Google-Smtp-Source: AGHT+IEVBN+nZl8MKEmvtUo5GMbK7xeKkzls5qXpx0s2OutO7Jvpps2qS6SsUR1HM2jxzRpzT7CFKW3Wf3o/srFXHhw=
X-Received: by 2002:a81:5342:0:b0:611:2eb4:2402 with SMTP id
 h63-20020a815342000000b006112eb42402mr12634897ywb.21.1712089702684; Tue, 02
 Apr 2024 13:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
 <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com> <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
In-Reply-To: <CAHC9VhTt71JUeef5W8LCASKoH8DvstJr+kEZn2wqOaBGSiiprw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Apr 2024 16:28:12 -0400
Message-ID: <CAHC9VhSt0GkTe8ho2yyP8Bp1rbtiFbp6dNY6m93cvBXJ=aKtSQ@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 4:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Apr 2, 2024 at 3:39=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
>
> ...
>
> > But if we really want to do this ("if mknod creates a positive dentry,
> > I won't see it in lookup, so I want to appraise it now"), then we
> > should just deal with this in the generic layer with some hack like
> > this:
> >
> >   --- a/security/security.c
> >   +++ b/security/security.c
> >   @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
> >     */
> >    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry=
 *dentry)
> >    {
> >   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> >   +     struct inode *inode =3D d_backing_inode(dentry);
> >   +     if (unlikely(!inode || IS_PRIVATE(inode)))
> >                 return;
> >         call_void_hook(path_post_mknod, idmap, dentry);
> >    }
>
> Other than your snippet wrapping both the inode/NULL and
> inode/IS_PRIVATE checks with an unlikely(), that's what Roberto
> submitted (his patch only wrapped the inode/IS_PRIVATE with unlikely).

Nevermind, I missed the obvious OR / AND diff ... sorry for the noise.

--=20
paul-moore.com

