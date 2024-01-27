Return-Path: <linux-kernel+bounces-41167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2883ECD1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7DC282891
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA3220305;
	Sat, 27 Jan 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMAcoNUf"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94E1EB35;
	Sat, 27 Jan 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706353844; cv=none; b=eTXL6NA/M0Dlk9QWdTIr4vV7IueR4VRItpUW8yeGmFSp2cf5SosGBVe1nxVHCzuioRGqcVI5TGvkuWuMCI9qx8QpHCleO3mPi8OKop/XmlU2EUKHNlePY8i05vkvRXluLSGEULG2C5IfND3IUTAAwsgXTlsbTP3xLSBKtKAD4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706353844; c=relaxed/simple;
	bh=lWD3Yu/iWduUcZjUVmjkV6YLZ0ZkiCzd01DXVfzdL0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7OZFYNN8G0235VbyOgnF7syzsEVJCizYU9X64SRjomzg0s0LNaZAwrMC3ePg2ZDfoLyZl5BIJXey9jHjlN5ejhVa0mpPl7GTtzXrs6n42xL7qQ+OHpDaovysIhhIqcAqbOUQg4Vu8XKHrpAD1XaQcSuWNoVFtgpFOXjgDnRvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMAcoNUf; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso939505276.2;
        Sat, 27 Jan 2024 03:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706353841; x=1706958641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWD3Yu/iWduUcZjUVmjkV6YLZ0ZkiCzd01DXVfzdL0o=;
        b=DMAcoNUfSuaS0dLOMq2X0RwumUb31UhTyf8pW2+JbpdqavBUY2jHaC3sWFdQaj6PZH
         qS4WEAo2huhjafaWOEVN1/x+VUyoGHSie6n6qql3zAZ3jqIuLQjKQSjGzWDptF+m3W3q
         H/aIfRVdIhM21XC+orP0/K3ygvsLyE3B+wTkHhTK+yOiCDCBBhlOlzSo9E501/hSkLlI
         0zg5UESlY21kXpHrgZm0sZZhJmg3A1Twv76lruXpaLEgEPp7+iXpi/sPrHh8SvmhOxeB
         c5C7h9Vfn9YVmexucAcXAYqQm/N92aG2GLSkEmZPYN/HOso3cnxqL+QE6HSjA9oCPwtP
         /fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706353841; x=1706958641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWD3Yu/iWduUcZjUVmjkV6YLZ0ZkiCzd01DXVfzdL0o=;
        b=PhnABC+/8j16JNhnOTDdR7E4suIVEfAo9rSyzncD5SO3ovbgU+nOQNj5JM2u6/1t2y
         gYQIPbqDU14xkE1hvbLQUEipeErobcPVA/uatLhhMdLPBcXSlDYiZMq0tY0qnSsEjhjG
         A7Q5zplILs4DLHIxnohcgdHcBApzm/J+CD9wlRiIM3FQHe+Z6n9M3ecQQrHguw0DPHEk
         cl0IfEhDKdShsuDFouKvK5sVl6l6fGtbfU3YPBavSkjcUFEmnyrK80pu0Dwus5/R5sSF
         p7TAslDBLdPijX7XTBQ5WsnuldQ9uBX0mujRjaI3s4nT8rOB5joXh/zGJ4LnvRaPVPKo
         LdJw==
X-Gm-Message-State: AOJu0Yw0MHjMcbQtqP9c8TEPci65gib6TnyaTFZlm5E54XOTsAUtMj4v
	+dZ/Z9NwecQIZh+67PUvMzYWZcLbdGI98JUU5X3a3BDtV4IB1AWIqso4H31prZJ+fduU4frXjFY
	MBSBzY3aAG0D0HWwjCgfLjfjTvNg=
X-Google-Smtp-Source: AGHT+IE1vSzKK+O91qDqFt2y1OcufDzXdBHUga3KuwXkrrUbqgzpQs+SDOyDthoUk8FPoeOW8XBic/ie3g07/2XopM4=
X-Received: by 2002:a25:8141:0:b0:dc2:4ab7:3d81 with SMTP id
 j1-20020a258141000000b00dc24ab73d81mr727861ybm.96.1706353841483; Sat, 27 Jan
 2024 03:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126045220.861125-1-hayatake396@gmail.com> <fb90ae9c-1f83-424c-878a-8b7e472bb6f0@molgen.mpg.de>
In-Reply-To: <fb90ae9c-1f83-424c-878a-8b7e472bb6f0@molgen.mpg.de>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Sat, 27 Jan 2024 20:10:30 +0900
Message-ID: <CADFiAcKJyZPDbbLoH11OpaLA5+ny-QmakN5d3KvAO5A_zQbfAg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v3] ethtool: ice: Support for
 RSS settings to GTP from ethtool
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, vladimir.oltean@nxp.com, 
	linux-kernel@vger.kernel.org, laforge@gnumonks.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul-san

> This patch was sent at least four(?) times to the mailing list.

Oh, I apologize for that. I had sent it several times due to issues
caught by the CI.
I wasn't aware of the proper etiquette, so your guidance is much appreciate=
d!
I will tag it as `[PATCH net-next v3 RESENT]` next time.

> Should you sent another iteration, please do not break lines, just becaus=
e a sentence ends, and please add a blank line between paragraphs.

Understood. I will make sure to do that!

Takeru

2024=E5=B9=B41=E6=9C=8826=E6=97=A5(=E9=87=91) 20:12 Paul Menzel <pmenzel@mo=
lgen.mpg.de>:
>
> Dear Takeru,
>
>
> This patch was sent at least four(?) times to the mailing list. Could
> you please sent a patch tagged with [RESENT] or a v4, so there won=E2=80=
=99t be
> several replies to different threads.
>
> One nit below:
>
> Am 26.01.24 um 05:52 schrieb Takeru Hayasaka:
> > This is a patch that enables RSS functionality for GTP packets using
> > ethtool.
> > A user can include her TEID and make RSS work for GTP-U over IPv4 by
> > doing the following:
> > `ethtool -N ens3 rx-flow-hash gtpu4 sde`
> > In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)=
e,
> > gtpu(4|6)u, and gtpu(4|6)d.
>
> Should you sent another iteration, please do not break lines, just
> because a sentence ends, and please add a blank line between paragraphs.
>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

