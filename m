Return-Path: <linux-kernel+bounces-87766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59AD86D8B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AC41F218DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17DB2B9D9;
	Fri,  1 Mar 2024 01:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsZq25qy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC72B9B6;
	Fri,  1 Mar 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256109; cv=none; b=MQcqs6qM4aXDVAtY/o/nWi63DW4lASvz8/22ydyO7IXKTEaq2Pu9W/DwSWfNrn/da0zDDCy2sm/6zP+nAl2IfqSi7PPCggamDeokdKPobFNwb+fnZaMbanGg50DjNmjbHB5amvziOKFVLYFdM+vkm9naOnbf1c01ad9vJBr2I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256109; c=relaxed/simple;
	bh=9VZL3OL61O3NqsqmXJrrO9tTNisjXKO547fUEATu2vU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=cDx/zjfa7p4+53D6WlzPccME91uAydl/hC0+iXosgjW/hWRbx7v7NwNJ5kqR96NCD1Fdu2pMEKwUTllpNSbpJE2I1s7RW+Ik4gFyyAAgC5OEcUllj9bsLVxefgijUquEcXwpLA0tsoEZm/rJpxgIuC2Gq3PQvz62NItJ2rMu2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsZq25qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82733C433F1;
	Fri,  1 Mar 2024 01:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709256108;
	bh=9VZL3OL61O3NqsqmXJrrO9tTNisjXKO547fUEATu2vU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fsZq25qywIs9aZM87HNQqN7jD/u/zMvNq8lDWNMIYumdv6JFDkyND3G+26Wh3Ujis
	 cC808MZtWWqfWykpCRLGUtylhrAg205t1zU3T8RtOeqzhEWrz+3UjV7c88jUoG/TKT
	 dzQKqWEVpKiTS/98oBu8R0mz7XSo3UY7J0E25aIhRwNcZogODlhbsV/tzJDNUTW82Z
	 RbmSqk1ixxldWvmcPjpoS4+2zP6DimOJdxI/6lvG97fdy7O4Q2+SHVENAOVHxMBU5L
	 iAX4e/BUTzZouaEgp+QmaDK2iIKPqhQeUKqP1PdnDRcu9e2Pm1V1KLuwjozJ5hBbsg
	 +q1lowHWcHGTw==
Message-ID: <6bfce5ec26a26c327c4196dbe57b63d5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2b274111-e65a-4b99-8f07-220324f1e214@amd.com>
References: <20240229122250.24786-1-duoming@zju.edu.cn> <2b274111-e65a-4b99-8f07-220324f1e214@amd.com>
Subject: Re: [PATCH v2] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, mturquette@baylibre.com
To: Duoming Zhou <duoming@zju.edu.cn>, Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
Date: Thu, 29 Feb 2024 17:21:46 -0800
User-Agent: alot/0.10

Quoting Michal Simek (2024-02-29 04:45:54)
> On 2/29/24 13:22, Duoming Zhou wrote:
> > diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> > index 7bdeaff2bfd..e4c4c9adf79 100644
> > --- a/drivers/clk/zynq/clkc.c
> > +++ b/drivers/clk/zynq/clkc.c
> > @@ -427,7 +427,7 @@ static void __init zynq_clk_setup(struct device_nod=
e *np)
> >                       SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
> >  =20
> >       tmp =3D strlen("mio_clk_00x");
> > -     clk_name =3D kmalloc(tmp, GFP_KERNEL);
> > +     char clk_name[tmp];
>=20
> I know that Stephen asked for it but variable with variable length in the=
 middle=20
> of code doesn't look good or useful.

I didn't ask for it to be in the middle of the function :)

