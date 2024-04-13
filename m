Return-Path: <linux-kernel+bounces-143608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D048A3B62
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044ED1C218C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6E81CD2E;
	Sat, 13 Apr 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxQqLikU"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF8FC0C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992215; cv=none; b=CHODMHguP2aD0HNHLgWFMUlGdH/p7fTpI4hkdPmZeJTaLaODnpNU4HPY0oIupZnlwbnlFANbhuDGVCHSe5gbGlef0m3OIJtBJG8mu2E6kdPflsint2iQb2GZ1u5gaR9Hht9WEEgH4hIUiKMLlyq4JHmXUP+yC++Sy9BIaF/6COw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992215; c=relaxed/simple;
	bh=LCqlbnelJspV4wN6MJBYSpRItkRjyGaEvsaF23ikJ6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjyZp1yUa+x8I8S1ylHFjMu43J7sdIxf9+1Sfmoz9QO+JyVgmyT2WfcYJ6Mn2QKlofHvVcn3CSHNn2mfMTgFZoBR4kFrkf1nUd6r34+811VoAYuwrL3pQHYitSBdPI0kYzpaMoeotjLJUWIUC6XMmrOFW64YT53NFlq2exNHzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxQqLikU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d476d7972aso20005931fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712992212; x=1713597012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GARVgixrIAugDT0dOyV3omOZipsr/qxypAEnoWoOZUk=;
        b=UxQqLikUe/Y5OkstCQw7Lc7R/cK9kNE/LR0WZ5IerQfvUtdbfljSGWPbNkuBC6ZJvI
         QunqmA7DAEmZFr+eY+gBFQp1YUyGBVrum4/OmYf3oiteTdqy7nYyPIbOF63fTcR+Eg+8
         fqNdQXEP6Jd7zlJLquVBxHS9iY4gWAP1Hw02LyxtfIhFsTsWPeSoM8dwyF5FsVrqpgvb
         uueQYXhP7Awdv4U0RtCSEaJ/ez4dBz0K0rIb7v4Vunf4TExHj9DBIXRPhYWdBQHnPxJr
         ws/pVO1UKwfGjsHj+0Vt9MuwC9ymr84JMHbCGhTAxAUs3AJ6DQZ9mtAmvOw9OJJpYSCP
         Qo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712992212; x=1713597012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GARVgixrIAugDT0dOyV3omOZipsr/qxypAEnoWoOZUk=;
        b=fikIGEy6+b/lv/ooVwNcaPeU+cQ7I6mDZeh61yQPGamR9u/3GkEGCcOjARtp+gK5T5
         U6oUy9acYTpUBYtE0pTsQconx6X90H60FeH/1e/d5KaLEqbHbycGiX/l456KBHAc+a1D
         +Dojh9Mk7boAuJz4al1WSrqNEksBTSBBVleTHeNDF4c45Z33B1Bizcps4MdYU8i73ETO
         DuEgM0I/Uha444NkfQenX/qD+Da3OcXSJpaggLGDKtn4NkFadFmcHcHC9486sqxYM+XW
         fFr/sdWxJ94xcZGygTtHgmGa2R/MqyJU76lFCO6wXJy6d1dIJlE8AXxxgZ/q19Qb/N0/
         i2ug==
X-Forwarded-Encrypted: i=1; AJvYcCWWOv7JpR8NnL5rjZZTXe8BW4YHYpkJpQt+YtOuKxXY6iXjXypKFAnHwTIuMjFrdKRgN+vFPBd8LDmd2i7T6B4luGuq78CP5+GUoCJx
X-Gm-Message-State: AOJu0Yzivn6Wt7p6VwRXGVZsmyeAiX7Hcu+aI1InyDgyZW67vtVOp1mx
	kT8GNsEPMIQdz4/pSnjXxt/N6aU8VXVTLKFjWyAhipxVYitaGAelUspWN+kgTPNaIKKLzFyAbmQ
	B0RmqdJ9TyQV13+F49NC/yZbIiQQ=
X-Google-Smtp-Source: AGHT+IGx6Irk1FWAWdNGyn/y9hGdCzC74P0rW6lMm5Pmqx0heUNcncxBfHB5fMUcXg2ezzB0mzKr9rilR8VoJXT61P8=
X-Received: by 2002:a2e:b52a:0:b0:2d8:5815:4479 with SMTP id
 z10-20020a2eb52a000000b002d858154479mr3082788ljm.44.1712992211763; Sat, 13
 Apr 2024 00:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com> <ZhkoBNudREynp6GQ@casper.infradead.org>
In-Reply-To: <ZhkoBNudREynp6GQ@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sat, 13 Apr 2024 15:10:00 +0800
Message-ID: <CAGWkznHi-GrYv7vujBdhW_39cNRNJsADpSgrH6Rt4dch_Yehyg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Shi <alexs@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 8:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Apr 12, 2024 at 02:43:53PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Livelock in [1] is reported multitimes since v515, where the zero-ref
> > folio is repeatly found on the page cache by find_get_entry. A possible
> > timing sequence is proposed in [2], which can be described briefly as
>
> I have no patience for going through another one of your "analyses".
>
> 1. Can you reproduce this bug without this patch?
> 2. Does the reproducer stop working after this patch?
>
> Otherwise I'm not interested.  Sorry.  You burnt all my good will.

This bug has been reported many times by three people including me as
below for at least two years, have you ever tried to solve it? Do Dave
and Brian also burnt your good will if you ever have? Be aware that
you are the maintainer who has the responsibility for maintaining the
code but not us. "To wear crowns shall bear the heavy or give up". Put
me on your SPAM list, thank you.

https://lore.kernel.org/linux-mm/20221018223042.GJ2703033@dread.disaster.ar=
ea/
https://lore.kernel.org/linux-mm/Y0%2FkZbIvMgkNhWpM@bfoster/

>
> > the lockless xarray operation could get harmed by an illegal folio
> > remaining on the slot[offset]. This commit would like to protect
> > the xa split stuff(folio_ref_freeze and __split_huge_page) under
> > lruvec->lock to remove the race window.

