Return-Path: <linux-kernel+bounces-122590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B79088FA17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87B6B22D62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93A53E28;
	Thu, 28 Mar 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyISy5uL"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F91DFF0;
	Thu, 28 Mar 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615290; cv=none; b=oamAnyqGyLFcknftsjXNRL6kYvO5C/lmnf0Emf2bnQx9oLO0wTUhye4tnFGOF7nyXLC/cz6SfIBVoEUjUm0CSbkNjcegAp2JJgFnp58EvnNaIwA1G4GJjHOEt2xziNjuWE6rWfPIrx6QN/i5HyHG2lwN+Y6I0FR6Vbq0LMFp5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615290; c=relaxed/simple;
	bh=rBCX1vRqRdRkpZvPo4/73GUU8xUHYzwEJQOKnllDrqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiD1VVEhQenj+Mbb7pQKfufkf/7JKdzXxd6SYQ4+cNluSuXnrRp5PvOnr+71gZap32FUyjK/bSuPu+gu0r74UdBelUbzLI8zYFJKIr1mXqy/QJQFiG1wCqY/DtCi8y5v7i5YFpbNc8qdUBMTHVkl3t6NwYUfQQj24TJc7JhiP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyISy5uL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29f8ae4eae5so215924a91.0;
        Thu, 28 Mar 2024 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711615289; x=1712220089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBCX1vRqRdRkpZvPo4/73GUU8xUHYzwEJQOKnllDrqE=;
        b=MyISy5uLw8HJY4A+hCrImfZoo5FCYIPM2j9FR1pzmMs7hWlGbPrccXAySAxUjak2Ez
         F4QR00lwPxbsv7SCWapLABat29Xu4xAKFub6T06wR6xsWzklT21K5mFuhh9Q11eaS/QH
         B3F5oH28RAZ67nSQAxuTSpYzpcASkHcOBPfB0eTRW9nAkv4fZ00IUcBDSvvsxl3qPL0K
         9qWO7ITCKp7OSSDQ4UmzXWY1CxJAqflHBe0gPwa6IHoROxcXOFW8Jd6QOnbxil6gWk77
         SrKaMsQmBA8NauNYrynH+lmE6gECb1dWd5VnOyqPaj1HFfecxbzBuh+HegNmUl3aDGvM
         9Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615289; x=1712220089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBCX1vRqRdRkpZvPo4/73GUU8xUHYzwEJQOKnllDrqE=;
        b=sfG7DmzaP8TksNonoDXo6e1CnnwP8JEoyMkzYrbXPip/JPRpxodDCypHMXZew5ldM0
         tqqYV7OwGLEcGPLQzDmZiucGQ8IXDGwlCi5+RlY7lzvTKd6soA6T7xnZd3Dl6gH2csxE
         qDCabXXjDXadn+zPDaQfjyAnTxhWMlc91CySycBA0vAWGdEtHuf62KpLE8/k3Qn2Elfm
         MHtSwRJiSW0JQv9Q4CdVnMLkSEOo5LCrZVK+G9vcpM/e+ws3JiDVbUB8vthSLKMnMJB9
         PLM2u4x0cBlKjAacGWTWYgemo87jcIDmdTWZRyY7AtEWTrt5Bp/XROOw8I33HtBVJ7h6
         ZydA==
X-Forwarded-Encrypted: i=1; AJvYcCXRVRwMJ9M8Amv+7HI9ZexA08p/3LCfkrNPJJJHj/G2kOf6T1yOYNhy7RoE0g2o1xRGmivvwK/0snlnTavlQCPLgxAL2/xa
X-Gm-Message-State: AOJu0YyBVJsVP7lNS0ENntIZ78QatCvWFmT7QWmpjxC+zf8vmctSWP+2
	ZmDa0zDNHbg1Mp6j3bsrZW02+jUkYlUdb73IzK9pj0Z9VjNOpPEetFm6JefFslQt63VQLM/QQWY
	FfTY1q3eBqIMu9DuW90+hiISytu8=
X-Google-Smtp-Source: AGHT+IEzK/9g9IdxJdcAP2qh59eRR1xQ5H5ze1+sejBoHye3/TS+rL0aqbv6ZfFGSWK7ZVfRNXrAGek4KwBcAn5viDo=
X-Received: by 2002:a17:90b:3794:b0:2a0:65f:dc50 with SMTP id
 mz20-20020a17090b379400b002a0065fdc50mr1911117pjb.3.1711615288747; Thu, 28
 Mar 2024 01:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311122401.6549-1-lizheng043@gmail.com> <20240311135117.GA1244788@maili.marvell.com>
 <CAPCnf4zS=FN0MHM2tQV0b468zN0yqRHbaNMsk3cDQ7Vu8wiHKA@mail.gmail.com>
 <MWHPR1801MB19185089A3147123D1E877D0D32D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <CAPCnf4z0gp47TkxP+PFw3bd_Weh7=jn9Q2t-z6QB654Ckc36Pg@mail.gmail.com> <MWHPR1801MB1918BF213DD974CB5A6CF032D3312@MWHPR1801MB1918.namprd18.prod.outlook.com>
In-Reply-To: <MWHPR1801MB1918BF213DD974CB5A6CF032D3312@MWHPR1801MB1918.namprd18.prod.outlook.com>
From: James Lee <lizheng043@gmail.com>
Date: Thu, 28 Mar 2024 16:41:16 +0800
Message-ID: <CAPCnf4ysy032UZbHjtymkPHcJUOXef6ZUX13+L4yEC=eEYzLEQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] neighbour: guarantee the localhost
 connections be established successfully even the ARP table is full
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "jmorris@namei.org" <jmorris@namei.org>, 
	"James.Z.Li@dell.com" <James.Z.Li@dell.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's not an issue, why need "post a new patch version"?

Ratheesh Kannoth <rkannoth@marvell.com> =E4=BA=8E2024=E5=B9=B43=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=BA=94 11:37=E5=86=99=E9=81=93=EF=BC=9A
>
> > From: James Lee <lizheng043@gmail.com>
> > Sent: Tuesday, March 19, 2024 3:13 PM
> > To: Ratheesh Kannoth <rkannoth@marvell.com>
> > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> > nhorman@tuxdriver.com; davem@davemloft.net; jmorris@namei.org;
> > James.Z.Li@dell.com
> > Subject: Re: [EXTERNAL] Re: [PATCH] neighbour: guarantee the localhost
> > connections be established successfully even the ARP table is full
> >
> > It's not an issue, the loopback device can only be created by kernel it=
self,
> > loopback neigh entry also can only be created by kernel, one loopback n=
eigh
> > for ipv4 ,one for ipv6, impossible that the num of loopback neigh entri=
es
> > exceeds 2.
> ACK. I still feel like a hack. Please post a new patch version. Let maint=
ainers take a call.

