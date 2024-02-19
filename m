Return-Path: <linux-kernel+bounces-71695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5715D85A917
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE4428399D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50E3F9FB;
	Mon, 19 Feb 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="3CClvGDE"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058241C68
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360774; cv=none; b=uO9EeT5WM1/GL5qYIIE9dBrggo9yud7etDEZAIpA1T4vnYSyEHQruCFpmFt4fRLR0w1Q+94n5vXeSNentKm4zD2CK+UeF+OX1yjPzXJAYb+lKkwhVNWsoHcuAfFOgr9Z3/nLLzOsq/56YCqcS2sOIlRXKphPFrnv2IOCYETFWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360774; c=relaxed/simple;
	bh=gk6WUuOUYilwjlmi9KvPeSBtjRyvxYITvt3eyTtNzcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVCd9gWH5CCnhX7fNopmq/QrvZIoVftBGuUxdctY6L0wEkhaQEto3LsDCutgetnfj061YruZ4eVV9fPy+M1i/fQLQNnCtsiVRHFfFzYJQBhNpquBTj1QyUIFodafK1PkkO7v9Y7IAL7tHq8/+xrs6BXlmFp70BnFmAofueRl4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3CClvGDE; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607fc3e69adso33972047b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708360771; x=1708965571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk6WUuOUYilwjlmi9KvPeSBtjRyvxYITvt3eyTtNzcA=;
        b=3CClvGDEnSBT9FQnMKdjaqdE6yUjZpF9oBAyA/4knW1if0VFVWxAAX9GjL8thIyf1m
         TL1aE4z91qgTM7S/e4lyD7oAtMoAg8j2nSERfNcQ/nLAIHy28oP/2WGSIKBt2GFkw4DE
         yaoJcOuk5H+u8u1Q5LUovgC0vVu2JHXxjkArxYEbyDhamXx3mjhm7TMqt6oH7IQyFPpH
         19/vmyZ6CPVt/NWAtmqZgkSpj/gmHVU9Y+51/cwdQBd7j0gpr85kDBT/fBSoLJ3+9qNW
         hXR8UsepoOPcFnyLA0SMfiN+syO6pPwlMW5RgWWt3PijNcmxIUr1eOvtSX9yG34TwGSB
         vhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708360771; x=1708965571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk6WUuOUYilwjlmi9KvPeSBtjRyvxYITvt3eyTtNzcA=;
        b=WZm3Sg8e3HYZzYnq++25YPqVI2hBEmuFK/OBz6gcq6UG2ypvQcJrbZYxpb2mtqvjS8
         EV+uwxI3QR1GH5ziSiMqDIRWodY6Tws+VIx8qtQmH9hbWT+A/nfuLMJcJ6JOY9HseaW1
         pfLas+WtsRwfE0zZS7KpWNF2v6Fubk+7+abnRMqdJuVmfp/AuRgehDTlK/mFuQh3/8Os
         vq+UJKZ0SVpGkjlE6JOFCLjSUBmIt1RNQpFLSPZLTJUuNwvb47U0iAnOFWZckHaMxWR7
         1qByX6mXgec/idoW7jy1Vzx6n7MoUjfF7Qfnx7lZrYJ+5GHderdhKLZJX6Kn/a9tn98t
         o0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqvoUXNi+Ps+E2C13tpKlBHEnkb6dbxXV3tkDGY6gzvRlLZvOOMaqAsq8DLvp6SIy5eMWltzLbKG/5VTxG1lBeYfqRys6D26ndu8HR
X-Gm-Message-State: AOJu0Ywf3MTXhxMhEX2G/ddNasNMS6KYYpbk8unLziZ7VoAFmeWMYjJZ
	ty40VWCsZZid6OuphcavxUztbFPLlTQXboAStmz/JLFI+WH6QSXJvwUBp281j/fM5TC51R6pVTH
	K8B6I2uzUE1Gztq10CM9/t/te6xsrI2OqPwZm
