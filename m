Return-Path: <linux-kernel+bounces-123143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22908902E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726EF1F2770D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3968312F38B;
	Thu, 28 Mar 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b="IWSOWC7t"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0637E583
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639295; cv=none; b=rvNJ91AG4tfxfY2fLm6WB2RwsZatNO1NoShul9tvonPHCTnWAwtOPyJt+Lxp9YQwLNLWc9BOvh7asqC8f7maHqE8ZVtMCsSJ2LVNaw6k5XPi57GeiC0oGronLaeBfk5YO6ctFUfqmSc9xCtNMMIu1ICrUWpvMfXaJWVS5+sQNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639295; c=relaxed/simple;
	bh=wFRhuqAdTsfz8Pb10FUw0xm5RTQ37VsLf8OG1qFhaso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB0zkd1U0rKaXGk9yh1IwvTJaSkGtbvpN0oY0vo+43koa2bYLV6y5HsY4DMjLaKAoP1HT4or9iecYmNHgo0Xh8aFKbgUlDm2CiLAO4qdD26owT3zTzU9ggm/GdAULJiysdek4D40begHt7m6WZCRmri1UCLypFwlq7XrdS/hbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net; spf=pass smtp.mailfrom=one-eyed-alien.net; dkim=pass (1024-bit key) header.d=one-eyed-alien.net header.i=@one-eyed-alien.net header.b=IWSOWC7t; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=one-eyed-alien.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=one-eyed-alien.net
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1030017276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=one-eyed-alien.net; s=google; t=1711639290; x=1712244090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7QI/tup+7NJmY+g+0vWh6xzWihOFqUtUifn+JRUGos=;
        b=IWSOWC7tGjthiurMfF6utREGvb5apnl7SYyoKw2P8WEAp5E76S6Jyb7r2qkZnyOWqi
         6PJB6oTvHErFEPueonW6KQjmgoNjtufXnAePXEv9NJURlmnUtXt7PjAn15x3/fJ3SGQ0
         cKVGQ7jiqXnVXK6+y6fDc01WXcpwBKJeTDmaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639290; x=1712244090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7QI/tup+7NJmY+g+0vWh6xzWihOFqUtUifn+JRUGos=;
        b=PKNFFJ1eUTEwKA9YoVc5tzPl7Xxo1XapxWOX9pL271LwOZ0Eb7ToFIIr4WxW2S7Adn
         Ge6XXD4rCDJuKlhe1It90XT6gi9yH6owyBzn1xeGjgXYvEjCEoTG9C+1ijt5yiSqPYmV
         eOo9zcc/FBQBQ9ACfZxYZX4WXaf+f3ZSCndBXJ8l15yOCDvGa0CP+DYF9bXrBGaAQwCu
         RTy1PQD/0DmNynSoIen+xwvcNE4FSEFeGwxieXdcM7wZrm/yI8vPPJb/ILfpFVLWygdB
         uMpOtflrrkbu2ZYm0O51e0Q9NpdFDOLXXzGtye8SQDPJ95ajwxtn1kQCnmZeGd7YV245
         Sq/g==
X-Forwarded-Encrypted: i=1; AJvYcCXNf2Vc0wODD0z2Ed3DLQO4YfuaCyFiIohOKVDT45ltQtZUXfKULu6M1WZB5S3tkOB07fP3gRe8P6qD0SHcbUGgYh3VX/MA1shLdImE
X-Gm-Message-State: AOJu0YwiXU//+gjI4blD9ZaQUOS4Osasakio7g1xuilTVkVYjS14TJJc
	DQLkgOcQbbFUubR6c8eMfkc9JYcbSvsiVLMwlRglMsU6YDDUcGpf2lxFPD8oWJFXtV9406TvG4W
	EAOoH/6W22vhKTDTypPO9IKBSHqysKf5vcFQwPw==
X-Google-Smtp-Source: AGHT+IEUMl/1d3R4NEdijxclRpeBOvFNOk/Jgqff22zNPQs9stPAMQDCmf6Lw24zYS1WZOi+T5JxJXkUaCGIRfotNcY=
X-Received: by 2002:a25:6b4b:0:b0:dbd:120e:f337 with SMTP id
 o11-20020a256b4b000000b00dbd120ef337mr3222617ybm.30.1711639288887; Thu, 28
 Mar 2024 08:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327055130.43206-1-Norihiko.Hama@alpsalpine.com>
 <2024032757-surcharge-grime-d3dd@gregkh> <TYVPR01MB107814D7A583CB986884AD4B290342@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <a446cdf4-3a9b-43d8-b22b-78c20cce2b4f@rowland.harvard.edu>
 <TYVPR01MB10781AA8B37E147E318597B46903B2@TYVPR01MB10781.jpnprd01.prod.outlook.com>
 <0c99daaf-c727-467f-b8c1-ba8846d8a9ab@rowland.harvard.edu>
In-Reply-To: <0c99daaf-c727-467f-b8c1-ba8846d8a9ab@rowland.harvard.edu>
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Date: Thu, 28 Mar 2024 08:21:18 -0700
Message-ID: <CAA6KcBBcpug-rOytgnbb=c4O54m-Pfy=divqp12qOMrgmQrz7w@mail.gmail.com>
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: Optimize scan delay more precisely
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Norihiko Hama <norihiko.hama@alpsalpine.com>, Greg KH <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"usb-storage@lists.one-eyed-alien.net" <usb-storage@lists.one-eyed-alien.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:51=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Thu, Mar 28, 2024 at 03:04:47AM +0000, Norihiko Hama wrote:
> > > On Wed, Mar 27, 2024 at 07:39:55AM +0000, Norihiko Hama wrote:
> > > > > Sorry, but module parameters are from the 1990's, we will not go =
back to that if at all possible as it's not easy to maintain and will not w=
ork properly for multiple devices.
> > > > >
> > > > > I can understand wanting something between 1 and 0 seconds, but a=
dding yet-another-option isn't probably the best way, sorry.
> > > > 1 second does not meet with performance requirement.
> > > > I have no good idea except module parameter so that we can maintain=
 backward compatibility but be configurable out of module.
> > > > Do you have any other better solution?
> > >
> > > Can you accomplish what you want with a quirk flag?
> >
> > I think that it's hard to do that because 'quirk' is specified for a de=
vice
> > but it's difficult to identify the devices to make quirk, especially fo=
r future introduced devices.
> >
> > Can we change the design of existing 'delay_use' ?
> > For example, 'delay_use' is 32-bit value and the value "1000 secs" does=
 not make sense to set it,
> > So if it's set to '1100', it's treated as "100 / 1000 =3D 0.1 sec". Is =
this possible?
>
> Here's an approach that Greg might accept.
>
> Since we already have a delay_use module parameter, we could add a
> delay_use_ms parameter.  The two module parameters would display the
> same value, but delay_use_ms would be in milliseconds instead of in
> seconds.  (This is similar to what we did for the autosuspend and
> autosuspend_delay_ms sysfs attributes.)

What about just changing the parser on the currently delay_use
parameter to accept an optional suffix?  If it's just digits, it is in
seconds.  If it ends in "ms", then interpret it as milliseconds.  This
would be backwards compatible with existing uses, give you the
flexibility you want, avoid adding another modules parameter, and
potentially be expandable in the future (if, for some reason, someone
wanted microseconds or kiloseconds).

Matt

