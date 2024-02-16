Return-Path: <linux-kernel+bounces-67893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999E857278
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA828457B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2039441;
	Fri, 16 Feb 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IV3PPg3W"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04A63C1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043169; cv=none; b=t2NnKKaRhIAojHm2ltsLYKscttrYjwCkW8E8pvK1diA2as5J82LjaG5w9xdQc/Rsk/+gC8u0/TyxzdXTlTYfaUZ0bQfDVPdn6vpTno3S6/bThi645h/yD31oONSgVL3NnE3Np4jaCQkOPzRN8WNYJry9RI/EnlI76vISvB5uLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043169; c=relaxed/simple;
	bh=ddj6aJrQX/zLxk2ChEpJL8xzwmu/Ixsymjq9BOrMxks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNF92iURWRSf8NsL6t+MqvsFCV68ktGHL5iOgl2fmu31uioODAlJi/g7ShNa2UBe5ED/2dQ23R0Y7i/mH7Zy7+euiLd+HgfKbszDXot0BkNOv0Rk8MiHODMiLFw/Y+waUUCkosI9lbiEP22bZJzBSgcN766MhmKL7Dtn7Zu/3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IV3PPg3W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db61f7ebcbso34175ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708043168; x=1708647968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZpqm1jNdavSpo3vr4NLG35YMtA041kvQYWASko7wIE=;
        b=IV3PPg3WIjFfUgYg0aHskE5Hp8daLD7BPCTXWbHaKL5ipoSSGCtsQE8D7efz4ByWTW
         FAevojuMe4Kx9U1ndmwzTN3Bd5YInhL4rfvgHESzw0nkegJxjxcccp4kkEN6I2ohWetD
         Z8ASQdHEAOUwlizsyCyZT2/uWEm+N1XFr0HB244EnPFd21szrQ4Ip4jiYE6q+d7ed8vD
         WtyVLcmNL8lcGzlYXtgMUUs7hQvajyzUWw7vUuVwRe1ppp6y++JdaDU17Ip1z7WZfnwl
         v25IUFCjc3nZ35daz1ML1M9kwdHuobwLaTMQcKIpRs+TAlw0QvroJuEyIRR6gcVD2opR
         SjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708043168; x=1708647968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZpqm1jNdavSpo3vr4NLG35YMtA041kvQYWASko7wIE=;
        b=AB6NWLbnwFrqrrtSZBR2Bcw+1MjicMzmBWP7O/mWkvk9NSQkqSLd7IsQRLKPOfuOoa
         cMAc8gt2XqjURqkhBlzbQNG9dwb+6ogYGbk+HPjJNVq4pIzSJ2MSSub0tHeYhzCbxmwS
         Zb94f5Ayp7umz7y/h/lY8HnLkRarLxl+S9SfgqgsIPRQjTl3u9FQcv8ohf/6STYEK6EW
         0ISezuwj+7fSWLaUdiRVGTEQCjBR752ysV/EKq+qTBfhH/+pl6mouOhqrLctDZsQaqwp
         tlSzZVPA8d72q+L1dTFM0zZjNmoLGHr6drrmDgD2ELgbdpaZQ2IpGVlXjCMjl4nofsVs
         JDXA==
X-Forwarded-Encrypted: i=1; AJvYcCXiiVcjhJGfQ4ARC/juk8w9NzP9vxXiGb6ue/D7KLs6XZN0PRWNCtxAMKSWzj0CloEnXkV3QXocVzxacfxd4T3VnmQ0yYmiwciyDN0g
X-Gm-Message-State: AOJu0YygEpo4ed8W8zXOC+//MF/0UEZ1Rx2zWRJX4bMtvao4z9ra56Pg
	iU92NF5UBZL3HAfja7WIrPA/AjRseE8tO7tNtJ2Pj2GDAtPUWSnw2CZxBqJcHd9GzhkR66556gW
	+eQ5hkQuj8VTBzAV8TF8k8A/c+y5/HOA9G7x+
X-Google-Smtp-Source: AGHT+IFM8MofjIlAUJ2158uqKNFUxSIcGeGfFWSqFtIC8LY4LE4cYklcKC74Qia+/2KNhPLaRleuACH72UWrR5JDJyM=
X-Received: by 2002:a17:902:fccc:b0:1d9:c0e3:3f5e with SMTP id
 mi12-20020a170902fccc00b001d9c0e33f5emr115320plb.25.1708043167398; Thu, 15
 Feb 2024 16:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215215907.20121-1-osalvador@suse.de> <20240215215907.20121-2-osalvador@suse.de>
 <CA+fCnZddd82=Gp2j4sdks+NGpn-GSvZq8isYOwXDO=Y3TyBG1g@mail.gmail.com>
In-Reply-To: <CA+fCnZddd82=Gp2j4sdks+NGpn-GSvZq8isYOwXDO=Y3TyBG1g@mail.gmail.com>
From: Peter Collingbourne <pcc@google.com>
Date: Thu, 15 Feb 2024 16:25:54 -0800
Message-ID: <CAMn1gO680XrsvyxiKXQOcVvofEkuJNsjvoquNREtt0HxGWSqqA@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] lib/stackdepot: Fix first entry having a 0-handle
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:37=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Thu, Feb 15, 2024 at 10:58=E2=80=AFPM Oscar Salvador <osalvador@suse.d=
e> wrote:
> >
> > The very first entry of stack_record gets a handle of 0, but this is wr=
ong
> > because stackdepot treats a 0-handle as a non-valid one.
> > E.g: See the check in stack_depot_fetch()
> >
> > Fix this by adding and offset of 1.
> >
> > This bug has been lurking since the very beginning of stackdepot,
> > but no one really cared as it seems.
> > Because of that I am not adding a Fixes tag.
> >
> > Co-developed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  lib/stackdepot.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index 4a7055a63d9f..c043a4186bc5 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -45,15 +45,16 @@
> >  #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS -=
 \
> >                                STACK_DEPOT_EXTRA_BITS)
> >  #define DEPOT_POOLS_CAP 8192
> > +/* The pool_index is offset by 1 so the first record does not have a 0=
 handle. */
> >  #define DEPOT_MAX_POOLS \
> > -       (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
> > -        (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> > +       (((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> > +        (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
> >
> >  /* Compact structure that stores a reference to a stack. */
> >  union handle_parts {
> >         depot_stack_handle_t handle;
> >         struct {
> > -               u32 pool_index  : DEPOT_POOL_INDEX_BITS;
> > +               u32 pool_index  : DEPOT_POOL_INDEX_BITS; /* pool_index =
is offset by 1 */

Can we rename this, say to pool_index_plus_1? This will make the code
a bit clearer, as well as make it possible for debugging tools such as
drgn [1] to be able to tell when the off-by-one was introduced and
adapt accordingly.

Peter

[1] https://github.com/osandov/drgn/pull/376

