Return-Path: <linux-kernel+bounces-112071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15D48874DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F761F2351F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774EF8287D;
	Fri, 22 Mar 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnVZWImx"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26D60253
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146797; cv=none; b=u5OxUAKMDJiKq46bdiA9AlnkUXsJSQ6l42W6Du2QS64QrM1H7LHHcd60YrC144j8aY/YFTQUg07A9RnPUcWEyS4oHTGDIw3D4lgeMq4kImExYYOdt7esmYzyp2ewrxD7xy94/99pD1KI954cxMNlqkPwW8OHDJdpWKv96riObTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146797; c=relaxed/simple;
	bh=Cnfm9xdwmI7Yzkhi3AqNU+hvsi8BXcsiP+kyU3wPosw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiZN8gdaPspCakM3TEMNwb35EYgo2b6tbe7SiCH29G/GbwMCiYWOdiE5DJDkVQh6Hsv5GMM8dcIqHJJXrjlsIpjmqhR5uHlNvCBJICaowSNBWRt+b1VHIUFy2hftGBzUUvyCvyCZaMbltNTRd8ar09OxBhyCqr8iO3LuHUprdNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnVZWImx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e6fd225b40so2021794b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711146795; x=1711751595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cnfm9xdwmI7Yzkhi3AqNU+hvsi8BXcsiP+kyU3wPosw=;
        b=bnVZWImxnTsnHVOc/zTwVyt7hNAExMAw4lsNsfpUp9UrjMUrHhwyJCPX/DmrymuCmi
         gbENqP8lzNT0/TZMoBclpr8w0VvoJl2YE8hhEdr523UWaZC9qMhrlEc67/qRbz+pYGBV
         SCZD6Rv/GqJoPe/AlP5jePqE7g8mVJ4Ge7V1VEAstr3ajPL+JX/7c6svsQTR7OOw5cAH
         XUJgqHqB65UijUxliL0V1mmx7cAW2oX9Og79QbitINYfmASDCB1DmPJio/49CLazNDHW
         YV6tCzG/Wl9rIs9jk/NJpVue+F46OwLQkq4TZkudle+LjRbZAOEAk6+jFL7XXabybCcn
         BDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711146795; x=1711751595;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cnfm9xdwmI7Yzkhi3AqNU+hvsi8BXcsiP+kyU3wPosw=;
        b=DfUC/w+VkJqPf8NFLkjMx1T3mpTyQpNBb1ifyklncNgQ/12kKoJPUvo/HQP01k3QzT
         fbD/3bVSu6X46lywQw8Q8plVBlMLFH/iOfPAYmGYN5Uq8reqQ+IVVGE1Arxy7Utr+KNq
         jr8BDmjAKq3Zc3rUVAWT0B0+NSMRBp1ZP//bQdIgQ4hwNAUUScIsmnLnIuFBMuGlmtrA
         x/b1Phm4IBFOTNzAoWuERWUSxmNlsC+4i58y8flPV2LahTesOD/Ah+8KhguG+AS9UT08
         pxkMVqxke44Y4WGZN750rMyyEr8muP4fZNfP9c1RIQVY0IGv7CL3LZtjr1eBkwmsfHCE
         XrdA==
X-Forwarded-Encrypted: i=1; AJvYcCWscKjAZa3Zp37S0AY4TCuoIgbDUG+c3aOIRm5YAWOXk3AMp6mnYOwfZg6A/hPCjt5c5JEAkN2BiVXj4P7w3lRK0HQTSxK/ibal5sTV
X-Gm-Message-State: AOJu0YwYXURVpVFDq6hbGTUeuoDH3AAjLZfMEFUdVIwI98jvIbn2g3fA
	s1nx226WW7TlNK73UhkLrkRepLPwlae6azaXOMUwSG09lZeUTPFKrXUzPsGBzRBcIYENwT4X6UM
	pm60McS6M1tnE29SN8g==
X-Google-Smtp-Source: AGHT+IHXtPdRtQD6tSe9r59cIEYeBNGQJ2Ol6DFvxFMGUt3I71z9xOo9m9Lxj1/3bSVlDo2ISMsGFxYYgHvOS1Yt
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2d96:b0:6ea:8938:b069 with
 SMTP id fb22-20020a056a002d9600b006ea8938b069mr70242pfb.1.1711146795474; Fri,
 22 Mar 2024 15:33:15 -0700 (PDT)
Date: Fri, 22 Mar 2024 22:33:13 +0000
In-Reply-To: <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
 <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com> <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
Message-ID: <Zf4HKUpKpDWZygni@google.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: chengming.zhou@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 10:41:32AM +1300, Barry Song wrote:
> On Sat, Mar 23, 2024 at 8:38=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Fri, Mar 22, 2024 at 9:40=E2=80=AFAM <chengming.zhou@linux.dev> wrot=
e:
> > >
> > > From: Chengming Zhou <chengming.zhou@linux.dev>
> > >
> > > There is a report of data corruption caused by double swapin, which i=
s
> > > only possible in the skip swapcache path on SWP_SYNCHRONOUS_IO backen=
ds.
> > >
> > > The root cause is that zswap is not like other "normal" swap backends=
,
> > > it won't keep the copy of data after the first time of swapin. So if
>=20
> I don't quite understand this, so once we load a page from zswap, zswap
> will free it even though do_swap_page might not set it to PTE?
>=20
> shouldn't zswap free the memory after notify_free just like zram?

It's an optimization that zswap has, exclusive loads. After a page is
swapped in it can stick around in the swapcache for a while. In this
case, there would be two copies in memory with zram (compressed and
uncompressed). Zswap implements exclusive loads to drop the compressed
copy. The folio is marked as dirty so that any attempts to reclaim it
cause a new write (compression) to zswap. It is also for a lot of
cleanups and straightforward entry lifetime tracking in zswap.

It is mostly fine, the problem here happens because we skip the
swapcache during swapin, so there is a possibility that we load the
folio from zswap then just drop it without stashing it anywhere.

>=20
> > > the folio in the first time of swapin can't be installed in the paget=
able
> > > successfully and we just free it directly. Then in the second time of
> > > swapin, we can't find anything in zswap and read wrong data from swap=
file,
> > > so this data corruption problem happened.
> > >
> > > We can fix it by always adding the folio into swapcache if we know th=
e
> > > pinned swap entry can be found in zswap, so it won't get freed even t=
hough
> > > it can't be installed successfully in the first time of swapin.
> >
> > A concurrent faulting thread could have already checked the swapcache
> > before we add the folio to it, right? In this case, that thread will
> > go ahead and call swap_read_folio() anyway.
> >
> > Also, I suspect the zswap lookup might hurt performance. Would it be
> > better to add the folio back to zswap upon failure? This should be
> > detectable by checking if the folio is dirty as I mentioned in the bug
> > report thread.
>=20
> I don't like the idea either as sync-io is the fast path for zram etc.
> or, can we use
> the way of zram to free compressed data?

I don't think we want to stop doing exclusive loads in zswap due to this
interaction with zram, which shouldn't be common.

I think we can solve this by just writing the folio back to zswap upon
failure as I mentioned.