X-Google-Smtp-Source: AGHT+IHOf7zN6UTEUs94Io+Il570qu2MIlpkBfsEY64np8rj8rUeVxwrc0psYvm2LfbR2YZKvPVrXq7xPmkV6NuOIPU=
X-Received: by 2002:a0d:db0a:0:b0:608:218b:5494 with SMTP id
 d10-20020a0ddb0a000000b00608218b5494mr4113497ywe.14.1708360771228; Mon, 19
 Feb 2024 08:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka> <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka> <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
 <ZcFG2JoXI7i8XzQY@tiehlicka> <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
 <ZcFQMru5_oATGbuP@tiehlicka> <CABdmKX35GV3VFar0_pNR_vAXLpvxo+APALXMharsXh6TO+0mrQ@mail.gmail.com>
 <ZcH0wBPvOjqayjAD@tiehlicka> <ZdNFbiH1ufbOTIDx@tiehlicka>
In-Reply-To: <ZdNFbiH1ufbOTIDx@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 19 Feb 2024 08:39:19 -0800
Message-ID: <CABdmKX0-nWU4P7ZJqOMusRCuhewf+kg1x==U7m52=MaKeRCYWg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 4:11=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 06-02-24 09:58:41, Michal Hocko wrote:
> > On Mon 05-02-24 20:01:40, T.J. Mercier wrote:
> > > On Mon, Feb 5, 2024 at 1:16=E2=80=AFPM Michal Hocko <mhocko@suse.com>=
 wrote:
> > > >
> > > > On Mon 05-02-24 12:47:47, T.J. Mercier wrote:
> > > > > On Mon, Feb 5, 2024 at 12:36=E2=80=AFPM Michal Hocko <mhocko@suse=
com> wrote:
> > > > [...]
> > > > > > This of something like
> > > > > > timeout $TIMEOUT echo $TARGET > $MEMCG_PATH/memory.reclaim
> > > > > > where timeout acts as a stop gap if the reclaim cannot finish i=
n
> > > > > > TIMEOUT.
> > > > >
> > > > > Yeah I get the desired behavior, but using sc->nr_reclaimed to ac=
hieve
> > > > > it is what's bothering me.
> > > >
> > > > I am not really happy about this subtlety. If we have a better way =
then
> > > > let's do it. Better in its own patch, though.
> > > >
> > > > > It's already wired up that way though, so if you want to make thi=
s
> > > > > change now then I can try to test for the difference using really
> > > > > large reclaim targets.
> > > >
> > > > Yes, please. If you want it a separate patch then no objection from=
 me
> > > > of course. If you do no like the nr_to_reclaim bailout then maybe w=
e can
> > > > go with a simple break out flag in scan_control.
> > > >
> > > > Thanks!
> > >
> > > It's a bit difficult to test under the too_many_isolated check, so I
> > > moved the fatal_signal_pending check outside and tried with that.
> > > Performing full reclaim on the /uid_0 cgroup with a 250ms delay befor=
e
> > > SIGKILL, I got an average of 16ms better latency with
> > > sc->nr_to_reclaim across 20 runs ignoring one 1s outlier with
> > > SWAP_CLUSTER_MAX.
> >
> > This will obviously scale with the number of memcgs in the hierarchy bu=
t
> > you are right that too_many_isolated makes the whole fatal_signal_pendi=
ng
> > check rather inefficient. I haven't missed that. The reclaim path is
> > rather convoluted so this will likely be more complex than I
> > anticipated. I will think about that some more.
> >
> > In order to not delay your patch, please repost with suggested updates
> > to the changelog. This needs addressing IMO but I do not think this is
> > critical at this stage.
>
> Has there been a new version or a proposal to refine the changelog
> posted?

Hi Michal,

I updated the commit message in V4 to include a sentence about restart
cost, and added a line above each reclaim test to note the MGLRU
config and whether the memcg LRU was used or not.

https://lore.kernel.org/all/20240206175251.3364296-1-tjmercier@google.com/

> --
> Michal Hocko
> SUSE Labs

