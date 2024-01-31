Return-Path: <linux-kernel+bounces-46528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E718440F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB1E282C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628B80BF4;
	Wed, 31 Jan 2024 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPuGA7Z6"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4B7F490;
	Wed, 31 Jan 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708781; cv=none; b=DUW4fC9Fnl2tld31ZyE8TMIY1UAv+LF7ORzpryQVdII1cCPBKVfKDTLBnCf7tKPWHOvNsLlKm46HDKKCLat6zoHeKlHEEkyLUtiFm3zRt9/A7ua5S0yxREJpYCbI4Kfy8dZ5UOaDdO4JCiG+COqf5PWRFdk+iO2nS75hnl2dLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708781; c=relaxed/simple;
	bh=ebr3AMTFub7iemMw/BGmsstjBawvqvFelKMLo850JVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2NainEMdcKkFES+OwElLfkEcHDiCmR2SsBOc6vZOSruWhYiUxwUEmSPWf/JU1WOle3wAggfCZ7fPc5/2fnq1+MHjS5/necjtenZt9pG6NK8XuBCkvewcx97TReKD7Hh4JeiXUorrHq8RXfuDgC+JF2AVfmvt2/UUI9Qqbe9yHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPuGA7Z6; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6933a46efso2680403276.0;
        Wed, 31 Jan 2024 05:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706708779; x=1707313579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1nzFqWekvSu6tY6ZSGzcooEF5tznBA46cjxleLmSoI=;
        b=LPuGA7Z6bQ8fJwlX6UVw1J93XtYL4RG0jdwKxYxRpR74wWEiUk93tOK9ryxb4UQf1i
         tPnvsJY4D494m4AM2V9jGZWDzmn43YorOOyM0fh3etstcP26xLmKAnMiFOTIg5kxMnxb
         TYmJx4ssArNglJaO3fiJk+CB3csWnLE+wbASRVA+jCGelxFKWkcCD5y39n1PFXiIROIq
         W/pxB8DXTXH2KBpzJ1oPdUOiPIBvEQ73qdhKx/WW0TPdYyd9V69tj/fQgG8w0PyHogab
         tuApeXSSOeMNgyQ3HsYz4RwxESUDp45fPm6kqcJ/fdPT9xLsiF/jADQksQ9q2rMecFlJ
         wCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708779; x=1707313579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1nzFqWekvSu6tY6ZSGzcooEF5tznBA46cjxleLmSoI=;
        b=kRWTur09/8MzbosZ6c5ahMjPW5sM4ep1dOIrBCrrrTtzUjRNYInDkUNeRg7Mmpznga
         f0hS/B82G9Ah3RL7tZNKrqRFgAw3FlPo6DGV2cyHs639yVyY2DQ0fpLjfmKKRpWYWu9O
         ZC/LD0EAK653Iuf7rAdhjUnaSXQxwxNlZLC0GpM/cXaEfyRTm7D1fHLDYLLo0jANdoei
         f8ScKo+xChntZ5/0KB1GKyjhLpyBPAlGVdJkc+8vPjUGZYsidhcJkPMc9LlS7TeLUSA7
         aYLzX1pPF3i1+hbdShpsfhOIU+5/iof0hrm8TBz3PH4BDdU99fUZTEO6rnSDgxSr3E3p
         UVqA==
X-Gm-Message-State: AOJu0YyR8VCNedJvVmcGPDTjOO2iitEDIHxLnsB/PhNvSdRJnCS1FqjC
	/plz4kvvAGJ4TNjj1cYKouHujMSF5fz6slMNfOvTo6w1qzfHYoeeB5ZsU6b/ojHe1LYIMw+k+Wy
	rj5ipGkhaG5Ia5gncHijEOCU50RA=
X-Google-Smtp-Source: AGHT+IEiFoBBXxuV5gR1XwSItKbDrrADzmIWacG63ou2WjTfLO5bCeIPeYOpJr+lhbVeaYbihGwqxx+EMKZNj1aTGQc=
X-Received: by 2002:a25:e00a:0:b0:dbe:ace1:acf6 with SMTP id
 x10-20020a25e00a000000b00dbeace1acf6mr1765364ybg.13.1706708778843; Wed, 31
 Jan 2024 05:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131013705.1002722-1-hayatake396@gmail.com> <0fc3f574-6243-4c85-a6a7-442dc480c9e7@linux.intel.com>
In-Reply-To: <0fc3f574-6243-4c85-a6a7-442dc480c9e7@linux.intel.com>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Wed, 31 Jan 2024 22:46:07 +0900
Message-ID: <CADFiAc+wymeApwWFAjA_+sYN6_MaMssA3b4bYjeHXxjypjemRg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v5] ethtool: ice: Support for
 RSS settings to GTP from ethtool
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-doc@vger.kernel.org, vladimir.oltean@nxp.com, 
	linux-kernel@vger.kernel.org, laforge@gnumonks.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcin-san

> LGTM

Thanks for your review!

> Still removing this line :c

Oh! Sorry for the oversight. I will fix it in the next patch.
Could you please take another look at the patch?

Thanks
Takeru
2024=E5=B9=B41=E6=9C=8831=E6=97=A5(=E6=B0=B4) 20:53 Marcin Szycik <marcin.s=
zycik@linux.intel.com>:

>
>
>
> On 31.01.2024 02:37, Takeru Hayasaka wrote:
> > This is a patch that enables RSS functionality for GTP packets using et=
htool.
> >
> > A user can include TEID and make RSS work for GTP-U over IPv4 by doing =
the
> > following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`
> >
> > In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)=
e,
> > gtpu(4|6)u, and gtpu(4|6)d.
> >
> > gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format=
 does
> > not include a TEID.
> > gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format t=
hat
> > includes a TEID.
> > gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
> > gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
> > gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U exte=
nded
> > header includes Uplink, applicable to both IPv4 and IPv6.
> > gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Dow=
nlink,
> > for both IPv4 and IPv6.
> >
> > GTP generates a flow that includes an ID called TEID to identify the tu=
nnel.
> > This tunnel is created for each UE (User Equipment).By performing RSS b=
ased on
> > this flow, it is possible to apply RSS for each communication unit from=
 the UE.
> > Without this, RSS would only be effective within the range of IP addres=
ses. For
> > instance, the PGW can only perform RSS within the IP range of the SGW.
> > Problematic from a load distribution perspective, especially if there's=
 a bias
> > in the terminals connected to a particular base station.This case can b=
e
> > solved by using this patch.
>
> LGTM
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>
> > Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> > ---
> > v2->v3: Based on Harald-san's review, I added documentation and comment=
s to
> > ethtool.h and ice.rst.
> > v3->v4: Based on Marcin-san's review, I added the missing code for GTPC=
 and
> > GTPC_TEID, and revised the documentation and comments.
> > v4->v5: Based on Marcin-san's review, I fixed rename and wrong code reg=
arding
> > GTPC
>
> [...]
>
> >      f     Hash on bytes 0 and 1 of the Layer 4 header of the Rx packet=
.
> >      n     Hash on bytes 2 and 3 of the Layer 4 header of the Rx packet=
.
> > -
>
> Still removing this line :c
>
> > +    e     Hash on GTP Packet on TEID (4bytes) of the Rx packet.
> >
> >  Accelerated Receive Flow Steering (aRFS)
> >  ----------------------------------------
>
> ---8<---

