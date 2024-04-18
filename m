Return-Path: <linux-kernel+bounces-149595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F998A9342
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA7328210F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6B29424;
	Thu, 18 Apr 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVO2Z2bk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46625622
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422426; cv=none; b=oeVviOARmQnj3oPSSTn4gtLxtu54D5oMioDOBWPE0jlBSbCF36uivf8+SmMTDVdKOHCQWR7jqg+uOo9IUkhHiIa/etzfEWWi16cRtkTj5xC27Wz0yzWJWcXwwriDOxLiZc2Tlqw8EAcklnJk65V2P4m9Qx2GK9l2UNSq5EU6/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422426; c=relaxed/simple;
	bh=EH03m7eOfHhtp/BcJ5vnIqquDs8mG7Y94m4YaqVAYs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rk2zT0jFj+9HAi5YWZOsGeuinK/f7qd3nRKoxuXnN7P8Wil29DSacnEmtPZMPGdrR5MjfI4T87X/pHDwwyIARz5bGGLt2jkxOo3dFy5iJAKuDgYOBR4lJMDh3Rv0cBhrIMp15SwK356aDCkdLmuLKV1NJOQceGVP3xqkuy95FSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVO2Z2bk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713422423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNvjTCc6FwOgFUSAbxLYa6iTeIgRgSjn22Bb0lwJRLg=;
	b=DVO2Z2bkuLa8Nh6qi2hEFlQ3GcHGY2aKopmOYn7TklGgMgcJsOSedvMOIFjbeeuGIujPZl
	cL9wowShgm5d49MVKZRskyP3hWzv+yxk6KXn9JJ0MkNth+cptcfwFb2Qy4c018iql7XEnr
	Li6p06PdPMIdcCDOgkgfZvwpm11XfU0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-cWfr648VPK2Ivf_SniEogg-1; Thu, 18 Apr 2024 02:40:19 -0400
X-MC-Unique: cWfr648VPK2Ivf_SniEogg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a4b48d7a19so562511a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422418; x=1714027218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNvjTCc6FwOgFUSAbxLYa6iTeIgRgSjn22Bb0lwJRLg=;
        b=O/MT6T980zHxgcM+zz0cL/l01GZDnp5IXcu1cbx0uQ696AKq0GhA9HLt4/Zci71eiP
         9pRhUSlwcZIR2lb1ziBB8lxyxPrUp5O6fqOGnXm00dWnWuzALbs09LpiakZpYMiBJdkw
         91eCVMP9+msUjPcDAi2S4w9Y3y0VI0Kon5XXpgMEWKr78wwbcIk0a+RlVfp+ha2CxMUK
         D9I9oEVlQEDkpvpISnJns1OAYEDNoKjuSq8ReJwlTJiekA4K1lo59INCJs8w3motVdWy
         HMNNvanTUgKMwfoaMBbxJ8t/71n612HJ08WUE1tmK0TFXDr0fFpCMMrZcdj2c26pX/4q
         +A3g==
X-Forwarded-Encrypted: i=1; AJvYcCXjWNd4m/lU0YI7ukxn687i5xNn+am5aatVrVcGmFn3wqYcJaSnWB43Fs6yLDSmFBXwj+jfqbqjOR7a6MBPqqopnmMPp0HCAOSve28Q
X-Gm-Message-State: AOJu0YwGG5wLoumvgjcxtAwhwS1KzRS41/zc2FaKDsKmdO3cSfKIh60Q
	HS395fK5ZpHoTcKFX68quV0/XbPqq1NfsIPvdCY4msMqjPv3jSBE6c+ReV/GZ+9uUuawS+ISs5b
	l4HJWdLSKY/EVlCKaNpSmWpmsI/s2T2sFJrUxW78rjmrpiO+Yacjn46p0WmudoabpMdT/SPD0q6
	6h1zvmYMgogll4eGOrDxTLDwHHF769IPGd4w0I
X-Received: by 2002:a17:90a:f298:b0:2a4:6ce7:37ad with SMTP id fs24-20020a17090af29800b002a46ce737admr2168454pjb.5.1713422417938;
        Wed, 17 Apr 2024 23:40:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Nqu/T3TcMgalwb0fgZz/LJ+EbTdQaBlb847ZkHwH6OthK4zjz68lfXhfvPUEvk2KNoUUWyOlK+WujobCKuY=
X-Received: by 2002:a17:90a:f298:b0:2a4:6ce7:37ad with SMTP id
 fs24-20020a17090af29800b002a46ce737admr2168419pjb.5.1713422417577; Wed, 17
 Apr 2024 23:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-5-hpa@redhat.com> <202404170023.1zEGO9ja-lkp@intel.com>
 <CAHp75VeKCGSZTb5bGU4YNr9r-z+gXmk4GC5HOZCFcoRQRN37CA@mail.gmail.com>
In-Reply-To: <CAHp75VeKCGSZTb5bGU4YNr9r-z+gXmk4GC5HOZCFcoRQRN37CA@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Thu, 18 Apr 2024 14:40:06 +0800
Message-ID: <CAEth8oF8rXABQqhM89QH4dR=Gqjv-ZkwPHWMEfy434jN6eOtbg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 17, 2024 at 1:34=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:03=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Kate,
> >
> > kernel test robot noticed the following build errors:
>
> > All errors (new ones prefixed by >>):
> >
> >    drivers/power/supply/power_supply_leds.c: In function 'power_supply_=
update_bat_leds':
> > >> drivers/power/supply/power_supply_leds.c:42:17: error: implicit decl=
aration of function 'led_mc_trigger_event'; did you mean 'led_trigger_event=
'? [-Werror=3Dimplicit-function-declaration]
> >       42 |                 led_mc_trigger_event(psy->charging_orange_fu=
ll_green_trig,
> >          |                 ^~~~~~~~~~~~~~~~~~~~
> >          |                 led_trigger_event
> >    cc1: some warnings being treated as errors
>
> Probably you need a new dependency or so.

I will include Hans' two patches for led_mc_trigger_event() in v7 patch.

>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


