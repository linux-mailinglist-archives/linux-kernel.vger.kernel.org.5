Return-Path: <linux-kernel+bounces-91830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504687173D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C818C1F21D23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A947EEF0;
	Tue,  5 Mar 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXSQS7ZW"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD39D18E1D;
	Tue,  5 Mar 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624869; cv=none; b=tarK3MOLWkCyAKe3KswvvT4+BSMaQuAxJJ77zml4blp8xGhfOllXFvw9tywB9sQLvzVm37iWQeX9Mm471X8LZmyK48S163ea7Ez4BOic5acHZ3G81IMqWLgA5tP8las/qRmGkrL2JoqTWxvr2aPJ4M+ZCzmAenlALWL6O0hvgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624869; c=relaxed/simple;
	bh=U89uh1DhfOTDkyC8oDCYbLAchYtQuvP7pwEZtO/ui6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDB+T2Z4jti8+a69aani5g1AyU+u/atlVVj4TV2eamLjdmuPm/BIotnkRxbjN+R+ejfk2MfKabiq/b/vFQeiVK+/PA/jFZkH2kOfBq+qYqi0ZQxsvdaL0SLYi8DgGQwdIY0A27mkKyNnk3/wVVwyXfnGMDBhtdxSYQVewZZzK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXSQS7ZW; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso5167699276.0;
        Mon, 04 Mar 2024 23:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624867; x=1710229667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UppqAarfwY+zIiaC2kTHlfDrH6S8pSlvdHIG4B7CkdE=;
        b=ZXSQS7ZWKHbwxvvupsNVsEDIJoumAiBNJ49ReKGeHOLI9Zc0Fp5QdJytYWcm+wEQMu
         tbpGFQAS27gfqpSsB/2Q2E8EwEPuSFbTiQ4G8sBqnKkpgCU1TTSDBtkR37mNH4+tdF2X
         bIRaAjOTXIkssYHOh5LHe0ckTPVQFM0PhvMBnN4x7Cb5EJ5vw5utKrsecqd0+iwVqoNy
         G8vAMeGFmfXg3abJ/YvMGWLfr4myrfhK5MaEfqL0cRmd4yXavQADbawNYpWppBr5EG7o
         gbEvoQY8BF2Jj4jr7R+9LRQgYsp10RryQtRtjsI8Wl4JaUMQHx2YXaQOrYjNSHDErnAp
         AXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624867; x=1710229667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UppqAarfwY+zIiaC2kTHlfDrH6S8pSlvdHIG4B7CkdE=;
        b=pwi9AzhvjSRksEE7j65gCUj9L+xtkPe/XY4wBQArTJuA+lvHSYD2m8lrrRgV1k9F58
         +cqaXs2M+OpZ359llvdV3UNWxk/wPTD2azb/H8P7Ev2ukwbZ67QfJsbn6q2Jh2IwTX9w
         aP1TEc+oWcDZdPfCny8/Oo2fljtgLufn1B/toCcZIQpI+IsCB0pYabMhyU7rUKp8R5uq
         8CWiBdgjYk25gUyJpVOTTVlN3KUmsUoEfMelpIjEruZyyoezdxQXfz8d7apZq+BocnqK
         ouIheTTI3LI/dMfPZ7+bPHWilP+zXJpiMOJ4CBmHK/yc6UL7nElbTUUlkzIHRqI9OwDc
         0ZIA==
X-Forwarded-Encrypted: i=1; AJvYcCWBOHHVeSWm+Xgzmkb44m+RAplK3MpLOOc7ee5Ptd3fpqoWAV1iYFy8omnXKmqXdMY4XcPhbB4O8dMvs7+jGw7SXM+EToZy0bSTsMCyYLIa89hx4pYJAKD6QMqj56keqo3s0t5yOSELEWKQrT/eUItm+ctze3B/Lje93tqU6tg1
X-Gm-Message-State: AOJu0YwNmoqsZ7Ls5inf4CTZkCKRMmZGY9F8jmR+vmSzwo+p7vWfOLYB
	SL8Q/Fz6TQXaO8MM3xmHYZWX0buUhXphDJyOqQI0bZ1Jtv/XoAEYRjp1jZUE4Ne/DBTaxYsA17n
	1j/EOOr/blROp/TaZt5Zlp78Bzlk=
