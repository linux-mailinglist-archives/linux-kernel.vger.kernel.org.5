Return-Path: <linux-kernel+bounces-149946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489F8A982E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08531F2275F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1415E5C4;
	Thu, 18 Apr 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="poMz/N8Y"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E715E215
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438338; cv=none; b=SpsDhhiIG9iV2ZObQ5h4yN9KcXrzrOzjWs0w+SF+Hb3fqvihi2g5BB6dsxIdcUsxMQGDUMS3ZpulQSchKY9JvUhlymaHhlOZNxLU7+VsPC68bTOjh2NAtfzCMAsXgIi7fHQJJVMBGZyz/q7LF/l9mfTDJz1mj1Vy4M75zjo9tcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438338; c=relaxed/simple;
	bh=I+PiGBk9TVIRn1ZmIbTxcCeNUNEu+yZ7+mQReEypCio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4aPuKxY/r8kUB/Z4DlQgzcSZNlkgx3+GT69HQp0RUbXSSlfydvQ2wjKX6A8rlnmZ3Ff7Ug8EK3Tgp6Gu/R4Zd1iuzjq9/sXZi4yIpxzPLTvVxrX2psDiR0qVb5k3t07iIy0Lr3/4ee0eo2T1MvYE3d2fPj0yU8BrzavNi6P7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=poMz/N8Y; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 21C393F68F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713438332;
	bh=S59cR+vrGyi8GrH3u6e9Fe6YHWJc/gBYyRloErg97Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=poMz/N8Yl/laZ87Kahs83Pvw1HeAzDJs2QMUslCq2e1QLaB+zz4xY9harDyIa+dlS
	 fj98EAYxptbfkH0YL2mDivZtCcQRzMWhmmysPCTDOXTWsb+lwILJq+UPy5o8HUo9RK
	 Udr7sHdJfKJm71B4Os5zKkx4yKjV/YaYr8kQtXW7vKMWQRBVNNh4fhjLqEZbKYS+e3
	 2R8D6z1Spizti4KASCrqrOiApies9evW7eVWcw2VSjOybmk31mo/mWULbjQcdb9ui/
	 x34wUi7mpL7o6pyL/J3MkUJqEuV7l23mxZo5HnV479STb9C7u6yUrSmuLYIdfb92Ix
	 cJTZJPtjBSPpA==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5aa2faa7115so1410407eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438331; x=1714043131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S59cR+vrGyi8GrH3u6e9Fe6YHWJc/gBYyRloErg97Bg=;
        b=hyttiQlkwnC1OOab4Z0SsAaWrzJsv0wvVtO1/7ieXDw+KexkomITKdwGl410otQ7Kb
         /wSJRP/0cJQjpbCfkSLmBx7FDVoEW8VvLFNhkFKr2pBu8EhgMUnu70nn1aRPUUvTaybn
         9U/tL0id4FuN2VGnEczcne5UQEZlsuAGd8b5BcZXMnzVOWvicmh3YF9411EVdCOsxru8
         HuG3D9AGQM2mu0tSw0V+ygReoK1tuFYWv2EC33fLIXBw7ZnOmz8qjBc+2Knam/7O/LWS
         XA8wIyluLY4/HKLOtuCWk3866qRiLA4BhKB7C/COFSrc2er7BrPdBuu3YBIUZp4/eudJ
         Ly+w==
X-Forwarded-Encrypted: i=1; AJvYcCVOeshUjc521+cubyFAekSV/DpxvQUEm3oZ6PMM6vksN2zQSIysvqusVwnjn5ToxuhVJyNhWY+WjTu8BAa7ISMf71iX7UJ3R3FtkMRS
X-Gm-Message-State: AOJu0YyYmIXzD2ZAwKoZ/U54s/B8o6oVmOsYb4oLVuNaGLmX2dAXBMeG
	83e+vDKf/Jx5pCoPHEBqtAXQ/RNy9bJr8A3FincixGSs3577z6PGW4S7ALsaK62ihx5FUnHll0K
	RCBQJvkBzsWs0KmDN/Eq8A2NXaSfggvu2OZtKjsulykRq7FNfcDloZ0qHU65GiD0IL8jGcXcxAO
	pT7yqE0MTZG651McA1JWnm5MD/UB3SZ9F3rZoUDGT/B190vRZ6GHka
X-Received: by 2002:a05:6358:c89:b0:17f:87fc:e0cc with SMTP id o9-20020a0563580c8900b0017f87fce0ccmr2915863rwj.14.1713438330843;
        Thu, 18 Apr 2024 04:05:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoqZMTYgUvh9dDDcha8Q7dq0Isr6UZuzRKCg2XQSqf9dzK0Kh0+4b39/DzJ2+6zBH/hKdADicF/jQMZR2Mbew=
X-Received: by 2002:a05:6358:c89:b0:17f:87fc:e0cc with SMTP id
 o9-20020a0563580c8900b0017f87fce0ccmr2915831rwj.14.1713438330517; Thu, 18 Apr
 2024 04:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416144814.173185-1-aleksandr.mikhalitsyn@canonical.com> <32f56a2e-8142-4391-916a-65fe51a57933@ssi.bg>
