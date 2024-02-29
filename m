Return-Path: <linux-kernel+bounces-86888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B0886CC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3462C1F23855
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3A2137772;
	Thu, 29 Feb 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cx1Xa08R"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A141E885
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218982; cv=none; b=X/EmrhpLusDEKQNvmugq0aBpYNjb28XKNQDFbUkYPPXVnIxxdfErsD2slRTIZMgqmrZPWOdnnCXhOq2KGKjpxocP0/WaNIPg35DfrB/DcUXxt3dcjdOXJ8XFv6oEMNznOS2sg0k7kxvGpS4ewBMkdXn+fa58kluwuezcfLIz9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218982; c=relaxed/simple;
	bh=cQcFxqDajIh61LAgGE1PEswk3De48/DL2Y1kXjUPNkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNdFK8G5QO/+A/WvuGDOdE5C6Nk24sYmvkUIIubPoWQZ9Ypajk6alz1aJl1pHEqC9jUG65kj2YT9gx7JG9GlwooGFs1WDtw1CRzZgutB82KzoeMBIqan2TnMGWHYSmooJC2pzto9JeK1fX4KoOk0dmXcSr4p1ZTdGsQO8hRHP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cx1Xa08R; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso4699a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709218979; x=1709823779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Xt7r0iy2ZKjZiKFpfmpzIBkzlUZzfD5jbJ2OWHmQhQ=;
        b=Cx1Xa08RKfDUuYtSVqMFiOuhTlFmiRqmxTOcDz51utKAaQJAACzcGtnrsNza2FUj6c
         u9KCvCb9LrFap3hlwDO2MJQuvad187/bh9EFnvo0zQhw94nY1UThQ1LXt/6lUPmYnsdi
         M1XF6oL3+TTYhMvRtCLDfbpydcgEXkkglltCowYKBu9WcTNipKRdMGhqTSK8nsItRdAL
         UHGO93Obpzr/tPK6Vkqc+y0zen91c1LLKb1SyUYZIXxdL/YDeqMqKBwK4DHjt9rk4B/T
         n7wXMsydDGpnBloAe2b3BViiTDrQieNLm6IQOy3g+v+jsEQor2IF3XqMRak5pQJLPbrF
         0sqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709218979; x=1709823779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Xt7r0iy2ZKjZiKFpfmpzIBkzlUZzfD5jbJ2OWHmQhQ=;
        b=dnFaLkNhHMUx2i+OU8hlMs9TBKUeoTphkiU6ID9/uNiYbmx5+fGBQ80wUotCxev+OM
         zBp0zm8/P79sCLPOuZZlPJMPsjT6rm1ywfCJ3sWrYKMWLkfg6LvHwQg5aCNy8sNrxNDp
         VI6WOAte9WuBa2olShc+fs+bGBWrMOSdfTdhY9Sr80cOXxhjPUZFAkKCfbgdhpgKT3OW
         fTNnUZi2D06GO5mOC3/9v2NNtclUU0VhjBv51Fs+p39EKwkXEapf/NQuWGapWVHa1Ec+
         LzgocK1J4jsWzEa4hlUcFebKNa7LKbMWrscpqQMcPI9CHJ3slVPEcrGqSA7y2UyfMdFa
         Q3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUVmPQug5FUsyIWKtyQfrWkmIAXru95/1HGf6Q1MB2t2NmT8dRs1Twhek9nd+A8esTX5PilB08RFeT+HcR8IpNxJsuvMgMGpKMgWz2p
X-Gm-Message-State: AOJu0YxpUdEBENC7ctb5ANVPEUV0NB32URS9/AcBBCpcZTTP1LnE7pxs
	7Km1oZPEeDFWTIG8U9Y2VBYprrBN90O8vpoIlWNoCSdSKW/iGcg5/NgwnYXmESjaBqTpxy0AHdB
	/Z4+zGN43+L9M2Uy9wJzEVqWc/duHzc+zi3h+1BKW1mJ3wdZP7U8J
