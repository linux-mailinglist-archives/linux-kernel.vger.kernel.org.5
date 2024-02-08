Return-Path: <linux-kernel+bounces-58174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A984E24C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090FA1F2580C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4827866A;
	Thu,  8 Feb 2024 13:50:18 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76476414;
	Thu,  8 Feb 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400218; cv=none; b=hdSeAn9vIp3FUpMDASEU5Z4q+1+g5EZWaK+kGupiN7LP/p+dN0LhcMdCYnvRoTM60mTng3+uPvkPElnDdMA8RD6kcHefjZJmdlzLsohJ2bh7gshqNAFmBtXiA+NtOHymq9p9g0qQUsOqCeBlrq1wlpriAR8CVnSdMA56ZZHCfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400218; c=relaxed/simple;
	bh=k1NNnC+yIkCrCM9yvFPbzgg4mQWnvkfU5Su8+mooQjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnSFBKe7p2hNccAgmE/oQaxDmnr+hfef8/OMt93xgXX2W/Yc/9XlBnJU5wQg0KIdFlfe4OJF1Y1BWuBzj7NmT6uoeeUKTjpGWWXFc40JSa7ZMt7D9tu29vTRwWr1HUiTxazr2xs/LIZOK8aKLX+OORb5evBLS84WlWjCR3ojysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59ceb5a0593so88779eaf.0;
        Thu, 08 Feb 2024 05:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400215; x=1708005015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1NNnC+yIkCrCM9yvFPbzgg4mQWnvkfU5Su8+mooQjM=;
        b=Fkjbx+Oug0yMcSFRCWVJWmt47tqoG7PpIBNN3jR2mGkAvMTajPKII8JuGqrPIc7s1O
         rY3wRFv9c6smr7mYFFRPgZ5AZK85vojztvQ6LQTN/oAB/6nB6ZKXWPVw0AFSX6P+n/Bz
         j2TRMmG3SaH8boMCxv2JZKNvPiVYJUfDRymvMyLvqjt2CP3crXQq+bimcjyYqFFOSbfz
         Kca5B1typT9tvq09mzt/t5ck6mFBG0LUcD4wU4Lr/ZbV3mhwv91R++xhXk9Cr2mSrU6Y
         +oumcZM/HaRRJWGJcOvNtPlWCtEqWg13kt+6LjZlHaR2cCdeiKAlo7niZkcVu+wRLduN
         So4g==
X-Forwarded-Encrypted: i=1; AJvYcCVeBL99d/XNtQa5+ZejZgXIjMWeAyvb9AL1obmKdKenc6wgGUrmTw2X/8gRfuFcal8GHRysVK8RMjxcGyqgu9QFDs1k1rkTDAbuk5Mh6L3jGHFF01AMFvdZjPSURASuUbjiv2PcCnX3iWRNCRjEJAEZRxE0CpuNFaYEKrQS3iYjlEpsJ2fdgw==
X-Gm-Message-State: AOJu0YzcrtMro2v+A+XQRD0Rl3Tt+HyMy0Z5tx9ZPP/lLSjBN9BsKbjq
	amV74XDobwUHFgRZrsypRHpjPXGdDat7zNiaquMh13KZ8SCGs3x/958NV9nY7BpsdXTJZ+YfR/o
	p0kwqKAIoxZio1meVV9cGU0QqjMGHDt+R
X-Google-Smtp-Source: AGHT+IFrHZbdxODDdLyWqBUxhFjB1P+AqoJNJ1xPFPQDZ/b7oFC9u7YlZf0fX+tEbY98hT/0tcyd3wUvvg2ffkSaTw0=
X-Received: by 2002:a05:6820:405:b0:59a:bfb:f556 with SMTP id
 o5-20020a056820040500b0059a0bfbf556mr8799733oou.0.1707400215608; Thu, 08 Feb
 2024 05:50:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1892445.tdWV9SEqCh@kreacher> <875xyzh4ah.fsf@kernel.org>
 <9e740b50d7798b5d01c0a3c9e328ccf90978d30c.camel@sipsolutions.net> <MW5PR11MB58101FBF45EFEC362A8A1E18A3442@MW5PR11MB5810.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB58101FBF45EFEC362A8A1E18A3442@MW5PR11MB5810.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Feb 2024 14:50:04 +0100
Message-ID: <CAJZ5v0ixRs0cM0ZMnSY5K7PMcHwiZy5OL3mAMFQ=yTZuHpVr1w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:26=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
>
>
> > On Thu, 2024-02-08 at 08:13 +0200, Kalle Valo wrote:
> > > >
> > > > If possible, I'd like to route the $subject series through the
> > > > thermal tree, it is requisite for the above one.
> > >
> > > iwlwifi is getting a lot of patches lately, though I don't know if an=
y
> > > of them touch the thermal stuff. But if this patchset goes to the
> > > thermal I am a bit worried about conflicts.
> >
> > Should be OK, I checked now and apart from the trivial change in mvm.h =
this is
> > contained in tt.c, which isn't touched (even in our internal feeder tre=
e) after
> > commit 0106cce5ad0c ("wifi: iwlwifi: mvm: drop NULL pointer check in
> > iwl_mvm_tzone_set_trip_temp()").
> >
> > But I'll let Miri send an Acked-by to go through your tree, since she's=
 the
> > maintainer :-)
> >
> > Johannes
>
> Hi,
>
> This seems fine to go through your tree, as Johannes said, we don't expec=
t any conflicts.

Thank you!

I'll go ahead and queue it up, then.