In-Reply-To: <32f56a2e-8142-4391-916a-65fe51a57933@ssi.bg>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 18 Apr 2024 13:05:19 +0200
Message-ID: <CAEivzxfDLSrHP2H1ou8rccGLOxk5tycZH1+VKt3X8S0QcXNxcA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipvs: allow some sysctls in non-init user namespaces
To: Julian Anastasov <ja@ssi.bg>
Cc: horms@verge.net.au, netdev@vger.kernel.org, lvs-devel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:02=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote:
>
>
>         Hello,

Dear Julian,

>
> On Tue, 16 Apr 2024, Alexander Mikhalitsyn wrote:
>
> > Let's make all IPVS sysctls visible and RO even when
> > network namespace is owned by non-initial user namespace.
> >
> > Let's make a few sysctls to be writable:
> > - conntrack
> > - conn_reuse_mode
> > - expire_nodest_conn
> > - expire_quiescent_template
> >
> > I'm trying to be conservative with this to prevent
> > introducing any security issues in there. Maybe,
> > we can allow more sysctls to be writable, but let's
> > do this on-demand and when we see real use-case.
> >
> > This list of sysctls was chosen because I can't
> > see any security risks allowing them and also
> > Kubernetes uses [2] these specific sysctls.
> >
> > This patch is motivated by user request in the LXC
> > project [1].
> >
> > [1] https://github.com/lxc/lxc/issues/4278
> > [2] https://github.com/kubernetes/kubernetes/blob/b722d017a34b300a2284b=
890448e5a605f21d01e/pkg/proxy/ipvs/proxier.go#L103
> >
> > Cc: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Julian Anastasov <ja@ssi.bg>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > Cc: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  net/netfilter/ipvs/ip_vs_ctl.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_=
ctl.c
> > index 143a341bbc0a..92a818c2f783 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> > @@ -4285,10 +4285,22 @@ static int __net_init ip_vs_control_net_init_sy=
sctl(struct netns_ipvs *ipvs)
>
>         As the list of privileged vars is short I prefer
> to use a bool and to make only some vars read-only:
>
>         bool unpriv =3D false;
>
> >               if (tbl =3D=3D NULL)
> >                       return -ENOMEM;
> >
> > -             /* Don't export sysctls to unprivileged users */
> > +             /* Let's show all sysctls in non-init user namespace-owne=
d
> > +              * net namespaces, but make them read-only.
> > +              *
> > +              * Allow only a few specific sysctls to be writable.
> > +              */
> >               if (net->user_ns !=3D &init_user_ns) {
>
>         Here we should just set: unpriv =3D true;
>
> > -                     tbl[0].procname =3D NULL;
> > -                     ctl_table_size =3D 0;
> > +                     for (idx =3D 0; idx < ARRAY_SIZE(vs_vars); idx++)=
 {
> > +                             if (!tbl[idx].procname)
> > +                                     continue;
> > +
> > +                             if (!((strcmp(tbl[idx].procname, "conntra=
ck") =3D=3D 0) ||
> > +                                   (strcmp(tbl[idx].procname, "conn_re=
use_mode") =3D=3D 0) ||
> > +                                   (strcmp(tbl[idx].procname, "expire_=
nodest_conn") =3D=3D 0) ||
> > +                                   (strcmp(tbl[idx].procname, "expire_=
quiescent_template") =3D=3D 0)))
> > +                                     tbl[idx].mode =3D 0444;
> > +                     }
> >               }
> >       } else
> >               tbl =3D vs_vars;
>
>         And below at every place to use:
>
>         if (unpriv)
>                 tbl[idx].mode =3D 0444;
>
>         for the following 4 privileged sysctl vars:
>
> - sync_qlen_max:
>         - allocates messages in kernel context
>         - this needs better tunning in another patch
>
> - sync_sock_size:
>         - allocates messages in kernel context
>
> - run_estimation:
>         - for now, better init ns to decide if to use est stats
>
> - est_nice:
>         - for now, better init ns to decide the value
>
> - debug_level:
>         - already set to 0444
>
>         I.e. these vars allocate resources (mem, CPU) without
> proper control, so for now we will just copy them from init ns
> without allowing writing. And they are vars that are not tuned
> often. Also we do not know which netns is supposed to be the
> privileged one, some solutions move all devices out of init_net,
> so we can not decide where to use lower limits.

I agree. I have also decided to forbid "est_cpulist" for unprivileged users=
.

>
>         OTOH, "amemthresh" is not privileged but needs single READ_ONCE
> for sysctl_amemthresh in update_defense_level() due to the possible
> div by zero if we allow writing to anyone, eg.:
>
>         int amemthresh =3D max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
>         ...
>         nomem =3D availmem < amemthresh;
>         ... use only amemthresh
>
>         All other vars can be writable.

Have fixed this and sent it as a separate patch! ;-)

Thanks a lot for such a quick review!

Kind regards,
Alex

>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>

