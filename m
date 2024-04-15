Return-Path: <linux-kernel+bounces-145742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE78A5A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24401B226CB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64B155A59;
	Mon, 15 Apr 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gpnU87sC"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF9155734
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207776; cv=none; b=YN//SQVRc4mF5kCcifcCnGoAoXLVr7H5SmW836FkgoPQmWvjSpGbTJ2AkggTVJRaNG2iO/tFVucwJ3mnGMi7qK7hFTH3/h5PZknpHS/WvrtksV01lGEkzXbfGrBDheJLQJQ8DX8GTa0TX3M7amq16nckp/Zs4Kx/qC5fLnOE3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207776; c=relaxed/simple;
	bh=+Sl0KDp+f88KlkN5sL9qL6tcIvj36qePcyg1XNCcTOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+NxDt6xEON9czlZEx1AvymvyIjxIQyfI9rF3OdXFReHmK+Ex1srNs6xEmtEdaMe7Fn5yqxu5tHC74pNCxKNjFNYHEJdEIL7SzWpYXf7FjOxkGFOXQ/WEfMIA3247VRMvvjCUc2UOtvJHV1o6opDob6WNLa8y8bExR82DCvjNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gpnU87sC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb8ae9b14eso350568a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1713207774; x=1713812574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnuzy4YohZRKFHiloeA4mVaIUDCwUMILHZ7C0FksI2Q=;
        b=gpnU87sCjG2A+yB1sR0hx6yrIJCj3mqA1/XkVLX+KUMZzWfSj3yqLc2mLJAUp5+r98
         QzW7bEDH38MDio36RdPPhAjeB03vh2jCKtmE1aThRdtB1m3dXIFOmTi6T7eAxaER1S/V
         hEArF/ktmVVsN6/O6kanNscl75ylDXidH+BMuhQkDrKp6IW4OmlvEpI+4c5dh9Hmz29B
         jnP9U+DQItj04Grz+HTaMAmnDee1np67V6Vni6ARWGADAvrbN5a6rmMsmPAiEXJebXQy
         Ultkl7CXrG6qSmavylnPPb+gf6OGkqoFMGoMK7e3fOfO+F7u60dYs6PQlCzLmVCV+trO
         UWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207774; x=1713812574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qnuzy4YohZRKFHiloeA4mVaIUDCwUMILHZ7C0FksI2Q=;
        b=gYq96WN8gTiVGWJbTOvLzPOZZusTJG6IplMOiwO8SwWw4Jq+QjPG5qIyjiwG2qEEOL
         EE34lQ9ln8qPyNx4oVvmnQVjBjrBTH30dYIJ58E9fpTuRvRkeNbQFPYbwb5Vc9aFkA2Q
         v0H3WE5juxsbsPNFVcGgBlRQ3PhCkAE5JcoDheh5N28FhQeuMhJ/EHSXL++xu1l4npLH
         x2KmjYSRNWAcxFUlhg36SSfsSVvb/IE70J1P/HVBcNDSMjfQKh3J34hZa4FszX7h5No3
         jZyfT5WtfXA/hmBHycTe+VXlytWj8eiJYOehb7oFH0nE43ZZGiSglmP+ey0UJwFej7o7
         XBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlfHU6PUXn9w5+r3OYi4F96MPGWbd33dk7nmKP4pOdYM37GDe6UwsID9i7t33b7SQH6z9tEph9TndjixoAm+C/pNaNOOkuD9sSRWHc
X-Gm-Message-State: AOJu0YykasAbcxE0mnycvkn9TusPAImOlfzwEuVNXM6VFQvxAaiHE92w
	W3lqlZeNc+oVicxbpmL0f7knQuQbQjDOKPh6Vm5ToXUoNK/yM4KbiWj/bt0YAYjSAMqsCGMs+4q
	JQU+BcEx8ULMzKBVp61/ckoOTgWFAwfvs6Qb6
X-Google-Smtp-Source: AGHT+IEZFN4hbYjCj1ww/D1sjvqe8pOqx7vvJkr0xZqROOpJDxITAIMHtAwtRNrZa/YLYN0XY/RRnGvMJysW4KwpFmQ=
X-Received: by 2002:a05:6830:1484:b0:6ea:386a:44d8 with SMTP id
 s4-20020a056830148400b006ea386a44d8mr11138794otq.3.1713207774198; Mon, 15 Apr
 2024 12:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com>
 <CGME20240328155911eucas1p23472e0c6505ca73df5c76fe019fdd483@eucas1p2.samsung.com>
 <20240328-jag-sysctl_remset_misc-v1-2-47c1463b3af2@samsung.com>
 <20240415134406.5l6ygkl55yvioxgs@joelS2.panther.com> <CAHC9VhTE+85xLytWD8LYrmdV8xcXdi-Tygy5fVvokaLCfk9bUQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTE+85xLytWD8LYrmdV8xcXdi-Tygy5fVvokaLCfk9bUQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Apr 2024 15:02:43 -0400
Message-ID: <CAHC9VhT1ykCKnijSbsgPXO9o-5_LHAtSm=q=cdQ8N9QH+WA+tw@mail.gmail.com>
Subject: Re: [PATCH 2/7] security: Remove the now superfluous sentinel element
 from ctl_table array
To: Joel Granados <j.granados@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:17=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Mon, Apr 15, 2024 at 9:44=E2=80=AFAM Joel Granados <j.granados@samsung=
com> wrote:
> >
> > Hey
> >
> > This is the only patch that I have not seen added to the next tree.
> > I'll put this in the sysctl-next
> > https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?=
h=3Dsysctl-next
> > for testing. Please let me know if It is lined up to be upstream throug=
h
> > another path.
>
> I was hoping to see some ACKs from the associated LSM maintainers, but
> it's minor enough I'll go ahead and pull it into the lsm/dev tree this
> week.  I'll send a note later when I do the merge.

.. and now it's merged, it should be in the next cut of the
linux-next tree.  Thanks!

--=20
paul-moore.com

