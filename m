Return-Path: <linux-kernel+bounces-127965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5C8953C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80FA1F2512C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A958D7A705;
	Tue,  2 Apr 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SfF51EV"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEE5E091
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061925; cv=none; b=iEeiZxlbPWOKsZNPFLxR260TxiRNarvydPpFAY0K4ItUJ4InYzKsji8g5m4KU62axSV96WrStAdCw1XN99T2XGz2LzcvuGvVsB9jFZBpaU5RstG27Blc0XQ00/N2ZSV73uI1nQCseRLkaJRS19tkMDanIkotR1v5mpynwupRTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061925; c=relaxed/simple;
	bh=Hp8+y1lbURygDrP16BOzTCfSF4sdsYEiWaKbYF2pUuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4t0tJw/Trq0pK+U9MyvBkadwkpAkWv05e1cBBHyS4dmOyZyhWJ1KKGoMrx9G7lUU7aSePfxX/C5Fxh0XZf4Y/sBFL4V8wjpFi9c85C1snPaQcWHMz6530MBWRn97k5jtmGDt2GeMQrrSnvhTDs0AzqPNuMuSM8grpWU/dRPmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SfF51EV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so61525a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712061922; x=1712666722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M/azvQg/95Yvu21qnsgnp3DmsmNUd+XuYGkFLtL53E=;
        b=4SfF51EV5SuU624rqNBQUGuv0FyvfC9zZ0D1baHKBt/L4UE3aDxSE3kyYaNEeDrhCq
         xi+pE6vJ2M2ByhyTqo/RBi/Kk8i/PMvTHmqczmz3D2TgarpoyOBWlirYRirMp1kbUeeM
         2rwayrhINAgXt8fmCbN7iyftm0p512FKnnNbZsWaKzy06kynC4say51teF54qhy0Dy8S
         VmCAIe0oPXA4eIEg1M72IPiLhLfG2LWuOKGLjWF6HkCuiTkD6EsYdlQcJiKOzj7hMUyl
         sOOPtrE8ZsA3lRx/WIDx1f78f7hPU0KG75JwUWoGDSuGIdgVmKtdLfMn3OsNH1A77hW+
         VjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061922; x=1712666722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M/azvQg/95Yvu21qnsgnp3DmsmNUd+XuYGkFLtL53E=;
        b=Yiade+mCYek1DwzSH7lx4tPtIAh9G+dHKQnkPijBwksGdyeSQhUucaCL4LEUjq4HK/
         8k58cLCMfpuz9hFaG59bSm5ViYLazM0/qSf7wjaqK2klVbZSH7r8DJ+loZxdatMXv2RE
         crhliqHmI/o/P/m5d3tckwOjzXfDXpekXJE5RbQdhC6VFX+cXEQhWhGTo3KdYfrKtdT4
         8cBqWK/bZU9NLXvY/V8YtDLwvPpDjzwS+5o6pO3iIRVkcNjm1YqaEp5FNyZ1GWr0HptO
         t25AMaNNJGBmdrTYimL90w1QYfbTxp7SKiSD85eBFcVX/w/4urYxyvN+MqOdpKkKhM8k
         7oKw==
X-Forwarded-Encrypted: i=1; AJvYcCUwWAi7oBkzo1QJFBcywGzCd7BUe04+zoP4bJZduV9QCxfx5MX8WMBOxbSJOOwXHmY1AaKCCtUqf2KwzL+5sWcxBQ+qsfYR4RRXBfIV
X-Gm-Message-State: AOJu0Yzkw6Jbud/OJhHu/QPt6VhY7MCb8SNmhmcP9H5blCe9W0/XFLdi
	tlYdOFs7CFnAtI0mYw1a6wI7Z9qdWUwoS0LTelMxsLuQrrHeTG+bcgSn61YjxvxcE1UNcMvrMor
	8Xgc+TJADjIT8Q208NE1Csla4GBqQ5Ne+1qxO
X-Google-Smtp-Source: AGHT+IHMjS/2sjsBEfoebJKUCNdTTacLZ/DhdMxA/YGogeYj61TWY5FINIzC9qI0FWbTCE9mt74E4TxiFZHEUUV+JsU=
X-Received: by 2002:a05:6402:716:b0:56d:f412:c42e with SMTP id
 w22-20020a056402071600b0056df412c42emr67494edx.1.1712061922219; Tue, 02 Apr
 2024 05:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
 <20240329170000.3241460-3-aleksander.lobakin@intel.com> <20240329131857.730c6528@kernel.org>
 <20240329135344.1a310f31@kernel.org> <912d1f9f-a88d-4751-8d91-b82a75f82a32@intel.com>
In-Reply-To: <912d1f9f-a88d-4751-8d91-b82a75f82a32@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 14:45:07 +0200
Message-ID: <CANn89iL+goDgitdic97+um6D-PZDw2xYf=2eYgnNYEYU-Nws0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse shadow
 warnings throughout the file
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 1:55=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 29 Mar 2024 13:53:44 -0700
>
> > On Fri, 29 Mar 2024 13:18:57 -0700 Jakub Kicinski wrote:
> >>> Sparse:
> >>>
> >>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol =
'_res' shadows an earlier one
> >>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally decla=
red here
> >>
> >> I don't see these building with LLVM=3D1 W=3D12 C=3D1
> >> and I really don't like complicating the code because the compiler
> >> is stupid. Can't you solve this with some renames? Add another
>
> It's not the compiler, its warnings are valid actually. Shadowing makes
> it very easy to confuse variables and make bugs...
>
> >> underscore or something?
> >
> > I'm stupid I tried on the test branch which already had your fix..
>
> :D Sometimes it happens.
>
> >
> > This is enough:
> >
> > diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> > index 1ec408585373..2270fbb99cf7 100644
> > --- a/include/net/netdev_queues.h
> > +++ b/include/net/netdev_queues.h
> > @@ -89,7 +89,7 @@ struct netdev_stat_ops {
> >
> >  #define netif_txq_try_stop(txq, get_desc, start_thrs)                 =
       \
> >       ({                                                              \
> > -             int _res;                                               \
> > +             int __res;                                              \
> >                                                                       \
> >               netif_tx_stop_queue(txq);                               \
> >               /* Producer index and stop bit must be visible          \
> > @@ -101,12 +101,12 @@ struct netdev_stat_ops {
> >               /* We need to check again in a case another             \
> >                * CPU has just made room available.                    \
> >                */                                                     \
> > -             _res =3D 0;                                              =
 \
> > +             __res =3D 0;                                             =
 \
> >               if (unlikely(get_desc >=3D start_thrs)) {                =
 \
> >                       netif_tx_start_queue(txq);                      \
> > -                     _res =3D -1;                                     =
 \
> > +                     __res =3D -1;                                    =
 \
> >               }                                                       \
> > -             _res;                                                   \
> > +             __res;                                                  \
> >       })                                                              \
> >
> >  /**
>
> But what if there's a function which calls one of these functions and
> already has _res or __res or something? I know renaming is enough for
> the warnings I mentioned, but without __UNIQUE_ID() anything can happen
> anytime, so I wanted to fix that once and for all :z
>
> I already saw some macros which have a layer of indirection for
> __UNIQUE_ID(), but previously they didn't and then there were fixes
> which added underscores, renamed variables etc etc...
>

We have hundreds of macros in include/ directory which use local names with=
out
__UNIQUE_ID()

What is the plan ? Hundreds of patches obfuscating them more than they are =
?

Can you show us how rb_entry_safe() (random choice) would be rewritten ?

