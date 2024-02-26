Return-Path: <linux-kernel+bounces-82274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F59E868198
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E71F26FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E8130AF2;
	Mon, 26 Feb 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vu0ltbrW"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4712FF98
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708977613; cv=none; b=HSoAIloG0886r92hgNHXBUKzPdV3IXWLH+P3wjAzC0/qHwTDms7FLSYVWs/Y32+PNPxe+xLeq6DNGuZXvERO928ALMJc6jwA5CDc4UGtIgcbOM7kqf/UVtrm257H7ojn4xr6Pt6REOvUlyZbEXj+xGYSERcQ9U/Y7fohPiY1mWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708977613; c=relaxed/simple;
	bh=pehUlEWHJhuRq9lM7KavvQJzY5vJpoSwudZUjolrSuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNp1Sz24rRc8N0Lovr4p5FJx5etKlp++58Byu1tBtK2Gb2TuB8tt2WDMjYS/2oMmyzcgrllXoGxXkuS5727JJIeanv3Q/pVou04dS0yCwSAaycmFQ26o9/VoALGADnMuUt6xGME/rEBGVIt7QCKnPJGZ10uz06T8Ytd/Vscu9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vu0ltbrW; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so2992649276.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708977610; x=1709582410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMyH3X6y0ghY91KBV/IXMi8hinan8vTup4YSJD234YQ=;
        b=Vu0ltbrWtBfntQBiqMOXofE/xsoZFs0qnwabmBXg2gZBbRjxNb2r8hC4eBn7FLc99M
         un+ei2VMF9y1YGWnSzSkbs4S7suJNMbjP9H/iEaFRHCjYr4Guni2+3X0H8zN/YElaMED
         Sq1pRyIao3TGcVuFlDUKXP5TZ3WlSSOLr3/d41LYh4cCYppPD8KcSN9xSENfirqlR4vO
         1ypQKraoUEHU0IunmWgzNrVuC/wWapFmyXTfJzjhUTRPfhxpJh46vq/rrGz2xbTViXY0
         wr9YPFH7+jduOS2vyzwn5QF8cU8fBQg05UboGcEtoydnqTQpNWuHf7bU5O8MDs1O8xDe
         4HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708977610; x=1709582410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMyH3X6y0ghY91KBV/IXMi8hinan8vTup4YSJD234YQ=;
        b=XlWIFbu0akxDPDevlsqenxC94dGhKkuGlkVtJnyeVMV/yQzreH+qJdz6tjneayS5ic
         izuV9XMWsCxsSDzJR7YUJh8woAzjDRPm7OXiVF7UQTa9Z2dbkDWUfgdAM1va+Z65GPbt
         paq3F5DRdxX+mLF35ZUjnn6SMz2oFeRC0U5nfjdxOB78COm/MvZ6k0/1vW4USIIoZvEa
         9oyxNrMpQWJq7aOGFF+JX++HYLK8Jj/rIK/Dtew9bP9GRdnIq5KJRXXjU8oFmVCUq9N+
         PUSDXSnlDxHV6D2RS9627hMLxpgQ0qgVMfb0vrP3Z9UeHilKzwTVoJFXxClQ8nVmddGK
         bMRg==
X-Forwarded-Encrypted: i=1; AJvYcCWoU6bG/ihO0365fY5nEgJlXFqJFNhPBo14RnV5qzwowE/TbG/XMdl51gzt7uxOqWs6HYhz3apG+TuWWFrAQQfCg6KYE5MmNc48VVJp
X-Gm-Message-State: AOJu0YwM+lb/8wdVe8AMBABIm8naFYUbxmPjN3EfBDeV4VIcx4PlDFak
	ORphh4lhDCLXiiBGfZX6iz9LCIh7YTfxa/wO23DuD5A2Xa+cyrmWKIICXn1FEWVMjO7sSVYJMFU
	xDhuhHGU3i+0C12yk8B/50i9wSg/baeUxpjxz+nc7vftEUMM=
X-Google-Smtp-Source: AGHT+IH9gi+JHHei3aslePPRBmX+ggOjwi0k4abScoUltl6mqfTgxhLuJg5zV2FSQNlPizp/84gScLMILBMR1UO0cxY=
X-Received: by 2002:a25:8b89:0:b0:dc6:bbbc:80e4 with SMTP id
 j9-20020a258b89000000b00dc6bbbc80e4mr206159ybl.4.1708977610011; Mon, 26 Feb
 2024 12:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
 <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
In-Reply-To: <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Feb 2024 14:59:59 -0500
Message-ID: <CAHC9VhTUux1j9awg8pBhHv_4-ZZH0_txnEp5jQuiRpAcZy79uQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:
> >
> > aa_getprocattr() may not initialize the value's pointer in some case.
> > As for proc_pid_attr_read(), initialize this pointer to NULL in
> > apparmor_getselfattr() to avoid an UAF in the kfree() call.
> >
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: John Johansen <john.johansen@canonical.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > ---
> >  security/apparmor/lsm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> If you like John, I can send this up to Linus with the related SELinux
> fix, I would just need an ACK from you.

Reviewed-by: Paul Moore <paul@paul-moore.com>

This patch looks good to me, and while we've still got at least two
(maybe three?) more weeks before v6.8 is tagged, I think it would be
good to get this up to Linus ASAP.  I'll hold off for another day, but
if we don't see any comment from John I'll go ahead and merge this and
send it up to Linus with the SELinux fix; I'm sure John wouldn't be
happy if v6.8 went out the door without this fix.

> > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > index 98e1150bee9d..9a3dcaafb5b1 100644
> > --- a/security/apparmor/lsm.c
> > +++ b/security/apparmor/lsm.c
> > @@ -784,7 +784,7 @@ static int apparmor_getselfattr(unsigned int attr, =
struct lsm_ctx __user *lx,
> >         int error =3D -ENOENT;
> >         struct aa_task_ctx *ctx =3D task_ctx(current);
> >         struct aa_label *label =3D NULL;
> > -       char *value;
> > +       char *value =3D NULL;
> >
> >         switch (attr) {
> >         case LSM_ATTR_CURRENT:
> > --
> > 2.43.0

--=20
paul-moore.com

