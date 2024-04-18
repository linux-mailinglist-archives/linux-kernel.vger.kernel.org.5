Return-Path: <linux-kernel+bounces-150358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B668A9DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15480B255BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12E16C43B;
	Thu, 18 Apr 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EsK3BI3w"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FA168B00
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452527; cv=none; b=YtRKbpLpn628F8Wu1C1iRl9mJsYtvU12leltqq2TEKZ8vyl01lio3KzxQkg2sro+zzQ97dCASczkue+HpDMKop4lWFupT2RRuSluB6sIXWjIu0gmM+Zrh/XEFQ7PkZ9ZTnd58OWQLY1oDC6LJBVlmcs6frtgOSU2hQVTAqU7uIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452527; c=relaxed/simple;
	bh=DQg9N9NsmAiomB3YevtTSMmyEr0U2U0LM9Xrfnum6ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF/OMXSGOxyasMO41K6i+n/CTeZhqA+GZCK6UcZYqyCHoYt90ZR6eSJjlHXWK6aYvzfC0nw4oBvV/cvjoBeCAF8jr8iJNRMw0hNL6FPtrZOFr0jqImqDxj3qRyTz1UEmfq04blaiIVNcj8emIXiBrOM7sr/ZVzFY3S0P1KutroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EsK3BI3w; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C1953F8E7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713452522;
	bh=Uwv3V9NnGMB5Wj85PeZTAIoBr809/UIjglv9mvQKrBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=EsK3BI3w/36KL1YiurVwhkCrgd74JYbPyQcAtL/9YzbiE+NUkaCHkonopFsZOh8OI
	 E3/esZxM6q0lBihe3VAj9NzaIEMOfv9iVyCrOpTkFmEeIdhn15GGCVHF291tFpz+8u
	 AqWIbnRqsYKgeV1xQbLGXCPEVZF3Gtx/kNDrPGn5Xgmhdlnyy+AHpyvXWELQSZg3DH
	 QSmFgJVvrYPsM3dlrZk3uZjtVteGIsxIMY2ZG5BX2sT3nHNLNB0lN8OStlBRKkzJQy
	 yuMVC0g7mCiquoE3lZ3RcmNEq2NKUmaETyYZQvK0ZjEspQ0wmlbY/mBRQ6I1p0o+fg
	 kQ3y2y5VjkZKg==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6994084553bso12635876d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452521; x=1714057321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwv3V9NnGMB5Wj85PeZTAIoBr809/UIjglv9mvQKrBw=;
        b=iaMPTGOWft3GksQrxclTvpTxy9RYe09OKIiZa0ytukq5IB4+WIaq4lA2dYItXzRaRa
         U6cLxctklrYfP7RoQOCgjLQDGgkdW7rembwQg+rEenG4bvhGEh7lRjXkwWhEa2PxVJCU
         PkMwFyLTaOAqu+QFpMpfMiF1uPTXk3//Fh8YFJuQAONletjdklLzbDTuvXJerCO7T2YS
         0Y5lr5qcHaY1FMs9xv5v5BTZBNbkdf+sMN9Qd+45yenAzhTQHX8EuQIeXVgW85I+nn6c
         w0Whkm91G9AztZdT39Pk7LZX7CW7m1zpOd+tzLsYnnQROalsRWJzF+642qVF1Gxu0h35
         af7g==
X-Forwarded-Encrypted: i=1; AJvYcCUdzVK71ZAiCSYYWeVal4YZ9wuXZjFy8X80Hy1i9ydmeZ5FLCxfYRqC1vPrmykiZinGrhL1hVPpe6iZaFDuKtvF87whoFF91z2OEChs
X-Gm-Message-State: AOJu0Yw/xKdJY4BIB+wnSfBMFg8L8Fb+QcVytpqED7Y15f/INuWkcu4z
	nV1GE3xC0L2AKW1Xut1XMD1EGS/OkNTFLHZ2XRhuQrpkUKsymi3QRkY+EyEY9CYw4ZApbozCVDW
	t8fd2tFm/PeWsDcl8Y2OmYJcS8XLk2e1mqiUmLm0dluiQoHXnHVp40OYOKUrCegnCV8tt73xK9n
	pQyzlFrj1P4nMwc4ZIzhxwdSWyGluX36wuE8KEkrePDJG6mOQUC4b00pH3iyE+1dI=
