Return-Path: <linux-kernel+bounces-160523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C68B3EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861861C22128
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8A16190A;
	Fri, 26 Apr 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JA+LwgWI"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA26762EF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154110; cv=none; b=nRIfa29US+fiIXU9jvNhB8kG/rYmO5cGtDe0fGpYafkDDlZY3g3GIeMcw860cyNw+d+e83R+zn2vXMHAdRxHhoGLd7sKYMjhFK9NfsOfITrO9LaFcNQO+GaB4ebX5Z3V5+0sT6Q7B7IK0hJzgZ/IeDXPVIp6qmU3lj6vYGjFtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154110; c=relaxed/simple;
	bh=kL+7ZrrqScdesusKGohNEzDyqEogNewFbdVCuWv96gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YMAObuD11+KojsWoNpTvM7HBolk+8VTs6CkRZgxq/GqOBDmNLlhvEgbEGWH1Gh5O1+w7xddt8pUJS/6R3/8BNdPQpMjqvgsUQB77Q6spy7ihBarabkBL5zej1LSlrEx0fvb09vBZY2ocA0caxHonelZWymmxjaJ5WM3zOgX1S1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JA+LwgWI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so1325a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714154106; x=1714758906; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8c3fp45OFJMal76GyuAg1MWr//D/Pxstvhd99L3qf4=;
        b=JA+LwgWIlXStfzB44tclGV5+keTQ6bUIdor+Tog1wtEeOpbSpjmpEGp3lwX0ib7hpL
         vrXtarOjuhUjmA3lpyPSSCrydv07ngU3cf6jnEkYOmDtCU1MvArI/zjU6LTq3R0wSl/k
         B7N5Z1Au1Rn7KJN4FtiUFi0nIh5Fsy9vY2tk3PmsIqo5X6hTozAT8zmxhpmDEdwcGtaM
         mLRqpZCa2YYhDASkpIm5gdre/JaPxUKFrjlNUAzZWLsTCXXCZjSZ9mo11CpRSUDWImgD
         jzbOBsfNHtGR3tD0PeYjOdbj/gByx8gL0DU49kwNQZFDskV5xNPRaq8iGlkY6b1dYMZR
         oU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154106; x=1714758906;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8c3fp45OFJMal76GyuAg1MWr//D/Pxstvhd99L3qf4=;
        b=C4xVg+so1dfVkjcOcSKAs1GHrZyjy1DeheMpgcUyBTHKVJDlHKK/pRLIlvTAPKYMx6
         sGFyVl8Jqr2/UEVM9aYgSifOiDLTLCCbE/92k+jweabXzgGTwZ+RaLsnDR/w9AXXce8u
         EXpooULQtRLQg/zbId4RvL+p7Zh89lz4HHpeIh4s2eJ+WFe6uRxFcTamijA7SDBaA3If
         S9FToIx+Cnts9e3PUO5m4SfxiJCCe3PWE13V3XtKAstfl2Mw+/dBd0UERv7Kukg0rJfm
         H+5sI1GOD6ylFxUh6fK0tEaUOlNp44QelAYTJReuq2eCLJ7WYMz2MR/uysE3Se5ipOVf
         aBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtIlo3tGQ0z6Tnhm6JN+45oKGJdBXZjQKzjCZKnfC4z2KZBYtziVOjU6/oBgcUiYju5epwdXv50THLPafkJL5qr7QauGOSXhB9C/2k
X-Gm-Message-State: AOJu0Yz5OqGELQksUCkHmIhxiaspwzHK2J5HbYDpZvphWXVmaE1ZDnOH
	wwwnWcSnPaLW9dbp7jCkfpTEzX0vl6ApoeNNfpjA4dUNvi0Iz9XfGRczAWroMAuHL5hHItXMvOO
	CFyBYHWo4VHKtvT/psF0LiIoB3drozy/b+W5s
X-Google-Smtp-Source: AGHT+IGNneXmQFDgqQc9JoRJ7D4mFnW6fLkrjLGyh1mdJTz9eclJLKxSl2hXpj0qG+wm1H4YOnpVMdvcBQl67A2FHxE=
X-Received: by 2002:aa7:c6c9:0:b0:572:fae:7f96 with SMTP id
 b9-20020aa7c6c9000000b005720fae7f96mr3051eds.6.1714154106362; Fri, 26 Apr
 2024 10:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423134731.918157-1-vinschen@redhat.com> <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
 <Ziu6k5cjXsaUpAYH@calimero.vinschen.de>
In-Reply-To: <Ziu6k5cjXsaUpAYH@calimero.vinschen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 19:54:52 +0200
Message-ID: <CANn89iJ_eM2oK5ruGu1NMk0ZEivEQO=R64E9eb9ujYj+=qWiKA@mail.gmail.com>
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
To: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:30=E2=80=AFPM Corinna Vinschen <vinschen@redhat.c=
om> wrote:
>
> Hi Eric,
>
> On Apr 23 16:10, Eric Dumazet wrote:
> > On Tue, Apr 23, 2024 at 3:47=E2=80=AFPM Corinna Vinschen <vinschen@redh=
at.com> wrote:
> > >
> > > From: Paolo Abeni <pabeni@redhat.com>
> > >
> > > Sabrina reports that the igb driver does not cope well with large
> > > MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> > > corruption on TX.
> > >
> > > An easy reproducer is to run ssh to connect to the machine.  With
> > > MAX_SKB_FRAGS=3D17 it works, with MAX_SKB_FRAGS=3D45 it fails.
> > >
> > > The root cause of the issue is that the driver does not take into
> > > account properly the (possibly large) shared info size when selecting
> > > the ring layout, and will try to fit two packets inside the same 4K
> > > page even when the 1st fraglist will trump over the 2nd head.
> > >
> > > Address the issue forcing the driver to fit a single packet per page,
> > > leaving there enough room to store the (currently) largest possible
> > > skb_shared_info.
> > >
> > > Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB=
_FRAG")
> > > Reported-by: Jan Tluka <jtluka@redhat.com>
> > > Reported-by: Jirka Hladky <jhladky@redhat.com>
> > > Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> > > Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> > > Tested-by: Corinna Vinschen <vinschen@redhat.com>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v2: fix subject, add a simple reproducer
> > >
> > >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/=
ethernet/intel/igb/igb_main.c
> > > index a3f100769e39..22fb2c322bca 100644
> > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_ad=
apter *adapter,
> > >
> > >  #if (PAGE_SIZE < 8192)
> > >         if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > > +           SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2)=
 ||
> >
> > I wonder if adding IGB_SKB_PAD would be needed ?
> >
> > adapter->max_frame_size does not seem to include it.
> >
> > I would try using all mtus between 1200 and 1280 to make sure this work=
s.
>
> Erm... did you mean between 1500 and 1580 by any chance?  1200 doesn't
> really seem to make sense...

No, I meant 1200 to 1280 .  IPv4 should accept these MTU .

1200 + 768 =3D 1968
1280 + 768 =3D 2048 (2 KB)

I am worried of some padding that would cross 2048 bytes boundary,
while SKB_HEAD_ALIGN(adapter->max_frame_size) could still be < 2048


>
> I tested this patch now with mtu 1500, 1540 and 1580 successfully.
>
> Either way, I'm just heading into vacation, so I guess I'll pick this up
> again when I'm back, unless Paolo takes another look during my absence.
>

I guess your patch is better than nothing, this can be refined if
necessary later.

