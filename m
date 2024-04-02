Return-Path: <linux-kernel+bounces-127233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67225894865
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC7C1C22C46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BBD50F;
	Tue,  2 Apr 2024 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3x54VzzE"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4BEC4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017006; cv=none; b=UUTxaMMJ0Mr3cL3OijaO4Bm8KBfWM4s2QmfCrDb4T/RJ3ztDbpgRtereFNRvJo+hpgauTw9XedakmdOuy0Gd1kPxvG2Pe43bIayw+0/jjIH7DYp2UPp2uwNI/Q4ElZzcgRj2KpR75X6XtPmWDvpJNpPSePgmVP8EHvQh61fd0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017006; c=relaxed/simple;
	bh=LzLZbEKpNDtOEiZfAv971eS133/igaEe3qFvFQHwi/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDBLseaxwUrleAaCedm0dToiFBfBOW+0hMmhf0VdCw93HuAAB2wpuUNr+Omh9dpv3KgVGDpNl5hlNYKwI3r8tUXRu7VV5A/QjTIAHAWZfmKpYQSIs+FgQfbkjeRr/uCyHY0egQ3XRAJQQCxepHYwI0h1nwHiAmBETiLhYf+F1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3x54VzzE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e062f3a47bso538885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 17:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712017004; x=1712621804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyW4BCGaQS495oS/zQ0Useus0nHWJbq7KkRShOZB/QA=;
        b=3x54VzzEt4sT3ICtwBiaTDZjWxhItLG3DDvH6cQh9yb+/jCXCqYFeJZfpOteyL2IyI
         06DM6hggFuExeHNCs2uwtZh9xywPhQw/N0vKUvJBtmlh8Lbb7ofLbDEzDLPRJxiFvM2i
         9bb98KG86srlSLFnT9ZDx3nukEObNUoTeds89NlT+xNO2Ka26rBR9WSO8zQED2IUqt9m
         ik3k4CUz0EWHNir+g5ATFqKiZwl6ekLBOIIq22N+zSf9MFixSPmsci5JILDUPzPGKahj
         dY6slXC2JrjNZ4wA673NVpZWtAtFmQbiL/Qy+LkjBKzi5U02MKFFiCs8JbgxJIrLxtjy
         DG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712017004; x=1712621804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyW4BCGaQS495oS/zQ0Useus0nHWJbq7KkRShOZB/QA=;
        b=i3y2um+2A9BdVlccrW1EqjkfnvmL+Zv5m0aPD50vT/fqDoVjr1nY+k5UvOypZw1mfl
         tYNGsQ38pAtOZVeoAyemcPtBlyN11ZLIkXwjZMi5iaVb7I/Trg5vfi/v81zP0c+ZOl7Q
         NsJReLVO4AGAi5C1seLoIOuGgvF9GlPAjEmeaeE6KGP2F9mznNJU5n9SDgltMM4nXVMD
         ljEqg0hMbBfIhaR9t5yq360ietBOPXadgAoaeHmJTxMnJMOLXbH/QbFh/UqsQhyygkrp
         zA9r7udj7D5Ewlg+x8wgmGaFfI63cN3zyR56FO++G/ipHZilMtU0DsHKy2QpbswUUOH5
         8zkA==
X-Forwarded-Encrypted: i=1; AJvYcCWL96QTahUMJiDQ0lBZXl43sJwnymoGxK9Q9HovIitGidXz1EXUx9PijAuWB5no/ipmh37pD+oNAXE6tojNXavcx8d4rSq/KKzh7fJg
X-Gm-Message-State: AOJu0YwciueluK6wo3E7h0orIhGCfwiV9PM/v61vF0PXbi24+RcsFCwg
	s6STNKDiGcbzc8JXPMfxQcLoPLtvgg4VZs3svgSJ4R7Flwt5bmQ8Ka/pXK8j4W3at7b3ji8zpMI
	5tBA5Z4SfXutpan3GZRVoz1IXm7+8nV5UVzIn
X-Google-Smtp-Source: AGHT+IEmefmlOYptKLrsjrYXMZdGKtoAo0HMnv8wYVRtxPcevsDBQnJ/0sK3/0DKNIlibuR7D02mzHG0kdqh6knJRXg=
X-Received: by 2002:a17:902:cec6:b0:1e0:f525:a831 with SMTP id
 d6-20020a170902cec600b001e0f525a831mr710596plg.28.1712017004291; Mon, 01 Apr
 2024 17:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215215907.20121-1-osalvador@suse.de> <20240215215907.20121-2-osalvador@suse.de>
 <CA+fCnZddd82=Gp2j4sdks+NGpn-GSvZq8isYOwXDO=Y3TyBG1g@mail.gmail.com> <CAMn1gO680XrsvyxiKXQOcVvofEkuJNsjvoquNREtt0HxGWSqqA@mail.gmail.com>
In-Reply-To: <CAMn1gO680XrsvyxiKXQOcVvofEkuJNsjvoquNREtt0HxGWSqqA@mail.gmail.com>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 1 Apr 2024 17:16:31 -0700
Message-ID: <CAMn1gO6aaJG7V7ydNGpA-hL+Bsh2xtzVdJx_KuUtvusTbGbLbA@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] lib/stackdepot: Fix first entry having a 0-handle
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 4:25=E2=80=AFPM Peter Collingbourne <pcc@google.com=
> wrote:
>
> On Thu, Feb 15, 2024 at 3:37=E2=80=AFPM Andrey Konovalov <andreyknvl@gmai=
l.com> wrote:
> >
> > On Thu, Feb 15, 2024 at 10:58=E2=80=AFPM Oscar Salvador <osalvador@suse=
de> wrote:
> > >
> > > The very first entry of stack_record gets a handle of 0, but this is =
wrong
> > > because stackdepot treats a 0-handle as a non-valid one.
> > > E.g: See the check in stack_depot_fetch()
> > >
> > > Fix this by adding and offset of 1.
> > >
> > > This bug has been lurking since the very beginning of stackdepot,
> > > but no one really cared as it seems.
> > > Because of that I am not adding a Fixes tag.
> > >
> > > Co-developed-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  lib/stackdepot.c | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > index 4a7055a63d9f..c043a4186bc5 100644
> > > --- a/lib/stackdepot.c
> > > +++ b/lib/stackdepot.c
> > > @@ -45,15 +45,16 @@
> > >  #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS=
 - \
> > >                                STACK_DEPOT_EXTRA_BITS)
> > >  #define DEPOT_POOLS_CAP 8192
> > > +/* The pool_index is offset by 1 so the first record does not have a=
 0 handle. */
> > >  #define DEPOT_MAX_POOLS \
> > > -       (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
> > > -        (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> > > +       (((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> > > +        (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
> > >
> > >  /* Compact structure that stores a reference to a stack. */
> > >  union handle_parts {
> > >         depot_stack_handle_t handle;
> > >         struct {
> > > -               u32 pool_index  : DEPOT_POOL_INDEX_BITS;
> > > +               u32 pool_index  : DEPOT_POOL_INDEX_BITS; /* pool_inde=
x is offset by 1 */
>
> Can we rename this, say to pool_index_plus_1? This will make the code
> a bit clearer, as well as make it possible for debugging tools such as
> drgn [1] to be able to tell when the off-by-one was introduced and
> adapt accordingly.
>
> Peter
>
> [1] https://github.com/osandov/drgn/pull/376

Unfortunately this message was not acted upon, and it looks like akpm
picked up the patch and it made its way into Linus's tree. So I sent a
followup to fix this here:
https://lore.kernel.org/all/20240402001500.53533-1-pcc@google.com/

Peter

