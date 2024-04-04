Return-Path: <linux-kernel+bounces-131162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF378983E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422411F24895
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4519745C2;
	Thu,  4 Apr 2024 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNqXEOVs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0E5E07E;
	Thu,  4 Apr 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222684; cv=none; b=rBnNEuvGCzz5pDOryqW/eY+qNuzkZcqHhPlsqk5X8/IFmtJc75mci0Dw+MTOQ9MUkKRl9MsNmfM/FrqSruFlW9GayJxVEvwDczbBDSXqJcw+fb2XVB/W5rmxNDvM/Ra5rZ60Jh6ixqSOcDJmsB1OSa1sDSL/m0cAxpqw8C4XsiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222684; c=relaxed/simple;
	bh=RBVrbKnK3ovQO15P41mcUHM/iUWBDjuiISow2hRyoow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1rva4fCRUhi2lDpP+jEcEWuKmeK8C57JKZZNaxlL0K3IJkF6OtAJ9NLKasB0e++fgKKEJIe+K/1ET5hrIQcaeRaSTp2woZPpV2cxKvdTeD8PEmg5H/1TF7A0NTYUscYonvGRMk8v/Z5UEMzzxAprNzJ7psq4iXRTRpmWRODzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNqXEOVs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a466fc8fcccso98141466b.1;
        Thu, 04 Apr 2024 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712222681; x=1712827481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBVrbKnK3ovQO15P41mcUHM/iUWBDjuiISow2hRyoow=;
        b=mNqXEOVsf+pue+KHm24IpmiOAfnvPEmCqZjLDmS6yvkMYf+PlS6GRALfbV4kz638mu
         djKY3ZT7CtU+iGvLn1Mm3VnNfVdxxMFADFQzXFg0lY0wi3J22Aqr09Mn6ZBEECVN/mOS
         aS7K/23r/hij3wVjuNeiIRhcf4sNt6tlnQ2MI8k3Me8KQoBdchkneXBgG7FEIrLJuPk8
         5801CJf952WMTppRNNAP2lLLV2nOrzW3AR1We9rvpSJSJSmLCk5YdQzQS0PuDQ7btbmL
         iRxYDvRFf29Qw1s5u1t8K3rYGo5F9mE1DTl8LvOI1ljj4I0y41CekQu9voL8n+PDkiiv
         BfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712222681; x=1712827481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBVrbKnK3ovQO15P41mcUHM/iUWBDjuiISow2hRyoow=;
        b=ee5Ecii1oSzobuH0E5CX9/oLKJ+icC4WR7jOaP/a17Kmklf7Cfu6Jp/M1keGd6i+aG
         JWDF+24S0CJAvOQpEb7o5Z+jqRweSP31t5m13WWEzoLG79xpgD/EtT8lgeIE+hCODuuz
         VU8DIXPvMnHULNiMIqLYDKWVFuXJsv95yySB9EsvOCK67R5yCHiJAYXkM3ohCRmjkCHK
         4y/6ShZMRFs51mXZSJKUWWPfDGIP6nMsSlclBmYoqbvvTjA5qUJKznxewKHX5B6B4cJ1
         x7j7ZmxqbZqXhZT60Duo9uBuTpaIiWqaiU5PeZKOG7YkXDwg6ljyELzmtjd1JPM7N8Hf
         ButQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNK2FNAFCsetn7kidKcAy7SoofAwOShhjjik0a87n9EgLiYXd2PxMfx1Spn1OMFERi/GTGs59OfU4Q9dHRK/fZFkbytgWxkEq/m1MQyuqfULkXPFDGMaBbd8qt4mkpjEl4YxF3/o4syIdB
X-Gm-Message-State: AOJu0YyMQsueOtz4EsmBYpjTvbXcRpQuiK9bhLe9tDzyeUYw26ZcPAIo
	qogBrMA4BToBbR430/63jgR7E3NKxWb0E0X+OQ3ktqEBKtBIMR8irGhWfm3jbLBi0IU+2Y5jCE1
	LrNKAn0GEfNARWG6qrwMdGiIB9Aw=
X-Google-Smtp-Source: AGHT+IFFuzK/Tj73r6cElPFLHYS0K+qrK8YOabFg09GALNmzfEyOCxxfGhkrrxxnyxPeh7bUQ1le67F9/FyVLwJu/PI=
X-Received: by 2002:a17:906:6dd2:b0:a4e:1055:8602 with SMTP id
 j18-20020a1709066dd200b00a4e10558602mr1069503ejt.19.1712222680512; Thu, 04
 Apr 2024 02:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain> <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
In-Reply-To: <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 12:24:04 +0300
Message-ID: <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com>
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq flood
To: Finn Thain <fthain@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:57=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> w=
rote:
> On Thu, 4 Apr 2024, Andy Shevchenko wrote:

..

> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> > > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> > > Cc: linux-m68k@lists.linux-m68k.org
> >
> > Second, please move these Cc to be after the '---' line
>
> I thought they were placed above the line for audit (and signing)
> purposes.

I didn't get this, sorry.

> There are thousands of Cc lines in the mainline commit messages
> since v6.8.

Having thousands of mistaken cases does not prove it's a good thing to
follow. I answered Jiri why it's better the way I suggested.

> > > Link: https://github.com/vivier/qemu-m68k/issues/44
> > > Link: https://lore.kernel.org/all/1078874617.9746.36.camel@gaston/
> >
> > Missed Fixes tag?
>
> Would this be ok: Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> I have to ask because some reviewers do not like to see a Fixes tag cite
> that commit.

Yes, or you even may dig into the history.git from history group (see
git.kernel.org) for the real first patch that brought it.

> > > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > > ---
> > (here is a good location for Cc:)
>
> Documentation/process/submitting-patches.rst indicats that it should be
> above the "---" separator together with Acked-by etc. Has this convention
> changed recently?

I see, I will prepare a patch to discuss this aspect.

--=20
With Best Regards,
Andy Shevchenko

