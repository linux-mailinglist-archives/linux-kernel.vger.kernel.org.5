Return-Path: <linux-kernel+bounces-137317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F57589E055
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE31728CFA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C2B13956C;
	Tue,  9 Apr 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="D1eoL9sd"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CD13E05D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679986; cv=none; b=Rni/c5uJYZlWI8/UYs111/W8wsjDUuI02eLmsxcTGsPctWB3+t7n51vn1n7/vvi3bWi7pz2WplSY+CRAOys3XTdm4vlONhntG6ahmiep3kAI3HvJamlvojdwKqDIdgYUpuLzAGH3LiwzptqoAuNLzdkxvLcrPP7LhTNWkzgtLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679986; c=relaxed/simple;
	bh=ulQ6PWJvV5PaX5ZxY16FXaf8ZFkz5DuHJFEVcGtM+6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btyOaPgNu3Kvx9X+rKFR0CI2EJ6tUuN5BK+mnkvS0M1+VavmWQHe2v2pTCYRHG5ZYG8iZSlxqf+jcrfTN8INkp9QNpht1bRUi6pV46cBjSJ1x1K6Pyj0tx3JYYquE31cuaoD9UBUNqZmLqdKzcsRH6Cu0O8re8L9/JtBE9gUVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=D1eoL9sd; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c60019eecaso333775b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1712679984; x=1713284784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty4BwWZvIxrkPVChPVI3LUwWVMwSnCumX0TJmcBbQqg=;
        b=D1eoL9sdbeCTTjuhoNLiRU28jbKKmRo+QJYJkTXgwQ28QKzKPNZh1+XYvqaby9A8Nv
         V1274Yu9opf77LLKZ/SuEFBDZ0rpmvHNxih6x2h8Vx7exTZFjRtAnByIpTE9IM6XK/yU
         m1Q3VdvhIQfYoY5bf85H/fYu5fhK6DuohFD98t9HMtK+oTbXZLLVbOdm/NreJg/Vd31j
         wuTaJtLJhZNQ3vDk4UDSDT53RE6Sx4w30KGRq3KjwB8EkHh1MkM0W2qiLXp+iROHQxtZ
         SbFpmynw2bbxYU+D9nHhtBgu99F1ooao5S2D/4zTcFsxYsZH4DSt3WZEfkY+v+g/sR8t
         2hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679984; x=1713284784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty4BwWZvIxrkPVChPVI3LUwWVMwSnCumX0TJmcBbQqg=;
        b=WVEPrdyVjxXTGqYP844HiJS4PGr1shqqJVe7EY9BI69rVZqWWOk1Xqqc2zHXjXKIVs
         oqkImDGt14Kj5GKc9zNYh6TYLAiyKI34fXNfSg9AZeBuwQxX3jcaGrhJB2/52kjmto25
         MWI0jWJFdYbueBNKRw/rBS8qOhDw4S+EW3k9z/npqzgGaOpQmC7i+9XODL0vytEmIeZb
         5Jmo4LrcBMAqRgo5vo7Bb6WQVUbLr5uHkWx2eMn0xIxbvd904ZRPyX6eFp4HY0zGpwrx
         K8SoDS+3VC2eOuL6ao4eBzrdJOLbE0B2+bdBGT12ij8zOqQlz+bv0IvbjSWnWPcsY2HQ
         ZX3w==
X-Forwarded-Encrypted: i=1; AJvYcCXiolyCHrYyzlkfIRO4TBaQDlrug7ljC3Yficy69jiBqmaKLoxdp074bDnpd0o6go9UZUYPvNz2r4XfvlTWrl4NUD1HxsG3RYRNPUBT
X-Gm-Message-State: AOJu0YxN5xgCIXoWsntfg+azz0jzdo0Wx1PV9WAzVnSeKghIZBFM0coE
	uOcU3saoIyBlhCof+UaSi4+vWfB/p8WkSoG+vZtjpL902CId4uZrAyCLldd/oXIwtl5Ib1fI119
	xsTttZQVVCUGkC/zMjer14bfEvFyDETUQbAkyuXKfnDm5TwG69g==
X-Google-Smtp-Source: AGHT+IGk9zeM/N1DPlYlaCC9lnhI09RgSyk5wLF389LHAoEWRcSGe8ivncZBC049o6kWoqphMSspeffsfT//EijA7Lc=
X-Received: by 2002:a05:6808:1a:b0:3c5:f51e:a0a1 with SMTP id
 u26-20020a056808001a00b003c5f51ea0a1mr6217029oic.51.1712679984020; Tue, 09
 Apr 2024 09:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408075052.3304511-1-arnd@kernel.org> <20240408143623.t4uj4dbewl4hyoar@quack3>
 <CAFhGd8ohK=tQ+_qBQF5iW10qoySWi6MsGNoL3diBGHsgsP+n_A@mail.gmail.com> <96b55a64-2bcf-44da-a728-ae54e2a73343@app.fastmail.com>
In-Reply-To: <96b55a64-2bcf-44da-a728-ae54e2a73343@app.fastmail.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 9 Apr 2024 12:26:12 -0400
Message-ID: <CAOg9mSSMAao4WpZWmVhsqLwsn=sfs05XPVuHMdjH0wUyWET_WQ@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
To: Arnd Bergmann <arnd@arndb.de>
Cc: Justin Stitt <justinstitt@google.com>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I applied Arnd's patch on top of Linux 6.9-rc3 and
ran through xfstests with no issue.

Also, instead of Arnd's patch, I used Jan's idea:

+
+       buf->f_fsid.val[0] =3D ORANGEFS_SB(sb)->fs_id;
+       buf->f_fsid.val[1] =3D ORANGEFS_SB(sb)->id;
+

And ran that through as well, no issue.

Sorry for missing the earlier patch.

-Mike

On Tue, Apr 9, 2024 at 1:55=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 8, 2024, at 23:21, Justin Stitt wrote:
> > On Mon, Apr 8, 2024 at 7:36=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >> Frankly, this initializer is hard to understand for me. Why not simple=
:
> >>
> >>         buf->f_fsid[0] =3D ORANGEFS_SB(sb)->fs_id;
> >>         buf->f_fsid[1] =3D ORANGEFS_SB(sb)->id;
> >>
> >
> > +1 for this idea, seems easier to read for me.
>
> Yes, good idea, I'll send this as v2 after my next round
> of build testing.
>
>       Arnd