X-Received: by 2002:ad4:414f:0:b0:69b:5961:1ff4 with SMTP id z15-20020ad4414f000000b0069b59611ff4mr2636825qvp.63.1713452520911;
        Thu, 18 Apr 2024 08:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwnD/dVrXbHRIjywyojR4601i9J6JDecCBPGXdOo9n2JxohMovJ/J3JuT2jIjVRTbNhUbSWJ19JUCG2v0M57o=
X-Received: by 2002:ad4:414f:0:b0:69b:5961:1ff4 with SMTP id
 z15-20020ad4414f000000b0069b59611ff4mr2636758qvp.63.1713452520029; Thu, 18
 Apr 2024 08:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418110153.102781-1-aleksandr.mikhalitsyn@canonical.com> <eb0b4b89-9a1f-0e1b-9744-6eb3396048bd@ssi.bg>
In-Reply-To: <eb0b4b89-9a1f-0e1b-9744-6eb3396048bd@ssi.bg>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 18 Apr 2024 17:01:49 +0200
Message-ID: <CAEivzxd_Lz3o8Qmqq6wyfK_UduVL1Qm9jQ9UJaoE_O7wWPrg-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
To: Julian Anastasov <ja@ssi.bg>
Cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:23=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote:
>
>
>         Hello,

Dear Julian,

>
> On Thu, 18 Apr 2024, Alexander Mikhalitsyn wrote:
>
> > Cc: Julian Anastasov <ja@ssi.bg>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > Cc: Florian Westphal <fw@strlen.de>
> > Suggested-by: Julian Anastasov <ja@ssi.bg>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  net/netfilter/ipvs/ip_vs_ctl.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_=
ctl.c
> > index 143a341bbc0a..daa62b8b2dd1 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
>
> > @@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >       /* si_swapinfo(&i); */
> >       /* availmem =3D availmem - (i.totalswap - i.freeswap); */
> >
> > -     nomem =3D (availmem < ipvs->sysctl_amemthresh);
> > +     amemthresh =3D max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
> > +     nomem =3D (availmem < amemthresh);
> >
> >       local_bh_disable();
> >
> > @@ -146,8 +148,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >       case 1:
> >               if (nomem) {
> >                       ipvs->drop_rate =3D ipvs->drop_counter
> > -                             =3D ipvs->sysctl_amemthresh /
> > -                             (ipvs->sysctl_amemthresh-availmem);
> > +                             =3D amemthresh /
> > +                             (amemthresh-availmem);
>
>         Thanks, both patches look ok except that the old styling
> is showing warnings for this patch:
>
> scripts/checkpatch.pl --strict /tmp/file1.patch
>
>         It would be great if you silence them somehow in v3...

Yeah, I have fixed this in v3. Also, I had to split multiple
assignments into different
lines because of:
>CHECK: multiple assignments should be avoided

Now everything looks fine.

>
>         BTW, est_cpulist is masked with current->cpus_mask of the
> sysctl writer process, if that is of any help. That is why I skipped
> it but lets keep it read-only for now...

That's a good point! Probably I'm too conservative ;-)

>
> >                       ipvs->sysctl_drop_packet =3D 2;
> >               } else {
> >                       ipvs->drop_rate =3D 0;
> > @@ -156,8 +158,8 @@ static void update_defense_level(struct netns_ipvs =
*ipvs)
> >       case 2:
> >               if (nomem) {
> >                       ipvs->drop_rate =3D ipvs->drop_counter
> > -                             =3D ipvs->sysctl_amemthresh /
> > -                             (ipvs->sysctl_amemthresh-availmem);
> > +                             =3D amemthresh /
> > +                             (amemthresh-availmem);
> >               } else {
> >                       ipvs->drop_rate =3D 0;
> >                       ipvs->sysctl_drop_packet =3D 1;
>
> Regards

Kind regards,
Alex

>
> --
> Julian Anastasov <ja@ssi.bg>
>

