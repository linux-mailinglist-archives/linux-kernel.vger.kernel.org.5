Return-Path: <linux-kernel+bounces-131161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805C8983E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77101C228BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1174438;
	Thu,  4 Apr 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqsEAVB+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0DD5C61D;
	Thu,  4 Apr 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712222496; cv=none; b=KkiLkclXRfsdyxtrRUevembsoSeOTLINwcLcL/QCFb7L5Mph57xw8HjY9KcI6GvX3irssH6JT2X9ETLpb1JjfEc5i0sWWmDouzzh+4gxPXxUSlOt3lR8WIEn41d+nJnxvU8Jx5ydmaVUUGrDglr9KZyyjCWnsIb9WEt47gv0qjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712222496; c=relaxed/simple;
	bh=IBtqvebZipirK0kh1olnmPcc8MM/cNoL1tv0Wtc1tsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRTf2mKkTDQuCVP8ixOGRiMtE8DEaaMWrcrosJDSoR0042adF2bEJhTEJaHUnQ4DUYXUHETRdjXwCQHZBerSkQWSaTT55cnD7r9IvkFlA/ArB2ZK6lvBBoC/Q5hnidjCYX64O7YEcxZpdUU0A6b2dzkTg9wXCVvgYWsU6aKF144=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqsEAVB+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e22574eb3so235068a12.3;
        Thu, 04 Apr 2024 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712222493; x=1712827293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBtqvebZipirK0kh1olnmPcc8MM/cNoL1tv0Wtc1tsU=;
        b=FqsEAVB+mb5Q33F0YLS7CIsj1ukh+gk9w1Kfttn/cthVSRV1y21C+moUPKUaEpSaNP
         m6e3T/lhxnowxtdxTe6wOXLTK/esGVXvGiKZM6YnWpoLRmOxMR59iTiCP0h8rKJTPQZQ
         SyPPxsbeiFw3qrE1Gaj7YQ56Ae7B9iQGEi5k+Y4RIVJFbLaD18uwv8tLMGOQtcZBx/LE
         r7UN7L48jGR3voCayr/ufWUQk/bkreQ8X3CqbUHdT8C2EKV4PuZjKqXTFYeVL+hbBptZ
         SqvNagaOEEVdrXulrKn+6xNG9kVjI8eA54gtaataI9PNnu3To+xF+o9Jt9ftOjL+VNsO
         HUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712222493; x=1712827293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBtqvebZipirK0kh1olnmPcc8MM/cNoL1tv0Wtc1tsU=;
        b=rQLDCAx34tCdExH5sHH23d6ytGoONS64QT7DTUxupzPa58LE31fC2n4ta7E/A6+I8k
         DODR96XfOjvpTdWoAjMkHmBVUSmZSWvg6ojpgmzMLVWWoBrblxXLuZ7f23O5jsGwMxpz
         mC/PQVhx81kzDhRvcl3EHDoeHaIWhlbbBb1N6sM857jNGUKCPJEfChxCnCLurfTkgiGo
         KB4boUKwje2zyprL5tZ6A+JUFQifEO/tMcy07dq3lK8594MA3kpYaJ1og4GQxFSyB2e3
         KLmc7FO56cME6vrVBjL+C4y8WUU6M/2QWKSNXr5qpC0k4TE6Pe0N+uDsQ+e1JE9q6MPC
         9JTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4/8Gaf9fQeCRJvihQQSatypRa8sn7SeZYV4HZyDyYkOqQqcEShFfehWdBlrtiIBs6k6AnO8dlLL254nAew5GG/TgYKPhml8DImyDhML5oQmOAZfoJzV1NFfSCiBy5Yjx8J5KBaVwloqGe
X-Gm-Message-State: AOJu0YwSIGeimymtkci/11LdiWNB805+4C5YAM4TznkbQZzqDCeEyVvL
	O8hEyNrKqLPabgTn9Rpkh3vHtPFXT6yXPCh8GmAGwP2Rlps6tTgoYcWo22uJsJO4GpD0PmdkyZs
	82oMD116rXnQ4pbx0txXRBzlwq54=
X-Google-Smtp-Source: AGHT+IEuFsWQzjuoFKH6xP3gUs4bjys7kjQDLGl7XjPe+GUjpbLrwsjQcVsY5ZtSes7AfzSta2BDUCPfEFFQt++PcSk=
X-Received: by 2002:a17:906:6d4:b0:a47:32b3:18c5 with SMTP id
 v20-20020a17090606d400b00a4732b318c5mr1130270ejb.68.1712222493009; Thu, 04
 Apr 2024 02:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain> <de576647-1147-4aa6-9d5f-aa6e3464fe1e@kernel.org>
In-Reply-To: <de576647-1147-4aa6-9d5f-aa6e3464fe1e@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 12:20:56 +0300
Message-ID: <CAHp75VcQXQv26M1aLias2xnsgehqOr1PzX9sztSa_b1Ws=_L4g@mail.gmail.com>
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq flood
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Finn Thain <fthain@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:07=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> wr=
ote:
> On 04. 04. 24, 0:29, Andy Shevchenko wrote:

> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: Nicholas Piggin <npiggin@gmail.com>
> >> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> >> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> >> Cc: linux-m68k@lists.linux-m68k.org
> >
> > Second, please move these Cc to be after the '---' line
>
> Sorry, but why?

Really need to create a Q&A entry for this.

This will pollute the commit messages with irrelevant (to some extent)
information. Since we have a lore mail archive there is no need to
have this (the email itself will be sent to the list of people,
otherwise the Cc email headers can be tracked in the mail archive).
Also note, some developers may read git history on the mobile devices,
meaning small screens, this just (as for backtraces) simply blurs the
information with a high potential to lose significant piece(s) of
information). Last, but not least is environmentally friendly approach
(I'm not joking): having it on thousands of computers, scrolling with
longer time, power for compressing - decompressing -- all of this
wastes a lot of energy (maybe kWh:s per such a Cc list).

--=20
With Best Regards,
Andy Shevchenko