X-Google-Smtp-Source: AGHT+IHfZSuQQsq0Y6qpFsVyqy6sZNeaHlt0da7iEaRL5PP45J0iq/yS5BKZvfCWvC85In5QPT2Hm95+UNnJE//HDXM=
X-Received: by 2002:a25:4a06:0:b0:dcf:2b44:f38d with SMTP id
 x6-20020a254a06000000b00dcf2b44f38dmr9182681yba.49.1709624866673; Mon, 04 Mar
 2024 23:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212020403.1639030-1-hayatake396@gmail.com>
 <CYYPR11MB8429FCD568EE2AF90AEE2CABBD5E2@CYYPR11MB8429.namprd11.prod.outlook.com>
 <CADFiAc++edOb7-O6yCUgpAaonZ1sQdkrwwH8432D=e40g1CwoQ@mail.gmail.com> <CYYPR11MB84290126F884C2AB4F9AA5FBBD222@CYYPR11MB8429.namprd11.prod.outlook.com>
In-Reply-To: <CYYPR11MB84290126F884C2AB4F9AA5FBBD222@CYYPR11MB8429.namprd11.prod.outlook.com>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Tue, 5 Mar 2024 16:47:35 +0900
Message-ID: <CADFiAcJtJWMqeiVRLyZQivYw2J5EBeMVjP+qeJfS9YeWokdX+Q@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS
 hash options to ethtool.h
To: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
Cc: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"laforge@gnumonks.org" <laforge@gnumonks.org>, Marcin Szycik <marcin.szycik@linux.intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Himasekhar Reddy-san

> After added the above v4 patch able to to see tab completion for flow-typ=
e but not rx-flow-hash. Please find below logs.

Sorry. I submitted a code with the conditions reversed. I have
resubmitted it, so could you please check it again?
https://lore.kernel.org/all/20240305074350.533622-1-hayatake396@gmail.com/

Takeru

2024=E5=B9=B43=E6=9C=885=E6=97=A5(=E7=81=AB) 13:28 Pucha, HimasekharX Reddy=
 <himasekharx.reddy.pucha@intel.com>:
>
> >-----Original Message-----
> > From: Takeru Hayasaka <hayatake396@gmail.com>
> > Sent: Tuesday, March 5, 2024 9:12 AM
> > To: Pucha, HimasekharX Reddy <himasekharx.reddy.pucha@intel.com>
> > Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <=
anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Du=
mazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni =
<pabeni@redhat.com>; Jonathan Corbet <corbet@lwn.net>; linux-doc@vger.kerne=
l.org; vladimir.oltean@nxp.com; linux-kernel@vger.kernel.org; laforge@gnumo=
nks.org; Marcin Szycik <marcin.szycik@linux.intel.com>; intel-wired-lan@lis=
ts.osuosl.org; netdev@vger.kernel.org; mailhol.vincent@wanadoo.fr
> > Subject: Re: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP=
 RSS hash options to ethtool.h
> >
> > Hi Himasekhar Reddy-san
> >
> > > Functionality wise its working fine. But the ethtool part (tab comple=
te doesn't show GTP)
> >
> > I forgot to add the tab completion feature! Thank you for the good
> > points. I've added it again in this version's patch.
> > https://lore.kernel.org/all/20240305033555.524741-1-hayatake396@gmail.c=
om/
> >
> > Takeru
> >
>
> After added the above v4 patch able to to see tab completion for flow-typ=
e but not rx-flow-hash. Please find below logs.
>
> # ethtool -N eth4 rx-flow-hash
> ah4    ah6    esp4   esp6   ether  sctp4  sctp6  tcp4   tcp6   udp4   udp=
6
> # ethtool -N eth4 rx-flow-hash
> ah4    ah6    esp4   esp6   ether  sctp4  sctp6  tcp4   tcp6   udp4   udp=
6
> # ethtool -N eth4 flow-type
> ah4     esp4    ether   gtpc4t  gtpc6t  gtpu4d  gtpu4u  gtpu6d  gtpu6u  i=
p6     sctp6   tcp6    udp6
> ah6     esp6    gtpc4   gtpc6   gtpu4   gtpu4e  gtpu6   gtpu6e  ip4     s=
ctp4   tcp4    udp4
>

