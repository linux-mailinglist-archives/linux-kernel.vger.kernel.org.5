Return-Path: <linux-kernel+bounces-119784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB588CCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3721C3D1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BC13C9AA;
	Tue, 26 Mar 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dd+KwLFj"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840F13CFA5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480731; cv=none; b=YXPebKfQ1W3Ou1CvVYvdbIXvlyxJhgLAVyzmm50xN3SMRfxwFjSWgk6cQv8cslS5g5R/XsIXpIWNV+X37PqTgLseuQDJEynFY5wtdgHkOS1xRc5X3Q8pBBm3QH2qGq4FTmUEutQyJ/ESDwkWfJwYeOrbi2O8QLaz289jui9RjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480731; c=relaxed/simple;
	bh=rIylzLX9J4lI4zws2LlXbhQ7UBlTM78dlQkpCoGuNZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9jkIWvV+4XhZOTmf1WSWV4z3HcXVtexpLHAIlpvLpLgKfRotZ/Nss9TaYn2Z/huxi5sWL0e83krQhLjdpsR5NDAkgknNgLHN7QYRT5LNA8RgmZdy5pIBrlfq2LBqDFHZ/TQlgYFUvteO2tS4I9oDkVzDiKvlfqgkrXgrdoWrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dd+KwLFj; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5665135276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711480729; x=1712085529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYgOqn25gz9ie7H+12IzY1nGkmV5SX8eunsh05XgwQg=;
        b=Dd+KwLFjuRZAD+4bISi9lY88kQwFwPRI9NXNiCTV6coGU5moFOYV9PfHPv5ndBM4Nt
         pbsS7dN7DezMKf1xFptgtr+DUggi6aJhAk3nZIg+blx6wgw/RFFd773CH0KSQtKqquQG
         e0GpWHrUrugJG4o4aOKQBEMp9FxAf9m9D4mhPB3c/rOHN2f4XsWHmPI8AP8ltEGgbocW
         twGQZuoU6SWNp2gg//d5PoNZaTIITQTkcZuBsq3p+V/oqp3h6ZhuJw7/Y6toUvKRsd6j
         6GnoIpCyr9Ywgo28HTb9rnUuYWeZXZGF2bZczifK6jxYeoq3l2gFAL/hYnv5MLLEuCuN
         fmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480729; x=1712085529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYgOqn25gz9ie7H+12IzY1nGkmV5SX8eunsh05XgwQg=;
        b=jyQ0MXQ7+maCnyZxC/4ah4NpPGketRYGQsggrPdG477wKIxWV271atFqSilBBTi1yC
         JN+IW4h86tDKSJFXunRqh1tnPuG9uqV5ICE4wFidE9y22O2vktGMvMsqDVdQLM832MK0
         cqqkzPugHpqj5VR9m8SLy1YXF3V2HvZSHkfTG1ouCJwpXtMJsuGB2nL83ID3kCaTiv13
         nRs0Qe6w3X15aMtv2t0NxB5IW/mtD+ZOiBMYV0nA7ufjJU5Qo7PctWHm9ejne3oM/Qbx
         JGRwg7fKHX8IAZdgKKHo6j5MKUxo6SuMnHJvzVjwHd6I/D31r2EOhXBnUhxnnDYIUL2t
         PQFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXedmzvusUbZa54fvD637osgJIOBwYYmN9OK+QGljfXlZmHlRUewEkDOtbCoXJNBu00HAiftPTE5Z4DFj1oY91cnoSrNLtU/a8gov2A
X-Gm-Message-State: AOJu0YzMxQZ5JnA8VLaphhhoZWmsrj6333+LzXMX984WwZAY909NpdMy
	eqILyYRwzT9Lzhk8FIWSMpPTbYvfTyIRnhYtleE+UWoJHCdnKbnJN/uCMCB716/ITLmr8SzqmAp
	Gkxr8c95S8kTs9FrPGdReO0GtrFE4H5rYm2oY
X-Google-Smtp-Source: AGHT+IFc2eIKJ7d4YLg5xPwKn3eSXqib+pnZt/naj67Aoraqg2lZyHWdIy8LStTjQAxLscv6AnlkiFaJa8XuhVWngDg=
X-Received: by 2002:a25:ac48:0:b0:dd0:2076:4706 with SMTP id
 r8-20020a25ac48000000b00dd020764706mr3510341ybd.31.1711480728958; Tue, 26 Mar
 2024 12:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315125418.273104-1-cgzones@googlemail.com>
 <20240315125418.273104-2-cgzones@googlemail.com> <CAHC9VhTOmkpZu-zUEcvWJxLVHwoUnTcPxhBexs1ZKjr_LRKx_w@mail.gmail.com>
In-Reply-To: <CAHC9VhTOmkpZu-zUEcvWJxLVHwoUnTcPxhBexs1ZKjr_LRKx_w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 15:18:38 -0400
Message-ID: <CAHC9VhQZNpz3m-YBrKtuoX1Ve4cPQ3rr3Y1ONjXA0hcsu7RqXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] yama: document function parameter
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 3:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Mar 15, 2024 at 8:54=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Document the unused function parameter of yama_relation_cleanup() to
> > please kernel doc warnings.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/yama/yama_lsm.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> One small comment below, but otherwise looks okay to me.
>
> Reviewed-by:

Bah, let's try that again ...

Reviewed-by: Paul Moore <paul@paul-moore.com>

> > diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> > index 49dc52b454ef..f8e4acd41b72 100644
> > --- a/security/yama/yama_lsm.c
> > +++ b/security/yama/yama_lsm.c
> > @@ -111,6 +111,7 @@ static void report_access(const char *access, struc=
t task_struct *target,
> >
> >  /**
> >   * yama_relation_cleanup - remove invalid entries from the relation li=
st
> > + * @work: unused
> >   *
> >   */
> >  static void yama_relation_cleanup(struct work_struct *work)
>
> Should we also take this opportunity to mark the parameter as '__always_u=
nused'?

--=20
paul-moore.com