X-Google-Smtp-Source: AGHT+IHKKvFohCmsqwznChrSRNtAgrRFA9gi2zMoaC1rwF8TzuG0km2vSc+rjeIkq6wfRbw6opIJuwOoddvxCCvQ8EI=
X-Received: by 2002:a05:6402:34cc:b0:565:d0e4:d8a0 with SMTP id
 w12-20020a05640234cc00b00565d0e4d8a0mr131215edc.3.1709218978541; Thu, 29 Feb
 2024 07:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com>
 <85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev> <CANn89iJEzTjwxF7wXSnUR+NyDu-S-zEOYVXA+fEaYs_1o1g5HQ@mail.gmail.com>
 <a1fdd2c2-4443-458e-86db-280e7cbd4a36@linux.vnet.ibm.com> <CANn89iKdaMFCKnGRL4ffnbyrr2PUaKn1hoiu4VZ=sRyX=Vy0Wg@mail.gmail.com>
 <20240229064742.36c2f476@kernel.org> <CANn89i+4Q2L7Gd5zGrSwT_v2wjL-ZKEFcM=oQ9w090+xc57HTQ@mail.gmail.com>
In-Reply-To: <CANn89i+4Q2L7Gd5zGrSwT_v2wjL-ZKEFcM=oQ9w090+xc57HTQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 16:02:47 +0100
Message-ID: <CANn89i+xNW5Dg2UgHWPdoqW8Cq9a+KVV2TJCbGqrt1StZx0b=Q@mail.gmail.com>
Subject: Re: [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, arkadiusz.kubalewski@intel.com, 
	jiri@nvidia.com, "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>, 
	"mputtash@linux.vnet.com" <mputtash@linux.vnet.com>, "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>, 
	venkat88@linux.vnet.ibm.com, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:53=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Feb 29, 2024 at 3:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 29 Feb 2024 09:55:22 +0100 Eric Dumazet wrote:
> > > I do not see other solution than this, otherwise we have to add more
> > > pollution to include/linux/netdevice.h
> >
> > Right :(
> >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index a9c973b92294bb110cf3cd336485972127b01b58..40797ea80bc6273cae6b7=
773d0a3e47459a72150
> > > 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -2469,7 +2469,7 @@ struct net_device {
> > >         struct devlink_port     *devlink_port;
> > >
> > >  #if IS_ENABLED(CONFIG_DPLL)
> > > -       struct dpll_pin __rcu   *dpll_pin;
> > > +       void __rcu *dpll_pin;
> > >  #endif
> >
> > If DPLL wants to hide its type definitions the helpers must live
> > in dpll? IOW move netdev_dpll_pin() to drivers/dpll/dpll_core.c
>
> Oh for some reason I thought this stuff was a module.
>
> Otherwise, why having dpll 'core' helpers in net/core/dev.c

So, we would have something a bit convoluted like :

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 4c2bb27c99fe4e517b0d92c4ae3db83a679c7d11..241db366b2c74ae749f49612d86=
176b2f8f479c1
100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -42,6 +42,11 @@ struct dpll_pin_registration {
        void *priv;
 };

+struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
+{
+       return rcu_dereference_rtnl(dev->dpll_pin);
+}
+
 struct dpll_device *dpll_device_get_by_id(int id)
 {
        if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 4ec2fe9caf5a3f284afd0cfe4fc7c2bf42cbbc60..c60591308ae80fb99aa5abb5832=
b9a228473a916
100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -169,13 +169,13 @@ int dpll_device_change_ntf(struct dpll_device *dpll);

 int dpll_pin_change_ntf(struct dpll_pin *pin);

+#if !IS_ENABLED(CONFIG_DPLL)
 static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *de=
v)
 {
-#if IS_ENABLED(CONFIG_DPLL)
-       return rcu_dereference_rtnl(dev->dpll_pin);
-#else
        return NULL;
-#endif
 }
+#else
+struct dpll_pin *netdev_dpll_pin(const struct net_device *dev);
+#endif

 #endif

