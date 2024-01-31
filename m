Return-Path: <linux-kernel+bounces-45704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA9384346B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5381C2497D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A111196;
	Wed, 31 Jan 2024 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRDBoQmN"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C5FBF5;
	Wed, 31 Jan 2024 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670956; cv=none; b=QSZPqMrmcYDspdrxIxHSz6n9Y9PKCHtvA7OkMGn4ZU2vx5sNXgetF1gNK/g0Pe0CLYnJH7qmJsLqwkQ0MIOSYc65XuTWp4KXrwJC0idUFXcM65qaL7aEn6cJNp/mZcKtMFJ4BBpPkzDIwAfLfTBjJ3bTjHYFFdYbqV84y7qWX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670956; c=relaxed/simple;
	bh=xj888ufwZMUj4A2QyuAYOBr+//HBIZGWsKDinV5WyCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkKbcl0xc+/4KFtt8oihW1RTjluISDYkgyF6auV4Q9lNAZs70ceTM6RH+93NgNP2pYJoOnMq0x5Q9T8Q7nq1zQ/pz/tJZ42LUW1YjLp2ipciMrBhptOKB3/1eoOB/beIR7e7+oRDIUf78CJbwyZVvTkr6GWOJQ0jjQ22ebE6yAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRDBoQmN; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6bad09398so338561276.2;
        Tue, 30 Jan 2024 19:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706670953; x=1707275753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5vfFw+B4qQaAmX0KSnFyPWaYeXXdPCyWr3sYtimr6c=;
        b=YRDBoQmN1F7zbs4O2XHvlAHhxK6i6iit0rn3OiWPocK3MX9BIosPuxlfeuRwKhl1ff
         W/L+9P2YG6AIEQV9SwGXZ9DwayKpqi/05RtVgB7Ph3NVZK7IoCrSpNg9JCh5Y2GdWL94
         zdlN12KimZZm8uSdNwXdXQNCevpF+r4Ahf8QpFbbKSSyBvW0nXyh/4hl+yXH2aKIsjhq
         eZteTshZirgm7RTQn/KB0qbv6DwU5K3fjGgOM3orqLdGkXHGhznOqGh5Jdq1Mwi0Qarr
         z6t8uajSnaZXMplvHiaxgai/M4vn0w3/FT8Xs3eS+uIo/9DvmxshH5qBBlMXy5i5hZgc
         MMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706670953; x=1707275753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5vfFw+B4qQaAmX0KSnFyPWaYeXXdPCyWr3sYtimr6c=;
        b=ZgK3j4YXTal/ORG6PjhPJzFR7RPVYno5HfzHqghzbYHgR9D1B1kA3EJ63O7rtjG7iY
         ywYtJ5VqlFAfUTuySLxFkSL4xIExCn8p9iqPKA+OE4IK7OLpKbWXc5DDiNTwXj0CKmM7
         6v/Tpn+wJLR0PuVHFCHNuB2wX5ScMFaeqslELWETsTBEoz9WyPXsV6TpT1z0gfK3KeFh
         SkpX6djCmrwwf/WgnM1ZRIzdfw1IAsJb9Fi1PJcFer/41y6yg3CjkFTvrrSNEoE5YBJJ
         AjmT1VGtBBaPGbmuZ9pW5gko4Vnv4dWNaxAKdsPFEy9wRKGhNf+tL02iBZ11ElQKe4ZK
         gBuw==
X-Gm-Message-State: AOJu0Yye/51n07qyQTRBQPVRhFX9mh2qY8mebQem6IyVgpdhkCd4P+vp
	IgMdVqEilM5ytbJlzrYxnRTTNYwt4gmaKwdoTRDNMY0RUJoSZrhD0kI3ZYZ0UGrfdowxOVLk+YT
	A+4z78fEK0eUI+Z7F87BJILC2p6c=
X-Google-Smtp-Source: AGHT+IEgSI5FvPenJVdi3XSwbwBPCPZgeHMPUFSwjko4DrgrPFSHLEF6/7bMGVVrk7NI2yxvajEREOc/g+s3DqlyrL8=
X-Received: by 2002:a25:bd92:0:b0:dc6:b945:e58 with SMTP id
 f18-20020a25bd92000000b00dc6b9450e58mr348589ybh.48.1706670953113; Tue, 30 Jan
 2024 19:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127140747.905552-1-hayatake396@gmail.com>
 <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com> <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
 <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com> <ZbjLWwG8m-FdyxMH@nataraja>
In-Reply-To: <ZbjLWwG8m-FdyxMH@nataraja>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Wed, 31 Jan 2024 12:15:41 +0900
Message-ID: <CADFiAcLuKXTsHm6FzojKcD_wc8LQz43xt-cN0rHJyA3Va_-EDQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next RESENT v3] ethtool: ice:
 Support for RSS settings to GTP from ethtool
To: Harald Welte <laforge@gnumonks.org>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, vladimir.oltean@nxp.com, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harald-san

I apologize for the delay in making further progress on this
patch.(I'm three months late...

> There are many different GTPv2C messages

Thank you for your assistance in explaining GTPC:)

Thanks,
Takeru

2024=E5=B9=B41=E6=9C=8830=E6=97=A5(=E7=81=AB) 19:15 Harald Welte <laforge@g=
numonks.org>:
>
> hi Marcin,
>
> Disclaimer: I have no understanding of the proposed implementation here, =
just commenting
> on this from a 3GPP protocol architecture point of view.
>
> On Tue, Jan 30, 2024 at 10:59:40AM +0100, Marcin Szycik wrote:
> > >> gtpc(4|6) doesn't include TEID, so what is its purpose?
> > > In GTPC communication, there is no TEID in the CSR (Create Session Re=
quest).
> > > Therefore, there are cases of GTPC that do not include TEID.
> >
> > The way I understand it now, this patch (and the ethtool one) adds hash=
ing on
> > TEID field in GTP* headers. So I wanted to ask why do we have a case (g=
tpc(4|6))
> > that doesn't include TEID? Do we hash on other fields in this header?
>
> There are many differen GTPv2C messages, most of which contain a TEID.  S=
o it does
> in general still make sense to be able to use RSS for all those other mes=
sages.
>
> The CSR (Create Session Request) will not be able to benfit from it, but
> it's just the first message initiating a dialogue between two elements
> (think of it like a TCP SYN).  All the follow-up messages in that
> dialogue contain TEIDs and hence can benefit from RSS.
>
> --
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.o=
rg/
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. =
A6)

