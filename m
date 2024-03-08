Return-Path: <linux-kernel+bounces-96981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0694787640F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28791C20C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AA85676F;
	Fri,  8 Mar 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp5Fx7So"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E455E57;
	Fri,  8 Mar 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899881; cv=none; b=U9hZqeESfzfcUM2tcAH4FpI/zgdun6P7xAIgpl9MCkTyFuYjDD08Tt0/vpPvAsXdGYctKd3W82EoeUChobTDGh8z3LQvJkqJZgOnhgUOKIS9CLV2j1v2fK1A9syNYmeia2wLU09YgGrKgy18gtJs65W6ZITMxQmprVOG3uttBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899881; c=relaxed/simple;
	bh=u4myuziinAHA+RzQxn7J0GstogU0y+s2j9zS1VgekCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azY7LpntmXaWt/Apf885miX03WThN79z5/DFrNtXnQKpa19/P/cTDWMRvDKOh76MVBgm+9KtS8hi2Y3hd20M257uHidKoDV/oN8cCV0wCe1pGNefFsBla07s9xXz/K6y7zKizjF2llHX7CR28DCTsSujCt6RYU1gunKNTQUr4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp5Fx7So; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d422b6253cso2862661fa.2;
        Fri, 08 Mar 2024 04:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709899878; x=1710504678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4myuziinAHA+RzQxn7J0GstogU0y+s2j9zS1VgekCo=;
        b=fp5Fx7Soz3jHOYaZKKsZlTB9sOMhHr4wl/5k8o78kj5oPGSDf0UInq7GMn8aFIqDPl
         jPyv0cSS4LCS9mYdwa1+uMTQ+7T1hc9iwZyva4sUpDEzjhI1rO6/jj6oLBZ9q1VZ6pvN
         KMvb3cR32O6XSV8p6GMgS5U27XBZRBq+DaOpnDGkGU0Qq3fGAGh5fVHES60j2B12IcZk
         X6orDGHP174DckrpSDuU51j6PlCPyPwi+n1Os1C4g4Nr1dOuCEzhSm/aJoBefIYz6UmG
         yGFmth0ZbpuooYiE2CnQRLN3fzlvGNRrYRd1r989deb/9MkCiy3kuF7I0HfE+kKA1Jms
         OBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899878; x=1710504678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4myuziinAHA+RzQxn7J0GstogU0y+s2j9zS1VgekCo=;
        b=tmPNLh9ugxVBmEXXxR1VCiV3TBn9ZA8wrbjnlCiJavOxFUz7IqRUhMgwQqK5jaagAL
         TPenNa7wnIWJeP7RFtMBo06VfBRruIM6apUptEP78OY9HyaRAZVb+K2a4v3Ctuo4bjWE
         /TJLvRD8khFgWtdIEsaF9Sc+rjvd1dA/TYjQwQW3QhDfbfQSOFEZ7vDoAtgYVbzoFwlh
         xlT0pvsSApvgJaB0c9lmdHA04DN22BG3gK1zOCRg6t+oXTd8SeDMOQZvxAKb8zQhIFiW
         yNjrGEytu6IbTQlQYZqVnuBMiSz7UpD1DNI/zOO1tNIX1ItiTVXqk+L28b9BKofUuZM4
         IlTg==
X-Forwarded-Encrypted: i=1; AJvYcCXuwhrSz9kCI6BXw1Ie7TWaZHqSUf09XaTSzMjgdiWx6RXTQ8SS6Ai7Wr7B0Y4/kQneJI2TlrrW/mCKUA2p4cJA+piSfZ7GC0MWgV6hIKJhrCEMdEp/jai15g4k9pPrCEB2FttC+E5OBLQVlp0=
X-Gm-Message-State: AOJu0YyUT4AoGhutnKi1WoD0uaVistZ9iH6NCojrpZ9q/xUc81iLInDX
	CX1CFSQlZ2zSO6BAzIEc69VJ8SqxsL1J6QJnJ59y0f2w82V+6KnFJh1E4MKXlnqEppjc+1xY8hx
	Y79jRicyl8JOaa5LfdKtEMUhbnvI=
X-Google-Smtp-Source: AGHT+IFOD3e+SaV736HdUegwhtFhUl8vlHK561xG6D82XTIxXEv593zyQhGzN7zz6UKn9ypwZl9UUa8WHhtgrQnyuis=
X-Received: by 2002:ac2:4e09:0:b0:513:5ed9:c193 with SMTP id
 e9-20020ac24e09000000b005135ed9c193mr4365888lfr.35.1709899877910; Fri, 08 Mar
 2024 04:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307223849.13d5b58b@barney> <20240307232927.171197-1-rand.sec96@gmail.com>
 <CAAMvbhE53upfqfB=afJK9YAZUWFTBN8ripae0W+PUUXdwj4-kw@mail.gmail.com>
In-Reply-To: <CAAMvbhE53upfqfB=afJK9YAZUWFTBN8ripae0W+PUUXdwj4-kw@mail.gmail.com>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Fri, 8 Mar 2024 15:11:06 +0300
Message-ID: <CAN8dotnMCQG+cUxKR_aq6=XxqMTh7KLDCpH1sOa6RqujKfYRgg@mail.gmail.com>
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
To: James Dutton <james.dutton@gmail.com>
Cc: deeb.rand@confident.ru, jonas.gorski@gmail.com, khoroshilov@ispras.ru, 
	kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, 
	voskresenski.stanislav@confident.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 4:05=E2=80=AFAM James Dutton <james.dutton@gmail.com=
> wrote:
> The reason it is probably not a good design is what comes later.
> Another developer comes along and says I see a nice SUM(a, b);
> function that I would like to re-use in my new function I am adding.
> But that new developer introduces a bug whereby they have implemented
> their CHECK(a) wrongly which results in SUM(a, b) now being a security
> exploit point because of some very subtle bug in CHECK(a) that no one
> noticed initially.
> After a while, we might have ten functions that all re-use SUM(a, b)
> at which point it becomes too time consuming for someone to check all
> ten functions don't have bugs in their CHECK(a) steps.
> It is always easier for the safety checks to be done as close as
> possible to the potential exploit point (e.g. NULL pointer
> dereference) so that it catches all future cases of re-use of the
> function.
> For example, there exist today zero day exploits in the Linux wireless
> code that is due to the absence of these checks being done at the
> exploit point.
> The biggest problem with all this, is if I sutily (without wishing to
> give away that it is to fix a zero day exploit) submitted a patch to
> do an extra check in SUM(a, b) that I know prevents a zero day
> exploit, my patch would be rejected.

Hi James,

Thank you very much for your detailed and interesting interaction. In fact,
while I was writing the example, I expected such a comment :)

The example is just an explanation, do not take it literally, but it is
definitely better than the second method. Now, if the developer makes a
mistake using the function, this is possible, but this is not a convincing
reason to add redundant code everywhere. In addition mistakes could occur
in all scenarios.

I agree with you in general, but I will answer you in simple statements:

For this reason, modification permission should not be granted to anyone,
and for this reason there are reviewers and documentation. In the end,
Somehow, software engineering concepts are applied because this is one of
the most important projects and not a calculator project as homework for
the university.

Best Regards

